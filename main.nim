import json, dynlib, strutils, sequtils, rdstdin

type
  ImGuiCol = enum
    Text = 0, TextDisabled, WindowBg, ChildBg, PopupBg,
    Border, BorderShadow, FrameBg, FrameBgHovered, FrameBgActive,
    TitleBg, TitleBgActive, TitleBgCollapsed, MenuBarBg,
    ScrollbarBg, ScrollbarGrab, ScrollbarGrabHovered, ScrollbarGrabActive,
    CheckMark, SliderGrab, SliderGrabActive, Button, ButtonHovered,
    ButtonActive, Header, HeaderHovered, HeaderActive, Separator,
    SeparatorHovered, SeparatorActive, ResizeGrip, ResizeGripHovered,
    ResizeGripActive, Tab, TabHovered, TabActive, TabUnfocused,
    TabUnfocusedActive, PlotLines, PlotLinesHovered, PlotHistogram,
    PlotHistogramHovered, TableHeaderBg, TableBorderStrong, TableBorderLight,
    TableRowBg, TableRowBgAlt, TextSelectedBg, DragDropTarget,
    NavHighlight, NavWindowingHighlight, NavWindowingDimBg, ModalWindowDimBg,
    COUNT

var theme2colors = %* { 
    "darkestGrey": "#141f2c", 
    "darkerGrey": "#2a2e39" ,
    "darkGrey": "#363b4a",
    "lightGrey": "#5a5a5a",
    "lighterGrey": "#7A818C",
    "evenLighterGrey": "#8491a3",
    "black": "#0A0B0D",
    "green": "#75f986",
    "red": "#ff0062",
    "white": "#fff"
}

var theme2 = %* { "colors": {} }

theme2["colors"][$(ImGuiCol.Text.int)] = %* [theme2Colors["white"], 1.0]
theme2["colors"][$(ImGuiCol.TextDisabled.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.WindowBg.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.ChildBg.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.PopupBg.int)] = %* [theme2Colors["white"], 1.0]
theme2["colors"][$(ImGuiCol.Border.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.BorderShadow.int)] = %* [theme2Colors["darkestGrey"], 1.0]
theme2["colors"][$(ImGuiCol.FrameBg.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.FrameBgHovered.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.FrameBgActive.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TitleBg.int)] = %* [theme2Colors["darkGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TitleBgActive.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TitleBgCollapsed.int)] = %* [theme2Colors["darkGrey"], 1.0]
theme2["colors"][$(ImGuiCol.MenuBarBg.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ScrollbarBg.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ScrollbarGrab.int)] = %* [theme2Colors["darkestGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ScrollbarGrabHovered.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ScrollbarGrabActive.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.CheckMark.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.SliderGrab.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.SliderGrabActive.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.Button.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.ButtonHovered.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ButtonActive.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.Header.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.HeaderHovered.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.HeaderActive.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.Separator.int)] = %* [theme2Colors["darkestGrey"], 1.0]
theme2["colors"][$(ImGuiCol.SeparatorHovered.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.SeparatorActive.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ResizeGrip.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.ResizeGripHovered.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ResizeGripActive.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.Tab.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.TabHovered.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TabActive.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TabUnfocused.int)] = %* [theme2Colors["darkGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TabUnfocusedActive.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.PlotLines.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.PlotLinesHovered.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.PlotHistogram.int)] = %* [theme2Colors["lightGrey"], 1.0]
theme2["colors"][$(ImGuiCol.PlotHistogramHovered.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TableHeaderBg.int)] = %* [theme2Colors["black"], 1.0]
theme2["colors"][$(ImGuiCol.TableBorderStrong.int)] = %* [theme2Colors["lighterGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TableBorderLight.int)] = %* [theme2Colors["darkGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TableRowBg.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TableRowBgAlt.int)] = %* [theme2Colors["darkestGrey"], 1.0]
theme2["colors"][$(ImGuiCol.TextSelectedBg.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.DragDropTarget.int)] = %* [theme2Colors["darkGrey"], 1.0]
theme2["colors"][$(ImGuiCol.NavHighlight.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.NavWindowingHighlight.int)] = %* [theme2Colors["darkerGrey"], 1.0]
theme2["colors"][$(ImGuiCol.NavWindowingDimBg.int)] = %* [theme2Colors["darkestGrey"], 1.0]
theme2["colors"][$(ImGuiCol.ModalWindowDimBg.int)] = %* [theme2Colors["darkestGrey"], 1.0]


# Base font definitions
let baseFontDefs = @[
  ("roboto-regular", @[16, 18, 20, 24, 28, 32, 36, 48])
]

var fontDefs = %* { "defs": [
    {"name": "roboto-regular", "size": 16},
    {"name": "roboto-regular", "size": 18},
    {"name": "roboto-regular", "size": 20},
    {"name": "roboto-regular", "size": 24},
    {"name": "roboto-regular", "size": 28},
    {"name": "roboto-regular", "size": 32},
    {"name": "roboto-regular", "size": 36},
    {"name": "roboto-regular", "size": 48}
  ] 
}

echo fontDefs
echo theme2

# type
#   Node = object
#     id: string
#     root: string
#     typ: string

#   UnformattedText = object
#     id: string
#     text: string
#     typ: string

# # Constructor for Node
# proc initNode(id, root: string): Node =
#   result.typ = "node"
#   result.id = id
#   result.root = root

# # toJson for Node
# proc toJson(node: Node): cstring =
#   %* {
#     "type": node.typ,
#     "id": node.id,
#     "root": node.root
#   }

# # Constructor for UnformattedText
# proc initUnformattedText(id, text: string): UnformattedText =
#   result.typ = "unformatted-text"
#   result.id = id
#   result.text = text

# # toJson for UnformattedText
# proc toJson(utext: UnformattedText): cstring =
#   %* {
#     "type": utext.typ,
#     "id": utext.id,
#     "text": utext.text
#   }

# # Example usage
# let node = initNode("1", "root1")
# echo toJson(node)

# let uText = initUnformattedText("2", "Some unformatted text")
# echo toJson(uText)

when defined(windows):
  const ffiLib = "./xframesshared.dll"
elif defined(linux):
  const ffiLib = "./libxframesshared.so"
elif defined(macosx):
  const ffiLib = "./libxframesshared.dylib"
elif defined(bsd):
  const ffiLib = "./libxframesshared.so"
else:
  echo "Unsupported platform"
  quit(1)

# type OnInitCb {.importc, dynlib: ffiLib.} = proc(): void
# type OnTextChangedCb {.importc.} = proc(id: cint, value: cstring): void
# type OnComboChangedCb {.importc.} = proc(id: cint, selected_index: cint): void
# type OnNumericValueChangedCb {.importc.} = proc(id: cint, value: cfloat): void
# type OnBooleanValueChangedCb {.importc.} = proc(id: cint, value: bool): void
# type OnMultipleNumericValuesChangedCb {.importc.} = proc(id: cint, values: pointer, num_values: cint): void
# type OnClickCb {.importc.} = proc(id: cint): void

proc init(
    assetsBasePath: cstring, 
    rawFontDefinitions: cstring, 
    rawStyleOverrideDefinitions: cstring,
    onInit: proc(): void {.cdecl.}, 
    onTextChanged: proc(id: cint, value: cstring): void {.cdecl.}, 
    onComboChanged: proc(id: cint, selected_index: cint): void {.cdecl.} ,
    onNumericValueChanged: proc(id: cint, value: cfloat): void {.cdecl.}, 
    onBooleanValueChanged: proc(id: cint, value: bool): void {.cdecl.},
    onMultipleNumericValuesChanged: proc(id: cint, values: pointer, num_values: cint): void {.cdecl.}, 
    onClick: proc(id: cint): void {.cdecl.}
    ) {.importc, dynlib: ffiLib.}

proc onInit(): void {.cdecl.} =
    discard

proc onTextChanged(id: cint, value: cstring): void {.cdecl.} =
    echo "onTextChanged"

proc onComboChanged(id: cint, selected_index: cint): void {.cdecl.} =
    echo "onComboChanged"

proc onNumericValueChanged(id: cint, value: cfloat): void {.cdecl.} =
    echo "onNumericValueChanged"

proc onBooleanValueChanged(id: cint, value: bool): void {.cdecl.} =
    echo "onBooleanValueChanged"

proc onMultipleNumericValuesChanged(id: cint, values: pointer, num_values: cint): void {.cdecl.} =
    echo "onMultipleNumericValuesChanged"

proc onClick(id: cint): void {.cdecl.} =
    echo "onClick"

var baseAssetsPath = "./assets"

var a = newString(baseAssetsPath.len)

let fontDefsJson = $fontDefs
let theme2Json = $theme2

init(baseAssetsPath.cstring(), fontDefsJson.cstring(), theme2Json.cstring(), onInit, onTextChanged, onComboChanged, onNumericValueChanged, onBooleanValueChanged, onMultipleNumericValuesChanged, onClick)


echo readLineFromStdin("Press enter to exit")


From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 27 Sep 2018 13:40:00 +0200
Subject: [PATCH v3 3/7] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
In-Reply-To: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
References: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1538048404-9041-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the
STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
new file mode 100644
index 0000000..c1b4c18
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
@@ -0,0 +1,116 @@
+STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander bindings
+
+ST Multi-Function eXpander (STMFX) offers up to 24 GPIOs expansion.
+Please refer to ../mfd/stmfx.txt for STMFX Core bindings.
+
+Required properties:
+- compatible: should be "st,stmfx-0300-pinctrl".
+- #gpio-cells: should be <2>, the first cell is the GPIO number and the second
+  cell is the gpio flags in accordance with <dt-bindings/gpio/gpio.h>.
+- gpio-controller: marks the device as a GPIO controller.
+- #interrupt-cells: should be <2>, the first cell is the GPIO number and the
+  second cell is the interrupt flags in accordance with
+  <dt-bindings/interrupt-controller/irq.h>.
+- interrupt-controller: marks the device as an interrupt controller.
+- gpio-ranges: specifies the mapping between gpio controller and pin
+  controller pins. Check "Concerning gpio-ranges property" below.
+Please refer to ../gpio/gpio.txt.
+
+Please refer to pinctrl-bindings.txt for pin configuration.
+
+Required properties for pin configuration sub-nodes:
+- pins: list of pins to which the configuration applies.
+
+Optional properties for pin configuration sub-nodes (pinconf-generic ones):
+- bias-disable: disable any bias on the pin.
+- bias-pull-up: the pin will be pulled up.
+- bias-pull-pin-default: use the pin-default pull state.
+- bias-pull-down: the pin will be pulled down.
+- drive-open-drain: the pin will be driven with open drain.
+- drive-push-pull: the pin will be driven actively high and low.
+- output-high: the pin will be configured as an output driving high level.
+- output-low: the pin will be configured as an output driving low level.
+
+Note that STMFX pins[15:0] are called "gpio[15:0]", and STMFX pins[23:16] are
+called "agpio[7:0]". Example, to refer to pin 18 of STMFX, use "agpio2".
+
+Concerning gpio-ranges property:
+- if all STMFX pins[24:0] are available (no other STMFX function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+- if agpio[3:0] are not available (STMFX Touchscreen function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 16>, <&stmfx_pinctrl 20 20 4>;
+- if agpio[7:4] are not available (STMFX IDD function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 20>;
+
+
+Example:
+
+	stmfx: stmfx at 42 {
+		...
+
+		stmfx_pinctrl: stmfx-pin-controller {
+			compatible = "st,stmfx-0300-pinctrl";
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+
+			joystick_pins: joystick {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
+				drive-push-pull;
+				bias-pull-up;
+			};
+		};
+	};
+
+Example of STMFX GPIO consumers:
+
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&joystick_pins>;
+		pinctrl-names = "default";
+		button-0 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-1 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-2 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-3 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-4 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		orange {
+			gpios = <&stmfx_pinctrl 17 1>;
+		};
+
+		blue {
+			gpios = <&stmfx_pinctrl 19 1>;
+		};
+	}
-- 
2.7.4

From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 11 Nov 2014 20:38:54 +0800
Subject: [PATCH v3 2/3] dt-bindings: Add pinctrl bindings for mt65xx/mt81xx.
In-Reply-To: <1415709535-31515-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1415709535-31515-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1415709535-31515-3-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hongzhou Yang <hongzhou.yang@mediatek.com>

Add devicetree bindings for Mediatek SoC pinctrl driver.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
new file mode 100644
index 0000000..70f35b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -0,0 +1,123 @@
+* Mediatek MT65XX Pin Controller
+
+The Mediatek's Pin controller is used to control GPIO pins.
+
+Required properties:
+- compatible: value should be either of the following.
+    (a) "mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
+- mediatek,pctl-regmap: Should be a phandle of the syscfg node.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
+  binding is used, the amount of cells must be specified as 2. See the below
+  mentioned gpio binding representation for description of particular cells.
+
+	Eg: <&pio 6 0>
+	<[phandle of the gpio controller node]
+	[pin number within the gpio controller]
+	[flags]>
+
+	Values for gpio specifier:
+	- Pin number: is a value between 0 to 202.
+	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
+            Only the following flags are supported:
+            0 - GPIO_ACTIVE_HIGH
+            1 - GPIO_ACTIVE_LOW
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+A pinctrl node should contain at least one subnodes representing the
+pinctrl groups available on the machine. Each subnode will list the
+pins it needs, and how they should be configured, with regard to muxer
+configuration, pullups, drive strngth, input enable/disable and input schmitt.
+
+Required subnode-properties:
+
+- mediatek,pins: 2 integers array, represents gpio pinmux number and config
+  setting. The format as following
+
+    node {
+     mediatek,pins = <PIN_NUMBER_PINMUX>;
+                     GENERIC_PINCONFIG;
+    };
+
+    The PIN_NUMBER_PINMUX is combination of GPIO number and pinmux, it can
+    use macros which already defind in boot/dts/mt8135-pinfunc.h directly.
+    The GENERIC_PINCONFIG is the generic pinconfig options to use, bias-disable,
+    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
+    input-schmitt-enable and input-schmitt-disable are valid.
+
+Examples:
+
+#include "mt8135-pinfunc.h"
+
+...
+{
+	syscfg_pctl_a: syscfg_pctl_a at 10005000 {
+		compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
+		reg = <0 0x10005000 0 0x1000>;
+	};
+
+	syscfg_pctl_b: syscfg_pctl_b at 1020C020 {
+		compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
+		reg = <0 0x1020C020 0 0x1000>;
+	};
+
+	pinctrl at 01c20800 {
+		compatible = "mediatek,mt8135-pinctrl";
+		mediatek,pctl-regmap = <&syscfg_pctl_a &syscfg_pctl_b>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		i2c0_pins_a: i2c0 at 0 {
+			pins1 {
+				mediatek,pins = <MT8135_PIN_100_SDA0__FUNC_SDA0>,
+						<MT8135_PIN_101_SCL0__FUNC_SCL0>;
+				bias-disable;
+			};
+		};
+
+		i2c1_pins_a: i2c1 at 0 {
+			pins {
+				mediatek,pins = <MT8135_PIN_195_SDA1__FUNC_SDA1>,
+						<MT8135_PIN_196_SCL1__FUNC_SCL1>;
+				bias-pull-up = <55>;
+			};
+		};
+
+		i2c2_pins_a: i2c2 at 0 {
+			pins1 {
+				mediatek,pins = <MT8135_PIN_193_SDA2__FUNC_SDA2>;
+				bias-pull-down;
+			};
+
+			pins2 {
+				mediatek,pins = <MT8135_PIN_49_WATCHDOG__FUNC_GPIO49>;
+				bias-pull-up;
+			};
+		};
+
+		i2c3_pins_a: i2c3 at 0 {
+			pins1 {
+				mediatek,pins = <MT8135_PIN_40_DAC_CLK__FUNC_GPIO40>,
+						<MT8135_PIN_41_DAC_WS__FUNC_GPIO41>;
+				bias-pull-up = <55>;
+			};
+
+			pins2 {
+				mediatek,pins = <MT8135_PIN_35_SCL3__FUNC_SCL3>,
+						<MT8135_PIN_36_SDA3__FUNC_SDA3>;
+				output-low;
+				bias-pull-up = <55>;
+			};
+
+			pins3 {
+				mediatek,pins = <MT8135_PIN_57_JTCK__FUNC_GPIO57>,
+						<MT8135_PIN_60_JTDI__FUNC_JTDI>;
+				drive-strength = <32>;
+			};
+		};
+
+		...
+	}
+};
-- 
1.8.1.1.dirty

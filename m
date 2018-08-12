From: sam@ravnborg.org (Sam Ravnborg)
Date: Sun, 12 Aug 2018 20:46:24 +0200
Subject: [PATCH v1 2/7] dt-binding: add bindings for Atmel LCDC mfd
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Message-ID: <20180812184629.3808-2-sam@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCDC IP used by some Atmel SOC's have a
multifunction device that include two sub-devices:
- pwm
- display controller

This binding describe the multi function device
that act as root for the sub-devices

The Atmel SOC's are at91sam9 etc.

The compatible name is intentionally
prefixed with -mfd to avoid clash with existing
compatible entries.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/mfd/atmel-lcdc.txt         | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-lcdc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel-lcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-lcdc.txt
new file mode 100644
index 000000000000..70e9b7bda6c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-lcdc.txt
@@ -0,0 +1,75 @@
+Device-Tree bindings for Atmel's LCDC (LCD Controller) MFD driver
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,at91sam9261-lcdc-mfd"
+   "atmel,at91sam9263-lcdc-mfd"
+   "atmel,at91sam9g10-lcdc-mfd"
+   "atmel,at91sam9g45-lcdc-mfd"
+   "atmel,at91sam9g46-lcdc-mfd"
+   "atmel,at91sam9m10-lcdc-mfd"
+   "atmel,at91sam9m11-lcdc-mfd"
+   "atmel,at91sam9rl-lcdc-mfd"
+ - reg: base address and size of the LCDC device registers.
+ - clock-names: the name of the 2 clocks requested by the LCDC device.
+   Should contain "lcdc_clk", and "hclk".
+ - clocks: should contain the 2 clocks requested by the LCDC device.
+	   May specify the same clock twice is there is no need to enable
+	   "hclk" to use the display.
+ - interrupts: should contain the description of the LCDC interrupt line
+
+The LCDC IP exposes two subdevices:
+ - a PWM chip: see ../pwm/atmel-lcdc-pwm.txt
+ - a Display Controller: see ../display/atmel/lcdc-display-controller.txt
+
+Example:
+	lcdc0: lcdc at 700000 {
+		compatible = "atmel,at91sam9263-lcdc-mfd";
+		reg = <0x700000 0x1000>;
+		interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
+		clocks = <&lcd_clk>, <&lcd_clk>;
+		clock-names = "lcdc_clk", "hclk";
+
+		lcdc-display-controller {
+			compatible = "atmel,lcdc-display-controller";
+			lcd-supply = <&lcdc_reg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				lcdc_panel_output: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&panel_input>;
+				};
+			};
+		};
+
+		lcdc_pwm: lcdc-pwm {
+			compatible = "atmel,lcdc-pwm";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcdc_pwm>;
+			#pwm-cells = <3>;
+		};
+
+	};
+
+	panel: panel {
+		compatible = "logictechnologies,lttd800480070-l2rt", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&panel_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&lcdc_panel_output>;
+			};
+		};
+	};
-- 
2.12.0

From: sam@ravnborg.org (Sam Ravnborg)
Date: Sun, 12 Aug 2018 20:46:28 +0200
Subject: [PATCH v1 6/7] dt-bindings: add bindings for Atmel
 lcdc-display-controller
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Message-ID: <20180812184629.3808-6-sam@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCDC IP used by some Atmel SOC's have a
multifunction device that include two sub-devices:
- pwm
- display controller

This binding describe the lcdc display controller and
refer back to the mfd device that this must be a child node of.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../display/atmel/lcdc-display-controller.txt      | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/lcdc-display-controller.txt

diff --git a/Documentation/devicetree/bindings/display/atmel/lcdc-display-controller.txt b/Documentation/devicetree/bindings/display/atmel/lcdc-display-controller.txt
new file mode 100644
index 000000000000..508a49b5d8b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel/lcdc-display-controller.txt
@@ -0,0 +1,40 @@
+Atmel LCD Controller (LCDC) Display Controller
+
+Required properties:
+ - compatible: value should be one of the following:
+   "atmel,lcdc-display-controller"
+
+Optional properties:
+- lcd-supply: phandle to a regulator that supply the display
+
+Required children nodes:
+ One child node that references the panel connected.
+ (See ../graph.txt)
+ At least one port node is required.
+
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
+	};
-- 
2.12.0

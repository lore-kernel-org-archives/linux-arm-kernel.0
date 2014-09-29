From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 29 Sep 2014 16:44:19 +0200
Subject: [PATCH v6 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <1412001864-3251-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1412001864-3251-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1412001864-3251-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
controller device.

The HLCDC block provides a single RGB output port, and only supports LCD
panels connection to LCD panels for now.

The atmel,panel property link the HLCDC RGB output with the LCD panel
connected on this port (note that the HLCDC RGB connector implementation
makes use of the DRM panel framework).

Connection to other external devices (DRM bridges) might be added later by
mean of a new atmel,xxx (atmel,bridge) property.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt

diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
new file mode 100644
index 0000000..73b9860
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
@@ -0,0 +1,54 @@
+Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
+
+The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
+See ../mfd/atmel-hlcdc.txt for more details.
+
+Required properties:
+ - compatible: value should be "atmel,hlcdc-display-controller"
+ - interrupts: the HLCDC interrupt definition
+ - pinctrl-names: the pin control state names. Should contain "default".
+ - pinctrl-0: should contain the default pinctrl states.
+ - #address-cells: should be set to 1.
+ - #size-cells: should be set to 0.
+
+Required children nodes:
+ Children nodes are encoding available output ports and their connections
+ to external devices using the OF graph reprensentation (see ../graph.txt).
+ At least one port node is required.
+
+Example:
+
+	hlcdc: hlcdc at f0030000 {
+		compatible = "atmel,sama5d3-hlcdc";
+		reg = <0xf0030000 0x2000>;
+		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+		clock-names = "periph_clk","sys_clk", "slow_clk";
+		status = "disabled";
+
+		hlcdc-display-controller {
+			compatible = "atmel,hlcdc-display-controller";
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				hlcdc_panel_output: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&panel_input>;
+				};
+			};
+		};
+
+		hlcdc_pwm: hlcdc-pwm {
+			compatible = "atmel,hlcdc-pwm";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcd_pwm>;
+			#pwm-cells = <3>;
+		};
+	};
-- 
1.9.1

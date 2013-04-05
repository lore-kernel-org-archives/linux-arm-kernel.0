From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  4 Apr 2013 23:20:54 -0300
Subject: [PATCH v4 1/2] ARM: dts: mxs: Use 'regulator-fixed' for turning on LCD
Message-ID: <1365128456-8762-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of using a custom binding for turning on a GPIO that activates the
LCD, use the standard 'regulator-fixed'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- Fix regulator bindings (use lcd-supply)
Changes since v2:
- Use regulator-fixed
Changes since v1:
- Adjust Subject, since the change is not specific to mx28evk
 Documentation/devicetree/bindings/fb/mxsfb.txt |    5 +----
 arch/arm/boot/dts/imx23-evk.dts                |   11 ++++++++++-
 arch/arm/boot/dts/imx28-evk.dts                |   11 ++++++++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/fb/mxsfb.txt b/Documentation/devicetree/bindings/fb/mxsfb.txt
index 7ba3b76..b15230c 100644
--- a/Documentation/devicetree/bindings/fb/mxsfb.txt
+++ b/Documentation/devicetree/bindings/fb/mxsfb.txt
@@ -8,9 +8,7 @@ Required properties:
 - display : phandle to display node (see below for details)
 
 Optional properties:
-- panel-enable-gpios : Should specify the gpio for panel enable
-
-* display node
+- display node
 
 Required properties:
 - bits-per-pixel : <16> for RGB565, <32> for RGB888/666.
@@ -25,7 +23,6 @@ lcdif at 80030000 {
 	compatible = "fsl,imx28-lcdif";
 	reg = <0x80030000 2000>;
 	interrupts = <38 86>;
-	panel-enable-gpios = <&gpio3 30 0>;
 
 	display: display {
 		bits-per-pixel = <32>;
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 7880e17..da0588a 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -59,7 +59,7 @@
 			lcdif at 80030000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a>;
-				panel-enable-gpios = <&gpio1 18 0>;
+				lcd-supply = <&reg_lcd_3v3>;
 				display = <&display>;
 				status = "okay";
 
@@ -120,6 +120,15 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio1 29 0>;
 		};
+
+		reg_lcd_3v3: lcd-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "lcd-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 18 0>;
+			enable-active-high;
+		};
 	};
 
 	backlight {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2d4ea3b..3637bf3 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -123,7 +123,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
-				panel-enable-gpios = <&gpio3 30 0>;
+				lcd-supply = <&reg_lcd_3v3>;
 				display = <&display>;
 				status = "okay";
 
@@ -310,6 +310,15 @@
 			gpio = <&gpio3 8 0>;
 			enable-active-high;
 		};
+
+		reg_lcd_3v3: lcd-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "lcd-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 30 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
-- 
1.7.9.5

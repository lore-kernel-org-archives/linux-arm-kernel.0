From: marcofrk@gmail.com (Marco Franchi)
Date: Wed,  6 Dec 2017 13:15:17 -0200
Subject: [PATCH v3 1/3] ARM: dts: imx6sx-sdb: Convert from fbdev to drm
 bindings
Message-ID: <1512573319-6624-1-git-send-email-marcofrk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is preferred to use the panel compatible string rather than passing
the LCD timing in the device tree.

So pass the "sii,43wvf1g" compatible string, which describes the parallel
LCD.

Also pass the 'backlight' property as described in
Documentation/devicetree/bindings/display/panel/simple-panel.txt

Signed-off-by: Marco Franchi <marcofrk@gmail.com>
---
Changes since v2:
-none
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index d57a41c..d35aa85 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -24,7 +24,7 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
-	backlight {
+	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -129,6 +129,13 @@
 		enable-active-high;
 	};
 
+	reg_lcd_5v: regulator-lcd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	sound {
 		compatible = "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
@@ -144,6 +151,19 @@
 		mux-int-port = <2>;
 		mux-ext-port = <6>;
 	};
+
+	panel {
+		compatible = "sii,43wvf1g";
+		backlight = <&backlight_display>;
+		dvdd-supply = <&reg_lcd_3v3>;
+		avdd-supply = <&reg_lcd_5v>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &audmux {
@@ -221,31 +241,11 @@
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
-	lcd-supply = <&reg_lcd_3v3>;
-	display = <&display0>;
 	status = "okay";
 
-	display0: display0 {
-		bits-per-pixel = <16>;
-		bus-width = <24>;
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <33500000>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <89>;
-				hfront-porch = <164>;
-				vback-porch = <23>;
-				vfront-porch = <10>;
-				hsync-len = <10>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
 		};
 	};
 };
-- 
2.7.4

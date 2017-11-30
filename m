From: marco.franchi@nxp.com (Marco Franchi)
Date: Thu, 30 Nov 2017 11:00:09 -0200
Subject: [PATCH] ARM: dts: imx6sl-evk: Add DRM panel,
 power-enable and backlight support
Message-ID: <1512046809-18434-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marco Frank <marco.franchi@nxp.com>

It is preferred to use the panel compatible string rather than passing 
the LCD timming in the device tree.

So pass the "sii,43wvf1g" compatible string, a new driver for the Seiko 
Panel, which describes the parallel LCD.

This new driver needs two power supply, so pass 'dvdd-supply' and 
'avdd-supply', which makes the kernel to turn on the LCD on is own.

Also, pass the 'backlight' property as described in 
Documentation/devicetree/bindings/display/panel/simple-panel.txt

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 49 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 0a90eea..d5148f4 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -20,7 +20,7 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
-	backlight {
+	backlight_display: backlight_display {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -91,6 +91,14 @@
 			gpio = <&gpio4 3 0>;
 			enable-active-high;
 		};
+
+		reg_lcd_5v: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "lcd-5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
 	};
 
 	sound {
@@ -108,6 +116,19 @@
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
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
@@ -546,31 +567,11 @@
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
-	lcd-supply = <&reg_lcd_3v3>;
-	display = <&display0>;
 	status = "okay";
 
-	display0: display0 {
-		bits-per-pixel = <32>;
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

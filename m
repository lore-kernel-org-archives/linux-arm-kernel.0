From: marco.franchi@nxp.com (Marco Franchi)
Date: Thu, 30 Nov 2017 11:02:09 -0200
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add DRM panel,
 power-enable and backlight support
Message-ID: <1512046929-18597-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 49 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index da81552..3a597a4 100644
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
@@ -129,6 +129,14 @@
 			regulator-max-microvolt = <3300000>;
 			gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		};
+
+		reg_lcd_5v: regulator at 7 {
+			compatible = "regulator-fixed";
+			reg = <7>;
+			regulator-name = "lcd-5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
 	};
 
 	sound {
@@ -146,6 +154,19 @@
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
@@ -215,31 +236,11 @@
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

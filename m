From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 17:39:17 -0300
Subject: [PATCH 2/6] ARM: dts: imx28-evk: Convert to the new display bindings
In-Reply-To: <1532119161-16597-1-git-send-email-festevam@gmail.com>
References: <1532119161-16597-1-git-send-email-festevam@gmail.com>
Message-ID: <1532119161-16597-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx28-evk board has a Seiko 43WVF1G parallel display.

Instead of hardcoding the display timings in the device tree, use
the "sii,43wvf1g" compatible instead.

This aligns with the new mxsfb bindings scheme documented at:
Documentation/devicetree/bindings/display/mxsfb.txt

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-evk.dts | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 210aee0..93ab5bd 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -74,6 +74,26 @@
 		enable-active-high;
 	};
 
+	reg_lcd_5v: regulator-lcd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
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
+
 	apb at 80000000 {
 		apbh at 80000000 {
 			gpmi-nand at 8000c000 {
@@ -177,31 +197,11 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
-				lcd-supply = <&reg_lcd_3v3>;
-				display = <&display0>;
 				status = "okay";
 
-				display0: display0 {
-					bits-per-pixel = <32>;
-					bus-width = <24>;
-
-					display-timings {
-						native-mode = <&timing0>;
-						timing0: timing0 {
-							clock-frequency = <33500000>;
-							hactive = <800>;
-							vactive = <480>;
-							hback-porch = <89>;
-							hfront-porch = <164>;
-							vback-porch = <23>;
-							vfront-porch = <10>;
-							hsync-len = <10>;
-							vsync-len = <10>;
-							hsync-active = <0>;
-							vsync-active = <0>;
-							de-active = <1>;
-							pixelclk-active = <0>;
-						};
+				port {
+					display_out: endpoint {
+						remote-endpoint = <&panel_in>;
 					};
 				};
 			};
@@ -350,7 +350,7 @@
 		};
 	};
 
-	backlight {
+	backlight_display: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 2 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
-- 
2.7.4

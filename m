From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 17:39:19 -0300
Subject: [PATCH 4/6] ARM: dts: imx23-evk: Convert to the new display bindings
In-Reply-To: <1532119161-16597-1-git-send-email-festevam@gmail.com>
References: <1532119161-16597-1-git-send-email-festevam@gmail.com>
Message-ID: <1532119161-16597-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx23-evk board has a Seiko 43WVF1G parallel display.

Instead of hardcoding the display timings in the device tree, use
the "sii,43wvf1g" compatible instead.

This aligns with the new mxsfb bindings scheme documented at:
Documentation/devicetree/bindings/display/mxsfb.txt

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx23-evk.dts | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 494095d..ad2ae25 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -30,6 +30,26 @@
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
@@ -69,31 +89,11 @@
 			lcdif at 80030000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a>;
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
-							clock-frequency = <9200000>;
-							hactive = <480>;
-							vactive = <272>;
-							hback-porch = <15>;
-							hfront-porch = <8>;
-							vback-porch = <12>;
-							vfront-porch = <4>;
-							hsync-len = <1>;
-							vsync-len = <1>;
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
@@ -135,7 +135,7 @@
 		};
 	};
 
-	backlight {
+	backlight_display: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 2 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
-- 
2.7.4

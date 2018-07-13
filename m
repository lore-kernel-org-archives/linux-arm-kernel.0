From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 13 Jul 2018 14:49:03 +0200
Subject: [PATCH 2/3] ARM: dts: imx7d-nitrogen7: use OF graph to describe the
 display
In-Reply-To: <20180713124904.9285-1-gary.bisson@boundarydevices.com>
References: <20180713124904.9285-1-gary.bisson@boundarydevices.com>
Message-ID: <20180713124904.9285-3-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make use of the new eLCDIF DRM driver OF graph description is
required. Describe the display using OF graph nodes.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx7d-nitrogen7.dts | 48 +++++++++------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 9c6a3fdfcf78..d8aac4a2d02a 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -11,11 +11,6 @@
 	model = "Boundary Devices i.MX7 Nitrogen7 Board";
 	compatible = "boundary,imx7d-nitrogen7", "fsl,imx7d";
 
-	aliases {
-		fb-lcd = &lcdif;
-		t-lcd = &t_lcd;
-	};
-
 	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
@@ -28,7 +23,7 @@
 		default-on;
 	};
 
-	backlight-j20 {
+	backlight_lcd: backlight-j20 {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -36,6 +31,17 @@
 		status = "okay";
 	};
 
+	panel-lcd {
+		compatible = "okaya,rs800480t-7x0gp";
+		backlight = <&backlight_lcd>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
 	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
@@ -280,35 +286,11 @@
 };
 
 &lcdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif_dat
-		     &pinctrl_lcdif_ctrl>;
-	lcd-supply = <&reg_vref_3v3>;
-	display = <&display0>;
 	status = "okay";
 
-	display0: lcd-display {
-		bits-per-pixel = <16>;
-		bus-width = <18>;
-
-		display-timings {
-			native-mode = <&t_lcd>;
-			t_lcd: t_lcd_default {
-				/* default to Okaya display */
-				clock-frequency = <30000000>;
-				hactive = <800>;
-				vactive = <480>;
-				hfront-porch = <40>;
-				hback-porch = <40>;
-				hsync-len = <48>;
-				vback-porch = <29>;
-				vfront-porch = <13>;
-				vsync-len = <3>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
 		};
 	};
 };
-- 
2.18.0

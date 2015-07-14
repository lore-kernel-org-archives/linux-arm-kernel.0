From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 11:15:55 -0300
Subject: [PATCH] ARM: dts: sabresd: use simple-panel instead of
 display-timings for LVDS1
Message-ID: <1436883355-11256-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use the compatible string "hannstar,hsd100pxn1" for representing
the LCD panel that is connected to the LVDS1 port.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index cca847e..5fecb3a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -115,7 +115,7 @@
 		mux-ext-port = <3>;
 	};
 
-	backlight {
+	backlight_lvds: backlight_lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -123,6 +123,17 @@
 		status = "okay";
 	};
 
+	panel {
+		compatible = "hannstar,hsd100pxn1";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds1_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -508,18 +519,11 @@
 		fsl,data-width = <18>;
 		status = "okay";
 
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
+		port at 4 {
+			reg = <4>;
+
+			lvds1_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
-- 
1.9.1

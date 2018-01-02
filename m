From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  2 Jan 2018 14:32:15 +0530
Subject: [PATCH 2/5] ARM: dts: imx6q-icore: Switch LVDS timings from
 panel-simple
In-Reply-To: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
References: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1514883738-16297-2-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use ampire,am-800480aytzqw-00h LVDS timings from
panel-simple instead hard coding the same in dts.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6q-icore.dts    | 31 +++++++++++++++++--------------
 arch/arm/boot/dts/imx6qdl-icore.dtsi |  2 +-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 5613dd9..c8e464e 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -48,6 +48,17 @@
 / {
 	model = "Engicam i.CoreM6 Quad/Dual Starter Kit";
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
+
+	panel {
+		compatible = "ampire,am-800480aytzqw-00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -71,22 +82,14 @@
 	status = "okay";
 
 	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
+		reg = <0>;
 		status = "okay";
 
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <60000000>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <30>;
-				hfront-porch = <30>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				hsync-len = <64>;
-				vsync-len = <20>;
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index a1b469c..5fd9e00 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -49,7 +49,7 @@
 		reg = <0x10000000 0x80000000>;
 	};
 
-	backlight {
+	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 100000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
-- 
2.7.4

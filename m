From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue, 19 May 2015 08:50:15 -0700
Subject: [PATCH V2 1/2] ARM: dts: nitrogen6x: use simple-panel instead of
 display-timings for LVDS0
In-Reply-To: <1432050616-11465-1-git-send-email-eric.nelson@boundarydevices.com>
References: <20150518075844.7e1b5916@ipc1.ka-ro>
 <1432050616-11465-1-git-send-email-eric.nelson@boundarydevices.com>
Message-ID: <1432050616-11465-2-git-send-email-eric.nelson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also add label for backlight_lvds and connect it to the display.

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
V2 changes 'alias' in commit message to 'label'

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index fd096dc..712c5ec 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -122,7 +122,7 @@
 		status = "okay";
 	};
 
-	backlight_lvds {
+	backlight_lvds: backlight_lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm4 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -130,6 +130,17 @@
 		power-supply = <&reg_3p3v>;
 		status = "okay";
 	};
+
+	panel {
+		compatible = "hannstar,hsd100pxn1";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &audmux {
@@ -379,18 +390,11 @@
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
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
-- 
2.1.4

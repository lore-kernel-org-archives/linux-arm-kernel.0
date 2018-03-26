From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 26 Mar 2018 13:35:53 +0530
Subject: [PATCH v4] ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from
 panel-simple
Message-ID: <20180326080554.11559-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use koe_tx31d200vm0baa LVDS timings from
panel-simple instead hard coding the same in dts.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Send as seprate patch from previous series
  https://patchwork.kernel.org/patch/10199423/
Changes for v3, v2:
- none

 arch/arm/boot/dts/imx6q-icore-ofcap12.dts | 31 +++++++++++++++++--------------
 arch/arm/boot/dts/imx6qdl-icore.dtsi      |  2 +-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap12.dts b/arch/arm/boot/dts/imx6q-icore-ofcap12.dts
index 9e230f56c5fb..6e27c8143f82 100644
--- a/arch/arm/boot/dts/imx6q-icore-ofcap12.dts
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap12.dts
@@ -48,28 +48,31 @@
 / {
 	model = "Engicam i.CoreM6 Quad/Dual OpenFrame Capacitive touch 12 Kit";
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
+
+	panel {
+		compatible = "koe,tx31d200vm0baa";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &ldb {
 	status = "okay";
 
 	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
+		reg = <0>;
 		status = "okay";
 
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <46800000>;
-				hactive = <1280>;
-				vactive = <480>;
-				hback-porch = <353>;
-				hfront-porch = <47>;
-				vback-porch = <39>;
-				vfront-porch = <4>;
-				hsync-len = <8>;
-				vsync-len = <2>;
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index b3a463a5908b..1bce85c3376b 100644
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
2.14.3

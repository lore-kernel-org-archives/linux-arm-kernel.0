From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 01 Sep 2014 16:06:31 +0530
Subject: [PATCH V3 1/2] ARM: dts: Add DT changes for display on snow
Message-ID: <1409567792-8281-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for ptn3460 bridge chip and panel.
Add backlight enable pin and backlight power supply for pwm-backlight.
Also add bridge phandle needed by dp to enable display on snow.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
Changes since V1:
	-- Remove "simple-panel" compatible string.
	-- Use GPIO_ACTIVE_HIGH instead of 0.
	-- Change panel node naming from "panel-simple" to "panel".

Changes since V2:
	-- Use proper compatible string: "auo,b116xw03"

 arch/arm/boot/dts/exynos5250-snow.dts |   41 ++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index f2b8c41..1ac9709 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -9,6 +9,7 @@
 */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "exynos5250.dtsi"
 #include "exynos5250-cros-common.dtsi"
 
@@ -181,7 +182,7 @@
 					dcdc3 {
 						ti,enable-ext-control;
 					};
-					fet1 {
+					fet1: fet1 {
 						regulator-name = "vcd_led";
 						ti,overcurrent-wait = <3>;
 					};
@@ -204,7 +205,7 @@
 						regulator-always-on;
 						ti,overcurrent-wait = <3>;
 					};
-					fet6 {
+					fet6: fet6 {
 						regulator-name = "lcd_vdd";
 						ti,overcurrent-wait = <3>;
 					};
@@ -253,6 +254,15 @@
 			pinctrl-0 = <&max98095_en>;
 			pinctrl-names = "default";
 		};
+
+		ptn3460: lvds-bridge at 20 {
+			compatible = "nxp,ptn3460";
+			reg = <0x20>;
+			powerdown-gpios = <&gpy2 5 GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpx1 5 GPIO_ACTIVE_HIGH>;
+			edid-emulation = <5>;
+			panel = <&panel>;
+		};
 	};
 
 	i2s0: i2s at 03830000 {
@@ -300,11 +310,13 @@
 		vdd_pll-supply = <&ldo8_reg>;
 	};
 
-	backlight {
+	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 1000000 0>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
+		enable-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
+		power-supply = <&fet1>;
 		pinctrl-0 = <&pwm0_out>;
 		pinctrl-names = "default";
 	};
@@ -314,6 +326,12 @@
 		samsung,invert-vclk;
 	};
 
+	panel: panel {
+		compatible = "auo,b116xw03";
+		power-supply = <&fet6>;
+		backlight = <&backlight>;
+	};
+
 	dp-controller at 145B0000 {
 		status = "okay";
 		pinctrl-names = "default";
@@ -325,22 +343,7 @@
 		samsung,link-rate = <0x0a>;
 		samsung,lane-count = <2>;
 		samsung,hpd-gpio = <&gpx0 7 0>;
-
-		display-timings {
-			native-mode = <&timing1>;
-
-			timing1: timing at 1 {
-				clock-frequency = <70589280>;
-				hactive = <1366>;
-				vactive = <768>;
-				hfront-porch = <40>;
-				hback-porch = <40>;
-				hsync-len = <32>;
-				vback-porch = <10>;
-				vfront-porch = <12>;
-				vsync-len = <6>;
-			};
-		};
+		bridge = <&ptn3460>;
 	};
 };
 
-- 
1.7.9.5

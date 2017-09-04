From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon,  4 Sep 2017 15:58:36 +0900
Subject: [RESEND PATCH v4 1/2] ARM: dts: uniphier: add nodes of thermal
 monitor and thermal zone for PXs2
In-Reply-To: <1504508317-12076-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1504508317-12076-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1504508317-12076-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
The thermal monitor node is included in sysctrl. Since the efuse might not
have a calibrated value of thermal monitor, this patch gives the default
value for PXs2.

Furthermore, add cpuN labels for reference in cooling-device property.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 47 +++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 90b020c..f2dfebe 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/thermal/thermal.h>
+
 / {
 	compatible = "socionext,uniphier-pxs2";
 	#address-cells = <1>;
@@ -16,7 +18,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
@@ -24,9 +26,10 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu_opp>;
+			#cooling-cells = <2>;
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
@@ -36,7 +39,7 @@
 			operating-points-v2 = <&cpu_opp>;
 		};
 
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
@@ -46,7 +49,7 @@
 			operating-points-v2 = <&cpu_opp>;
 		};
 
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
@@ -114,6 +117,35 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu_crit {
+					temperature = <95000>;	/* 95C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu_alert {
+					temperature = <85000>;	/* 85C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0
+					    THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -358,6 +390,13 @@
 				compatible = "socionext,uniphier-pxs2-reset";
 				#reset-cells = <1>;
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-pxs2-thermal";
+				interrupts = <0 3 4>;
+				#thermal-sensor-cells = <0>;
+				socionext,tmod-calibration = <0x0f86 0x6844>;
+			};
 		};
 
 		nand: nand at 68000000 {
-- 
2.7.4

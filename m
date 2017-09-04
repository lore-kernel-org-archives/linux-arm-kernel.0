From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon,  4 Sep 2017 15:58:37 +0900
Subject: [RESEND PATCH v4 2/2] arm64: dts: uniphier: add nodes of thermal
 monitor and thermal zone for LD20
In-Reply-To: <1504508317-12076-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1504508317-12076-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1504508317-12076-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of thermal monitor and thermal zone for UniPhier LD20 SoC.
The thermal monitor node is included in sysctrl. Since the efuse might not
have a calibrated value of thermal monitor, this patch gives the default
value for LD20.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a29c279..59e5ae6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/thermal/thermal.h>
+
 /memreserve/ 0x80000000 0x02000000;
 
 / {
@@ -46,6 +48,7 @@
 			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -64,6 +67,7 @@
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu at 101 {
@@ -173,6 +177,40 @@
 			     <1 10 4>;
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu_crit {
+					temperature = <110000>;	/* 110C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu_alert {
+					temperature = <100000>;	/* 100C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0
+					    THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu2
+					    THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	soc at 0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -410,6 +448,13 @@
 			watchdog {
 				compatible = "socionext,uniphier-wdt";
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-ld20-thermal";
+				interrupts = <0 3 4>;
+				#thermal-sensor-cells = <0>;
+				socionext,tmod-calibration = <0x0f22 0x68ee>;
+			};
 		};
 
 		nand: nand at 68000000 {
-- 
2.7.4

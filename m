From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:15 +0200
Subject: [PATCH v2 11/11] DT: QCOM: Add thermal mitigation to msm8996
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-12-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal mitigation configuration to msm8996.
With the cpufreq-dt OPP table the CPU frequency may be
scaled and therefore throttled by the thermal config.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 98 +++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8beea7e..6fa061f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/qcom,gcc-msm8996.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -88,6 +89,10 @@
 			enable-method = "psci";
 			clocks = <&kryocc 0>;
 			operating-points-v2 = <&cluster0_opp>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -102,6 +107,10 @@
 			enable-method = "psci";
 			clocks = <&kryocc 0>;
 			operating-points-v2 = <&cluster0_opp>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -112,6 +121,10 @@
 			enable-method = "psci";
 			clocks = <&kryocc 1>;
 			operating-points-v2 = <&cluster1_opp>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 			      compatible = "cache";
@@ -126,6 +139,10 @@
 			enable-method = "psci";
 			clocks = <&kryocc 1>;
 			operating-points-v2 = <&cluster1_opp>;
+			/* cooling options */
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>;
 			next-level-cache = <&L2_1>;
 		};
 
@@ -336,18 +353,33 @@
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu_alert0: trip0 {
+				cpu_alert0: cpu_alert0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn0: cpu_warn0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
-
-				cpu_crit0: trip1 {
+				cpu_crit0: cpu_crit0 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn0>;
+					cooling-device = <&CPU0 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal1 {
@@ -357,18 +389,33 @@
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
-				cpu_alert1: trip0 {
+				cpu_alert1: cpu_alert1 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn1: cpu_warn1 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
-
-				cpu_crit1: trip1 {
+				cpu_crit1: cpu_crit1 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn1>;
+					cooling-device = <&CPU0 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal2 {
@@ -378,18 +425,32 @@
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
-				cpu_alert2: trip0 {
+				cpu_alert2: cpu_alert2 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn2: cpu_warn2 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
-
-				cpu_crit2: trip1 {
+				cpu_crit2: cpu_crit2 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert2>;
+					cooling-device = <&CPU2 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn2>;
+					cooling-device = <&CPU2 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu-thermal3 {
@@ -399,18 +460,33 @@
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu_alert3: trip0 {
+				cpu_alert3: cpu_alert3 {
 					temperature = <75000>;
 					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_warn3: cpu_warn3 {
+					temperature = <90000>;
+					hysteresis = <2000>;
 					type = "passive";
 				};
-
 				cpu_crit3: trip1 {
 					temperature = <110000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert3>;
+					cooling-device = <&CPU2 THERMAL_NO_LIMIT 7>;
+				};
+				map1 {
+					trip = <&cpu_warn3>;
+					cooling-device = <&CPU2 8 THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 
-- 
1.9.1

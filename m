From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 10 Mar 2017 11:39:20 +0100
Subject: [PATCH v2 10/11] ARM: dtsi: sun8i: a33: add CPU thermal throttling
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Message-ID: <20170310103921.19469-11-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds CPU thermal throttling for the Allwinner A33. It uses the
thermal sensor present in the SoC's GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
  - updated cooling-max-level to reflect newly added OPPs,

 arch/arm/boot/dts/sun8i-a33.dtsi | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 704f2b0..df6e77f 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -43,6 +43,7 @@
  */
 
 #include "sun8i-a23-a33.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	cpu0_opp_table: opp_table0 {
@@ -139,6 +140,9 @@
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <13>;
+			#cooling-cells = <2>;
 		};
 
 		cpu at 1 {
@@ -182,6 +186,49 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&rtp>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_alert1: cpu_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_crit: cpu_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
-- 
2.9.3

From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Feb 2018 16:45:36 -0200
Subject: [PATCH 5/7] arm64: dts: ls208xa: Move cpu_thermal out of bus node
In-Reply-To: <1517856338-28289-1-git-send-email-festevam@gmail.com>
References: <1517856338-28289-1-git-send-email-festevam@gmail.com>
Message-ID: <1517856338-28289-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Move cpu_thermal node from soc node to root node.

cpu_thermal node does not have any register properties and thus
shouldn't be placed on the bus.

This fixes the following build warnings with W=1:

arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 98 +++++++++++++-------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f3a40af..137ef4d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -111,6 +111,55 @@
 		mask = <0x2>;
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+
+			thermal-sensors = <&tmu 4>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit: cpu-crit {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu2 THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+				};
+				map2 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu4 THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+				};
+				map3 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&cpu6 THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
@@ -194,55 +243,6 @@
 			#thermal-sensor-cells = <1>;
 		};
 
-		thermal-zones {
-			cpu_thermal: cpu-thermal {
-				polling-delay-passive = <1000>;
-				polling-delay = <5000>;
-
-				thermal-sensors = <&tmu 4>;
-
-				trips {
-					cpu_alert: cpu-alert {
-						temperature = <75000>;
-						hysteresis = <2000>;
-						type = "passive";
-					};
-					cpu_crit: cpu-crit {
-						temperature = <85000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
-				};
-
-				cooling-maps {
-					map0 {
-						trip = <&cpu_alert>;
-						cooling-device =
-							<&cpu0 THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-					};
-					map1 {
-						trip = <&cpu_alert>;
-						cooling-device =
-							<&cpu2 THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-					};
-					map2 {
-						trip = <&cpu_alert>;
-						cooling-device =
-							<&cpu4 THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-					};
-					map3 {
-						trip = <&cpu_alert>;
-						cooling-device =
-							<&cpu6 THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-					};
-				};
-			};
-		};
-
 		serial0: serial at 21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-- 
2.7.4

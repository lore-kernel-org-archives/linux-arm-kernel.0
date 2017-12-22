From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:17 +0100
Subject: [PATCH 06/11] arm64: dts: renesas: r8a7796: move nodes which have no
 reg property out of bus
In-Reply-To: <cover.1513936760.git.horms+renesas@verge.net.au>
References: <cover.1513936760.git.horms+renesas@verge.net.au>
Message-ID: <9b9b8fd7e7c057fc8fd8148416296e71df70af44.1513936761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pmu_a5[73], timer and thermal-zones nodes from soc node to root node.
The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

This problem is flagged by the compiler as follows:
$ make
...
  DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb
...
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
...
  DTC     arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb
...
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
...
  DTC     arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb
...
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
...
  DTC     arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb
...
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
...

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 144 +++++++++++++++----------------
 1 file changed, 68 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index c1b0d0344329..49c5893f8a35 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -154,6 +154,22 @@
 		clock-frequency = <0>;
 	};
 
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a57_0>, <&a57_1>;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>, <&a53_1>, <&a53_2>, <&a53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -190,18 +206,6 @@
 			resets = <&cpg 408>;
 		};
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		wdt0: watchdog at e6020000 {
 			compatible = "renesas,r8a7796-wdt",
 				     "renesas,rcar-gen3-wdt";
@@ -337,26 +341,6 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
-		pmu_a57 {
-			compatible = "arm,cortex-a57-pmu";
-			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&a57_0>,
-					     <&a57_1>;
-		};
-
-		pmu_a53 {
-			compatible = "arm,cortex-a53-pmu";
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&a53_0>,
-					     <&a53_1>,
-					     <&a53_2>,
-					     <&a53_3>;
-		};
-
 		ipmmu_vi0: mmu at febd0000 {
 			compatible = "renesas,ipmmu-r8a7796";
 			reg = <0 0xfebd0000 0 0x1000>;
@@ -1577,50 +1561,6 @@
 			status = "okay";
 		};
 
-		thermal-zones {
-			sensor_thermal1: sensor-thermal1 {
-				polling-delay-passive = <250>;
-				polling-delay = <1000>;
-				thermal-sensors = <&tsc 0>;
-
-				trips {
-					sensor1_crit: sensor1-crit {
-						temperature = <120000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
-				};
-			};
-
-			sensor_thermal2: sensor-thermal2 {
-				polling-delay-passive = <250>;
-				polling-delay = <1000>;
-				thermal-sensors = <&tsc 1>;
-
-				trips {
-					sensor2_crit: sensor2-crit {
-						temperature = <120000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
-				};
-			};
-
-			sensor_thermal3: sensor-thermal3 {
-				polling-delay-passive = <250>;
-				polling-delay = <1000>;
-				thermal-sensors = <&tsc 2>;
-
-				trips {
-					sensor3_crit: sensor3-crit {
-						temperature = <120000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
-				};
-			};
-		};
-
 		rcar_sound: sound at ec500000 {
 			/*
 			 * #sound-dai-cells is required
@@ -2027,4 +1967,56 @@
 			resets = <&cpg 822>;
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 0>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal2: sensor-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 1>;
+
+			trips {
+				sensor2_crit: sensor2-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal3: sensor-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 2>;
+
+			trips {
+				sensor3_crit: sensor3-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.11.0

From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:38 +0100
Subject: [PATCH 08/69] arm64: dts: renesas: r8a77995: move nodes which have no
 reg property out of bus
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <f320eead5dad37f296201bbcc00a88188a63a7da.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pmu_a53 and timer nodes from soc node to root node.  The nodes that
have been moved do not have any register properties and thus shouldn't be
placed on the bus.

This problem is flagged by the compiler as follows:
$ make W=1
...
arch/arm64/boot/dts/renesas/r8a77995-draak.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a77995-draak.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index cff42cd1a6c8..23f763beab46 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -58,6 +58,11 @@
 		clock-frequency = <0>;
 	};
 
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	scif_clk: scif {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -88,18 +93,6 @@
 			resets = <&cpg 408>;
 		};
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a77995-wdt",
 				     "renesas,rcar-gen3-wdt";
@@ -110,11 +103,6 @@
 			status = "disabled";
 		};
 
-		pmu_a53 {
-			compatible = "arm,cortex-a53-pmu";
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		ipmmu_vi0: mmu at febd0000 {
 			compatible = "renesas,ipmmu-r8a77995";
 			reg = <0 0xfebd0000 0 0x1000>;
@@ -637,4 +625,12 @@
 			status = "disabled";
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
 };
-- 
2.11.0

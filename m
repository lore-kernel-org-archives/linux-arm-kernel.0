From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:34 +0200
Subject: [PATCH 61/69] ARM: dts: r8a7790: Add PMU device nodes
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <5b68384469af764caa2c02f2c651409c6930c767.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable support for the ARM Performance Monitor Units in the Cortex-A15
and Cortex-A7 CPU cores on R-Car H2 by adding device nodes for the two
PMUs.

New Linux output:

    hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
    hw perfevents: /pmu-1: failed to probe PMU!
    hw perfevents: /pmu-1: failed to register PMU devices!

The last two lines are due to the Cortex-A7 CPU cores being described in
DT, but not enabled by the firmware.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0a426548a212..ae97ec146260 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -202,6 +202,24 @@
 		clock-frequency = <0>;
 	};
 
+	pmu-0 {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	pmu-1 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts-extended = <&gic GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
 	/* External SCIF clock */
 	scif_clk: scif {
 		compatible = "fixed-clock";
-- 
2.11.0

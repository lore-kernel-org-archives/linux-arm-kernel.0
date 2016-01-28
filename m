From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Jan 2016 13:32:55 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7794: Add thermal device to DT
Message-ID: <1453955575-32008-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*** Currently does not work
*** Not for upstream merge
*** For informational purposes only

Instantiate the thermal sensor in the r8a7794 device tree.

Based on very similar work for the r8a7790 by Magnus Damm.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Hi Morimoto-san,

as discussed briefly last week I am having some trouble enabling thermal
for the r8a7794/alt. With this patch applied on top of
renesas-devel-20160127-v4.5-rc1 I see:

# dmesg | grep thermal
[    1.089897] rcar_thermal e61f0000.thermal: thermal sensor was broken
[    1.101225] rcar_thermal: probe of e61f0000.thermal failed with error -22

I also see this with "[PATCH] thermal: core: don't call unsupported trip on
thermal_tripped_notify()" applied.

Is this a kernel issue that you are aware of?
Is there a possibility that there is a problem with my hardware?

Any insight would be greatly appreciated.

AFIK this is not urgent.

---
 arch/arm/boot/dts/r8a7794.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 5d5d8cb41191..3b84bf3c1124 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -187,6 +187,14 @@
 		status = "disabled";
 	};
 
+	thermal at e61f0000 {
+		compatible = "renesas,thermal-r8a7794", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7794_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
@@ -1045,6 +1053,14 @@
 			clock-indices = <R8A7794_CLK_IRQC>;
 			clock-output-names = "irqc";
 		};
+		mstp5_clks: mstp5_clks at e6150144 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7794_CLK_THERMAL>;
+			clock-output-names = "thermal";
+		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-- 
2.1.4

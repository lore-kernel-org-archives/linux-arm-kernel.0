From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 11:56:33 +0100
Subject: [PATCH  3/3] ARM: dts: r8a7743: Add OPP table for frequency scaling
In-Reply-To: <1502189793-59679-1-git-send-email-biju.das@bp.renesas.com>
References: <1502189793-59679-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502189793-59679-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add needed information inside CPU0 for the generic cpufreq-cpu0 driver.

- clock-latency = 300 us
Approximate worst-case latency to do clock transition for every
OPPs. Using an arbitrary safe value similar to r8a7791(R-Car M2) Soc.

- operating-points = < kHz - uV >
List of 6 operating points. All of them are using the same voltage
since DVS is not supported in RZ/G1 Soc.

Note:This also fixes the below errors seen on kernel logs
[    0.876877] cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
[    0.883727] cpu cpu1: cpufreq_init: failed to get clk: -2

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 77da319..8c46f62 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -29,8 +29,17 @@
 			reg = <0>;
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7743_CLK_Z>;
+			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7743_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1500000 1000000>,
+					   <1312500 1000000>,
+					   <1125000 1000000>,
+					   < 937500 1000000>,
+					   < 750000 1000000>,
+					   < 375000 1000000>;
 		};
 
 		cpu1: cpu at 1 {
-- 
1.9.1

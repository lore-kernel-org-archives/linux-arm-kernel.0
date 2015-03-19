From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 01:19:08 +0800
Subject: [PATCH 6/6] ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i
In-Reply-To: <1426785548-5932-1-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
Message-ID: <1426785548-5932-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock driver now supports a muxable ahb clock. Update the dtsi
with the proper compatible and add the new parent clocks.

This also adds the new pll6/4 output for pll6 on sun7i-a20. The
output is not used on sun4/5i.

Also use assigned-clocks to reparent ahb to pll6. We want ahb to
have a stable, non-changing clock rate. cpu/axi clock rate changes
as a result of newly added cpufreq support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i.dtsi     | 10 ++++++++--
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 ++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index e42cbb03620f..df79b4c75b34 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -150,10 +150,16 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-ahb-clk";
+			compatible = "allwinner,sun5i-a13-ahb-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&axi>;
+			clocks = <&axi>, <&cpu>, <&pll6 1>;
 			clock-output-names = "ahb";
+			/*
+			 * Use PLL6 as parent, instead of CPU/AXI
+			 * which has rate changes due to cpufreq
+			 */
+			assigned-clocks = <&ahb>;
+			assigned-clock-parents = <&pll6 1>;
 		};
 
 		apb0: apb0 at 01c20054 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 3a8530b79f1c..52538beb969a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -225,7 +225,8 @@
 			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6_sata", "pll6_other", "pll6";
+			clock-output-names = "pll6_sata", "pll6_other", "pll6",
+					     "pll6_div_4";
 		};
 
 		pll8: clk at 01c20040 {
@@ -254,10 +255,16 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-ahb-clk";
+			compatible = "allwinner,sun5i-a13-ahb-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&axi>;
+			clocks = <&axi>, <&pll6 3>, <&pll6 1>;
 			clock-output-names = "ahb";
+			/*
+			 * Use PLL6 as parent, instead of CPU/AXI
+			 * which has rate changes due to cpufreq
+			 */
+			assigned-clocks = <&ahb>;
+			assigned-clock-parents = <&pll6 3>;
 		};
 
 		ahb_gates: clk at 01c20060 {
-- 
2.1.4

From: william.towle@codethink.co.uk (William Towle)
Date: Tue,  4 Feb 2014 18:17:37 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: specify multiple parents for
 cpg_clks
In-Reply-To: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
Message-ID: <1391537858-28593-3-git-send-email-william.towle@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current drivers/clk/shmobile/clk-rcar-gen2.c uses the
extal_clk reference for the parent of all the clocks that
it registers. However the lb, qspi, sdh, sd0 and sd1 clocks
are all parented to either pll1 or pll1_div2 which means
that the clock rates are incorrect.

This is part of the fix that corrects the SDHI0 clock
rate error where it reports 1MHz instead of 97.5:
    sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 1 MHz

Notes:
- May require cross-merge with clk-rcar-gen2.c fix
- Also not clear which clock "z" is to fix it.

[ben.dooks at codethink.co.uk: updated patch description]
Signed-off-by: William Towle <william.towle@codethink.co.uk>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ff55c6e..242e6e2 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -446,7 +446,13 @@
 			compatible = "renesas,r8a7790-cpg-clocks",
 				     "renesas,rcar-gen2-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
+			clocks = <&extal_clk>, <&extal_clk>, <&extal_clk>, <&extal_clk>,
+				<&cpg_clocks R8A7790_CLK_PLL1>,
+				<&pll1_div2_clk>,
+				<&cpg_clocks R8A7790_CLK_PLL1>,
+				<&cpg_clocks R8A7790_CLK_PLL1>,
+				<&cpg_clocks R8A7790_CLK_PLL1>
+				/* not known for "z" ...,<> */;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "sd1",
-- 
1.7.10.4

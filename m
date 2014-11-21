From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Fri, 21 Nov 2014 10:27:41 +0100
Subject: [PATCH] clk: rockchip: fix clock gate for rk3188 spdif_pre
Message-ID: <1416562062-14286-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In rk3188 clock branches, spdif_pre gate was set to RK2928_CLKGATE_CON(13) bit 13.
This appears to be a copy-paste error because such a register does not exist.
We correct it to RK2928_CLKGATE_CON(0) and find out that the rk3188 spdif clock
is the same as the rk3066 spdif clock, so we move it to the common clock branches.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 drivers/clk/rockchip/clk-rk3188.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index b0293c4..725d841 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -330,6 +330,15 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(24), 8, 8, DFLAGS,
 			RK2928_CLKGATE_CON(2), 8, GFLAGS),
 
+	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
+			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
+			RK2928_CLKGATE_CON(0), 13, GFLAGS),
+	COMPOSITE_FRAC(0, "spdif_frac", "spdif_pll", 0,
+			RK2928_CLKSEL_CON(9), 0,
+			RK2928_CLKGATE_CON(0), 14, GFLAGS),
+	MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
+			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
+
 	/*
 	 * Clock-Architecture Diagram 4
 	 */
@@ -577,14 +586,6 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 12, GFLAGS),
 	MUX(SCLK_I2S2, "sclk_i2s2", mux_sclk_i2s2_p, 0,
 			RK2928_CLKSEL_CON(4), 8, 2, MFLAGS),
-	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
-			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
-			RK2928_CLKGATE_CON(0), 13, GFLAGS),
-	COMPOSITE_FRAC(0, "spdif_frac", "spdif_pll", 0,
-			RK2928_CLKSEL_CON(9), 0,
-			RK2928_CLKGATE_CON(0), 14, GFLAGS),
-	MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
-			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
 
 	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
@@ -675,14 +676,6 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 10, GFLAGS),
 	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, 0,
 			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS),
-	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
-			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
-			RK2928_CLKGATE_CON(13), 13, GFLAGS),
-	COMPOSITE_FRAC(0, "spdif_frac", "spdif_pll", 0,
-			RK2928_CLKSEL_CON(9), 0,
-			RK2928_CLKGATE_CON(0), 14, GFLAGS),
-	MUX(SCLK_SPDIF, "sclk_spdif", mux_sclk_spdif_p, 0,
-			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
 
 	GATE(0, "hclk_imem0", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 	GATE(0, "hclk_imem1", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 15, GFLAGS),
-- 
2.1.0

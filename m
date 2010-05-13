From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:04 +0900
Subject: [PATCH 03/11] ARM: S5P6440: Remove usage of clk_arm and add
	clk_armclk clock
Message-ID: <1273710424-14591-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_arm clock is of type 'struct clk' whereas on S5P6440,
the arm clock is more suitable to be of type 'struct clksrc_clk'
(since arm clock is divided version of apll clock).

This patch modifies the following.

1. Removes the usage of clk_arm clock (defined in plat-s5p) and
   defines the new clock 'clk_armclk' of type 'struct clksrc_clk'.

2. Rearranges the assignment of clock rate for the fout_a/m/epll
   clocks. This will help in calculating the clock rate of fclk
   from clk_armclk clock and setup the clock rate for fout_m/epll
   for subsequent patches which depend on it.

3. Modifies the clock rate calculation of fclk to be based on
   the newly added clk_armclk clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index 8bd6f15..2c6dd54 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -247,6 +247,16 @@ static struct clk_ops s5p6440_clkarm_ops = {
 	.round_rate	= s5p6440_armclk_round_rate,
 };
 
+static struct clksrc_clk clk_armclk = {
+	.clk	= {
+		.name	= "armclk",
+		.id	= 1,
+		.parent	= &clk_mout_apll.clk,
+		.ops	= &s5p6440_clkarm_ops,
+	},
+	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 0, .size = 4 },
+};
+
 static struct clksrc_clk clk_dout_mpll = {
 	.clk	= {
 		.name	= "dout_mpll",
@@ -569,6 +579,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_epll,
 	&clk_mout_mpll,
 	&clk_dout_mpll,
+	&clk_armclk,
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -592,8 +603,6 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	clk_fout_epll.ops = &s5p6440_epll_ops;
 
 	/* Set S5P6440 functions for arm clock */
-	clk_arm.parent = &clk_mout_apll.clk;
-	clk_arm.ops = &s5p6440_clkarm_ops;
 	clk_48m.enable = s5p6440_clk48m_ctrl;
 
 	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
@@ -610,11 +619,15 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
 	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4502);
 
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+	clk_fout_apll.rate = apll;
+
 	printk(KERN_INFO "S5P6440: PLL settings, A=%ld.%ldMHz, M=%ld.%ldMHz," \
 			" E=%ld.%ldMHz\n",
 			print_mhz(apll), print_mhz(mpll), print_mhz(epll));
 
-	fclk = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_ARM);
+	fclk = clk_get_rate(&clk_armclk.clk);
 	hclk = fclk / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK);
 	pclk = hclk / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK);
 
@@ -633,10 +646,6 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 			print_mhz(hclk), print_mhz(hclk_low),
 			print_mhz(pclk), print_mhz(pclk_low));
 
-	clk_fout_mpll.rate = mpll;
-	clk_fout_epll.rate = epll;
-	clk_fout_apll.rate = apll;
-
 	clk_f.rate = fclk;
 	clk_h.rate = hclk;
 	clk_p.rate = pclk;
-- 
1.6.2.5

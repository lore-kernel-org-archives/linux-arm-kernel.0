From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:26:58 +0900
Subject: [PATCH 02/11] ARM: S5P6440: Change dout_mpll clock type to clksrc_clk
	clock type.
Message-ID: <1273710418-14558-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch modifies the following.

1. Modifies the dout_mpll clock type as clksrc_clk clock type.
   This modification allows the use of common clock code in
   managing the dout_mpll clock (which otherwise would need
   custom defined functions such as s5p6440_clk_doutmpll_get_rate).

2. s5p6440_clk_doutmpll_get_rate function is removed as it is
   no longer needed.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index 3ad63f4..8bd6f15 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -247,23 +247,13 @@ static struct clk_ops s5p6440_clkarm_ops = {
 	.round_rate	= s5p6440_armclk_round_rate,
 };
 
-static unsigned long s5p6440_clk_doutmpll_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-
-	if (__raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_MPLL_MASK)
-		rate /= 2;
-
-	return rate;
-}
-
-static struct clk clk_dout_mpll = {
-	.name		= "dout_mpll",
-	.id		= -1,
-	.parent		= &clk_mout_mpll.clk,
-	.ops            = &(struct clk_ops) {
-		.get_rate	= s5p6440_clk_doutmpll_get_rate,
+static struct clksrc_clk clk_dout_mpll = {
+	.clk	= {
+		.name	= "dout_mpll",
+		.id	= -1,
+		.parent	= &clk_mout_mpll.clk,
 	},
+	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 4, .size = 1 },
 };
 
 int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
@@ -490,7 +480,7 @@ static struct clk clk_pcm_cd = {
 
 static struct clk *clkset_spi_mmc_list[] = {
 	&clk_mout_epll.clk,
-	&clk_dout_mpll,
+	&clk_dout_mpll.clk,
 	&clk_fin_epll,
 };
 
@@ -501,7 +491,7 @@ static struct clksrc_sources clkset_spi_mmc = {
 
 static struct clk *clkset_uart_list[] = {
 	&clk_mout_epll.clk,
-	&clk_dout_mpll
+	&clk_dout_mpll.clk,
 };
 
 static struct clksrc_sources clkset_uart = {
@@ -578,6 +568,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
 	&clk_mout_epll,
 	&clk_mout_mpll,
+	&clk_dout_mpll,
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -658,7 +649,6 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 
 static struct clk *clks[] __initdata = {
 	&clk_ext,
-	&clk_dout_mpll,
 	&clk_iis_cd_v40,
 	&clk_pcm_cd,
 	&clk_p_low,
-- 
1.6.2.5

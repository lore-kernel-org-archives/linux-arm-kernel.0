From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:17 +0900
Subject: [PATCH 06/11] ARM: S5P6440: Remove usage of clk_h_low and add
	clk_hclk_low clock
Message-ID: <1273710437-14690-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_h_low clock is of type 'struct clk' whereas on S5P6440,
the hclk_low clock is more suitable to be of type 'struct clksrc_clk'
(since hclk_low clock is derived from a choice of clock sources and
then divided by a divisor).

This patch modifies the following.

1. Removes the definition and usage of clk_h_clk clock.
2. Adds the clk_hclk_low clock of type 'struct clksrc_clk' clock.
3. Adds clk_hclk_low to the list of system clocks.
4. The clock rate of hclk_low is derived from the clk_hclk_low clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   54 +++++++++++++++++++++-------------------
 1 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index 61bc85b..c70b3a4 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -134,15 +134,6 @@ static struct clksrc_clk clk_mout_mpll = {
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 1, .size = 1 },
 };
 
-static struct clk clk_h_low = {
-	.name		= "hclk_low",
-	.id		= -1,
-	.rate		= 0,
-	.parent		= NULL,
-	.ctrlbit	= 0,
-	.ops		= &clk_ops_def_setrate,
-};
-
 static struct clk clk_p_low = {
 	.name		= "pclk_low",
 	.id		= -1,
@@ -284,6 +275,26 @@ static struct clksrc_clk clk_pclk = {
 	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 4 },
 };
 
+static struct clk *clkset_hclklow_list[] = {
+	&clk_mout_apll.clk,
+	&clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clkset_hclklow = {
+	.sources	= clkset_hclklow_list,
+	.nr_sources	= ARRAY_SIZE(clkset_hclklow_list),
+};
+
+static struct clksrc_clk clk_hclk_low = {
+	.clk = {
+		.name	= "hclk_low",
+		.id	= -1,
+	},
+	.sources	= &clkset_hclklow,
+	.reg_src	= { .reg = S5P_SYS_OTHERS, .shift = 6, .size = 1 },
+	.reg_div	= { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
+};
+
 int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
 {
 	unsigned long flags;
@@ -405,37 +416,37 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name    	= "otg",
 		.id	   	= -1,
-		.parent  	= &clk_h_low,
+		.parent		= &clk_hclk_low.clk,
 		.enable  	= s5p6440_hclk0_ctrl,
 		.ctrlbit 	= S5P_CLKCON_HCLK0_USB
 	}, {
 		.name    	= "post",
 		.id	   	= -1,
-		.parent  	= &clk_h_low,
+		.parent		= &clk_hclk_low.clk,
 		.enable  	= s5p6440_hclk0_ctrl,
 		.ctrlbit 	= S5P_CLKCON_HCLK0_POST0
 	}, {
 		.name		= "lcd",
 		.id		= -1,
-		.parent		= &clk_h_low,
+		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk1_ctrl,
 		.ctrlbit	= S5P_CLKCON_HCLK1_DISPCON,
 	}, {
 		.name		= "hsmmc",
 		.id		= 0,
-		.parent		= &clk_h_low,
+		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk0_ctrl,
 		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC0,
 	}, {
 		.name		= "hsmmc",
 		.id		= 1,
-		.parent		= &clk_h_low,
+		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk0_ctrl,
 		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC1,
 	}, {
 		.name		= "hsmmc",
 		.id		= 2,
-		.parent		= &clk_h_low,
+		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p6440_hclk0_ctrl,
 		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC2,
 	}, {
@@ -600,6 +611,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_armclk,
 	&clk_hclk,
 	&clk_pclk,
+	&clk_hclk_low,
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -650,15 +662,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	fclk = clk_get_rate(&clk_armclk.clk);
 	hclk = clk_get_rate(&clk_hclk.clk);
 	pclk = clk_get_rate(&clk_pclk.clk);
-
-	if (__raw_readl(S5P_OTHERS) & S5P_OTHERS_HCLK_LOW_SEL_MPLL) {
-		/* Asynchronous mode */
-		hclk_low = mpll / GET_DIV(clkdiv3, S5P_CLKDIV3_HCLK_LOW);
-	} else {
-		/* Synchronous mode */
-		hclk_low = apll / GET_DIV(clkdiv3, S5P_CLKDIV3_HCLK_LOW);
-	}
-
+	hclk_low = clk_get_rate(&clk_hclk_low.clk);
 	pclk_low = hclk_low / GET_DIV(clkdiv3, S5P_CLKDIV3_PCLK_LOW);
 
 	printk(KERN_INFO "S5P6440: HCLK=%ld.%ldMHz, HCLK_LOW=%ld.%ldMHz," \
@@ -669,7 +673,6 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	clk_f.rate = fclk;
 	clk_h.rate = hclk;
 	clk_p.rate = pclk;
-	clk_h_low.rate = hclk_low;
 	clk_p_low.rate = pclk_low;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
@@ -681,7 +684,6 @@ static struct clk *clks[] __initdata = {
 	&clk_iis_cd_v40,
 	&clk_pcm_cd,
 	&clk_p_low,
-	&clk_h_low,
 };
 
 void __init s5p6440_register_clocks(void)
-- 
1.6.2.5

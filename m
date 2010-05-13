From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:29 +0900
Subject: [PATCH 07/11] ARM: S5P6440: Remove usage of clk_p_low and add
	clk_pclk_low clock
Message-ID: <1273710449-14723-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The pclk_low clock is of type 'struct clk' whereas on S5P6440,
the pclk_low clock is more suitable to be of type 'struct clksrc_clk'
(since pclk_low clock is a divided clock of hclk_low clock).

This patch modifies the following.

1. Removes the definition and usage of clk_p_clk clock.
2. Adds the clk_pclk_low clock of type 'struct clksrc_clk' clock.
3. Adds clk_pclk_low to the list of system clocks.
4. The clock rate of pclk_low is derived from the clk_pclk_low clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   55 ++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index c70b3a4..80d18f5 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -134,15 +134,6 @@ static struct clksrc_clk clk_mout_mpll = {
 	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 1, .size = 1 },
 };
 
-static struct clk clk_p_low = {
-	.name		= "pclk_low",
-	.id		= -1,
-	.rate		= 0,
-	.parent		= NULL,
-	.ctrlbit	= 0,
-	.ops		= &clk_ops_def_setrate,
-};
-
 enum perf_level {
 	L0 = 532*1000,
 	L1 = 266*1000,
@@ -295,6 +286,15 @@ static struct clksrc_clk clk_hclk_low = {
 	.reg_div	= { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
 };
 
+static struct clksrc_clk clk_pclk_low = {
+	.clk	= {
+		.name	= "pclk_low",
+		.id	= -1,
+		.parent	= &clk_hclk_low.clk,
+	},
+	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
+};
+
 int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
 {
 	unsigned long flags;
@@ -356,31 +356,31 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "adc",
 		.id		= -1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_TSADC,
 	}, {
 		.name		= "i2c",
 		.id		= -1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_IIC0,
 	}, {
 		.name		= "i2s_v40",
 		.id		= 0,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_IIS2,
 	}, {
 		.name		= "spi",
 		.id		= 0,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_SPI0,
 	}, {
 		.name		= "spi",
 		.id		= 1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_SPI1,
 	}, {
@@ -452,19 +452,19 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "rtc",
 		.id		= -1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_RTC,
 	}, {
 		.name		= "watchdog",
 		.id		= -1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_WDT,
 	}, {
 		.name		= "timers",
 		.id		= -1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_PWM,
 	}
@@ -477,31 +477,31 @@ static struct clk init_clocks[] = {
 	{
 		.name		= "gpio",
 		.id		= -1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_GPIO,
 	}, {
 		.name		= "uart",
 		.id		= 0,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_UART0,
 	}, {
 		.name		= "uart",
 		.id		= 1,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_UART1,
 	}, {
 		.name		= "uart",
 		.id		= 2,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_UART2,
 	}, {
 		.name		= "uart",
 		.id		= 3,
-		.parent		= &clk_p_low,
+		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_UART3,
 	}
@@ -612,6 +612,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_hclk,
 	&clk_pclk,
 	&clk_hclk_low,
+	&clk_pclk_low,
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -627,19 +628,13 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	unsigned long apll;
 	unsigned long mpll;
 	unsigned int ptr;
-	u32 clkdiv0;
-	u32 clkdiv3;
 
 	/* Set S5P6440 functions for clk_fout_epll */
 	clk_fout_epll.enable = s5p6440_epll_enable;
 	clk_fout_epll.ops = &s5p6440_epll_ops;
 
-	/* Set S5P6440 functions for arm clock */
 	clk_48m.enable = s5p6440_clk48m_ctrl;
 
-	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
-	clkdiv3 = __raw_readl(S5P_CLK_DIV3);
-
 	xtal_clk = clk_get(NULL, "ext_xtal");
 	BUG_ON(IS_ERR(xtal_clk));
 
@@ -663,7 +658,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	hclk = clk_get_rate(&clk_hclk.clk);
 	pclk = clk_get_rate(&clk_pclk.clk);
 	hclk_low = clk_get_rate(&clk_hclk_low.clk);
-	pclk_low = hclk_low / GET_DIV(clkdiv3, S5P_CLKDIV3_PCLK_LOW);
+	pclk_low = clk_get_rate(&clk_pclk_low.clk);
 
 	printk(KERN_INFO "S5P6440: HCLK=%ld.%ldMHz, HCLK_LOW=%ld.%ldMHz," \
 			" PCLK=%ld.%ldMHz, PCLK_LOW=%ld.%ldMHz\n",
@@ -673,7 +668,6 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	clk_f.rate = fclk;
 	clk_h.rate = hclk;
 	clk_p.rate = pclk;
-	clk_p_low.rate = pclk_low;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
@@ -683,7 +677,6 @@ static struct clk *clks[] __initdata = {
 	&clk_ext,
 	&clk_iis_cd_v40,
 	&clk_pcm_cd,
-	&clk_p_low,
 };
 
 void __init s5p6440_register_clocks(void)
-- 
1.6.2.5

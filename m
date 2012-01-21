From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:36:23 +0900
Subject: [PATCH 4/7] ARM: S5P64X0: use static declaration when it is not used
 in other files
Message-ID: <010c01ccd7f6$3abb6cb0$b0324610$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/clock.c                      |   11 ++++++-----
 arch/arm/mach-s5p64x0/dma.c                        |   10 +++++-----
 arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h |    7 -------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock.c b/arch/arm/mach-s5p64x0/clock.c
index 241d0e6..57e7189 100644
--- a/arch/arm/mach-s5p64x0/clock.c
+++ b/arch/arm/mach-s5p64x0/clock.c
@@ -73,7 +73,7 @@ static const u32 clock_table[][3] = {
 	{L2 * 1000, (3 << ARM_DIV_RATIO_SHIFT), (0 << S5P64X0_CLKDIV0_HCLK_SHIFT)},
 };
 
-unsigned long s5p64x0_armclk_get_rate(struct clk *clk)
+static unsigned long s5p64x0_armclk_get_rate(struct clk *clk)
 {
 	unsigned long rate = clk_get_rate(clk->parent);
 	u32 clkdiv;
@@ -84,7 +84,8 @@ unsigned long s5p64x0_armclk_get_rate(struct clk *clk)
 	return rate / (clkdiv + 1);
 }
 
-unsigned long s5p64x0_armclk_round_rate(struct clk *clk, unsigned long rate)
+static unsigned long s5p64x0_armclk_round_rate(struct clk *clk,
+					       unsigned long rate)
 {
 	u32 iter;
 
@@ -96,7 +97,7 @@ unsigned long s5p64x0_armclk_round_rate(struct clk *clk, unsigned long rate)
 	return clock_table[ARRAY_SIZE(clock_table) - 1][0];
 }
 
-int s5p64x0_armclk_set_rate(struct clk *clk, unsigned long rate)
+static int s5p64x0_armclk_set_rate(struct clk *clk, unsigned long rate)
 {
 	u32 round_tmp;
 	u32 iter;
@@ -148,7 +149,7 @@ int s5p64x0_armclk_set_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-struct clk_ops s5p64x0_clkarm_ops = {
+static struct clk_ops s5p64x0_clkarm_ops = {
 	.get_rate	= s5p64x0_armclk_get_rate,
 	.set_rate	= s5p64x0_armclk_set_rate,
 	.round_rate	= s5p64x0_armclk_round_rate,
@@ -173,7 +174,7 @@ struct clksrc_clk clk_dout_mpll = {
 	.reg_div	= { .reg = S5P64X0_CLK_DIV0, .shift = 4, .size = 1 },
 };
 
-struct clk *clkset_hclk_low_list[] = {
+static struct clk *clkset_hclk_low_list[] = {
 	&clk_mout_apll.clk,
 	&clk_mout_mpll.clk,
 };
diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
index f820c07..8fce116 100644
--- a/arch/arm/mach-s5p64x0/dma.c
+++ b/arch/arm/mach-s5p64x0/dma.c
@@ -38,7 +38,7 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-u8 s5p6440_pdma_peri[] = {
+static u8 s5p6440_pdma_peri[] = {
 	DMACH_UART0_RX,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
@@ -63,12 +63,12 @@ u8 s5p6440_pdma_peri[] = {
 	DMACH_SPI1_RX,
 };
 
-struct dma_pl330_platdata s5p6440_pdma_pdata = {
+static struct dma_pl330_platdata s5p6440_pdma_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(s5p6440_pdma_peri),
 	.peri_id = s5p6440_pdma_peri,
 };
 
-u8 s5p6450_pdma_peri[] = {
+static u8 s5p6450_pdma_peri[] = {
 	DMACH_UART0_RX,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
@@ -103,12 +103,12 @@ u8 s5p6450_pdma_peri[] = {
 	DMACH_UART5_TX,
 };
 
-struct dma_pl330_platdata s5p6450_pdma_pdata = {
+static struct dma_pl330_platdata s5p6450_pdma_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(s5p6450_pdma_peri),
 	.peri_id = s5p6450_pdma_peri,
 };
 
-struct amba_device s5p64x0_device_pdma = {
+static struct amba_device s5p64x0_device_pdma = {
 	.dev = {
 		.init_name = "dma-pl330",
 		.dma_mask = &dma_dmamask,
diff --git a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
index ff85b4b..0ef47d1 100644
--- a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
+++ b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
@@ -22,16 +22,9 @@ extern struct clksrc_clk clk_mout_epll;
 extern int s5p64x0_epll_enable(struct clk *clk, int enable);
 extern unsigned long s5p64x0_epll_get_rate(struct clk *clk);
 
-extern unsigned long s5p64x0_armclk_get_rate(struct clk *clk);
-extern unsigned long s5p64x0_armclk_round_rate(struct clk *clk, unsigned long rate);
-extern int s5p64x0_armclk_set_rate(struct clk *clk, unsigned long rate);
-
-extern struct clk_ops s5p64x0_clkarm_ops;
-
 extern struct clksrc_clk clk_armclk;
 extern struct clksrc_clk clk_dout_mpll;
 
-extern struct clk *clkset_hclk_low_list[];
 extern struct clksrc_sources clkset_hclk_low;
 
 extern int s5p64x0_pclk_ctrl(struct clk *clk, int enable);
-- 
1.7.1

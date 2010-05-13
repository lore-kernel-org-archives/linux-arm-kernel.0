From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:09 +0900
Subject: [PATCH 04/11] ARM: S5P6440: Remove usage of clk_h and add clk_hclk
	clock
Message-ID: <1273710429-14624-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_h clock is of type 'struct clk' whereas on S5P6440,
the hclk is more suitable to be of type 'struct clksrc_clk'
(since hclk clock is divided version of armclk)

This patch modifies the following.

1. Adds the 'clk_hclk' clock which is of type 'struct clksrc_clk'.
2. Removes all references to the clk_h clock.
3. Addes clk_hclk into the list of sysclks.
4. The clock rate 'hclk' is modified to be derived from clk_hclk.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index 2c6dd54..bc0458e 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -266,6 +266,15 @@ static struct clksrc_clk clk_dout_mpll = {
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 4, .size = 1 },
 };
 
+static struct clksrc_clk clk_hclk = {
+	.clk	= {
+		.name	= "clk_hclk",
+		.id	= -1,
+		.parent	= &clk_armclk.clk,
+	},
+	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 4 },
+};
+
 int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
 {
 	unsigned long flags;
@@ -321,7 +330,7 @@ static struct clk init_clocks_disable[] = {
 	{
 		.name		= "nand",
 		.id		= -1,
-		.parent		= &clk_h,
+		.parent		= &clk_hclk.clk,
 		.enable		= s5p6440_mem_ctrl,
 		.ctrlbit	= S5P_CLKCON_MEM0_HCLK_NFCON,
 	}, {
@@ -580,6 +589,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_mpll,
 	&clk_dout_mpll,
 	&clk_armclk,
+	&clk_hclk,
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -628,7 +638,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 			print_mhz(apll), print_mhz(mpll), print_mhz(epll));
 
 	fclk = clk_get_rate(&clk_armclk.clk);
-	hclk = fclk / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK);
+	hclk = clk_get_rate(&clk_hclk.clk);
 	pclk = hclk / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK);
 
 	if (__raw_readl(S5P_OTHERS) & S5P_OTHERS_HCLK_LOW_SEL_MPLL) {
-- 
1.6.2.5

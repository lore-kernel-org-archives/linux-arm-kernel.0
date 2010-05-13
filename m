From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:13 +0900
Subject: [PATCH 05/11] ARM: S5P6440: Remove usage of clk_p and add clk_pclk
	clock
Message-ID: <1273710433-14657-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_p clock is of type 'struct clk' whereas on S5P6440,
the pclk is more suitable to be of type 'struct clksrc_clk'
(since pclk clock is divided version of hclk).

This patch modifies the following.

1. Adds the 'clk_pclk' clock which is of type 'struct clksrc_clk'.
2. Adds clk_pclk into the list of sysclks.
3. The clock rate 'pclk' is modified to be derived from clk_pclk.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index bc0458e..61bc85b 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -275,6 +275,15 @@ static struct clksrc_clk clk_hclk = {
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 4 },
 };
 
+static struct clksrc_clk clk_pclk = {
+	.clk	= {
+		.name	= "clk_pclk",
+		.id	= -1,
+		.parent	= &clk_hclk.clk,
+	},
+	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 4 },
+};
+
 int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
 {
 	unsigned long flags;
@@ -590,6 +599,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_dout_mpll,
 	&clk_armclk,
 	&clk_hclk,
+	&clk_pclk,
 };
 
 void __init_or_cpufreq s5p6440_setup_clocks(void)
@@ -639,7 +649,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 
 	fclk = clk_get_rate(&clk_armclk.clk);
 	hclk = clk_get_rate(&clk_hclk.clk);
-	pclk = hclk / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK);
+	pclk = clk_get_rate(&clk_pclk.clk);
 
 	if (__raw_readl(S5P_OTHERS) & S5P_OTHERS_HCLK_LOW_SEL_MPLL) {
 		/* Asynchronous mode */
-- 
1.6.2.5

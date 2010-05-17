From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:31 +0900
Subject: [PATCH 04/18] ARM: S5PV210: Add armclk of clksrc_clk clock type
Message-ID: <1274056711-14317-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch modifies the following.

1. Adds arm clock 'clk_armclk' of type clksrc_clk clock type.
2. Adds arm clock to the list of system clocks 'sysclks' for
   registering it along with other system clocks.
3. Modifies the armclk clock rate calculation procedure to be
   based on the new clk_armclk clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index d782fed..f57fa1e 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -58,6 +58,26 @@ static struct clksrc_clk clk_mout_mpll = {
 	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
 };
 
+static struct clk *clkset_armclk_list[] = {
+	[0] = &clk_mout_apll.clk,
+	[1] = &clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clkset_armclk = {
+	.sources	= clkset_armclk_list,
+	.nr_sources	= ARRAY_SIZE(clkset_armclk_list),
+};
+
+static struct clksrc_clk clk_armclk = {
+	.clk	= {
+		.name		= "armclk",
+		.id		= -1,
+	},
+	.sources	= &clkset_armclk,
+	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 16, .size = 1 },
+	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 0, .size = 3 },
+};
+
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
@@ -328,6 +348,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
 	&clk_mout_epll,
 	&clk_mout_mpll,
+	&clk_armclk,
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -376,7 +397,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	printk(KERN_INFO "S5PV210: PLL settings, A=%ld, M=%ld, E=%ld",
 			apll, mpll, epll);
 
-	armclk = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_APLL);
+	armclk = clk_get_rate(&clk_armclk.clk);
 	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX200_MASK)
 		hclk200 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK200);
 	else
-- 
1.6.2.5

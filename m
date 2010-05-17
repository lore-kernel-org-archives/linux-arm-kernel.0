From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:48 +0900
Subject: [PATCH 10/18] ARM: S5PV210: Remove usage of clk_p83 and add
	clk_pclk_dsys clock\
Message-ID: <1274056728-14515-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_p83 clock, which is the PCLK clock for DSYS domain, is of
type 'struct clk' whereas on S5PV210, this clock is suitable to be
of type clksrc_clk clock (since it has a clock divider). So this
patch replaces the 'struct clk' type clock to 'struct clksrc_clk'
type clock for the PCLK DSYS clock.

This patch modifies the following.

1. Remove definitions and usage of 'clk_p83' clock.
2. Adds 'clk_pclk_dsys' clock which is of type 'struct clksrc_clk'.
3. Replace all usage of clk_p83 with clk_pclk_dsys clock.
4. Adds clk_pclk_dsys into list of clocks to be registered.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 527c9c4..b46d9ec 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -125,6 +125,15 @@ static struct clksrc_clk clk_hclk_dsys = {
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 4 },
 };
 
+static struct clksrc_clk clk_pclk_dsys = {
+	.clk	= {
+		.name	= "pclk_dsys",
+		.id	= -1,
+		.parent	= &clk_hclk_dsys.clk,
+	},
+	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 20, .size = 3 },
+};
+
 static struct clksrc_clk clk_hclk_psys = {
 	.clk	= {
 		.name	= "hclk_psys",
@@ -155,18 +164,12 @@ static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
 }
 
-static struct clk clk_p83 = {
-	.name		= "pclk83",
-	.id		= -1,
-};
-
 static struct clk clk_p66 = {
 	.name		= "pclk66",
 	.id		= -1,
 };
 
 static struct clk *sys_clks[] = {
-	&clk_p83,
 	&clk_p66
 };
 
@@ -397,6 +400,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_hclk_dsys,
 	&clk_hclk_psys,
 	&clk_pclk_msys,
+	&clk_pclk_dsys,
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -410,7 +414,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned long hclk_dsys;
 	unsigned long hclk_psys;
 	unsigned long pclk_msys;
-	unsigned long pclk83;
+	unsigned long pclk_dsys;
 	unsigned long pclk66;
 	unsigned long apll;
 	unsigned long mpll;
@@ -450,19 +454,18 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	hclk_dsys = clk_get_rate(&clk_hclk_dsys.clk);
 	hclk_psys = clk_get_rate(&clk_hclk_psys.clk);
 	pclk_msys = clk_get_rate(&clk_pclk_msys.clk);
-	pclk83 = hclk_dsys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
+	pclk_dsys = clk_get_rate(&clk_pclk_dsys.clk);
 	pclk66 = hclk_psys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
 
 	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld\n"
 			 "HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
 			armclk, hclk_msys, hclk_dsys, hclk_psys,
-			pclk_msys, pclk83, pclk66);
+			pclk_msys, pclk_dsys, pclk66);
 
 	clk_f.rate = armclk;
 	clk_h.rate = hclk_psys;
 	clk_p.rate = pclk66;
 	clk_p66.rate = pclk66;
-	clk_p83.rate = pclk83;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
-- 
1.6.2.5

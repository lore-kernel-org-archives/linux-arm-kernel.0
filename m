From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:37 +0900
Subject: [PATCH 06/18] ARM: S5PV210: Remove usage of clk_h166 and add
	clk_hclk_dsys clock
Message-ID: <1274056717-14383-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_h166 clock, which is the HCLK clock for DSYS domain, is of
type 'struct clk' whereas on S5PV210, this clock is suitable to be
of type clksrc_clk clock (since it has a choice of clock source
and a pre-divider). So this patch replaces the 'struct clk' type
clock to 'struct clksrc_clk' type clock for the HCLK DSYS clock.

This patch modifies the following.

1. Remove definitions and usage of 'clk_h166' clock.

2. Adds 'clk_sclk_a2m' clock which is one of possible parent clock
   sources for the DSYS HCLK clock.

3. Adds 'clk_hclk_dsys' clock which is of type 'struct clksrc_clk'.

4. Replace all usage of clk_h166 with clk_hclk_dsys clock.

5. Adds clk_sclk_a2m and clk_hclk_dsys into list of clocks to
   be registered.

6. Removes the clock rate calculation of hclk166 and replaces
   it with code that derives the HCLK DSYS clock rate from
   the clk_hclk_dsys clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   55 +++++++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index d5acd26..ecffafe 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -87,6 +87,35 @@ static struct clksrc_clk clk_hclk_msys = {
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 3 },
 };
 
+static struct clksrc_clk clk_sclk_a2m = {
+	.clk	= {
+		.name		= "sclk_a2m",
+		.id		= -1,
+		.parent		= &clk_mout_apll.clk,
+	},
+	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 4, .size = 3 },
+};
+
+static struct clk *clkset_hclk_sys_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_sclk_a2m.clk,
+};
+
+static struct clksrc_sources clkset_hclk_sys = {
+	.sources	= clkset_hclk_sys_list,
+	.nr_sources	= ARRAY_SIZE(clkset_hclk_sys_list),
+};
+
+static struct clksrc_clk clk_hclk_dsys = {
+	.clk	= {
+		.name	= "hclk_dsys",
+		.id	= -1,
+	},
+	.sources	= &clkset_hclk_sys,
+	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 1 },
+	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 4 },
+};
+
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
@@ -112,11 +141,6 @@ static struct clk clk_h100 = {
 	.id		= -1,
 };
 
-static struct clk clk_h166 = {
-	.name		= "hclk166",
-	.id		= -1,
-};
-
 static struct clk clk_h133 = {
 	.name		= "hclk133",
 	.id		= -1,
@@ -139,7 +163,6 @@ static struct clk clk_p66 = {
 
 static struct clk *sys_clks[] = {
 	&clk_h100,
-	&clk_h166,
 	&clk_h133,
 	&clk_p100,
 	&clk_p83,
@@ -150,7 +173,7 @@ static struct clk init_clocks_disable[] = {
 	{
 		.name		= "rot",
 		.id		= -1,
-		.parent		= &clk_h166,
+		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1<<29),
 	}, {
@@ -168,7 +191,7 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "lcd",
 		.id		= -1,
-		.parent		= &clk_h166,
+		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<0),
 	}, {
@@ -353,6 +376,8 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_mpll,
 	&clk_armclk,
 	&clk_hclk_msys,
+	&clk_sclk_a2m,
+	&clk_hclk_dsys,
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -363,7 +388,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned long xtal;
 	unsigned long armclk;
 	unsigned long hclk_msys;
-	unsigned long hclk166;
+	unsigned long hclk_dsys;
 	unsigned long hclk133;
 	unsigned long pclk100;
 	unsigned long pclk83;
@@ -403,12 +428,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 
 	armclk = clk_get_rate(&clk_armclk.clk);
 	hclk_msys = clk_get_rate(&clk_hclk_msys.clk);
-
-	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX166_MASK) {
-		hclk166 = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_A2M);
-		hclk166 = hclk166 / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK166);
-	} else
-		hclk166 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK166);
+	hclk_dsys = clk_get_rate(&clk_hclk_dsys.clk);
 
 	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX133_MASK) {
 		hclk133 = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_A2M);
@@ -417,12 +437,12 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 		hclk133 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK133);
 
 	pclk100 = hclk_msys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK100);
-	pclk83 = hclk166 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
+	pclk83 = hclk_dsys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
 	pclk66 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
 
 	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld, \
 			HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
-	       armclk, hclk_msys, hclk166, hclk133, pclk100, pclk83, pclk66);
+	       armclk, hclk_msys, hclk_dsys, hclk133, pclk100, pclk83, pclk66);
 
 	clk_f.rate = armclk;
 	clk_h.rate = hclk133;
@@ -430,7 +450,6 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	clk_p66.rate = pclk66;
 	clk_p83.rate = pclk83;
 	clk_h133.rate = hclk133;
-	clk_h166.rate = hclk166;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
-- 
1.6.2.5

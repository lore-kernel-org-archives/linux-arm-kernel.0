From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:42 +0900
Subject: [PATCH 08/18] ARM: S5PV210: Remove usage of clk_p100 and add
	clk_pclk_msys clock
Message-ID: <1274056722-14449-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_p100 clock, which is the PCLK clock for MSYS domain, is of
type 'struct clk' whereas on S5PV210, this clock is suitable to be
of type clksrc_clk clock (since it has a choice of clock source
and a pre-divider). So this patch replaces the 'struct clk' type
clock to 'struct clksrc_clk' type clock for the PCLK MSYS clock.

This patch modifies the following.

1. Remove definitions and usage of 'clk_p100' clock.
2. Adds 'clk_pclk_msys' clock which is of type 'struct clksrc_clk'.
3. Replace all usage of clk_p100 with clk_pclk_msys clock.
4. Adds clk_pclk_msys into list of clocks to be registered.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 7ed1d4e..4791642 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -87,6 +87,15 @@ static struct clksrc_clk clk_hclk_msys = {
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 3 },
 };
 
+static struct clksrc_clk clk_pclk_msys = {
+	.clk	= {
+		.name		= "pclk_msys",
+		.id		= -1,
+		.parent		= &clk_hclk_msys.clk,
+	},
+	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 3 },
+};
+
 static struct clksrc_clk clk_sclk_a2m = {
 	.clk	= {
 		.name		= "sclk_a2m",
@@ -151,11 +160,6 @@ static struct clk clk_h100 = {
 	.id		= -1,
 };
 
-static struct clk clk_p100 = {
-	.name		= "pclk100",
-	.id		= -1,
-};
-
 static struct clk clk_p83 = {
 	.name		= "pclk83",
 	.id		= -1,
@@ -168,7 +172,6 @@ static struct clk clk_p66 = {
 
 static struct clk *sys_clks[] = {
 	&clk_h100,
-	&clk_p100,
 	&clk_p83,
 	&clk_p66
 };
@@ -383,6 +386,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_a2m,
 	&clk_hclk_dsys,
 	&clk_hclk_psys,
+	&clk_pclk_msys,
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -395,7 +399,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned long hclk_msys;
 	unsigned long hclk_dsys;
 	unsigned long hclk_psys;
-	unsigned long pclk100;
+	unsigned long pclk_msys;
 	unsigned long pclk83;
 	unsigned long pclk66;
 	unsigned long apll;
@@ -435,15 +439,14 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	hclk_msys = clk_get_rate(&clk_hclk_msys.clk);
 	hclk_dsys = clk_get_rate(&clk_hclk_dsys.clk);
 	hclk_psys = clk_get_rate(&clk_hclk_psys.clk);
-
-	pclk100 = hclk_msys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK100);
+	pclk_msys = clk_get_rate(&clk_pclk_msys.clk);
 	pclk83 = hclk_dsys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
 	pclk66 = hclk_psys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
 
 	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld\n"
 			 "HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
 			armclk, hclk_msys, hclk_dsys, hclk_psys,
-			pclk100, pclk83, pclk66);
+			pclk_msys, pclk83, pclk66);
 
 	clk_f.rate = armclk;
 	clk_h.rate = hclk_psys;
-- 
1.6.2.5

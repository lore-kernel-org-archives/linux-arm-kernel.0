From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:34 +0900
Subject: [PATCH 05/18] ARM: S5PV210: Remove usage of clk_h200 clock and add
	clk_hclk_msys clock
Message-ID: <1274056714-14350-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_h200 represents the HCLK for the MSYS domain. This clock
is of type 'struct clk' but on V210, it is more suitable to be of
type 'struct clksrc_clk' (since it is a divided version of the
armclk). The replacement clock is renamed as clk_hclk_msys to
indicate that it represents the HCLK for MSYS domain.

This patch modifies the following.

1. Removes the usage of the clk_h200 clock.
2. Adds the new clock 'clk_hclk_msys'.
3. Adds clk_hclk_msys to the list of sysclks to be registered.
4. Modifies the hclk_msys clock rate calculation procedure to
   be based on the new clk_hclk_msys clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index f57fa1e..d5acd26 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -78,6 +78,15 @@ static struct clksrc_clk clk_armclk = {
 	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 0, .size = 3 },
 };
 
+static struct clksrc_clk clk_hclk_msys = {
+	.clk	= {
+		.name		= "hclk_msys",
+		.id		= -1,
+		.parent		= &clk_armclk.clk,
+	},
+	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 3 },
+};
+
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
@@ -98,11 +107,6 @@ static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
 }
 
-static struct clk clk_h200 = {
-	.name		= "hclk200",
-	.id		= -1,
-};
-
 static struct clk clk_h100 = {
 	.name		= "hclk100",
 	.id		= -1,
@@ -134,7 +138,6 @@ static struct clk clk_p66 = {
 };
 
 static struct clk *sys_clks[] = {
-	&clk_h200,
 	&clk_h100,
 	&clk_h166,
 	&clk_h133,
@@ -349,6 +352,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_epll,
 	&clk_mout_mpll,
 	&clk_armclk,
+	&clk_hclk_msys,
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -358,7 +362,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	struct clk *xtal_clk;
 	unsigned long xtal;
 	unsigned long armclk;
-	unsigned long hclk200;
+	unsigned long hclk_msys;
 	unsigned long hclk166;
 	unsigned long hclk133;
 	unsigned long pclk100;
@@ -398,10 +402,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 			apll, mpll, epll);
 
 	armclk = clk_get_rate(&clk_armclk.clk);
-	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX200_MASK)
-		hclk200 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK200);
-	else
-		hclk200 = armclk / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK200);
+	hclk_msys = clk_get_rate(&clk_hclk_msys.clk);
 
 	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX166_MASK) {
 		hclk166 = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_A2M);
@@ -415,13 +416,13 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	} else
 		hclk133 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK133);
 
-	pclk100 = hclk200 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK100);
+	pclk100 = hclk_msys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK100);
 	pclk83 = hclk166 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
 	pclk66 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
 
 	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld, \
 			HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
-	       armclk, hclk200, hclk166, hclk133, pclk100, pclk83, pclk66);
+	       armclk, hclk_msys, hclk166, hclk133, pclk100, pclk83, pclk66);
 
 	clk_f.rate = armclk;
 	clk_h.rate = hclk133;
@@ -430,7 +431,6 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	clk_p83.rate = pclk83;
 	clk_h133.rate = hclk133;
 	clk_h166.rate = hclk166;
-	clk_h200.rate = hclk200;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
-- 
1.6.2.5

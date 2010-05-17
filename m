From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:40 +0900
Subject: [PATCH 07/18] ARM: S5PV210: Remove usage of clk_h133 and add
	clk_hclk_psys clock
Message-ID: <1274056720-14416-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_h133 clock, which is the HCLK clock for PSYS domain, is of
type 'struct clk' whereas on S5PV210, this clock is suitable to be
of type clksrc_clk clock (since it has a choice of clock source
and a pre-divider). So this patch replaces the 'struct clk' type
clock to 'struct clksrc_clk' type clock for the HCLK PSYS clock.

This patch modifies the following.

1. Remove definitions and usage of 'clk_h133' clock.
2. Adds 'clk_hclk_psys' clock which is of type 'struct clksrc_clk'.
3. Replace all usage of clk_h133 with clk_hclk_psys clock.
4. Adds clk_hclk_psys into list of clocks to be registered.
5. Removes the clock rate calculation of hclk133 and replaces
   it with code that derives the HCLK PSYS clock rate from
   the clk_hclk_psys clock.
6. Modify printing of the system clock rates.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   52 ++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ecffafe..7ed1d4e 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -116,6 +116,16 @@ static struct clksrc_clk clk_hclk_dsys = {
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 4 },
 };
 
+static struct clksrc_clk clk_hclk_psys = {
+	.clk	= {
+		.name	= "hclk_psys",
+		.id	= -1,
+	},
+	.sources	= &clkset_hclk_sys,
+	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 24, .size = 1 },
+	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 24, .size = 4 },
+};
+
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
@@ -141,11 +151,6 @@ static struct clk clk_h100 = {
 	.id		= -1,
 };
 
-static struct clk clk_h133 = {
-	.name		= "hclk133",
-	.id		= -1,
-};
-
 static struct clk clk_p100 = {
 	.name		= "pclk100",
 	.id		= -1,
@@ -163,7 +168,6 @@ static struct clk clk_p66 = {
 
 static struct clk *sys_clks[] = {
 	&clk_h100,
-	&clk_h133,
 	&clk_p100,
 	&clk_p83,
 	&clk_p66
@@ -179,13 +183,13 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "otg",
 		.id		= -1,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<16),
 	}, {
 		.name		= "usb-host",
 		.id		= -1,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<17),
 	}, {
@@ -197,31 +201,31 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "cfcon",
 		.id		= 0,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<25),
 	}, {
 		.name		= "hsmmc",
 		.id		= 0,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<16),
 	}, {
 		.name		= "hsmmc",
 		.id		= 1,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<17),
 	}, {
 		.name		= "hsmmc",
 		.id		= 2,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<18),
 	}, {
 		.name		= "hsmmc",
 		.id		= 3,
-		.parent		= &clk_h133,
+		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<19),
 	}, {
@@ -378,6 +382,7 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_hclk_msys,
 	&clk_sclk_a2m,
 	&clk_hclk_dsys,
+	&clk_hclk_psys,
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -389,7 +394,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned long armclk;
 	unsigned long hclk_msys;
 	unsigned long hclk_dsys;
-	unsigned long hclk133;
+	unsigned long hclk_psys;
 	unsigned long pclk100;
 	unsigned long pclk83;
 	unsigned long pclk66;
@@ -429,27 +434,22 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	armclk = clk_get_rate(&clk_armclk.clk);
 	hclk_msys = clk_get_rate(&clk_hclk_msys.clk);
 	hclk_dsys = clk_get_rate(&clk_hclk_dsys.clk);
-
-	if (__raw_readl(S5P_CLK_SRC0) & S5P_CLKSRC0_MUX133_MASK) {
-		hclk133 = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_A2M);
-		hclk133 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK133);
-	} else
-		hclk133 = mpll / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK133);
+	hclk_psys = clk_get_rate(&clk_hclk_psys.clk);
 
 	pclk100 = hclk_msys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK100);
 	pclk83 = hclk_dsys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
-	pclk66 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
+	pclk66 = hclk_psys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
 
-	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld, \
-			HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
-	       armclk, hclk_msys, hclk_dsys, hclk133, pclk100, pclk83, pclk66);
+	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld\n"
+			 "HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
+			armclk, hclk_msys, hclk_dsys, hclk_psys,
+			pclk100, pclk83, pclk66);
 
 	clk_f.rate = armclk;
-	clk_h.rate = hclk133;
+	clk_h.rate = hclk_psys;
 	clk_p.rate = pclk66;
 	clk_p66.rate = pclk66;
 	clk_p83.rate = pclk83;
-	clk_h133.rate = hclk133;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
-- 
1.6.2.5

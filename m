From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:38:50 +0900
Subject: [PATCH 11/18] ARM: S5PV210: Remove usage of clk_p66 and add
	clk_pclk_psys clock
Message-ID: <1274056730-14548-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clk_p83 clock, which is the PCLK clock for PSYS domain, is of
type 'struct clk' whereas on S5PV210, this clock is suitable to be
of type clksrc_clk clock (since it has a clock divider). So this
patch replaces the 'struct clk' type clock to 'struct clksrc_clk'
type clock for the PCLK PSYS clock.

This patch modifies the following.

1. Removes definitions and usage of 'clk_p66' clock.
2. Adds 'clk_pclk_psys' clock which is of type 'struct clksrc_clk'.
3. Replaces all usage of clk_p66 with clk_pclk_psys clock.
4. Adds clk_pclk_psys into list of clocks to be registered.
5. Removes the sys_clks array since it is no longer required.
   Also the registration of clocks in sys_clks is also removed.
6. Remove the 'GET_DIV' as it is no longer required.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   66 ++++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index b46d9ec..315955d 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -144,6 +144,15 @@ static struct clksrc_clk clk_hclk_psys = {
 	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 24, .size = 4 },
 };
 
+static struct clksrc_clk clk_pclk_psys = {
+	.clk	= {
+		.name	= "pclk_psys",
+		.id	= -1,
+		.parent	= &clk_hclk_psys.clk,
+	},
+	.reg_div        = { .reg = S5P_CLK_DIV0, .shift = 28, .size = 3 },
+};
+
 static int s5pv210_clk_ip0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
@@ -164,15 +173,6 @@ static int s5pv210_clk_ip3_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
 }
 
-static struct clk clk_p66 = {
-	.name		= "pclk66",
-	.id		= -1,
-};
-
-static struct clk *sys_clks[] = {
-	&clk_p66
-};
-
 static unsigned long s5pv210_clk_imem_get_rate(struct clk *clk)
 {
 	return clk_get_rate(clk->parent) / 2;
@@ -240,73 +240,73 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "systimer",
 		.id		= -1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<16),
 	}, {
 		.name		= "watchdog",
 		.id		= -1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<22),
 	}, {
 		.name		= "rtc",
 		.id		= -1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<15),
 	}, {
 		.name		= "i2c",
 		.id		= 0,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<7),
 	}, {
 		.name		= "i2c",
 		.id		= 1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<8),
 	}, {
 		.name		= "i2c",
 		.id		= 2,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<9),
 	}, {
 		.name		= "spi",
 		.id		= 0,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<12),
 	}, {
 		.name		= "spi",
 		.id		= 1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<13),
 	}, {
 		.name		= "spi",
 		.id		= 2,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<14),
 	}, {
 		.name		= "timers",
 		.id		= -1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<23),
 	}, {
 		.name		= "adc",
 		.id		= -1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<24),
 	}, {
 		.name		= "keypad",
 		.id		= -1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<21),
 	}, {
@@ -341,25 +341,25 @@ static struct clk init_clocks[] = {
 	}, {
 		.name		= "uart",
 		.id		= 0,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<7),
 	}, {
 		.name		= "uart",
 		.id		= 1,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<8),
 	}, {
 		.name		= "uart",
 		.id		= 2,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<9),
 	}, {
 		.name		= "uart",
 		.id		= 3,
-		.parent		= &clk_p66,
+		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<10),
 	},
@@ -401,10 +401,9 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_hclk_psys,
 	&clk_pclk_msys,
 	&clk_pclk_dsys,
+	&clk_pclk_psys,
 };
 
-#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
-
 void __init_or_cpufreq s5pv210_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -415,7 +414,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	unsigned long hclk_psys;
 	unsigned long pclk_msys;
 	unsigned long pclk_dsys;
-	unsigned long pclk66;
+	unsigned long pclk_psys;
 	unsigned long apll;
 	unsigned long mpll;
 	unsigned long epll;
@@ -455,17 +454,16 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	hclk_psys = clk_get_rate(&clk_hclk_psys.clk);
 	pclk_msys = clk_get_rate(&clk_pclk_msys.clk);
 	pclk_dsys = clk_get_rate(&clk_pclk_dsys.clk);
-	pclk66 = hclk_psys / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
+	pclk_psys = clk_get_rate(&clk_pclk_psys.clk);
 
 	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld\n"
 			 "HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
 			armclk, hclk_msys, hclk_dsys, hclk_psys,
-			pclk_msys, pclk_dsys, pclk66);
+			pclk_msys, pclk_dsys, pclk_psys);
 
 	clk_f.rate = armclk;
 	clk_h.rate = hclk_psys;
-	clk_p.rate = pclk66;
-	clk_p66.rate = pclk66;
+	clk_p.rate = pclk_psys;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
@@ -490,10 +488,6 @@ void __init s5pv210_register_clocks(void)
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
-	ret = s3c24xx_register_clocks(sys_clks, ARRAY_SIZE(sys_clks));
-	if (ret > 0)
-		printk(KERN_ERR "Failed to register system clocks\n");
-
 	clkp = init_clocks_disable;
 	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
 		ret = s3c24xx_register_clock(clkp);
-- 
1.6.2.5

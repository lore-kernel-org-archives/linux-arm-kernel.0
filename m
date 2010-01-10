From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 17:28:25 +0000
Subject: [PATCH] Consolidate clks_register() and similar
Message-ID: <20100110172825.GB8639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most machine classes want some way to register a block of clk_lookup
structures, and most do it by implementing a clks_register() type
function which walks an array, or by open-coding a loop.

Consolidate all this into clkdev_add_table().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
This misses out Davinci, which needs cleaning up to remove its
seemingly redundant wrapping of the clk_lookup structure.

 arch/arm/common/clkdev.c                 |   10 ++++++++++
 arch/arm/include/asm/clkdev.h            |    3 +++
 arch/arm/mach-bcmring/core.c             |    3 +--
 arch/arm/mach-ep93xx/clock.c             |    4 +---
 arch/arm/mach-integrator/core.c          |    3 +--
 arch/arm/mach-integrator/integrator_cp.c |    4 +---
 arch/arm/mach-mmp/clock.c                |    8 --------
 arch/arm/mach-mmp/clock.h                |    2 --
 arch/arm/mach-mmp/pxa168.c               |    2 +-
 arch/arm/mach-mmp/pxa910.c               |    2 +-
 arch/arm/mach-mx1/clock.c                |    4 +---
 arch/arm/mach-mx2/clock_imx21.c          |    4 +---
 arch/arm/mach-mx2/clock_imx27.c          |    4 +---
 arch/arm/mach-mx25/clock.c               |    6 +-----
 arch/arm/mach-mx3/clock-imx35.c          |    4 +---
 arch/arm/mach-mx3/clock.c                |    4 +---
 arch/arm/mach-mxc91231/clock.c           |    4 +---
 arch/arm/mach-pnx4008/clock.c            |    5 +----
 arch/arm/mach-pxa/clock.c                |    8 --------
 arch/arm/mach-pxa/clock.h                |    4 ----
 arch/arm/mach-pxa/eseries.c              |    2 +-
 arch/arm/mach-pxa/pxa25x.c               |    4 ++--
 arch/arm/mach-pxa/pxa27x.c               |    2 +-
 arch/arm/mach-pxa/pxa300.c               |    4 ++--
 arch/arm/mach-pxa/pxa320.c               |    2 +-
 arch/arm/mach-pxa/pxa3xx.c               |    2 +-
 arch/arm/mach-realview/core.c            |    5 +----
 arch/arm/mach-u300/clock.c               |    5 +----
 arch/arm/mach-ux500/clock.c              |    5 +----
 arch/arm/mach-versatile/core.c           |    3 +--
 arch/arm/mach-w90x900/clock.c            |    9 ---------
 arch/arm/mach-w90x900/clock.h            |    1 -
 arch/arm/mach-w90x900/cpu.c              |    2 +-
 arch/arm/plat-stmp3xxx/clock.c           |    3 +--
 34 files changed, 41 insertions(+), 96 deletions(-)

diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index aae5bc0..446b696 100644
--- a/arch/arm/common/clkdev.c
+++ b/arch/arm/common/clkdev.c
@@ -99,6 +99,16 @@ void clkdev_add(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_add);
 
+void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
+{
+	mutex_lock(&clocks_mutex);
+	while (num--) {
+		list_add_tail(&cl->node, &clocks);
+		cl++;
+	}
+	mutex_unlock(&clocks_mutex);
+}
+
 #define MAX_DEV_ID	20
 #define MAX_CON_ID	16
 
diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index b6ec7c6..7a0690d 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -27,4 +27,7 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
 void clkdev_add(struct clk_lookup *cl);
 void clkdev_drop(struct clk_lookup *cl);
 
+void clkdev_add_table(struct clk_lookup *, size_t);
+int clk_add_alias(const char *, const char *, char *, struct device *);
+
 #endif
diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index e590bbe..3239e04 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -142,8 +142,7 @@ void __init bcmring_amba_init(void)
 
 	chipcHw_busInterfaceClockEnable(bus_clock);
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIEZ(lookups));
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 1d0f9d8..bb3c621 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -445,7 +445,6 @@ static void __init ep93xx_dma_clock_init(void)
 static int __init ep93xx_clock_init(void)
 {
 	u32 value;
-	int i;
 
 	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET1);
 	if (!(value & 0x00800000)) {			/* PLL1 bypassed?  */
@@ -474,8 +473,7 @@ static int __init ep93xx_clock_init(void)
 		clk_f.rate / 1000000, clk_h.rate / 1000000,
 		clk_p.rate / 1000000);
 
-	for (i = 0; i < ARRAY_SIZE(clocks); i++)
-		clkdev_add(&clocks[i]);
+	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
 	return 0;
 }
 arch_initcall(ep93xx_clock_init);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index a0f60e5..8b390e3 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -144,8 +144,7 @@ static int __init integrator_init(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 3f35293..66ef86d 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -558,9 +558,7 @@ static void __init intcp_init(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(cp_lookups); i++)
-		clkdev_add(&cp_lookups[i]);
-
+	clkdev_add_table(cp_lookups, ARRAY_SIZE(cp_lookups));
 	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index 2a46ed5..886e056 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -88,11 +88,3 @@ unsigned long clk_get_rate(struct clk *clk)
 	return rate;
 }
 EXPORT_SYMBOL(clk_get_rate);
-
-void clks_register(struct clk_lookup *clks, size_t num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		clkdev_add(&clks[i]);
-}
diff --git a/arch/arm/mach-mmp/clock.h b/arch/arm/mach-mmp/clock.h
index eefffbe..016ae94 100644
--- a/arch/arm/mach-mmp/clock.h
+++ b/arch/arm/mach-mmp/clock.h
@@ -68,5 +68,3 @@ struct clk clk_##_name = {					\
 
 extern struct clk clk_pxa168_gpio;
 extern struct clk clk_pxa168_timers;
-
-extern void clks_register(struct clk_lookup *, size_t);
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 37dbdde..1873c82 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -94,7 +94,7 @@ static int __init pxa168_init(void)
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa168_mfp_addr_map);
 		pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
-		clks_register(ARRAY_AND_SIZE(pxa168_clkregs));
+		clkdev_add_table(ARRAY_AND_SIZE(pxa168_clkregs));
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index d404950..46f2d69 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -131,7 +131,7 @@ static int __init pxa910_init(void)
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa910_mfp_addr_map);
 		pxa_init_dma(IRQ_PXA910_DMA_INT0, 32);
-		clks_register(ARRAY_AND_SIZE(pxa910_clkregs));
+		clkdev_add_table(ARRAY_AND_SIZE(pxa910_clkregs));
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mx1/clock.c b/arch/arm/mach-mx1/clock.c
index d1b5885..6cf2d4a 100644
--- a/arch/arm/mach-mx1/clock.c
+++ b/arch/arm/mach-mx1/clock.c
@@ -570,7 +570,6 @@ static struct clk_lookup lookups[] __initdata = {
 int __init mx1_clocks_init(unsigned long fref)
 {
 	unsigned int reg;
-	int i;
 
 	/* disable clocks we are able to */
 	__raw_writel(0, SCM_GCCR);
@@ -592,8 +591,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	reg = (reg & CCM_CSCR_CLKO_MASK) >> CCM_CSCR_CLKO_OFFSET;
 	clko_clk.parent = (struct clk *)clko_clocks[reg];
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	clk_enable(&hclk);
 	clk_enable(&fclk);
diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
index 91901b5..e82b489 100644
--- a/arch/arm/mach-mx2/clock_imx21.c
+++ b/arch/arm/mach-mx2/clock_imx21.c
@@ -968,7 +968,6 @@ static struct clk_lookup lookups[] = {
  */
 int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 {
-	int i;
 	u32 cscr;
 
 	external_low_reference = lref;
@@ -986,8 +985,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	else
 		spll_clk.parent = &fpm_clk;
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	/* Turn off all clock gates */
 	__raw_writel(0, CCM_PCCR0);
diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index b010bf9..18c53a6 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -719,7 +719,6 @@ static void __init to2_adjust_clocks(void)
 int __init mx27_clocks_init(unsigned long fref)
 {
 	u32 cscr = __raw_readl(CCM_CSCR);
-	int i;
 
 	external_high_reference = fref;
 
@@ -736,8 +735,7 @@ int __init mx27_clocks_init(unsigned long fref)
 
 	to2_adjust_clocks();
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	/* Turn off all clocks we do not need */
 	__raw_writel(0, CCM_PCCR0);
diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index ef26951..4499233 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -208,11 +208,7 @@ static struct clk_lookup lookups[] = {
 
 int __init mx25_clocks_init(unsigned long fref)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
-
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 
 	return 0;
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 7584b4c..f3f41fa 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -485,15 +485,13 @@ static struct clk_lookup lookups[] = {
 
 int __init mx35_clocks_init()
 {
-	int i;
 	unsigned int ll = 0;
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	ll = (3 << 16);
 #endif
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	/* Turn off all clocks except the ones we need to survive, namely:
 	 * EMI, GPIO1/2/3, GPT, IOMUX, MAX and eventually uart
diff --git a/arch/arm/mach-mx3/clock.c b/arch/arm/mach-mx3/clock.c
index 27a318a..b5c39a0 100644
--- a/arch/arm/mach-mx3/clock.c
+++ b/arch/arm/mach-mx3/clock.c
@@ -578,12 +578,10 @@ static struct clk_lookup lookups[] = {
 int __init mx31_clocks_init(unsigned long fref)
 {
 	u32 reg;
-	int i;
 
 	ckih_rate = fref;
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	/* change the csi_clk parent if necessary */
 	reg = __raw_readl(MXC_CCM_CCMR);
diff --git a/arch/arm/mach-mxc91231/clock.c b/arch/arm/mach-mxc91231/clock.c
index ecfa37f..5c85075 100644
--- a/arch/arm/mach-mxc91231/clock.c
+++ b/arch/arm/mach-mxc91231/clock.c
@@ -624,7 +624,6 @@ static struct clk_lookup lookups[] = {
 int __init mxc91231_clocks_init(unsigned long fref)
 {
 	void __iomem *gpt_base;
-	int i;
 
 	ckih_rate = fref;
 
@@ -632,8 +631,7 @@ int __init mxc91231_clocks_init(unsigned long fref)
 	sdhc_clk[0].parent = clk_sdhc_parent(&sdhc_clk[0]);
 	sdhc_clk[1].parent = clk_sdhc_parent(&sdhc_clk[1]);
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	gpt_base = MXC91231_IO_ADDRESS(MXC91231_GPT1_BASE_ADDR);
 	mxc_timer_init(&gpt_clk, gpt_base, MXC91231_INT_GPT);
diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index a38ef66..9d1975f 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -961,7 +961,6 @@ EXPORT_SYMBOL(clk_set_parent);
 
 static int __init clk_init(void)
 {
-	struct clk_lookup *cl;
 	struct clk **clkp;
 
 	/* Disable autoclocking, as it doesn't seem to work */
@@ -995,9 +994,7 @@ static int __init clk_init(void)
 	/* Disable autoclocking */
 	__raw_writeb(0xff, AUTOCLK_CTRL);
 
-	for (cl = onchip_clkreg;
-	     cl < onchip_clkreg + ARRAY_SIZE(onchip_clkreg); cl++)
-		clkdev_add(cl);
+	clkdev_add_table(onchip_clkreg, ARRAY_SIZE(onchip_clkreg));
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
index 49ae382..abba008 100644
--- a/arch/arm/mach-pxa/clock.c
+++ b/arch/arm/mach-pxa/clock.c
@@ -78,11 +78,3 @@ const struct clkops clk_cken_ops = {
 	.enable		= clk_cken_enable,
 	.disable	= clk_cken_disable,
 };
-
-void clks_register(struct clk_lookup *clks, size_t num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		clkdev_add(&clks[i]);
-}
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index 978a366..d848874 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -67,7 +67,3 @@ extern void clk_pxa3xx_cken_enable(struct clk *);
 extern void clk_pxa3xx_cken_disable(struct clk *);
 #endif
 
-void clks_register(struct clk_lookup *clks, size_t num);
-int clk_add_alias(const char *alias, const char *alias_name, char *id,
-	struct device *dev);
-
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 91417f0..96ed130 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -128,6 +128,6 @@ static struct clk_lookup eseries_clkregs[] = {
 
 void eseries_register_clks(void)
 {
-	clks_register(eseries_clkregs, ARRAY_SIZE(eseries_clkregs));
+	clkdev_add_table(eseries_clkregs, ARRAY_SIZE(eseries_clkregs));
 }
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 2c1b0b7..0b9ad30 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -349,7 +349,7 @@ static int __init pxa25x_init(void)
 
 		reset_status = RCSR;
 
-		clks_register(pxa25x_clkregs, ARRAY_SIZE(pxa25x_clkregs));
+		clkdev_add_table(pxa25x_clkregs, ARRAY_SIZE(pxa25x_clkregs));
 
 		if ((ret = pxa_init_dma(IRQ_DMA, 16)))
 			return ret;
@@ -370,7 +370,7 @@ static int __init pxa25x_init(void)
 
 	/* Only add HWUART for PXA255/26x; PXA210/250 do not have it. */
 	if (cpu_is_pxa255())
-		clks_register(&pxa25x_hwuart_clkreg, 1);
+		clkdev_add(&pxa25x_hwuart_clkreg);
 
 	return ret;
 }
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 6a0b731..d783123 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -392,7 +392,7 @@ static int __init pxa27x_init(void)
 
 		reset_status = RCSR;
 
-		clks_register(pxa27x_clkregs, ARRAY_SIZE(pxa27x_clkregs));
+		clkdev_add_table(pxa27x_clkregs, ARRAY_SIZE(pxa27x_clkregs));
 
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
 			return ret;
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index f4af6e2..40bb165 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -102,12 +102,12 @@ static int __init pxa300_init(void)
 	if (cpu_is_pxa300() || cpu_is_pxa310()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa300_mfp_addr_map);
-		clks_register(ARRAY_AND_SIZE(common_clkregs));
+		clkdev_add_table(ARRAY_AND_SIZE(common_clkregs));
 	}
 
 	if (cpu_is_pxa310()) {
 		mfp_init_addr(pxa310_mfp_addr_map);
-		clks_register(ARRAY_AND_SIZE(pxa310_clkregs));
+		clkdev_add_table(ARRAY_AND_SIZE(pxa310_clkregs));
 	}
 
 	return 0;
diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
index c7373e7..8d614ec 100644
--- a/arch/arm/mach-pxa/pxa320.c
+++ b/arch/arm/mach-pxa/pxa320.c
@@ -90,7 +90,7 @@ static int __init pxa320_init(void)
 	if (cpu_is_pxa320()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa320_mfp_addr_map);
-		clks_register(ARRAY_AND_SIZE(pxa320_clkregs));
+		clkdev_add_table(ARRAY_AND_SIZE(pxa320_clkregs));
 	}
 
 	return 0;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index fcb0721..4d7c03e 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -634,7 +634,7 @@ static int __init pxa3xx_init(void)
 		 */
 		ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
 
-		clks_register(pxa3xx_clkregs, ARRAY_SIZE(pxa3xx_clkregs));
+		clkdev_add_table(pxa3xx_clkregs, ARRAY_SIZE(pxa3xx_clkregs));
 
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
 			return ret;
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 9f29343..90bd4ef 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -346,10 +346,7 @@ static struct clk_lookup lookups[] = {
 
 static int __init clk_init(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 	return 0;
 }
 arch_initcall(clk_init);
diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index 111f7ea..c174ed1 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -1276,11 +1276,8 @@ static struct clk_lookup lookups[] = {
 
 static void __init clk_register(void)
 {
-	int i;
-
 	/* Register the lookups */
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 }
 
 /*
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 20b6ebb..8359a73 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -85,11 +85,8 @@ static struct clk_lookup lookups[] = {
 
 static int __init clk_init(void)
 {
-	int i;
-
 	/* register the clock lookups */
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 	return 0;
 }
 arch_initcall(clk_init);
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e13be7c..9ddb49b 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -851,8 +851,7 @@ void __init versatile_init(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lookups); i++)
-		clkdev_add(&lookups[i]);
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&versatile_i2c_device);
diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
index b785994..2c371ff 100644
--- a/arch/arm/mach-w90x900/clock.c
+++ b/arch/arm/mach-w90x900/clock.c
@@ -90,12 +90,3 @@ void nuc900_subclk_enable(struct clk *clk, int enable)
 
 	__raw_writel(clken, W90X900_VA_CLKPWR + SUBCLK);
 }
-
-
-void clks_register(struct clk_lookup *clks, size_t num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		clkdev_add(&clks[i]);
-}
diff --git a/arch/arm/mach-w90x900/clock.h b/arch/arm/mach-w90x900/clock.h
index f5816a0..c56ddab 100644
--- a/arch/arm/mach-w90x900/clock.h
+++ b/arch/arm/mach-w90x900/clock.h
@@ -14,7 +14,6 @@
 
 void nuc900_clk_enable(struct clk *clk, int enable);
 void nuc900_subclk_enable(struct clk *clk, int enable);
-void clks_register(struct clk_lookup *clks, size_t num);
 
 struct clk {
 	unsigned long		cken;
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 20dc0c9..6f5ca53 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -208,6 +208,6 @@ void __init nuc900_map_io(struct map_desc *mach_desc, int mach_size)
 
 void __init nuc900_init_clocks(void)
 {
-	clks_register(nuc900_clkregs, ARRAY_SIZE(nuc900_clkregs));
+	clkdev_add_table(nuc900_clkregs, ARRAY_SIZE(nuc900_clkregs));
 }
 
diff --git a/arch/arm/plat-stmp3xxx/clock.c b/arch/arm/plat-stmp3xxx/clock.c
index 5d2f19a..e593a2a 100644
--- a/arch/arm/plat-stmp3xxx/clock.c
+++ b/arch/arm/plat-stmp3xxx/clock.c
@@ -1126,9 +1126,8 @@ static int __init clk_init(void)
 			if (ops && ops->set_parent)
 				ops->set_parent(cl->clk, cl->clk->parent);
 		}
-
-		clkdev_add(cl);
 	}
+	clkdev_add_table(onchip_clks, ARRAY_SIZE(onchip_clks));
 	return 0;
 }
 

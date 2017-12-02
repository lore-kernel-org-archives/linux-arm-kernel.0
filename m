From: david@lechnology.com (David Lechner)
Date: Fri,  1 Dec 2017 20:34:11 -0600
Subject: [PATCH v1 3/6] ARM: davinci: don't use static clk_lookup
In-Reply-To: <1512182054-17410-1-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
Message-ID: <1512182054-17410-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of moving to the common clock framework, usage of static
struct clk_lookup is removed. The common clock framework uses an opaque
struct clk, so we won't be able to use static tables as was previously
done.

Each CPU family is given a new CPU-specific init_time function that
registers the clocks individually via function calls instead of using
a clk_lookup table.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |   2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |   4 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |   2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |   2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |   2 +-
 arch/arm/mach-davinci/clock.c               |  75 +++++++--------
 arch/arm/mach-davinci/clock.h               |   9 +-
 arch/arm/mach-davinci/da830.c               | 115 ++++++++++++-----------
 arch/arm/mach-davinci/da850.c               | 137 ++++++++++++++--------------
 arch/arm/mach-davinci/da8xx-dt.c            |   2 +-
 arch/arm/mach-davinci/davinci.h             |   4 +
 arch/arm/mach-davinci/devices-da8xx.c       |   5 +-
 arch/arm/mach-davinci/dm355.c               |  97 ++++++++++----------
 arch/arm/mach-davinci/dm365.c               | 127 +++++++++++++-------------
 arch/arm/mach-davinci/dm644x.c              |  89 +++++++++---------
 arch/arm/mach-davinci/dm646x.c              |  99 +++++++++++---------
 arch/arm/mach-davinci/include/mach/common.h |   1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |   3 +
 arch/arm/mach-davinci/time.c                |   8 --
 arch/arm/mach-davinci/usb-da8xx.c           |  15 +--
 26 files changed, 407 insertions(+), 403 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index db656d4..524049a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -633,7 +633,7 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da830_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da830_init_time,
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 7333ade..f766823 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1476,7 +1476,7 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da850_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index da462e7..ef27f55 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -411,7 +411,7 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.atag_offset  = 0x100,
 	.map_io		= dm355_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm355_init_time,
 	.init_machine = dm355_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 21fd713..e705a6e 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -266,7 +266,7 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.atag_offset  = 0x100,
 	.map_io		= dm355_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm355_init_time,
 	.init_machine = dm355_leopard_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 4ec759b..4232c09 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -769,7 +769,7 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.atag_offset	= 0x100,
 	.map_io		= dm365_map_io,
 	.init_irq	= davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm365_init_time,
 	.init_machine	= dm365_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 8f6e9ea..2f6c0c4 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -811,7 +811,7 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.atag_offset  = 0x100,
 	.map_io		= dm644x_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm644x_init_time,
 	.init_machine = davinci_evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f0e2762..de28f75 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -787,7 +787,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
 	.map_io		= dm646x_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm646x_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
@@ -798,7 +798,7 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.atag_offset  = 0x100,
 	.map_io		= dm646x_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm646x_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 9ea2628..d178932 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -565,7 +565,7 @@ MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
 	.map_io		= da850_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 6f4e7dc..bd01108 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -222,7 +222,7 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.atag_offset	= 0x100,
 	.map_io		= dm644x_map_io,
 	.init_irq	= davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm644x_init_time,
 	.init_machine = davinci_ntosd2_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 0fdb7b7..c1af201 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -329,7 +329,7 @@ MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
 	.map_io		= da850_map_io,
 	.init_irq	= cp_intc_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 3c1059a..8e659e1 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -145,7 +145,7 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.atag_offset  = 0x100,
 	.map_io		= dm644x_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= davinci_timer_init,
+	.init_time	= dm644x_init_time,
 	.init_machine = davinci_sffsdr_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index f77a4f7..5f0a31d 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -607,62 +607,51 @@ int davinci_set_refclk_rate(unsigned long rate)
 	return 0;
 }
 
-int __init davinci_clk_init(struct clk_lookup *clocks)
+void __init davinci_clk_init(struct clk *clk, const char *con_id,
+			     const char *dev_id)
 {
-	struct clk_lookup *c;
-	struct clk *clk;
-	size_t num_clocks = 0;
-
-	for (c = clocks; c->clk; c++) {
-		clk = c->clk;
+	if (!clk->recalc) {
 
-		if (!clk->recalc) {
+		/* Check if clock is a PLL */
+		if (clk->pll_data)
+			clk->recalc = clk_pllclk_recalc;
 
-			/* Check if clock is a PLL */
-			if (clk->pll_data)
-				clk->recalc = clk_pllclk_recalc;
+		/* Else, if it is a PLL-derived clock */
+		else if (clk->flags & CLK_PLL)
+			clk->recalc = clk_sysclk_recalc;
 
-			/* Else, if it is a PLL-derived clock */
-			else if (clk->flags & CLK_PLL)
-				clk->recalc = clk_sysclk_recalc;
-
-			/* Otherwise, it is a leaf clock (PSC clock) */
-			else if (clk->parent)
-				clk->recalc = clk_leafclk_recalc;
-		}
+		/* Otherwise, it is a leaf clock (PSC clock) */
+		else if (clk->parent)
+			clk->recalc = clk_leafclk_recalc;
+	}
 
-		if (clk->pll_data) {
-			struct pll_data *pll = clk->pll_data;
+	if (clk->pll_data) {
+		struct pll_data *pll = clk->pll_data;
 
-			if (!pll->div_ratio_mask)
-				pll->div_ratio_mask = PLLDIV_RATIO_MASK;
+		if (!pll->div_ratio_mask)
+			pll->div_ratio_mask = PLLDIV_RATIO_MASK;
 
-			if (pll->phys_base && !pll->base) {
-				pll->base = ioremap(pll->phys_base, SZ_4K);
-				WARN_ON(!pll->base);
-			}
+		if (pll->phys_base && !pll->base) {
+			pll->base = ioremap(pll->phys_base, SZ_4K);
+			WARN_ON(!pll->base);
 		}
+	}
 
-		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
-
-		if (clk->lpsc)
-			clk->flags |= CLK_PSC;
-
-		if (clk->flags & PSC_LRST)
-			clk->reset = davinci_clk_reset;
+	if (clk->recalc)
+		clk->rate = clk->recalc(clk);
 
-		clk_register(clk);
-		num_clocks++;
+	if (clk->lpsc)
+		clk->flags |= CLK_PSC;
 
-		/* Turn on clocks that Linux doesn't otherwise manage */
-		if (clk->flags & ALWAYS_ENABLED)
-			clk_enable(clk);
-	}
+	if (clk->flags & PSC_LRST)
+		clk->reset = davinci_clk_reset;
 
-	clkdev_add_table(clocks, num_clocks);
+	clk_register(clk);
+	clk_register_clkdev(clk, con_id, dev_id);
 
-	return 0;
+	/* Turn on clocks that Linux doesn't otherwise manage */
+	if (clk->flags & ALWAYS_ENABLED)
+		clk_enable(clk);
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index fa2b837..e4afaa9 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -118,14 +118,7 @@ struct clk {
 #define PSC_FORCE		BIT(6) /* Force module state transtition */
 #define PSC_LRST		BIT(8) /* Use local reset on enable/disable */
 
-#define CLK(dev, con, ck) 	\
-	{			\
-		.dev_id = dev,	\
-		.con_id = con,	\
-		.clk = ck,	\
-	}			\
-
-int davinci_clk_init(struct clk_lookup *clocks);
+void davinci_clk_init(struct clk *clk, const char *con_id, const char *dev_id);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
 int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index f28eda1..7771161 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -378,60 +378,60 @@ static struct clk rmii_clk = {
 	.parent		= &pll0_sysclk7,
 };
 
-static struct clk_lookup da830_clks[] = {
-	CLK(NULL,		"ref",		&ref_clk),
-	CLK(NULL,		"pll0",		&pll0_clk),
-	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
-	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
-	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
-	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
-	CLK(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
-	CLK(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
-	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
-	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
-	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
-	CLK(NULL,		"arm_rom",	&arm_rom_clk),
-	CLK(NULL,		"scr0_ss",	&scr0_ss_clk),
-	CLK(NULL,		"scr1_ss",	&scr1_ss_clk),
-	CLK(NULL,		"scr2_ss",	&scr2_ss_clk),
-	CLK(NULL,		"dmax",		&dmax_clk),
-	CLK(NULL,		"tpcc",		&tpcc_clk),
-	CLK(NULL,		"tptc0",	&tptc0_clk),
-	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK("da830-mmc.0",	NULL,		&mmcsd_clk),
-	CLK("serial8250.0",	NULL,		&uart0_clk),
-	CLK("serial8250.1",	NULL,		&uart1_clk),
-	CLK("serial8250.2",	NULL,		&uart2_clk),
-	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-	CLK(NULL,		"ecap0",	&ecap0_clk),
-	CLK(NULL,		"ecap1",	&ecap1_clk),
-	CLK(NULL,		"ecap2",	&ecap2_clk),
-	CLK(NULL,		"pwm0",		&pwm0_clk),
-	CLK(NULL,		"pwm1",		&pwm1_clk),
-	CLK(NULL,		"pwm2",		&pwm2_clk),
-	CLK("eqep.0",		NULL,		&eqep0_clk),
-	CLK("eqep.1",		NULL,		&eqep1_clk),
-	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
-	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
-	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
-	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
-	CLK(NULL,		"aintc",	&aintc_clk),
-	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
-	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci_mdio.0",   "fck",          &emac_clk),
-	CLK(NULL,		"gpio",		&gpio_clk),
-	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
-	CLK(NULL,		"emif3",	&emif3_clk),
-	CLK(NULL,		"arm",		&arm_clk),
-	CLK(NULL,		"rmii",		&rmii_clk),
-	CLK(NULL,		NULL,		NULL),
-};
+static __init void da830_clk_init(void)
+{
+	davinci_clk_init(&ref_clk, "ref", NULL);
+	davinci_clk_init(&pll0_clk, "pll0", NULL);
+	davinci_clk_init(&pll0_aux_clk, "pll0_aux", NULL);
+	davinci_clk_init(&pll0_sysclk2, "pll0_sysclk2", NULL);
+	davinci_clk_init(&pll0_sysclk3, "pll0_sysclk3", NULL);
+	davinci_clk_init(&pll0_sysclk4, "pll0_sysclk4", NULL);
+	davinci_clk_init(&pll0_sysclk5, "pll0_sysclk5", NULL);
+	davinci_clk_init(&pll0_sysclk6, "pll0_sysclk6", NULL);
+	davinci_clk_init(&pll0_sysclk7, "pll0_sysclk7", NULL);
+	davinci_clk_init(&i2c0_clk, NULL, "i2c_davinci.1");
+	davinci_clk_init(&timerp64_0_clk, "timer0", NULL);
+	davinci_clk_init(&timerp64_1_clk, NULL, "davinci-wdt");
+	davinci_clk_init(&arm_rom_clk, "arm_rom", NULL);
+	davinci_clk_init(&scr0_ss_clk, "scr0_ss", NULL);
+	davinci_clk_init(&scr1_ss_clk, "scr1_ss", NULL);
+	davinci_clk_init(&scr2_ss_clk, "scr2_ss", NULL);
+	davinci_clk_init(&dmax_clk, "dmax", NULL);
+	davinci_clk_init(&tpcc_clk, "tpcc", NULL);
+	davinci_clk_init(&tptc0_clk, "tptc0", NULL);
+	davinci_clk_init(&tptc1_clk, "tptc1", NULL);
+	davinci_clk_init(&mmcsd_clk, NULL, "da830-mmc.0");
+	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
+	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
+	davinci_clk_init(&uart2_clk, NULL, "serial8250.2");
+	davinci_clk_init(&spi0_clk, NULL, "spi_davinci.0");
+	davinci_clk_init(&spi1_clk, NULL, "spi_davinci.1");
+	davinci_clk_init(&ecap0_clk, "ecap0", NULL);
+	davinci_clk_init(&ecap1_clk, "ecap1", NULL);
+	davinci_clk_init(&ecap2_clk, "ecap2", NULL);
+	davinci_clk_init(&pwm0_clk, "pwm0", NULL);
+	davinci_clk_init(&pwm1_clk, "pwm1", NULL);
+	davinci_clk_init(&pwm2_clk, "pwm2", NULL);
+	davinci_clk_init(&eqep0_clk, NULL, "eqep.0");
+	davinci_clk_init(&eqep1_clk, NULL, "eqep.1");
+	davinci_clk_init(&lcdc_clk, "fck", "da8xx_lcdc.0");
+	davinci_clk_init(&mcasp0_clk, NULL, "davinci-mcasp.0");
+	davinci_clk_init(&mcasp1_clk, NULL, "davinci-mcasp.1");
+	davinci_clk_init(&mcasp2_clk, NULL, "davinci-mcasp.2");
+	davinci_clk_init(&usb20_clk, "usb20", "musb-da8xx");
+	davinci_clk_init(&cppi41_clk, NULL, "cppi41-dmaengine");
+	davinci_clk_init(&aemif_clk, "aemif", NULL);
+	davinci_clk_init(&aintc_clk, "aintc", NULL);
+	davinci_clk_init(&secu_mgr_clk, "secu_mgr", NULL);
+	davinci_clk_init(&emac_clk, NULL, "davinci_emac.1");
+	davinci_clk_init(&emac_clk, "fck", "davinci_mdio.0");
+	davinci_clk_init(&gpio_clk, "gpio", NULL);
+	davinci_clk_init(&i2c1_clk, NULL, "i2c_davinci.2");
+	davinci_clk_init(&usb11_clk, "usb11", "ohci-da8xx");
+	davinci_clk_init(&emif3_clk, "emif3", NULL);
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&rmii_clk, "rmii", NULL);
+}
 
 /*
  * Device specific mux setup
@@ -1200,7 +1200,6 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
 	.ids			= da830_ids,
 	.ids_num		= ARRAY_SIZE(da830_ids),
-	.cpu_clks		= da830_clks,
 	.psc_bases		= da830_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da830_psc_bases),
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
@@ -1221,3 +1220,9 @@ void __init da830_map_io(void)
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
+
+void __init da830_init_time(void)
+{
+	da830_clk_init();
+	davinci_timer_init();
+}
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 28d8ec2..a7484e6 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -518,71 +518,71 @@ static struct clk ecap2_clk = {
 	.parent		= &ecap_clk,
 };
 
-static struct clk_lookup da850_clks[] = {
-	CLK(NULL,		"ref",		&ref_clk),
-	CLK(NULL,		"pll0",		&pll0_clk),
-	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
-	CLK(NULL,		"pll0_sysclk1",	&pll0_sysclk1),
-	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
-	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
-	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
-	CLK(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
-	CLK(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
-	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
-	CLK(NULL,		"pll1",		&pll1_clk),
-	CLK(NULL,		"pll1_aux",	&pll1_aux_clk),
-	CLK(NULL,		"pll1_sysclk2",	&pll1_sysclk2),
-	CLK(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
-	CLK(NULL,		"async3",	&async3_clk),
-	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
-	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
-	CLK(NULL,		"arm_rom",	&arm_rom_clk),
-	CLK(NULL,		"tpcc0",	&tpcc0_clk),
-	CLK(NULL,		"tptc0",	&tptc0_clk),
-	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK(NULL,		"tpcc1",	&tpcc1_clk),
-	CLK(NULL,		"tptc2",	&tptc2_clk),
-	CLK("pruss_uio",	"pruss",	&pruss_clk),
-	CLK("serial8250.0",	NULL,		&uart0_clk),
-	CLK("serial8250.1",	NULL,		&uart1_clk),
-	CLK("serial8250.2",	NULL,		&uart2_clk),
-	CLK(NULL,		"aintc",	&aintc_clk),
-	CLK(NULL,		"gpio",		&gpio_clk),
-	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK(NULL,		"emif3",	&emif3_clk),
-	CLK(NULL,		"arm",		&arm_clk),
-	CLK(NULL,		"rmii",		&rmii_clk),
-	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci_mdio.0",	"fck",		&mdio_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
-	CLK("davinci-mcbsp.0",	NULL,		&mcbsp0_clk),
-	CLK("davinci-mcbsp.1",	NULL,		&mcbsp1_clk),
-	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
-	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
-	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
-	CLK("ti-aemif",		NULL,		&aemif_clk),
-	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
-	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
-	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
-	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-	CLK("vpif",		NULL,		&vpif_clk),
-	CLK("ahci_da850",	"fck",		&sata_clk),
-	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
-	CLK(NULL,		NULL,		&ehrpwm_clk),
-	CLK("ehrpwm.0",		"fck",		&ehrpwm0_clk),
-	CLK("ehrpwm.1",		"fck",		&ehrpwm1_clk),
-	CLK(NULL,		NULL,		&ehrpwm_tbclk),
-	CLK("ehrpwm.0",		"tbclk",	&ehrpwm0_tbclk),
-	CLK("ehrpwm.1",		"tbclk",	&ehrpwm1_tbclk),
-	CLK(NULL,		NULL,		&ecap_clk),
-	CLK("ecap.0",		"fck",		&ecap0_clk),
-	CLK("ecap.1",		"fck",		&ecap1_clk),
-	CLK("ecap.2",		"fck",		&ecap2_clk),
-	CLK(NULL,		NULL,		NULL),
-};
+static __init void da850_clk_init(void)
+{
+	davinci_clk_init(&ref_clk, "ref", NULL);
+	davinci_clk_init(&pll0_clk, "pll0", NULL);
+	davinci_clk_init(&pll0_aux_clk, "pll0_aux", NULL);
+	davinci_clk_init(&pll0_sysclk1, "pll0_sysclk1", NULL);
+	davinci_clk_init(&pll0_sysclk2, "pll0_sysclk2", NULL);
+	davinci_clk_init(&pll0_sysclk3, "pll0_sysclk3", NULL);
+	davinci_clk_init(&pll0_sysclk4, "pll0_sysclk4", NULL);
+	davinci_clk_init(&pll0_sysclk5, "pll0_sysclk5", NULL);
+	davinci_clk_init(&pll0_sysclk6, "pll0_sysclk6", NULL);
+	davinci_clk_init(&pll0_sysclk7, "pll0_sysclk7", NULL);
+	davinci_clk_init(&pll1_clk, "pll1", NULL);
+	davinci_clk_init(&pll1_aux_clk, "pll1_aux", NULL);
+	davinci_clk_init(&pll1_sysclk2, "pll1_sysclk2", NULL);
+	davinci_clk_init(&pll1_sysclk3, "pll1_sysclk3", NULL);
+	davinci_clk_init(&async3_clk, "async3", NULL);
+	davinci_clk_init(&i2c0_clk, NULL, "i2c_davinci.1");
+	davinci_clk_init(&timerp64_0_clk, "timer0", NULL);
+	davinci_clk_init(&timerp64_1_clk, NULL, "davinci-wdt");
+	davinci_clk_init(&arm_rom_clk, "arm_rom", NULL);
+	davinci_clk_init(&tpcc0_clk, "tpcc0", NULL);
+	davinci_clk_init(&tptc0_clk, "tptc0", NULL);
+	davinci_clk_init(&tptc1_clk, "tptc1", NULL);
+	davinci_clk_init(&tpcc1_clk, "tpcc1", NULL);
+	davinci_clk_init(&tptc2_clk, "tptc2", NULL);
+	davinci_clk_init(&pruss_clk, "pruss", "pruss_uio");
+	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
+	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
+	davinci_clk_init(&uart2_clk, NULL, "serial8250.2");
+	davinci_clk_init(&aintc_clk, "aintc", NULL);
+	davinci_clk_init(&gpio_clk, "gpio", NULL);
+	davinci_clk_init(&i2c1_clk, NULL, "i2c_davinci.2");
+	davinci_clk_init(&emif3_clk, "emif3", NULL);
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&rmii_clk, "rmii", NULL);
+	davinci_clk_init(&emac_clk, NULL, "davinci_emac.1");
+	davinci_clk_init(&mdio_clk, "fck", "davinci_mdio.0");
+	davinci_clk_init(&mcasp_clk, NULL, "davinci-mcasp.0");
+	davinci_clk_init(&mcbsp0_clk, NULL, "davinci-mcbsp.0");
+	davinci_clk_init(&mcbsp1_clk, NULL, "davinci-mcbsp.1");
+	davinci_clk_init(&lcdc_clk, "fck", "da8xx_lcdc.0");
+	davinci_clk_init(&mmcsd0_clk, NULL, "da830-mmc.0");
+	davinci_clk_init(&mmcsd1_clk, NULL, "da830-mmc.1");
+	davinci_clk_init(&aemif_clk, NULL, "ti-aemif");
+	davinci_clk_init(&aemif_nand_clk, "aemif", "davinci-nand.0");
+	davinci_clk_init(&usb11_clk, "usb11", "ohci-da8xx");
+	davinci_clk_init(&usb20_clk, "usb20", "musb-da8xx");
+	davinci_clk_init(&cppi41_clk, NULL, "cppi41-dmaengine");
+	davinci_clk_init(&spi0_clk, NULL, "spi_davinci.0");
+	davinci_clk_init(&spi1_clk, NULL, "spi_davinci.1");
+	davinci_clk_init(&vpif_clk, NULL, "vpif");
+	davinci_clk_init(&sata_clk, "fck", "ahci_da850");
+	davinci_clk_init(&dsp_clk, NULL, "davinci-rproc.0");
+	davinci_clk_init(&ehrpwm_clk, NULL, NULL);
+	davinci_clk_init(&ehrpwm0_clk, "fck", "ehrpwm.0");
+	davinci_clk_init(&ehrpwm1_clk, "fck", "ehrpwm.1");
+	davinci_clk_init(&ehrpwm_tbclk, NULL, NULL);
+	davinci_clk_init(&ehrpwm0_tbclk, "tbclk", "ehrpwm.0");
+	davinci_clk_init(&ehrpwm1_tbclk, "tbclk", "ehrpwm.1");
+	davinci_clk_init(&ecap_clk, NULL, NULL);
+	davinci_clk_init(&ecap0_clk, "fck", "ecap.0");
+	davinci_clk_init(&ecap1_clk, "fck", "ecap.1");
+	davinci_clk_init(&ecap2_clk, "fck", "ecap.2");
+}
 
 /*
  * Device specific mux setup
@@ -1353,7 +1353,6 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
 	.ids			= da850_ids,
 	.ids_num		= ARRAY_SIZE(da850_ids),
-	.cpu_clks		= da850_clks,
 	.psc_bases		= da850_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da850_psc_bases),
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
@@ -1393,3 +1392,9 @@ void __init da850_map_io(void)
 	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
 	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 }
+
+void __init da850_init_time(void)
+{
+	da850_clk_init();
+	davinci_timer_init();
+}
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 92c7c34..1a09215 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -96,7 +96,7 @@ static const char *const da850_boards_compat[] __initconst = {
 
 DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
 	.map_io		= da850_map_io,
-	.init_time	= davinci_timer_init,
+	.init_time	= da850_init_time,
 	.init_machine	= da850_init_machine,
 	.dt_compat	= da850_boards_compat,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index d550717..ce67a65 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -83,6 +83,7 @@ int davinci_init_wdt(void);
 
 /* DM355 function declarations */
 void dm355_map_io(void);
+void dm355_init_time(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
 void dm355_init_asp1(u32 evt_enable);
@@ -91,6 +92,7 @@ int dm355_gpio_register(void);
 
 /* DM365 function declarations */
 void dm365_map_io(void);
+void dm365_init_time(void);
 void dm365_init_asp(void);
 void dm365_init_vc(void);
 void dm365_init_ks(struct davinci_ks_platform_data *pdata);
@@ -102,12 +104,14 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_map_io(void);
+void dm644x_init_time(void);
 void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm644x_gpio_register(void);
 
 /* DM646x function declarations */
 void dm646x_map_io(void);
+void dm646x_init_time(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 22440c0..cc497f4 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1059,9 +1059,6 @@ static struct clk sata_refclk = {
 	.set_rate	= davinci_simple_set_rate,
 };
 
-static struct clk_lookup sata_refclk_lookup =
-		CLK("ahci_da850", "refclk", &sata_refclk);
-
 int __init da850_register_sata_refclk(int rate)
 {
 	int ret;
@@ -1071,7 +1068,7 @@ int __init da850_register_sata_refclk(int rate)
 	if (ret)
 		return ret;
 
-	clkdev_add(&sata_refclk_lookup);
+	clk_register_clkdev(&sata_refclk, "refclk", "ahci_da850");
 
 	return 0;
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 164ff27..555b99d 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -337,51 +337,51 @@ static struct clk usb_clk = {
 	.lpsc = DAVINCI_LPSC_USB,
 };
 
-static struct clk_lookup dm355_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk4", &pll1_sysclk4),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "vpss_dac", &vpss_dac_clk),
-	CLK("vpss", "master", &vpss_master_clk),
-	CLK("vpss", "slave", &vpss_slave_clk),
-	CLK(NULL, "clkout1", &clkout1_clk),
-	CLK(NULL, "clkout2", &clkout2_clk),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
-	CLK(NULL, "clkout3", &clkout3_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("serial8250.2", NULL, &uart2_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci-mcbsp.0", NULL, &asp0_clk),
-	CLK("davinci-mcbsp.1", NULL, &asp1_clk),
-	CLK("dm6441-mmc.0", NULL, &mmcsd0_clk),
-	CLK("dm6441-mmc.1", NULL, &mmcsd1_clk),
-	CLK("spi_davinci.0", NULL, &spi0_clk),
-	CLK("spi_davinci.1", NULL, &spi1_clk),
-	CLK("spi_davinci.2", NULL, &spi2_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "pwm3", &pwm3_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK(NULL, "timer3", &timer3_clk),
-	CLK(NULL, "rto", &rto_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK(NULL, NULL, NULL),
-};
+static __init void dm355_clk_init(void)
+{
+	davinci_clk_init(&ref_clk, "ref", NULL);
+	davinci_clk_init(&pll1_clk, "pll1", NULL);
+	davinci_clk_init(&pll1_sysclk1, "pll1_sysclk1", NULL);
+	davinci_clk_init(&pll1_sysclk2, "pll1_sysclk2", NULL);
+	davinci_clk_init(&pll1_sysclk3, "pll1_sysclk3", NULL);
+	davinci_clk_init(&pll1_sysclk4, "pll1_sysclk4", NULL);
+	davinci_clk_init(&pll1_aux_clk, "pll1_aux", NULL);
+	davinci_clk_init(&pll1_sysclkbp, "pll1_sysclkbp", NULL);
+	davinci_clk_init(&vpss_dac_clk, "vpss_dac", NULL);
+	davinci_clk_init(&vpss_master_clk, "master", "vpss");
+	davinci_clk_init(&vpss_slave_clk, "slave", "vpss");
+	davinci_clk_init(&clkout1_clk, "clkout1", NULL);
+	davinci_clk_init(&clkout2_clk, "clkout2", NULL);
+	davinci_clk_init(&pll2_clk, "pll2", NULL);
+	davinci_clk_init(&pll2_sysclk1, "pll2_sysclk1", NULL);
+	davinci_clk_init(&pll2_sysclkbp, "pll2_sysclkbp", NULL);
+	davinci_clk_init(&clkout3_clk, "clkout3", NULL);
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&mjcp_clk, "mjcp", NULL);
+	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
+	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
+	davinci_clk_init(&uart2_clk, NULL, "serial8250.2");
+	davinci_clk_init(&i2c_clk, NULL, "i2c_davinci.1");
+	davinci_clk_init(&asp0_clk, NULL, "davinci-mcbsp.0");
+	davinci_clk_init(&asp1_clk, NULL, "davinci-mcbsp.1");
+	davinci_clk_init(&mmcsd0_clk, NULL, "dm6441-mmc.0");
+	davinci_clk_init(&mmcsd1_clk, NULL, "dm6441-mmc.1");
+	davinci_clk_init(&spi0_clk, NULL, "spi_davinci.0");
+	davinci_clk_init(&spi1_clk, NULL, "spi_davinci.1");
+	davinci_clk_init(&spi2_clk, NULL, "spi_davinci.2");
+	davinci_clk_init(&gpio_clk, "gpio", NULL);
+	davinci_clk_init(&aemif_clk, "aemif", NULL);
+	davinci_clk_init(&pwm0_clk, "pwm0", NULL);
+	davinci_clk_init(&pwm1_clk, "pwm1", NULL);
+	davinci_clk_init(&pwm2_clk, "pwm2", NULL);
+	davinci_clk_init(&pwm3_clk, "pwm3", NULL);
+	davinci_clk_init(&timer0_clk, "timer0", NULL);
+	davinci_clk_init(&timer1_clk, "timer1", NULL);
+	davinci_clk_init(&timer2_clk, NULL, "davinci-wdt");
+	davinci_clk_init(&timer3_clk, "timer3", NULL);
+	davinci_clk_init(&rto_clk, "rto", NULL);
+	davinci_clk_init(&usb_clk, "usb", NULL);
+}
 
 /*----------------------------------------------------------------------*/
 
@@ -1012,7 +1012,6 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm355_ids,
 	.ids_num		= ARRAY_SIZE(dm355_ids),
-	.cpu_clks		= dm355_clks,
 	.psc_bases		= dm355_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm355_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -1045,6 +1044,12 @@ void __init dm355_map_io(void)
 	davinci_map_sysmod();
 }
 
+void __init dm355_init_time(void)
+{
+	dm355_clk_init();
+	davinci_timer_init();
+}
+
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 				struct vpbe_config *vpbe_cfg)
 {
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6076085..44bbfae 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -425,66 +425,66 @@ static struct clk mjcp_clk = {
 	.lpsc		= DM365_LPSC_MJCP,
 };
 
-static struct clk_lookup dm365_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "clkout0", &clkout0_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk4", &pll1_sysclk4),
-	CLK(NULL, "pll1_sysclk5", &pll1_sysclk5),
-	CLK(NULL, "pll1_sysclk6", &pll1_sysclk6),
-	CLK(NULL, "pll1_sysclk7", &pll1_sysclk7),
-	CLK(NULL, "pll1_sysclk8", &pll1_sysclk8),
-	CLK(NULL, "pll1_sysclk9", &pll1_sysclk9),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_aux", &pll2_aux_clk),
-	CLK(NULL, "clkout1", &clkout1_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclk2", &pll2_sysclk2),
-	CLK(NULL, "pll2_sysclk3", &pll2_sysclk3),
-	CLK(NULL, "pll2_sysclk4", &pll2_sysclk4),
-	CLK(NULL, "pll2_sysclk5", &pll2_sysclk5),
-	CLK(NULL, "pll2_sysclk6", &pll2_sysclk6),
-	CLK(NULL, "pll2_sysclk7", &pll2_sysclk7),
-	CLK(NULL, "pll2_sysclk8", &pll2_sysclk8),
-	CLK(NULL, "pll2_sysclk9", &pll2_sysclk9),
-	CLK(NULL, "vpss_dac", &vpss_dac_clk),
-	CLK("vpss", "master", &vpss_master_clk),
-	CLK("vpss", "slave", &vpss_slave_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("da830-mmc.0", NULL, &mmcsd0_clk),
-	CLK("da830-mmc.1", NULL, &mmcsd1_clk),
-	CLK("spi_davinci.0", NULL, &spi0_clk),
-	CLK("spi_davinci.1", NULL, &spi1_clk),
-	CLK("spi_davinci.2", NULL, &spi2_clk),
-	CLK("spi_davinci.3", NULL, &spi3_clk),
-	CLK("spi_davinci.4", NULL, &spi4_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "pwm3", &pwm3_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK(NULL, "timer3", &timer3_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_mdio.0", "fck", &emac_clk),
-	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
-	CLK("davinci-mcbsp", NULL, &asp0_clk),
-	CLK(NULL, "rto", &rto_clk),
-	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK(NULL, NULL, NULL),
-};
+static __init void dm365_clk_init(void)
+{
+	davinci_clk_init(&ref_clk, "ref", NULL);
+	davinci_clk_init(&pll1_clk, "pll1", NULL);
+	davinci_clk_init(&pll1_aux_clk, "pll1_aux", NULL);
+	davinci_clk_init(&pll1_sysclkbp, "pll1_sysclkbp", NULL);
+	davinci_clk_init(&clkout0_clk, "clkout0", NULL);
+	davinci_clk_init(&pll1_sysclk1, "pll1_sysclk1", NULL);
+	davinci_clk_init(&pll1_sysclk2, "pll1_sysclk2", NULL);
+	davinci_clk_init(&pll1_sysclk3, "pll1_sysclk3", NULL);
+	davinci_clk_init(&pll1_sysclk4, "pll1_sysclk4", NULL);
+	davinci_clk_init(&pll1_sysclk5, "pll1_sysclk5", NULL);
+	davinci_clk_init(&pll1_sysclk6, "pll1_sysclk6", NULL);
+	davinci_clk_init(&pll1_sysclk7, "pll1_sysclk7", NULL);
+	davinci_clk_init(&pll1_sysclk8, "pll1_sysclk8", NULL);
+	davinci_clk_init(&pll1_sysclk9, "pll1_sysclk9", NULL);
+	davinci_clk_init(&pll2_clk, "pll2", NULL);
+	davinci_clk_init(&pll2_aux_clk, "pll2_aux", NULL);
+	davinci_clk_init(&clkout1_clk, "clkout1", NULL);
+	davinci_clk_init(&pll2_sysclk1, "pll2_sysclk1", NULL);
+	davinci_clk_init(&pll2_sysclk2, "pll2_sysclk2", NULL);
+	davinci_clk_init(&pll2_sysclk3, "pll2_sysclk3", NULL);
+	davinci_clk_init(&pll2_sysclk4, "pll2_sysclk4", NULL);
+	davinci_clk_init(&pll2_sysclk5, "pll2_sysclk5", NULL);
+	davinci_clk_init(&pll2_sysclk6, "pll2_sysclk6", NULL);
+	davinci_clk_init(&pll2_sysclk7, "pll2_sysclk7", NULL);
+	davinci_clk_init(&pll2_sysclk8, "pll2_sysclk8", NULL);
+	davinci_clk_init(&pll2_sysclk9, "pll2_sysclk9", NULL);
+	davinci_clk_init(&vpss_dac_clk, "vpss_dac", NULL);
+	davinci_clk_init(&vpss_master_clk, "master", "vpss");
+	davinci_clk_init(&vpss_slave_clk, "slave", "vpss");
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
+	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
+	davinci_clk_init(&i2c_clk, NULL, "i2c_davinci.1");
+	davinci_clk_init(&mmcsd0_clk, NULL, "da830-mmc.0");
+	davinci_clk_init(&mmcsd1_clk, NULL, "da830-mmc.1");
+	davinci_clk_init(&spi0_clk, NULL, "spi_davinci.0");
+	davinci_clk_init(&spi1_clk, NULL, "spi_davinci.1");
+	davinci_clk_init(&spi2_clk, NULL, "spi_davinci.2");
+	davinci_clk_init(&spi3_clk, NULL, "spi_davinci.3");
+	davinci_clk_init(&spi4_clk, NULL, "spi_davinci.4");
+	davinci_clk_init(&gpio_clk, "gpio", NULL);
+	davinci_clk_init(&aemif_clk, "aemif", NULL);
+	davinci_clk_init(&pwm0_clk, "pwm0", NULL);
+	davinci_clk_init(&pwm1_clk, "pwm1", NULL);
+	davinci_clk_init(&pwm2_clk, "pwm2", NULL);
+	davinci_clk_init(&pwm3_clk, "pwm3", NULL);
+	davinci_clk_init(&timer0_clk, "timer0", NULL);
+	davinci_clk_init(&timer1_clk, "timer1", NULL);
+	davinci_clk_init(&timer2_clk, NULL, "davinci-wdt");
+	davinci_clk_init(&timer3_clk, "timer3", NULL);
+	davinci_clk_init(&usb_clk, "usb", NULL);
+	davinci_clk_init(&emac_clk, NULL, "davinci_emac.1");
+	davinci_clk_init(&emac_clk, "fck", "davinci_mdio.0");
+	davinci_clk_init(&voicecodec_clk, NULL, "davinci_voicecodec");
+	davinci_clk_init(&asp0_clk, NULL, "davinci-mcbsp");
+	davinci_clk_init(&rto_clk, "rto", NULL);
+	davinci_clk_init(&mjcp_clk, "mjcp", NULL);
+}
 
 /*----------------------------------------------------------------------*/
 
@@ -1114,7 +1114,6 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm365_ids,
 	.ids_num		= ARRAY_SIZE(dm365_ids),
-	.cpu_clks		= dm365_clks,
 	.psc_bases		= dm365_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm365_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -1168,6 +1167,12 @@ void __init dm365_map_io(void)
 	davinci_map_sysmod();
 }
 
+void __init dm365_init_time(void)
+{
+	dm365_clk_init();
+	davinci_timer_init();
+}
+
 static struct resource dm365_vpss_resources[] = {
 	{
 		/* VPSS ISP5 Base address */
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index c5b1cf3..5d5f70d 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -285,47 +285,47 @@ static struct clk timer2_clk = {
 	.usecount = 1,              /* REVISIT: why can't this be disabled? */
 };
 
-static struct clk_lookup dm644x_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk5", &pll1_sysclk5),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclk2", &pll2_sysclk2),
-	CLK(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
-	CLK(NULL, "dsp", &dsp_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "vicp", &vicp_clk),
-	CLK("vpss", "master", &vpss_master_clk),
-	CLK("vpss", "slave", &vpss_slave_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("serial8250.2", NULL, &uart2_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_mdio.0", "fck", &emac_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("davinci-mcbsp", NULL, &asp_clk),
-	CLK("dm6441-mmc.0", NULL, &mmcsd_clk),
-	CLK(NULL, "spi", &spi_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK(NULL, "vlynq", &vlynq_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK(NULL, NULL, NULL),
-};
+static __init void dm644x_clk_init(void)
+{
+	davinci_clk_init(&ref_clk, "ref", NULL);
+	davinci_clk_init(&pll1_clk, "pll1", NULL);
+	davinci_clk_init(&pll1_sysclk1, "pll1_sysclk1", NULL);
+	davinci_clk_init(&pll1_sysclk2, "pll1_sysclk2", NULL);
+	davinci_clk_init(&pll1_sysclk3, "pll1_sysclk3", NULL);
+	davinci_clk_init(&pll1_sysclk5, "pll1_sysclk5", NULL);
+	davinci_clk_init(&pll1_aux_clk, "pll1_aux", NULL);
+	davinci_clk_init(&pll1_sysclkbp, "pll1_sysclkbp", NULL);
+	davinci_clk_init(&pll2_clk, "pll2", NULL);
+	davinci_clk_init(&pll2_sysclk1, "pll2_sysclk1", NULL);
+	davinci_clk_init(&pll2_sysclk2, "pll2_sysclk2", NULL);
+	davinci_clk_init(&pll2_sysclkbp, "pll2_sysclkbp", NULL);
+	davinci_clk_init(&dsp_clk, "dsp", NULL);
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&vicp_clk, "vicp", NULL);
+	davinci_clk_init(&vpss_master_clk, "master", "vpss");
+	davinci_clk_init(&vpss_slave_clk, "slave", "vpss");
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
+	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
+	davinci_clk_init(&uart2_clk, NULL, "serial8250.2");
+	davinci_clk_init(&emac_clk, NULL, "davinci_emac.1");
+	davinci_clk_init(&emac_clk, "fck", "davinci_mdio.0");
+	davinci_clk_init(&i2c_clk, NULL, "i2c_davinci.1");
+	davinci_clk_init(&ide_clk, NULL, "palm_bk3710");
+	davinci_clk_init(&asp_clk, NULL, "davinci-mcbsp");
+	davinci_clk_init(&mmcsd_clk, NULL, "dm6441-mmc.0");
+	davinci_clk_init(&spi_clk, "spi", NULL);
+	davinci_clk_init(&gpio_clk, "gpio", NULL);
+	davinci_clk_init(&usb_clk, "usb", NULL);
+	davinci_clk_init(&vlynq_clk, "vlynq", NULL);
+	davinci_clk_init(&aemif_clk, "aemif", NULL);
+	davinci_clk_init(&pwm0_clk, "pwm0", NULL);
+	davinci_clk_init(&pwm1_clk, "pwm1", NULL);
+	davinci_clk_init(&pwm2_clk, "pwm2", NULL);
+	davinci_clk_init(&timer0_clk, "timer0", NULL);
+	davinci_clk_init(&timer1_clk, "timer1", NULL);
+	davinci_clk_init(&timer2_clk, NULL, "davinci-wdt");
+}
 
 static struct emac_platform_data dm644x_emac_pdata = {
 	.ctrl_reg_offset	= DM644X_EMAC_CNTRL_OFFSET,
@@ -905,7 +905,6 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm644x_ids,
 	.ids_num		= ARRAY_SIZE(dm644x_ids),
-	.cpu_clks		= dm644x_clks,
 	.psc_bases		= dm644x_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm644x_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -933,6 +932,12 @@ void __init dm644x_map_io(void)
 	davinci_map_sysmod();
 }
 
+void __init dm644x_init_time(void)
+{
+	dm644x_clk_init();
+	davinci_timer_init();
+}
+
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 				struct vpbe_config *vpbe_cfg)
 {
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a844f7b..9b09e5d 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -17,6 +17,7 @@
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 
+#include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
@@ -320,49 +321,54 @@ static struct clk vpif1_clk = {
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk_lookup dm646x_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "aux", &aux_clkin),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk4),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk5),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk6),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk8),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk9),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclkbp),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "dsp", &dsp_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "edma_cc", &edma_cc_clk),
-	CLK(NULL, "edma_tc0", &edma_tc0_clk),
-	CLK(NULL, "edma_tc1", &edma_tc1_clk),
-	CLK(NULL, "edma_tc2", &edma_tc2_clk),
-	CLK(NULL, "edma_tc3", &edma_tc3_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("serial8250.2", NULL, &uart2_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK("davinci-mcasp.0", NULL, &mcasp0_clk),
-	CLK("davinci-mcasp.1", NULL, &mcasp1_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_mdio.0", "fck", &emac_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK(NULL, "vpif0", &vpif0_clk),
-	CLK(NULL, "vpif1", &vpif1_clk),
-	CLK(NULL, NULL, NULL),
-};
+#define DM6467T_EVM_REF_FREQ		33000000
+
+static __init void dm646x_clk_init(void)
+{
+	davinci_clk_init(&ref_clk, "ref", NULL);
+	davinci_clk_init(&aux_clkin, "aux", NULL);
+	davinci_clk_init(&pll1_clk, "pll1", NULL);
+	davinci_clk_init(&pll1_sysclk1, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk2, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk3, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk4, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk5, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk6, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk8, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclk9, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_sysclkbp, "pll1_sysclk", NULL);
+	davinci_clk_init(&pll1_aux_clk, "pll1_aux", NULL);
+	davinci_clk_init(&pll2_clk, "pll2", NULL);
+	davinci_clk_init(&pll2_sysclk1, "pll2_sysclk1", NULL);
+	davinci_clk_init(&dsp_clk, "dsp", NULL);
+	davinci_clk_init(&arm_clk, "arm", NULL);
+	davinci_clk_init(&edma_cc_clk, "edma_cc", NULL);
+	davinci_clk_init(&edma_tc0_clk, "edma_tc0", NULL);
+	davinci_clk_init(&edma_tc1_clk, "edma_tc1", NULL);
+	davinci_clk_init(&edma_tc2_clk, "edma_tc2", NULL);
+	davinci_clk_init(&edma_tc3_clk, "edma_tc3", NULL);
+	davinci_clk_init(&uart0_clk, NULL, "serial8250.0");
+	davinci_clk_init(&uart1_clk, NULL, "serial8250.1");
+	davinci_clk_init(&uart2_clk, NULL, "serial8250.2");
+	davinci_clk_init(&i2c_clk, NULL, "i2c_davinci.1");
+	davinci_clk_init(&gpio_clk, "gpio", NULL);
+	davinci_clk_init(&mcasp0_clk, NULL, "davinci-mcasp.0");
+	davinci_clk_init(&mcasp1_clk, NULL, "davinci-mcasp.1");
+	davinci_clk_init(&aemif_clk, "aemif", NULL);
+	davinci_clk_init(&emac_clk, NULL, "davinci_emac.1");
+	davinci_clk_init(&emac_clk, "fck", "davinci_mdio.0");
+	davinci_clk_init(&pwm0_clk, "pwm0", NULL);
+	davinci_clk_init(&pwm1_clk, "pwm1", NULL);
+	davinci_clk_init(&timer0_clk, "timer0", NULL);
+	davinci_clk_init(&timer1_clk, "timer1", NULL);
+	davinci_clk_init(&timer2_clk, NULL, "davinci-wdt");
+	davinci_clk_init(&ide_clk, NULL, "palm_bk3710");
+	davinci_clk_init(&vpif0_clk, "vpif0", NULL);
+	davinci_clk_init(&vpif1_clk, "vpif1", NULL);
+
+	if (machine_is_davinci_dm6467tevm())
+		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
+}
 
 static struct emac_platform_data dm646x_emac_pdata = {
 	.ctrl_reg_offset	= DM646X_EMAC_CNTRL_OFFSET,
@@ -888,7 +894,6 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm646x_ids,
 	.ids_num		= ARRAY_SIZE(dm646x_ids),
-	.cpu_clks		= dm646x_clks,
 	.psc_bases		= dm646x_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(dm646x_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
@@ -958,6 +963,12 @@ void __init dm646x_map_io(void)
 	davinci_map_sysmod();
 }
 
+void __init dm646x_init_time(void)
+{
+	dm646x_clk_init();
+	davinci_timer_init();
+}
+
 static int __init dm646x_init_devices(void)
 {
 	int ret = 0;
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 037aa66..9b85d5d 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -53,7 +53,6 @@ struct davinci_soc_info {
 	u32				jtag_id_reg;
 	struct davinci_id		*ids;
 	unsigned long			ids_num;
-	struct clk_lookup		*cpu_clks;
 	u32				*psc_bases;
 	unsigned long			psc_bases_num;
 	u32				pinmux_base;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index c760c1b..90b00d0 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -87,7 +87,10 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_map_io(void);
+void da830_init_time(void);
+
 void da850_map_io(void);
+void da850_init_time(void);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 6ba156e..65b28e6 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -20,7 +20,6 @@
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 
-#include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
@@ -342,8 +341,6 @@ static struct clock_event_device clockevent_davinci = {
 	.set_state_oneshot	= davinci_set_oneshot,
 };
 
-#define DM6467T_EVM_REF_FREQ		33000000
-
 void __init davinci_timer_init(void)
 {
 	struct clk *timer_clk;
@@ -352,11 +349,6 @@ void __init davinci_timer_init(void)
 	unsigned int clocksource_id;
 	int i;
 
-	davinci_clk_init(soc_info->cpu_clks);
-
-	if (machine_is_davinci_dm6467tevm())
-		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
-
 	clockevent_id = soc_info->timer_info->clockevent_id;
 	clocksource_id = soc_info->timer_info->clocksource_id;
 
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 9a6af0b..2630efa9e 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -132,9 +132,6 @@ static struct clk usb_refclkin = {
 	.set_rate	= davinci_simple_set_rate,
 };
 
-static struct clk_lookup usb_refclkin_lookup =
-	CLK(NULL, "usb_refclkin", &usb_refclkin);
-
 /**
  * da8xx_register_usb_refclkin - register USB_REFCLKIN clock
  *
@@ -153,7 +150,7 @@ int __init da8xx_register_usb_refclkin(int rate)
 	if (ret)
 		return ret;
 
-	clkdev_add(&usb_refclkin_lookup);
+	clk_register_clkdev(&usb_refclkin, "usb_refclkin", NULL);
 
 	return 0;
 }
@@ -261,9 +258,6 @@ static struct clk usb20_phy_clk = {
 	.set_parent	= usb20_phy_clk_set_parent,
 };
 
-static struct clk_lookup usb20_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb20_phy", &usb20_phy_clk);
-
 /**
  * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
  *
@@ -290,7 +284,7 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 	usb20_phy_clk.parent = parent;
 	ret = clk_register(&usb20_phy_clk);
 	if (!ret)
-		clkdev_add(&usb20_phy_clk_lookup);
+		clk_register_clkdev(&usb20_phy_clk, "usb20_phy", "da8xx-usb-phy");
 
 	clk_put(parent);
 
@@ -323,9 +317,6 @@ static struct clk usb11_phy_clk = {
 	.set_parent	= usb11_phy_clk_set_parent,
 };
 
-static struct clk_lookup usb11_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb11_phy", &usb11_phy_clk);
-
 /**
  * da8xx_register_usb11_phy_clk - register USB1PHYCLKMUX clock
  *
@@ -347,7 +338,7 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 	usb11_phy_clk.parent = parent;
 	ret = clk_register(&usb11_phy_clk);
 	if (!ret)
-		clkdev_add(&usb11_phy_clk_lookup);
+		clk_register_clkdev(&usb11_phy_clk, "usb11_phy", "da8xx-usb-phy");
 
 	clk_put(parent);
 
-- 
2.7.4

From: david@lechnology.com (David Lechner)
Date: Sun, 31 Dec 2017 17:39:45 -0600
Subject: [PATCH v4 4/7] ARM: davinci: remove davinci_set_refclk_rate()
In-Reply-To: <1514763588-31560-1-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
Message-ID: <1514763588-31560-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the davinci_set_refclk_rate() function. This was used to set
the ref_clk rate after all clocks had been registered when clocks were
registered from a static table.

However, now it is possible to modify the rate before registering the
clocks in the first place by passing the rate as a function parameter.
The aux_clkin rate is also passed as a parameter since technically it is
also board-specific.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 12 +++++++-----
 arch/arm/mach-davinci/clock.c            | 32 --------------------------------
 arch/arm/mach-davinci/clock.h            |  1 -
 arch/arm/mach-davinci/davinci.h          |  2 +-
 arch/arm/mach-davinci/dm646x.c           | 18 +++++++-----------
 5 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index dafc852..c8f517b 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -716,17 +716,19 @@ static void __init evm_init_i2c(void)
 }
 #endif
 
-#define DM6467T_EVM_REF_FREQ		33000000
-
 static void __init davinci_map_io(void)
 {
 	dm646x_init();
 }
 
+static void __init dm6467_evm_init_time(void)
+{
+	dm646x_init_time(27000000, 24000000);
+}
+
 static void __init dm6467t_evm_init_time(void)
 {
-	dm646x_init_time();
-	davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
+	dm646x_init_time(33000000, 24000000);
 }
 
 #define DM646X_EVM_PHY_ID		"davinci_mdio-0:01"
@@ -800,7 +802,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.atag_offset  = 0x100,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
-	.init_time	= dm646x_init_time,
+	.init_time	= dm6467_evm_init_time,
 	.init_machine = evm_init,
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index f82a90c..52b95e2 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -575,38 +575,6 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 }
 EXPORT_SYMBOL(davinci_set_pllrate);
 
-/**
- * davinci_set_refclk_rate() - Set the reference clock rate
- * @rate:	The new rate.
- *
- * Sets the reference clock rate to a given value. This will most likely
- * result in the entire clock tree getting updated.
- *
- * This is used to support boards which use a reference clock different
- * than that used by default in <soc>.c file. The reference clock rate
- * should be updated early in the boot process; ideally soon after the
- * clock tree has been initialized once with the default reference clock
- * rate (davinci_clk_init()).
- *
- * Returns 0 on success, error otherwise.
- */
-int davinci_set_refclk_rate(unsigned long rate)
-{
-	struct clk *refclk;
-
-	refclk = clk_get(NULL, "ref");
-	if (IS_ERR(refclk)) {
-		pr_err("%s: failed to get reference clock\n", __func__);
-		return PTR_ERR(refclk);
-	}
-
-	clk_set_rate(refclk, rate);
-
-	clk_put(refclk);
-
-	return 0;
-}
-
 struct clk * __init davinci_clk_init(struct clk *clk)
 {
 	if (!clk->recalc) {
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 66c40a2..61fcdaa 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -122,7 +122,6 @@ struct clk *davinci_clk_init(struct clk *clk);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
 int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
-int davinci_set_refclk_rate(unsigned long rate);
 int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
 int davinci_clk_reset(struct clk *clk, bool reset);
 void davinci_clk_enable(struct clk *clk);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index d70f4d9..270cef8 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -111,7 +111,7 @@ int dm644x_gpio_register(void);
 
 /* DM646x function declarations */
 void dm646x_init(void);
-void dm646x_init_time(void);
+void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0cd5d51..31dbe93 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -39,12 +39,6 @@
 #define VSCLKDIS_MASK		(BIT_MASK(11) | BIT_MASK(10) | BIT_MASK(9) |\
 					BIT_MASK(8))
 
-/*
- * Device specific clocks
- */
-#define DM646X_REF_FREQ		27000000
-#define DM646X_AUX_FREQ		24000000
-
 #define DM646X_EMAC_BASE		0x01c80000
 #define DM646X_EMAC_MDIO_BASE		(DM646X_EMAC_BASE + 0x4000)
 #define DM646X_EMAC_CNTRL_OFFSET	0x0000
@@ -64,13 +58,11 @@ static struct pll_data pll2_data = {
 
 static struct clk ref_clk = {
 	.name = "ref_clk",
-	.rate = DM646X_REF_FREQ,
 	.set_rate = davinci_simple_set_rate,
 };
 
 static struct clk aux_clkin = {
 	.name = "aux_clkin",
-	.rate = DM646X_AUX_FREQ,
 };
 
 static struct clk pll1_clk = {
@@ -320,10 +312,13 @@ static struct clk vpif1_clk = {
 	.flags = ALWAYS_ENABLED,
 };
 
-static __init void dm646x_clk_init(void)
+static __init void dm646x_clk_init(unsigned long ref_clk_rate,
+				   unsigned long aux_clkin_rate)
 {
 	struct clk *clk;
 
+	ref_clk.rate = ref_clk_rate;
+	aux_clkin.rate = aux_clkin_rate;
 	clk = davinci_clk_init(&ref_clk);
 	clk_register_clkdev(clk, "ref", NULL);
 	clk = davinci_clk_init(&aux_clkin);
@@ -998,9 +993,10 @@ void __init dm646x_init(void)
 	davinci_map_sysmod();
 }
 
-void __init dm646x_init_time(void)
+void __init dm646x_init_time(unsigned long ref_clk_rate,
+			     unsigned long aux_clkin_rate)
 {
-	dm646x_clk_init();
+	dm646x_clk_init(ref_clk_rate, aux_clkin_rate);
 	davinci_timer_init();
 }
 
-- 
2.7.4

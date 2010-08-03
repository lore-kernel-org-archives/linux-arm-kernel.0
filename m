From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 3 Aug 2010 09:37:08 +0200
Subject: [PATCH 1/3] ARM: fix U300 apb_pclk split
Message-ID: <1280821028-14267-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a regression due to the new apb_pclk stuff in the U300
platform, makes it run by splitting the apb clock off the single
UART clocks. For the MMCI and PL022 clocks we don't split them:
these are actually hardwired to the same clock terminal and will
thus simply have a double reference count and will be referenced
twice.

We also move clock registration to .init_irq() so they are
available early enough for probing to be successful and remove the
earlier quirk to clock primecells during PrimeCell registration.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
NB: the pclk stuff also caused a power regression on U300 since
declocking the single clock disabled the block clock (and this
actually worked nicely) but that will have to be fixed properly
in the individual PrimeCell drivers.
---
 arch/arm/mach-u300/clock.c |  116 ++++++++++++++++++++------------------------
 arch/arm/mach-u300/clock.h |    3 +-
 arch/arm/mach-u300/core.c  |    5 +-
 3 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index 5d12d54..7836de3 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -947,6 +947,10 @@ static struct clk fast_clk = {
 	.lock       = __SPIN_LOCK_UNLOCKED(fast_clk.lock),
 };
 
+/*
+ * The MMCI apb_pclk is hardwired to the same terminal as the
+ * external MCI clock. Thus this will be referenced twice.
+ */
 static struct clk mmcsd_clk = {
 	.name       = "MCLK",
 	.parent	    = &fast_clk,
@@ -1024,6 +1028,10 @@ static struct clk i2c1_clk = {
 	.lock       = __SPIN_LOCK_UNLOCKED(i2c1_clk.lock),
 };
 
+/*
+ * The SPI apb_pclk is hardwired to the same terminal as the
+ * external SPI clock. Thus this will be referenced twice.
+ */
 static struct clk spi_clk = {
 	.name       = "SPI",
 	.parent	    = &fast_clk,
@@ -1040,10 +1048,9 @@ static struct clk spi_clk = {
 };
 
 #ifdef CONFIG_MACH_U300_BS335
-static struct clk uart1_clk = {
-	.name	    = "UART1",
+static struct clk uart1_pclk = {
+	.name	    = "UART1_PCLK",
 	.parent	    = &fast_clk,
-	.rate	    = 13000000,
 	.hw_ctrld   = false,
 	.reset	    = true,
 	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
@@ -1051,6 +1058,14 @@ static struct clk uart1_clk = {
 	.clk_val    = U300_SYSCON_SBCER_UART1_CLK_EN,
 	.enable     = syscon_clk_enable,
 	.disable    = syscon_clk_disable,
+	.lock       = __SPIN_LOCK_UNLOCKED(uart1_pclk.lock),
+};
+
+/* This one is hardwired to PLL13 */
+static struct clk uart1_clk = {
+	.name	    = "UART1_CLK",
+	.rate	    = 13000000,
+	.hw_ctrld   = true,
 	.lock       = __SPIN_LOCK_UNLOCKED(uart1_clk.lock),
 };
 #endif
@@ -1085,11 +1100,9 @@ static struct clk wdog_clk = {
 	.lock       = __SPIN_LOCK_UNLOCKED(wdog_clk.lock),
 };
 
-/* This one is hardwired to PLL13 */
-static struct clk uart_clk = {
-	.name	    = "UARTCLK",
+static struct clk uart0_pclk = {
+	.name	    = "UART0_PCLK",
 	.parent	    = &slow_clk,
-	.rate	    = 13000000,
 	.hw_ctrld   = false,
 	.reset	    = true,
 	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
@@ -1097,7 +1110,16 @@ static struct clk uart_clk = {
 	.clk_val    = U300_SYSCON_SBCER_UART_CLK_EN,
 	.enable     = syscon_clk_enable,
 	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(uart_clk.lock),
+	.lock       = __SPIN_LOCK_UNLOCKED(uart0_pclk.lock),
+};
+
+/* This one is hardwired to PLL13 */
+static struct clk uart0_clk = {
+	.name	    = "UART0_CLK",
+	.parent	    = &slow_clk,
+	.rate	    = 13000000,
+	.hw_ctrld   = true,
+	.lock       = __SPIN_LOCK_UNLOCKED(uart0_clk.lock),
 };
 
 static struct clk keypad_clk = {
@@ -1212,23 +1234,24 @@ static struct clk ppm_clk = {
 };
 #endif
 
-static struct clk dummy_apb_pclk;
-
 #define DEF_LOOKUP(devid, clkref)		\
 	{					\
 	.dev_id = devid,			\
 	.clk = clkref,				\
 	}
 
+#define DEF_LOOKUP_CON(devid, conid, clkref)	\
+	{					\
+	.dev_id = devid,			\
+	.con_id = conid,			\
+	.clk = clkref,				\
+	}
+
 /*
  * Here we only define clocks that are meaningful to
  * look up through clockdevice.
  */
 static struct clk_lookup lookups[] = {
-	{
-		.con_id = "apb_pclk",
-		.clk = &dummy_apb_pclk,
-	},
 	/* Connected directly to the AMBA bus */
 	DEF_LOOKUP("amba",      &amba_clk),
 	DEF_LOOKUP("cpu",       &cpu_clk),
@@ -1247,11 +1270,14 @@ static struct clk_lookup lookups[] = {
 	/* AHB bridge clocks */
 	DEF_LOOKUP("ahb_subsys", &ahb_subsys_clk),
 	DEF_LOOKUP("intcon",    &intcon_clk),
+	DEF_LOOKUP_CON("intcon", "apb_pclk", &intcon_clk),
 	DEF_LOOKUP("mspro",     &mspro_clk),
 	DEF_LOOKUP("pl172",     &emif_clk),
+	DEF_LOOKUP_CON("pl172", "apb_pclk", &emif_clk),
 	/* FAST bridge clocks */
 	DEF_LOOKUP("fast",      &fast_clk),
 	DEF_LOOKUP("mmci",      &mmcsd_clk),
+	DEF_LOOKUP_CON("mmci", "apb_pclk", &mmcsd_clk),
 	/*
 	 * The .0 and .1 identifiers on these comes from the platform device
 	 * .id field and are assigned when the platform devices are registered.
@@ -1261,13 +1287,16 @@ static struct clk_lookup lookups[] = {
 	DEF_LOOKUP("stu300.0",  &i2c0_clk),
 	DEF_LOOKUP("stu300.1",  &i2c1_clk),
 	DEF_LOOKUP("pl022",     &spi_clk),
+	DEF_LOOKUP_CON("pl022", "apb_pclk", &spi_clk),
 #ifdef CONFIG_MACH_U300_BS335
 	DEF_LOOKUP("uart1",     &uart1_clk),
+	DEF_LOOKUP_CON("uart1", "apb_pclk", &uart1_pclk),
 #endif
 	/* SLOW bridge clocks */
 	DEF_LOOKUP("slow",      &slow_clk),
 	DEF_LOOKUP("coh901327_wdog",      &wdog_clk),
-	DEF_LOOKUP("uart0",     &uart_clk),
+	DEF_LOOKUP("uart0",     &uart0_clk),
+	DEF_LOOKUP_CON("uart0", "apb_pclk", &uart0_pclk),
 	DEF_LOOKUP("apptimer",  &app_timer_clk),
 	DEF_LOOKUP("coh901461-keypad",    &keypad_clk),
 	DEF_LOOKUP("u300-gpio", &gpio_clk),
@@ -1287,46 +1316,6 @@ static void __init clk_register(void)
 }
 
 /*
- * These are the clocks for cells registered as primecell drivers
- * on the AMBA bus. These must be on during AMBA device registration
- * since the bus probe will attempt to read magic configuration
- * registers for these devices. If they are deactivated these probes
- * will fail.
- *
- *
- * Please note that on emif, both RAM and NAND is connected in dual
- * RAM phones. On single RAM phones, ram is on semi and NAND on emif.
- *
- */
-void u300_clock_primecells(void)
-{
-	clk_enable(&intcon_clk);
-	clk_enable(&uart_clk);
-#ifdef CONFIG_MACH_U300_BS335
-	clk_enable(&uart1_clk);
-#endif
-	clk_enable(&spi_clk);
-
-	clk_enable(&mmcsd_clk);
-
-}
-EXPORT_SYMBOL(u300_clock_primecells);
-
-void u300_unclock_primecells(void)
-{
-
-	clk_disable(&intcon_clk);
-	clk_disable(&uart_clk);
-#ifdef CONFIG_MACH_U300_BS335
-	clk_disable(&uart1_clk);
-#endif
-	clk_disable(&spi_clk);
-	clk_disable(&mmcsd_clk);
-
-}
-EXPORT_SYMBOL(u300_unclock_primecells);
-
-/*
  * The interrupt controller is enabled before the clock API is registered.
  */
 void u300_enable_intcon_clock(void)
@@ -1344,6 +1333,7 @@ void u300_enable_timer_clock(void)
 }
 EXPORT_SYMBOL(u300_enable_timer_clock);
 
+
 #if (defined(CONFIG_DEBUG_FS) && defined(CONFIG_U300_DEBUG))
 /*
  * The following makes it possible to view the status (especially
@@ -1385,11 +1375,13 @@ static struct clk *clks[] = {
 	&spi_clk,
 #ifdef CONFIG_MACH_U300_BS335
 	&uart1_clk,
+	&uart1_pclk,
 #endif
 	/* SLOW bridge clocks */
 	&slow_clk,
 	&wdog_clk,
-	&uart_clk,
+	&uart0_clk,
+	&uart0_pclk,
 	&app_timer_clk,
 	&keypad_clk,
 	&gpio_clk,
@@ -1430,7 +1422,7 @@ static int u300_clocks_show(struct seq_file *s, void *data)
 				chars++;
 			}
 			cdp[32] = '\0';
-			if (clk->get_rate)
+			if (clk->get_rate || clk->rate != 0)
 				seq_printf(s,
 					   "%s%s\t%s\t%d\t%s\t%lu Hz\n",
 					   &cdp[0],
@@ -1439,7 +1431,7 @@ static int u300_clocks_show(struct seq_file *s, void *data)
 					   clk->usecount ? "ON" : "OFF",
 					   clk->usecount,
 					   clk->hw_ctrld  ? "YES" : "NO ",
-					   clk->get_rate(clk));
+					   clk_get_rate(clk));
 			else
 				seq_printf(s,
 					   "%s%s\t%s\t%d\t%s\t" \
@@ -1483,7 +1475,7 @@ static int __init init_clk_read_debugfs(void)
 module_init(init_clk_read_debugfs);
 #endif
 
-static int __init u300_clock_init(void)
+int __init u300_clock_init(void)
 {
 	u16 val;
 
@@ -1520,10 +1512,8 @@ static int __init u300_clock_init(void)
 	 */
 	syscon_block_reset_disable(&semi_clk);
 	syscon_block_reset_disable(&emif_clk);
-	semi_clk.enable(&semi_clk);
-	emif_clk.enable(&emif_clk);
+	clk_enable(&semi_clk);
+	clk_enable(&emif_clk);
 
 	return 0;
 }
-/* initialize clocking early to be available later in the boot */
-core_initcall(u300_clock_init);
diff --git a/arch/arm/mach-u300/clock.h b/arch/arm/mach-u300/clock.h
index fc6d9cc..fc40c32 100644
--- a/arch/arm/mach-u300/clock.h
+++ b/arch/arm/mach-u300/clock.h
@@ -45,9 +45,8 @@ struct clk {
 	void (*disable) (struct clk *);
 };
 
-void u300_clock_primecells(void);
-void u300_unclock_primecells(void);
 void u300_enable_intcon_clock(void);
 void u300_enable_timer_clock(void);
+int u300_clock_init(void);
 
 #endif
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 653b3e0..b189763 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1479,6 +1479,9 @@ void __init u300_init_irq(void)
 	u32 mask[2] = {0, 0};
 	int i;
 
+	/* initialize clocking early, we want to clock the INTCON */
+	u300_clock_init();
+
 	for (i = 0; i < NR_IRQS; i++)
 		set_bit(i, (unsigned long *) &mask[0]);
 	u300_enable_intcon_clock();
@@ -1635,12 +1638,10 @@ void __init u300_init_devices(void)
 	u300_spi_init(&pl022_device);
 
 	/* Register the AMBA devices in the AMBA bus abstraction layer */
-	u300_clock_primecells();
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
 	}
-	u300_unclock_primecells();
 
 	u300_assign_physmem();
 
-- 
1.6.3.3

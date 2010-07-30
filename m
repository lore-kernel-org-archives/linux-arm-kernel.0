From: wellsk40@gmail.com (Kevin Wells)
Date: Thu, 29 Jul 2010 17:24:47 -0700
Subject: RFC ARM LPC32xx AMBA apb_pclk changes
Message-ID: <AANLkTi=eqwRMYLAUoXkuBgTrPWHsj_XbfQF4FgNOxiXd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a first cut at adding apb_pclk support for the AMBA bus driver.

The temporary clock enable/disable wrappers around the amba_register
function will no longer be needed. A "apb_pclk" con_id wasn't added,
using only the matching device IDs used by the AMBA drivers. Because
the AMBA driver attempts to turn off the LCD clock prior to exist, the
workaround for the LCD clock enable needs to be handled with
clk_enable so it will stay on after the AMBA driver disables it's clock.

---
 arch/arm/mach-lpc32xx/clock.c   |   27 +--------------------------
 arch/arm/mach-lpc32xx/clock.h   |    3 ---
 arch/arm/mach-lpc32xx/phy3250.c |   25 ++++++++++++++++---------
 3 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 043a5de..8d4aac1 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1032,31 +1032,6 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);

-/*
- * These are the clocks for cells registered as primecell drivers
- * on the AMBA bus. These must be on during AMBA device registration
- * since the bus probe will attempt to read magic configuration
- * registers for these devices. If they are deactivated these probes
- * will fail.
- */
-void lpc32xx_clock_primecells(void)
-{
-	clk_enable(&clk_mmc);
-	clk_enable(&clk_lcd);
-	clk_enable(&clk_ssp0);
-	clk_enable(&clk_ssp1);
-}
-EXPORT_SYMBOL(lpc32xx_clock_primecells);
-
-void lpc32xx_unclock_primecells(void)
-{
-	clk_disable(&clk_mmc);
-	clk_disable(&clk_lcd);
-	clk_disable(&clk_ssp0);
-	clk_disable(&clk_ssp1);
-}
-EXPORT_SYMBOL(lpc32xx_unclock_primecells);
-
 #define _REGISTER_CLOCK(d, n, c) \
 	{ \
 		.dev_id = (d), \
@@ -1094,7 +1069,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "i2s0_ck", clk_i2s0)
 	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
 	_REGISTER_CLOCK("lpc32xx-ts", NULL, clk_tsc)
-	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
+	_REGISTER_CLOCK("dev:mmc0", NULL, clk_mmc)
 	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
 	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
 	_REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
diff --git a/arch/arm/mach-lpc32xx/clock.h b/arch/arm/mach-lpc32xx/clock.h
index f326752..c0a8434 100644
--- a/arch/arm/mach-lpc32xx/clock.h
+++ b/arch/arm/mach-lpc32xx/clock.h
@@ -35,7 +35,4 @@ struct clk {
 	u32 enable_mask;
 };

-void lpc32xx_clock_primecells(void);
-void lpc32xx_unclock_primecells(void);
-
 #endif
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 9283cab..2e3facc 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -38,7 +38,6 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include "common.h"
-#include "clock.h"

 /*
  * Mapped GPIOLIB GPIOs
@@ -295,6 +294,7 @@ static void __init phy3250_board_init(void)
 {
 	u32 tmp;
 	int i;
+	struct clk *clk;

 	lpc32xx_gpio_init();

@@ -341,28 +341,35 @@ static void __init phy3250_board_init(void)

 	lpc32xx_serial_init();

-	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
-
-	lpc32xx_clock_primecells();
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
 	}
-	lpc32xx_unclock_primecells();

+	(void) clk;
 #ifdef CONFIG_FB_ARMCLCD
 	/*
 	 * The AMBA PL11x driver attempts to disable the LCD and then
 	 * access some peripheral registers while the clock is disabled.
 	 * This workaround won't fix the unbalanced clock enable and
 	 * disable, but will prevent the ARM core from throwing an
-	 * exception when that happens.
+	 * exception when that happens. The clkdev API is used to make
+	 * sure@least 1 device is alwasy requesting the clock to
+	 * prevent the AMBA bus driver from turning it off.
 	 */
-	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
-		LPC32XX_CLKPWR_LCDCLK_CTRL);
+	clk = clk_get(&lpc32xx_clcd_device.dev, NULL);
+	if (!IS_ERR(clk)) {
+		i = clk_enable(clk);
+		if (i)
+			clk_put(clk);
+	}
+
+	if (i || IS_ERR(clk))
+		printk("Cannot enable CLCD clock\n");
 #endif

+	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
+
 	/* Test clock needed for UDA1380 initial init */
 	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
-- 
1.7.1.1

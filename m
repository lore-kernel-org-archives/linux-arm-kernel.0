From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu,  3 Mar 2016 04:46:20 +0200
Subject: [PATCH for v4.7] arm: lpc32xx: remove leftovers of legacy clock
 source and provider drivers
Message-ID: <1456973180-31764-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After switching the platform to common clock framework there is no
more need to keep dead code in arch/arm/mach-lpc32xx, which glued
legacy clock source and clock provider drivers, remove the leftovers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-lpc32xx/common.c | 95 ------------------------------------------
 arch/arm/mach-lpc32xx/common.h | 23 +---------
 2 files changed, 1 insertion(+), 117 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 716e83e..3fea0b2 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -17,13 +17,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include <linux/i2c-pnx.h>
-#include <linux/io.h>
 
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
@@ -44,19 +37,6 @@ void lpc32xx_get_uid(u32 devid[4])
 }
 
 /*
- * Returns SYSCLK source
- * 0 = PLL397, 1 = main oscillator
- */
-int clk_is_sysclk_mainosc(void)
-{
-	if ((__raw_readl(LPC32XX_CLKPWR_SYSCLK_CTRL) &
-		LPC32XX_CLKPWR_SYSCTRL_SYSCLKMUX) == 0)
-		return 1;
-
-	return 0;
-}
-
-/*
  * Detects and returns IRAM size for the device variation
  */
 #define LPC32XX_IRAM_BANK_SIZE SZ_128K
@@ -87,81 +67,6 @@ u32 lpc32xx_return_iram_size(void)
 }
 EXPORT_SYMBOL_GPL(lpc32xx_return_iram_size);
 
-/*
- * Computes PLL rate from PLL register and input clock
- */
-u32 clk_check_pll_setup(u32 ifreq, struct clk_pll_setup *pllsetup)
-{
-	u32 ilfreq, p, m, n, fcco, fref, cfreq;
-	int mode;
-
-	/*
-	 * PLL requirements
-	 * ifreq must be >= 1MHz and <= 20MHz
-	 * FCCO must be >= 156MHz and <= 320MHz
-	 * FREF must be >= 1MHz and <= 27MHz
-	 * Assume the passed input data is not valid
-	 */
-
-	ilfreq = ifreq;
-	m = pllsetup->pll_m;
-	n = pllsetup->pll_n;
-	p = pllsetup->pll_p;
-
-	mode = (pllsetup->cco_bypass_b15 << 2) |
-		(pllsetup->direct_output_b14 << 1) |
-	pllsetup->fdbk_div_ctrl_b13;
-
-	switch (mode) {
-	case 0x0: /* Non-integer mode */
-		cfreq = (m * ilfreq) / (2 * p * n);
-		fcco = (m * ilfreq) / n;
-		fref = ilfreq / n;
-		break;
-
-	case 0x1: /* integer mode */
-		cfreq = (m * ilfreq) / n;
-		fcco = (m * ilfreq) / (n * 2 * p);
-		fref = ilfreq / n;
-		break;
-
-	case 0x2:
-	case 0x3: /* Direct mode */
-		cfreq = (m * ilfreq) / n;
-		fcco = cfreq;
-		fref = ilfreq / n;
-		break;
-
-	case 0x4:
-	case 0x5: /* Bypass mode */
-		cfreq = ilfreq / (2 * p);
-		fcco = 156000000;
-		fref = 1000000;
-		break;
-
-	case 0x6:
-	case 0x7: /* Direct bypass mode */
-	default:
-		cfreq = ilfreq;
-		fcco = 156000000;
-		fref = 1000000;
-		break;
-	}
-
-	if (fcco < 156000000 || fcco > 320000000)
-		cfreq = 0;
-
-	if (fref < 1000000 || fref > 27000000)
-		cfreq = 0;
-
-	return (u32) cfreq;
-}
-
-u32 clk_get_pclk_div(void)
-{
-	return 1 + ((__raw_readl(LPC32XX_CLKPWR_HCLK_DIV) >> 2) & 0x1F);
-}
-
 static struct map_desc lpc32xx_io_desc[] __initdata = {
 	{
 		.virtual	= (unsigned long)IO_ADDRESS(LPC32XX_AHB0_START),
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 1cd8853..f03683f 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -19,38 +19,17 @@
 #ifndef __LPC32XX_COMMON_H
 #define __LPC32XX_COMMON_H
 
-#include <mach/board.h>
-#include <linux/platform_device.h>
+#include <linux/init.h>
 #include <linux/reboot.h>
 
 /*
  * Other arch specific structures and functions
  */
-extern void lpc32xx_timer_init(void);
 extern void __init lpc32xx_init_irq(void);
 extern void __init lpc32xx_map_io(void);
 extern void __init lpc32xx_serial_init(void);
 extern void lpc23xx_restart(enum reboot_mode, const char *);
 
-
-/*
- * Structure used for setting up and querying the PLLS
- */
-struct clk_pll_setup {
-	int analog_on;
-	int cco_bypass_b15;
-	int direct_output_b14;
-	int fdbk_div_ctrl_b13;
-	int pll_p;
-	int pll_n;
-	u32 pll_m;
-};
-
-extern int clk_is_sysclk_mainosc(void);
-extern u32 clk_check_pll_setup(u32 ifreq, struct clk_pll_setup *pllsetup);
-extern u32 clk_get_pllrate_from_reg(u32 inputclk, u32 regval);
-extern u32 clk_get_pclk_div(void);
-
 /*
  * Returns the LPC32xx unique 128-bit chip ID
  */
-- 
2.1.4

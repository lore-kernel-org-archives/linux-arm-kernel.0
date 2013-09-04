From: stigge@antcom.de (Roland Stigge)
Date: Wed,  4 Sep 2013 16:33:28 +0200
Subject: [PATCH] ARM: LPC32xx: Fix reset function
Message-ID: <1378305208-5330-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the recent change to the reset function API (commit
7b6d864b48d95e6ea1df7df64475b9cb9616dcf9), the mode argument changed from a
char to an enum. lpc23xx_restart() only handles REBOOT_SOFT and REBOOT_HARD,
but the new kernel code emits REBOOT_COLD (0) on reboots now which leads to
lpc32xx simply not rebooting (but halting).

This patch fixes this by just resetting unconditionally as on other platforms
(e.g. mach-bcm2835).

Pulling lpc32xx_watchdog_reset() into lpc23xx_restart() since the while() in
lpc23xx_restart() is part of the procedure anyway and lpc32xx_watchdog_reset()
isn't used anywhere else anymore.

Signed-off-by: Roland Stigge <stigge@antcom.de>

--

Will provide a pull request for arm-soc when someone commented on this one.

---
 arch/arm/mach-lpc32xx/common.c |   29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/common.c
+++ linux-2.6/arch/arm/mach-lpc32xx/common.c
@@ -57,20 +57,6 @@ int clk_is_sysclk_mainosc(void)
 }
 
 /*
- * System reset via the watchdog timer
- */
-static void lpc32xx_watchdog_reset(void)
-{
-	/* Make sure WDT clocks are enabled */
-	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
-		LPC32XX_CLKPWR_TIMER_CLK_CTRL);
-
-	/* Instant assert of RESETOUT_N with pulse length 1mS */
-	__raw_writel(13000, io_p2v(LPC32XX_WDTIM_BASE + 0x18));
-	__raw_writel(0x70, io_p2v(LPC32XX_WDTIM_BASE + 0xC));
-}
-
-/*
  * Detects and returns IRAM size for the device variation
  */
 #define LPC32XX_IRAM_BANK_SIZE SZ_128K
@@ -209,16 +195,13 @@ void __init lpc32xx_map_io(void)
 
 void lpc23xx_restart(enum reboot_mode mode, const char *cmd)
 {
-	switch (mode) {
-	case REBOOT_SOFT:
-	case REBOOT_HARD:
-		lpc32xx_watchdog_reset();
-		break;
+	/* Make sure WDT clocks are enabled */
+	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
+		LPC32XX_CLKPWR_TIMER_CLK_CTRL);
 
-	default:
-		/* Do nothing */
-		break;
-	}
+	/* Instant assert of RESETOUT_N with pulse length 1mS */
+	__raw_writel(13000, io_p2v(LPC32XX_WDTIM_BASE + 0x18));
+	__raw_writel(0x70, io_p2v(LPC32XX_WDTIM_BASE + 0xC));
 
 	/* Wait for watchdog to reset system */
 	while (1)

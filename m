From: stigge@antcom.de (Roland Stigge)
Date: Thu, 28 Jun 2012 00:26:11 +0200
Subject: [PATCH 1/8] ARM: LPC32xx: Init MMC via clock
In-Reply-To: <1340835978-20331-1-git-send-email-stigge@antcom.de>
References: <1340835978-20331-1-git-send-email-stigge@antcom.de>
Message-ID: <1340835978-20331-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves MMC/SD controller initialization from the board specific file
phy3250.c to clock.c.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/clock.c   |    6 ++++--
 arch/arm/mach-lpc32xx/phy3250.c |    5 -----
 2 files changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -812,11 +812,13 @@ static int mmc_onoff_enable(struct clk *
 	u32 tmp;
 
 	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL) &
-		~LPC32XX_CLKPWR_MSCARD_SDCARD_EN;
+		~(LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
+		  LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN);
 
 	/* If rate is 0, disable clock */
 	if (enable != 0)
-		tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_EN;
+		tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
+			LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN;
 
 	__raw_writel(tmp, LPC32XX_CLKPWR_MS_CTRL);
 
--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -262,11 +262,6 @@ static void __init lpc3250_machine_init(
 
 	lpc32xx_serial_init();
 
-	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
-	tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
-		LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN;
-	__raw_writel(tmp, LPC32XX_CLKPWR_MS_CTRL);
-
 	/* Test clock needed for UDA1380 initial init */
 	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,

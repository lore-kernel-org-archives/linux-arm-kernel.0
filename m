From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:10 +0200
Subject: [PATCH v2 20/23] ARM: LPC32xx: Cleanup board init,
 remove duplicate clock init
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-21-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Remove SSP0, CLCD and DMA clocks that are already migrated to
the clock framework.

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/phy3250.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -272,28 +272,11 @@ static void __init lpc3250_machine_init(
 
 	lpc32xx_serial_init();
 
-	/*
-	 * AMBA peripheral clocks need to be enabled prior to AMBA device
-	 * detection or a data fault will occur, so enable the clocks
-	 * here.
-	 */
 	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
 	tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
 		LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN;
 	__raw_writel(tmp, LPC32XX_CLKPWR_MS_CTRL);
 
-	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
-		LPC32XX_CLKPWR_LCDCLK_CTRL);
-
-	tmp = __raw_readl(LPC32XX_CLKPWR_SSP_CLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN),
-		LPC32XX_CLKPWR_SSP_CLK_CTRL);
-
-	tmp = __raw_readl(LPC32XX_CLKPWR_DMA_CLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_DMACLKCTRL_CLK_EN),
-		     LPC32XX_CLKPWR_DMA_CLK_CTRL);
-
 	/* Test clock needed for UDA1380 initial init */
 	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,

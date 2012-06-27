From: stigge@antcom.de (Roland Stigge)
Date: Thu, 28 Jun 2012 00:26:17 +0200
Subject: [PATCH 7/8] ARM: LPC32xx: Remove USB and I2C init from phy3250.c
In-Reply-To: <1340835978-20331-1-git-send-email-stigge@antcom.de>
References: <1340835978-20331-1-git-send-email-stigge@antcom.de>
Message-ID: <1340835978-20331-8-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB and I2C initialization can be removed safely from the board specific
phy3250.c, now that initialization moved to the generalized clock.c.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/phy3250.c |   12 ------------
 1 file changed, 12 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -248,18 +248,6 @@ static void __init lpc3250_machine_init(
 	tmp |= LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT16;
 	__raw_writel(tmp, LPC32XX_CLKPWR_LCDCLK_CTRL);
 
-	/* Set up USB power */
-	tmp = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
-	tmp |= LPC32XX_CLKPWR_USBCTRL_HCLK_EN |
-		LPC32XX_CLKPWR_USBCTRL_USBI2C_EN;
-	__raw_writel(tmp, LPC32XX_CLKPWR_USB_CTRL);
-
-	/* Set up I2C pull levels */
-	tmp = __raw_readl(LPC32XX_CLKPWR_I2C_CLK_CTRL);
-	tmp |= LPC32XX_CLKPWR_I2CCLK_USBI2CHI_DRIVE |
-		LPC32XX_CLKPWR_I2CCLK_I2C2HI_DRIVE;
-	__raw_writel(tmp, LPC32XX_CLKPWR_I2C_CLK_CTRL);
-
 	lpc32xx_serial_init();
 
 	/* Test clock needed for UDA1380 initial init */

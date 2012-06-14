From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:13 +0200
Subject: [PATCH v2 23/23] ARM: LPC32xx: Remove duplicate usb host clock init
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-24-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Remove usb host clock init from phy3250.c. Fix clock.c usb host and also
enable the usb i2c clock as well.

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/clock.c   |    3 ++-
 arch/arm/mach-lpc32xx/phy3250.c |    6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -743,7 +743,8 @@ static struct clk clk_usbd = {
 	.parent		= &clk_usbpll,
 	.enable		= local_onoff_enable,
 	.enable_reg	= LPC32XX_CLKPWR_USB_CTRL,
-	.enable_mask	= LPC32XX_CLKPWR_USBCTRL_HCLK_EN,
+	.enable_mask	= LPC32XX_CLKPWR_USBCTRL_HCLK_EN |
+			  LPC32XX_CLKPWR_USBCTRL_USBI2C_EN,
 	.get_rate	= local_return_parent_rate,
 };
 
--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -248,12 +248,6 @@ static void __init lpc3250_machine_init(
 	tmp |= LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT16;
 	__raw_writel(tmp, LPC32XX_CLKPWR_LCDCLK_CTRL);
 
-	/* Set up USB power */
-	tmp = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
-	tmp |= LPC32XX_CLKPWR_USBCTRL_HCLK_EN |
-		LPC32XX_CLKPWR_USBCTRL_USBI2C_EN;
-	__raw_writel(tmp, LPC32XX_CLKPWR_USB_CTRL);
-
 	/* Set up I2C pull levels */
 	tmp = __raw_readl(LPC32XX_CLKPWR_I2C_CLK_CTRL);
 	tmp |= LPC32XX_CLKPWR_I2CCLK_USBI2CHI_DRIVE |

From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:12 +0200
Subject: [PATCH v2 22/23] ARM: LPC32xx: Move i2s1 dma enabling to clock.c
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-23-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Move i2s1 dma init to be done when it's clock is enabled.

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/clock.c   |    3 ++-
 arch/arm/mach-lpc32xx/phy3250.c |    5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -718,7 +718,8 @@ static struct clk clk_i2s1 = {
 	.parent		= &clk_hclk,
 	.enable		= local_onoff_enable,
 	.enable_reg	= LPC32XX_CLKPWR_I2S_CLK_CTRL,
-	.enable_mask	= LPC32XX_CLKPWR_I2SCTRL_I2SCLK1_EN,
+	.enable_mask	= LPC32XX_CLKPWR_I2SCTRL_I2SCLK1_EN |
+			  LPC32XX_CLKPWR_I2SCTRL_I2S1_USE_DMA,
 	.get_rate	= local_return_parent_rate,
 };
 
--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -260,11 +260,6 @@ static void __init lpc3250_machine_init(
 		LPC32XX_CLKPWR_I2CCLK_I2C2HI_DRIVE;
 	__raw_writel(tmp, LPC32XX_CLKPWR_I2C_CLK_CTRL);
 
-	/* Enable DMA for I2S1 channel */
-	tmp = __raw_readl(LPC32XX_CLKPWR_I2S_CLK_CTRL);
-	tmp = LPC32XX_CLKPWR_I2SCTRL_I2S1_USE_DMA;
-	__raw_writel(tmp, LPC32XX_CLKPWR_I2S_CLK_CTRL);
-
 	lpc32xx_serial_init();
 
 	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);

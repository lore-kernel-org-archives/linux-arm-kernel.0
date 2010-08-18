From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 18 Aug 2010 16:40:58 -0700
Subject: [PATCH 5/6] ARM: LPC32XX: Remove clock enable code for AMBA driver
In-Reply-To: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1282174859-8780-6-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

These clock enables were just for the AMBA driver's peripheral
ID check and are no longer needed with the AMBA bus clock
changes.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/phy3250.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bc9a42d..3ef69cb 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -340,23 +340,6 @@ static void __init phy3250_board_init(void)
 
 	lpc32xx_serial_init();
 
-	/*
-	 * AMBA peripheral clocks need to be enabled prior to AMBA device
-	 * detection or a data fault will occur, so enable the clocks
-	 * here. However, we don't want to enable them if the peripheral
-	 * isn't included in the image
-	 */
-#ifdef CONFIG_FB_ARMCLCD
-	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
-		LPC32XX_CLKPWR_LCDCLK_CTRL);
-#endif
-#ifdef CONFIG_SPI_PL022
-	tmp = __raw_readl(LPC32XX_CLKPWR_SSP_CLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN),
-		LPC32XX_CLKPWR_SSP_CLK_CTRL);
-#endif
-
 	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
-- 
1.7.1.1

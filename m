From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:50:52 +0200
Subject: [PATCH v2 02/23] ARM: LPC32xx: Clock initialization for NAND
 controllers
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock initialization for the MLC NAND controller of the LPC32xx
SoC and adjusts it for the SLC controller.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---

 arch/arm/mach-lpc32xx/clock.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -691,10 +691,21 @@ static struct clk clk_nand = {
 	.parent		= &clk_hclk,
 	.enable		= local_onoff_enable,
 	.enable_reg	= LPC32XX_CLKPWR_NAND_CLK_CTRL,
-	.enable_mask	= LPC32XX_CLKPWR_NANDCLK_SLCCLK_EN,
+	.enable_mask	= LPC32XX_CLKPWR_NANDCLK_SLCCLK_EN |
+			  LPC32XX_CLKPWR_NANDCLK_SEL_SLC,
 	.get_rate	= local_return_parent_rate,
 };
 
+static struct clk clk_nand_mlc = {
+	.parent         = &clk_hclk,
+	.enable         = local_onoff_enable,
+	.enable_reg     = LPC32XX_CLKPWR_NAND_CLK_CTRL,
+	.enable_mask    = LPC32XX_CLKPWR_NANDCLK_MLCCLK_EN |
+			  LPC32XX_CLKPWR_NANDCLK_DMA_INT |
+			  LPC32XX_CLKPWR_NANDCLK_INTSEL_MLC,
+	.get_rate       = local_return_parent_rate,
+};
+
 static struct clk clk_i2s0 = {
 	.parent		= &clk_hclk,
 	.enable		= local_onoff_enable,
@@ -1121,7 +1132,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT("dev:ssp0", NULL, &clk_ssp0),
 	CLKDEV_INIT("dev:ssp1", NULL, &clk_ssp1),
 	CLKDEV_INIT("lpc32xx_keys.0", NULL, &clk_kscan),
-	CLKDEV_INIT("lpc32xx-nand.0", "nand_ck", &clk_nand),
+	CLKDEV_INIT("20020000.flash", NULL, &clk_nand),
+	CLKDEV_INIT("200a8000.flash", NULL, &clk_nand_mlc),
 	CLKDEV_INIT("40048000.adc", NULL, &clk_adc),
 	CLKDEV_INIT(NULL, "i2s0_ck", &clk_i2s0),
 	CLKDEV_INIT(NULL, "i2s1_ck", &clk_i2s1),

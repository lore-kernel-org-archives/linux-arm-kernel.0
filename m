From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:54 +0200 (CEST)
Subject: [PATCH 6/10] LPC32XX: 006-clock.1: Fully enable SSP devices
Message-ID: <mailman.16.1366231434.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cedric Berger <cedric@precidata.com>
---
The current code forget to enable various MUXes on the LPCw32xx silicon when
SSP0 and SSP1 controllers are used, making them unusable.
Enable the MUXes when their clock is enabled.

Index: arch/arm/mach-lpc32xx/clock.c
===================================================================
--- arch/arm/mach-lpc32xx/clock.c	(revision 1725)
+++ arch/arm/mach-lpc32xx/clock.c	(revision 1726)
@@ -568,6 +568,51 @@
 	return 0;
 }
 
+static int ssp_onoff_enable(struct clk *clk, int enable, int pmask, int dmask)
+{
+	u32 pin, pin0, dma, dma0;
+
+	pin = pin0 = __raw_readl(LPC32XX_GPIO_P_MUX_SET);
+	dma = dma0 = __raw_readl(LPC32XX_CLKPWR_SSP_CLK_CTRL);
+	if (enable) {
+		pin |= pmask;
+		dma |= dmask;
+	} else {
+		pin &= ~pmask;
+		dma &= ~dmask;
+	}
+	if (pin != pin0) {
+		pr_debug("LPC32XX_GPIO_P_MUX_SET: %08x => %08x\n", pin0, pin);
+		__raw_writel(pin, LPC32XX_GPIO_P_MUX_SET);
+	}
+	if (dma != dma0) {
+		pr_debug("LPC32XX_CLKPWR_SSP_CLK_CTRL: %08x => %08x\n", dma0,
+		    dma);
+		__raw_writel(dma, LPC32XX_CLKPWR_SSP_CLK_CTRL);
+	}
+	return local_onoff_enable(clk, enable);
+}
+
+static int ssp0_onoff_enable(struct clk *clk, int enable)
+{
+	return ssp_onoff_enable(clk, enable,
+		BIT(9) |				/* select ssp0:MOSI */
+		BIT(10) |				/* select ssp0:MISO */
+		BIT(12),				/* select ssp0:SCK */
+		LPC32XX_CLKPWR_SSPCTRL_DMA_SSP0RX |
+		LPC32XX_CLKPWR_SSPCTRL_DMA_SSP0TX);
+}
+
+static int ssp1_onoff_enable(struct clk *clk, int enable)
+{
+	return ssp_onoff_enable(clk, enable,
+		BIT(5) |				/* select ssp1:MOSI */
+		BIT(6) |				/* select ssp1:MISO */
+		BIT(8),					/* select ssp1:SCK */
+		LPC32XX_CLKPWR_SSPCTRL_DMA_SSP1RX |
+		LPC32XX_CLKPWR_SSPCTRL_DMA_SSP1TX);
+}
+
 /* Peripheral clock sources */
 static struct clk clk_timer0 = {
 	.parent		= &clk_pclk,
@@ -697,7 +742,7 @@
 
 static struct clk clk_ssp0 = {
 	.parent		= &clk_hclk,
-	.enable		= local_onoff_enable,
+	.enable		= ssp0_onoff_enable,
 	.enable_reg	= LPC32XX_CLKPWR_SSP_CLK_CTRL,
 	.enable_mask	= LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN,
 	.get_rate	= local_return_parent_rate,
@@ -705,7 +750,7 @@
 
 static struct clk clk_ssp1 = {
 	.parent		= &clk_hclk,
-	.enable		= local_onoff_enable,
+	.enable		= ssp1_onoff_enable,
 	.enable_reg	= LPC32XX_CLKPWR_SSP_CLK_CTRL,
 	.enable_mask	= LPC32XX_CLKPWR_SSPCTRL_SSPCLK1_EN,
 	.get_rate	= local_return_parent_rate,

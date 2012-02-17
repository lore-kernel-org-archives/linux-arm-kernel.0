From: stigge@antcom.de (Roland Stigge)
Date: Fri, 17 Feb 2012 14:58:14 +0100
Subject: [PATCH v5] ARM: LPC32xx: ADC support for mach-lpc32xx
Message-ID: <1329487094-3486-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the mach specific support for the LPC32XX ADC driver (the
latter being already in staging/iio)

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>

---
 Olof, can you please add this to the updated LPC32xx support? The patch
 applies cleanly to current arm-soc.git/for-next. The actual ADC driver that is
 used here was already accepted to staging/iio by GregKH.

 arch/arm/mach-lpc32xx/clock.c   |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.c  |   22 ++++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h  |    1 +
 arch/arm/mach-lpc32xx/phy3250.c |    1 +
 4 files changed, 60 insertions(+)

--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-arm-soc/arch/arm/mach-lpc32xx/clock.c
@@ -721,6 +721,41 @@ static struct clk clk_tsc = {
 	.get_rate	= local_return_parent_rate,
 };
 
+static int adc_onoff_enable(struct clk *clk, int enable)
+{
+	u32 tmp;
+	u32 divider;
+
+	/* Use PERIPH_CLOCK */
+	tmp = __raw_readl(LPC32XX_CLKPWR_ADC_CLK_CTRL_1);
+	tmp |= LPC32XX_CLKPWR_ADCCTRL1_PCLK_SEL;
+	/*
+	 * Set clock divider so that we have equal to or less than
+	 * 4.5MHz clock at ADC
+	 */
+	divider = clk->get_rate(clk) / 4500000 + 1;
+	tmp |= divider;
+	__raw_writel(tmp, LPC32XX_CLKPWR_ADC_CLK_CTRL_1);
+
+	/* synchronize rate of this clock w/ actual HW setting */
+	clk->rate = clk->get_rate(clk->parent) / divider;
+
+	if (enable == 0)
+		__raw_writel(0, clk->enable_reg);
+	else
+		__raw_writel(clk->enable_mask, clk->enable_reg);
+
+	return 0;
+}
+
+static struct clk clk_adc = {
+	.parent		= &clk_pclk,
+	.enable		= adc_onoff_enable,
+	.enable_reg	= LPC32XX_CLKPWR_ADC_CLK_CTRL,
+	.enable_mask	= LPC32XX_CLKPWR_ADC32CLKCTRL_CLK_EN,
+	.get_rate	= local_return_parent_rate,
+};
+
 static int mmc_onoff_enable(struct clk *clk, int enable)
 {
 	u32 tmp;
@@ -1055,6 +1090,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
 	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
 	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
+	_REGISTER_CLOCK("lpc32xx-adc", NULL, clk_adc)
 	_REGISTER_CLOCK(NULL, "i2s0_ck", clk_i2s0)
 	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
 	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/common.c
+++ linux-arm-soc/arch/arm/mach-lpc32xx/common.c
@@ -138,6 +138,28 @@ struct platform_device lpc32xx_rtc_devic
 };
 
 /*
+ * ADC support
+ */
+static struct resource adc_resources[] = {
+	{
+		.start = LPC32XX_ADC_BASE,
+		.end = LPC32XX_ADC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_LPC32XX_TS_IRQ,
+		.end = IRQ_LPC32XX_TS_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device lpc32xx_adc_device = {
+	.name =  "lpc32xx-adc",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(adc_resources),
+	.resource = adc_resources,
+};
+
+/*
  * Returns the unique ID for the device
  */
 void lpc32xx_get_uid(u32 devid[4])
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/common.h
+++ linux-arm-soc/arch/arm/mach-lpc32xx/common.h
@@ -29,6 +29,7 @@ extern struct platform_device lpc32xx_i2
 extern struct platform_device lpc32xx_i2c1_device;
 extern struct platform_device lpc32xx_i2c2_device;
 extern struct platform_device lpc32xx_tsc_device;
+extern struct platform_device lpc32xx_adc_device;
 extern struct platform_device lpc32xx_rtc_device;
 
 /*
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-arm-soc/arch/arm/mach-lpc32xx/phy3250.c
@@ -254,6 +254,7 @@ static struct platform_device *phy3250_d
 	&lpc32xx_i2c2_device,
 	&lpc32xx_watchdog_device,
 	&lpc32xx_gpio_led_device,
+	&lpc32xx_adc_device,
 };
 
 static struct amba_device *amba_devs[] __initdata = {

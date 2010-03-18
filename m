From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 18 Mar 2010 19:00:02 +0200
Subject: [PATCH v2 3/3] ep93xx: SPI driver platform support code
In-Reply-To: <c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
Message-ID: <7097c785a7482918d74e7a412b97c90ef965da43.1268930557.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds platform side support code for EP93xx SPI driver. This includes
clock, resources and muxing. There is a new function: ep93xx_register_spi() that
can be used by board support code to register new SPI devices for the board.

Patch depends on the previous patch which adds function ep93xx_chip_revision().

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/clock.c                    |   14 +++++++
 arch/arm/mach-ep93xx/core.c                     |   42 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    2 +
 4 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 5f80092..daaa799 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -96,6 +96,10 @@ static struct clk clk_keypad = {
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
+static struct clk clk_spi = {
+	.parent		= &clk_xtali,
+	.rate		= EP93XX_EXT_CLK_RATE / 2,
+};
 static struct clk clk_pwm = {
 	.parent		= &clk_xtali,
 	.rate		= EP93XX_EXT_CLK_RATE,
@@ -186,6 +190,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
+	INIT_CK("ep93xx-spi",		NULL,		&clk_spi),
 	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
 	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
 	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
@@ -473,6 +478,14 @@ static int __init ep93xx_clock_init(void)
 	/* Initialize the pll2 derived clocks */
 	clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
 
+	/*
+	 * EP93xx SSP clock rate was doubled in version E2. For more information
+	 * see:
+	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
+	 */
+	if (ep93xx_chip_revision() >= EP93XX_CHIP_REV_E2)
+		clk_spi.rate *= 2;
+
 	pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
 		clk_pll1.rate / 1000000, clk_pll2.rate / 1000000);
 	pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
@@ -480,6 +493,7 @@ static int __init ep93xx_clock_init(void)
 		clk_p.rate / 1000000);
 
 	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
+
 	return 0;
 }
 arch_initcall(ep93xx_clock_init);
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 07572bb..e25b1bd 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -377,6 +377,48 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 	platform_device_register(&ep93xx_eth_device);
 }
 
+static struct resource ep93xx_spi_resources[] = {
+	{
+		.start	= EP93XX_SPI_PHYS_BASE,
+		.end	= EP93XX_SPI_PHYS_BASE + 0x18 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_EP93XX_SSP,
+		.end	= IRQ_EP93XX_SSP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ep93xx_spi_device = {
+	.name		= "ep93xx-spi",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_spi_resources),
+	.resource	= ep93xx_spi_resources,
+};
+
+/**
+ * ep93xx_register_spi() - registers spi platform device
+ * @info: ep93xx board specific spi info
+ *
+ * This function registers platform device for the EP93xx SPI controller and
+ * also makes sure that SPI pins are muxed so that I2S is not using those
+ * pins. Caller should allocate necessary GPIO lines and register any SPI
+ * devices before calling this (see also spi_register_board_info()).
+ *
+ * Returns %0 in success and negative value in case of failure.
+ */
+int __init ep93xx_register_spi(struct ep93xx_spi_info *info)
+{
+	/*
+	 * When SPI is used, we need to make sure that I2S is muxed off from
+	 * SPI pins.
+	 */
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONSSP);
+
+	ep93xx_spi_device.dev.platform_data = info;
+	return platform_device_register(&ep93xx_spi_device);
+}
 
 /*************************************************************************
  * EP93xx i2c peripheral handling
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 93e2ecc..b1e096f 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -106,6 +106,7 @@
 
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
 
+#define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
 #define EP93XX_SPI_BASE			EP93XX_APB_IOMEM(0x000a0000)
 
 #define EP93XX_IRDA_BASE		EP93XX_APB_IOMEM(0x000b0000)
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index b663390..d3fb715 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -9,6 +9,7 @@ struct i2c_board_info;
 struct platform_device;
 struct ep93xxfb_mach_info;
 struct ep93xx_keypad_platform_data;
+struct ep93xx_spi_info;
 
 struct ep93xx_eth_data
 {
@@ -42,6 +43,7 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 unsigned int ep93xx_chip_revision(void);
 
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
+int ep93xx_register_spi(struct ep93xx_spi_info *info);
 void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 			 struct i2c_board_info *devices, int num);
 void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
-- 
1.5.6.5

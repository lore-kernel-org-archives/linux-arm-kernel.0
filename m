From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu,  6 May 2010 07:47:05 +0300
Subject: [PATCH v7 2/2] ep93xx: SPI driver platform support code
In-Reply-To: <cover.1273120206.git.mika.westerberg@iki.fi>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
Message-ID: <c4be393041bfab8d1c27d43dd5a2526222d1d4ef.1273120206.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds platform side support code for the EP93xx SPI driver. This
includes clock, resources and muxing. There is a new function: ep93xx_register_spi()
which can be used by board support code to register new SPI devices for the
board.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Martin Guy <martinwguy@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c                    |   13 ++++++
 arch/arm/mach-ep93xx/core.c                     |   52 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    4 ++
 4 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 5f80092..e29bdef 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -96,6 +96,10 @@ static struct clk clk_keypad = {
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
+static struct clk clk_spi = {
+	.parent		= &clk_xtali,
+	.rate		= EP93XX_EXT_CLK_RATE,
+};
 static struct clk clk_pwm = {
 	.parent		= &clk_xtali,
 	.rate		= EP93XX_EXT_CLK_RATE,
@@ -186,6 +190,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
+	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
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
+	if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
+		clk_spi.rate /= 2;
+
 	pr_info("PLL1 running at %ld MHz, PLL2@%ld MHz\n",
 		clk_pll1.rate / 1000000, clk_pll2.rate / 1000000);
 	pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..df2f0a1 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -31,10 +31,12 @@
 #include <linux/amba/serial.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
 #include <mach/fb.h>
 #include <mach/ep93xx_keypad.h>
+#include <mach/ep93xx_spi.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -398,6 +400,56 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 	platform_device_register(&ep93xx_i2c_device);
 }
 
+/*************************************************************************
+ * EP93xx SPI peripheral handling
+ *************************************************************************/
+static struct ep93xx_spi_info ep93xx_spi_master_data;
+
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
+	.id		= 0,
+	.dev		= {
+		.platform_data = &ep93xx_spi_master_data,
+	},
+	.num_resources	= ARRAY_SIZE(ep93xx_spi_resources),
+	.resource	= ep93xx_spi_resources,
+};
+
+/**
+ * ep93xx_register_spi() - registers spi platform device
+ * @info: ep93xx board specific spi master info (__initdata)
+ * @devices: SPI devices to register (__initdata)
+ * @num: number of SPI devices to register
+ *
+ * This function registers platform device for the EP93xx SPI controller and
+ * also makes sure that SPI pins are muxed so that I2S is not using those pins.
+ */
+void __init ep93xx_register_spi(struct ep93xx_spi_info *info,
+				struct spi_board_info *devices, int num)
+{
+	/*
+	 * When SPI is used, we need to make sure that I2S is muxed off from
+	 * SPI pins.
+	 */
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONSSP);
+
+	ep93xx_spi_master_data = *info;
+	spi_register_board_info(devices, num);
+	platform_device_register(&ep93xx_spi_device);
+}
 
 /*************************************************************************
  * EP93xx LEDs
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
index c6dc14d..f11f1d7 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -6,9 +6,11 @@
 
 struct i2c_gpio_platform_data;
 struct i2c_board_info;
+struct spi_board_info;
 struct platform_device;
 struct ep93xxfb_mach_info;
 struct ep93xx_keypad_platform_data;
+struct ep93xx_spi_info;
 
 struct ep93xx_eth_data
 {
@@ -36,6 +38,8 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 			 struct i2c_board_info *devices, int num);
+void ep93xx_register_spi(struct ep93xx_spi_info *info,
+			 struct spi_board_info *devices, int num);
 void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
 void ep93xx_register_pwm(int pwm0, int pwm1);
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
-- 
1.5.6.5

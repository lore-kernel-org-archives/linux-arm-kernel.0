From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 21 Mar 2012 11:35:49 -0700
Subject: [PATCH] arm: ep93xx: use DEFINE_RES_* macros
Message-ID: <201203211135.49295.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the DEFINE_RES_* macros to reduce some of the boilerplate code.

Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d25895..a2cb176 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -241,11 +241,7 @@ unsigned int ep93xx_chip_revision(void)
  * EP93xx GPIO
  *************************************************************************/
 static struct resource ep93xx_gpio_resource[] = {
-	{
-		.start		= EP93XX_GPIO_PHYS_BASE,
-		.end		= EP93XX_GPIO_PHYS_BASE + 0xcc - 1,
-		.flags		= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(EP93XX_GPIO_PHYS_BASE, 0xcc),
 };
 
 static struct platform_device ep93xx_gpio_device = {
@@ -288,11 +284,7 @@ static AMBA_APB_DEVICE(uart3, "apb:uart3", 0x00041010, EP93XX_UART3_PHYS_BASE,
 	{ IRQ_EP93XX_UART3 }, &ep93xx_uart_data);
 
 static struct resource ep93xx_rtc_resource[] = {
-	{
-		.start		= EP93XX_RTC_PHYS_BASE,
-		.end		= EP93XX_RTC_PHYS_BASE + 0x10c - 1,
-		.flags		= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(EP93XX_RTC_PHYS_BASE, 0x10c),
 };
 
 static struct platform_device ep93xx_rtc_device = {
@@ -304,16 +296,8 @@ static struct platform_device ep93xx_rtc_device = {
 
 
 static struct resource ep93xx_ohci_resources[] = {
-	[0] = {
-		.start	= EP93XX_USB_PHYS_BASE,
-		.end	= EP93XX_USB_PHYS_BASE + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_EP93XX_USB,
-		.end	= IRQ_EP93XX_USB,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(EP93XX_USB_PHYS_BASE, 0x1000),
+	DEFINE_RES_IRQ(IRQ_EP93XX_USB),
 };
 
 
@@ -372,15 +356,8 @@ void __init ep93xx_register_flash(unsigned int width,
 static struct ep93xx_eth_data ep93xx_eth_data;
 
 static struct resource ep93xx_eth_resource[] = {
-	{
-		.start	= EP93XX_ETHERNET_PHYS_BASE,
-		.end	= EP93XX_ETHERNET_PHYS_BASE + 0xffff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_EP93XX_ETHERNET,
-		.end	= IRQ_EP93XX_ETHERNET,
-		.flags	= IORESOURCE_IRQ,
-	}
+	DEFINE_RES_MEM(EP93XX_ETHERNET_PHYS_BASE, 0x10000),
+	DEFINE_REQ_IRQ(IRQ_EP93XX_ETHERNET),
 };
 
 static u64 ep93xx_eth_dma_mask = DMA_BIT_MASK(32);
@@ -461,16 +438,8 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 static struct ep93xx_spi_info ep93xx_spi_master_data;
 
 static struct resource ep93xx_spi_resources[] = {
-	{
-		.start	= EP93XX_SPI_PHYS_BASE,
-		.end	= EP93XX_SPI_PHYS_BASE + 0x18 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= IRQ_EP93XX_SSP,
-		.end	= IRQ_EP93XX_SSP,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(EP93XX_SPI_PHYS_BASE, 0x18),
+	DEFINE_RES_IRQ(IRQ_EP93XX_SSP),
 };
 
 static u64 ep93xx_spi_dma_mask = DMA_BIT_MASK(32);
@@ -541,11 +510,7 @@ static struct platform_device ep93xx_leds = {
  * EP93xx pwm peripheral handling
  *************************************************************************/
 static struct resource ep93xx_pwm0_resource[] = {
-	{
-		.start	= EP93XX_PWM_PHYS_BASE,
-		.end	= EP93XX_PWM_PHYS_BASE + 0x10 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(EP93XX_PWM_PHYS_BASE, 0x10),
 };
 
 static struct platform_device ep93xx_pwm0_device = {
@@ -556,11 +521,7 @@ static struct platform_device ep93xx_pwm0_device = {
 };
 
 static struct resource ep93xx_pwm1_resource[] = {
-	{
-		.start	= EP93XX_PWM_PHYS_BASE + 0x20,
-		.end	= EP93XX_PWM_PHYS_BASE + 0x30 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(EP93XX_PWM_PHYS_BASE + 0x20, 0x10),
 };
 
 static struct platform_device ep93xx_pwm1_device = {
@@ -628,11 +589,7 @@ EXPORT_SYMBOL(ep93xx_pwm_release_gpio);
 static struct ep93xxfb_mach_info ep93xxfb_data;
 
 static struct resource ep93xx_fb_resource[] = {
-	{
-		.start		= EP93XX_RASTER_PHYS_BASE,
-		.end		= EP93XX_RASTER_PHYS_BASE + 0x800 - 1,
-		.flags		= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(EP93XX_RASTER_PHYS_BASE, 0x800),
 };
 
 static struct platform_device ep93xx_fb_device = {
@@ -680,15 +637,8 @@ void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 static struct ep93xx_keypad_platform_data ep93xx_keypad_data;
 
 static struct resource ep93xx_keypad_resource[] = {
-	{
-		.start	= EP93XX_KEY_MATRIX_PHYS_BASE,
-		.end	= EP93XX_KEY_MATRIX_PHYS_BASE + 0x0c - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_EP93XX_KEY,
-		.end	= IRQ_EP93XX_KEY,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(EP93XX_KEY_MATRIX_PHYS_BASE, 0x0c),
+	DEFINE_RES_IRQ(IRQ_EP93XX_KEY),
 };
 
 static struct platform_device ep93xx_keypad_device = {
@@ -761,11 +711,7 @@ EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
  * EP93xx I2S audio peripheral handling
  *************************************************************************/
 static struct resource ep93xx_i2s_resource[] = {
-	{
-		.start	= EP93XX_I2S_PHYS_BASE,
-		.end	= EP93XX_I2S_PHYS_BASE + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(EP93XX_I2S_PHYS_BASE, 0x100),
 };
 
 static struct platform_device ep93xx_i2s_device = {
@@ -824,16 +770,8 @@ EXPORT_SYMBOL(ep93xx_i2s_release);
  * EP93xx AC97 audio peripheral handling
  *************************************************************************/
 static struct resource ep93xx_ac97_resources[] = {
-	{
-		.start	= EP93XX_AAC_PHYS_BASE,
-		.end	= EP93XX_AAC_PHYS_BASE + 0xac - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= IRQ_EP93XX_AACINTR,
-		.end	= IRQ_EP93XX_AACINTR,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(EP93XX_AAC_PHYS_BASE, 0xac),
+	DEFINE_RES_IRQ(IRQ_EP93XX_AACINTR),
 };
 
 static struct platform_device ep93xx_ac97_device = {

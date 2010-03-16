From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 16 Mar 2010 12:54:37 -0500
Subject: [PATCH] ep93xx/core.c: remove redundant static variable
In-Reply-To: <0D753D10438DA54287A00B02708426976368534061@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B02708426976368534061@AUSP01VMBX24.collaborationhost.net>
Message-ID: <0D753D10438DA54287A00B0270842697636858C6FE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the pointer to the passed board support data directly instead of 
copying it to local static variables.

This updates the ethernet, i2c, and framebuffer devices.

While here, also document the functions used to register the devices.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

V2: spotted a couple others in addition to the ethernet device.

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..5f5bc6d 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -330,8 +330,10 @@ static struct platform_device ep93xx_ohci_device = {
 	.resource	= ep93xx_ohci_resources,
 };
 
-static struct ep93xx_eth_data ep93xx_eth_data;
 
+/*************************************************************************
+ * EP93xx ethernet peripheral handling
+ *************************************************************************/
 static struct resource ep93xx_eth_resource[] = {
 	{
 		.start	= EP93XX_ETHERNET_PHYS_BASE,
@@ -347,19 +349,22 @@ static struct resource ep93xx_eth_resource[] = {
 static struct platform_device ep93xx_eth_device = {
 	.name		= "ep93xx-eth",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &ep93xx_eth_data,
-	},
 	.num_resources	= ARRAY_SIZE(ep93xx_eth_resource),
 	.resource	= ep93xx_eth_resource,
 };
 
+/**
+ * ep93xx_register_eth - Register the built-in ethernet platform device.
+ * @data:	platform specific ethernet configuration
+ * @copy_addr:	flag indicating that the MAC address should be copied
+ *		from the IndAd registers (as programmed by the bootloader)
+ */
 void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 {
 	if (copy_addr)
 		memcpy_fromio(data->dev_addr, EP93XX_ETHERNET_BASE + 0x50, 6);
 
-	ep93xx_eth_data = *data;
+	ep93xx_eth_device.dev.platform_data = data;
 	platform_device_register(&ep93xx_eth_device);
 }
 
@@ -367,14 +372,17 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 /*************************************************************************
  * EP93xx i2c peripheral handling
  *************************************************************************/
-static struct i2c_gpio_platform_data ep93xx_i2c_data;
-
 static struct platform_device ep93xx_i2c_device = {
 	.name			= "i2c-gpio",
 	.id			= 0,
-	.dev.platform_data	= &ep93xx_i2c_data,
 };
 
+/**
+ * ep93xx_register_i2c - Register the i2c platform device.
+ * @data:	platform specific i2c-gpio configurtion
+ * @devices:	platform specific i2c bus device information
+ * @num:	the number of devices on the i2c bus
+ */
 void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 				struct i2c_board_info *devices, int num)
 {
@@ -393,7 +401,7 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 		     (data->scl_is_open_drain << 0),
 		     EP93XX_GPIO_EEDRIVE);
 
-	ep93xx_i2c_data = *data;
+	ep93xx_i2c_device.dev.platform_data = data;
 	i2c_register_board_info(0, devices, num);
 	platform_device_register(&ep93xx_i2c_device);
 }
@@ -514,8 +522,6 @@ EXPORT_SYMBOL(ep93xx_pwm_release_gpio);
 /*************************************************************************
  * EP93xx video peripheral handling
  *************************************************************************/
-static struct ep93xxfb_mach_info ep93xxfb_data;
-
 static struct resource ep93xx_fb_resource[] = {
 	{
 		.start		= EP93XX_RASTER_PHYS_BASE,
@@ -528,7 +534,6 @@ static struct platform_device ep93xx_fb_device = {
 	.name			= "ep93xx-fb",
 	.id			= -1,
 	.dev			= {
-		.platform_data	= &ep93xxfb_data,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.dma_mask		= &ep93xx_fb_device.dev.coherent_dma_mask,
 	},
@@ -536,9 +541,13 @@ static struct platform_device ep93xx_fb_device = {
 	.resource		= ep93xx_fb_resource,
 };
 
+/**
+ * ep93xx_register_fb - Register the framebuffer platform device.
+ * @data:	platform specific framebuffer configuration
+ */
 void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 {
-	ep93xxfb_data = *data;
+	ep93xx_fb_device.dev.platform_data = data;
 	platform_device_register(&ep93xx_fb_device);
 }
 

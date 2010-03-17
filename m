From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 17 Mar 2010 13:43:09 -0500
Subject: [PATCH] ep93xx: pass platform startup data as __initdata
Message-ID: <0D753D10438DA54287A00B0270842697636858D5BC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of the peripherals for the ep93xx are registered at
startup using platform_data that is passed from the board init
code to the core code.  This data is then copied to a local
static variable in the core code.  Since the data is copied,
the original data can be marked as __initdata and discarded
after startup is complete.

This adds the __initdata tag to all the appropriate data in
the various ep93xx board init's.  Specifically, all the
struct ep93xx_eth_data, struct ep93xxfb_mach_info, and
struct i2c_gpio_platform_data.

Also, document the various registration functions and note
what data should be marked as __initdata.

While here, also cleanup a couple over zealous whitespace tabs.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index caf6d51..3a1a855 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -41,7 +41,7 @@ static struct platform_device adssphere_flash = {
 	.resource	= &adssphere_flash_resource,
 };
 
-static struct ep93xx_eth_data adssphere_eth_data = {
+static struct ep93xx_eth_data __initdata adssphere_eth_data = {
 	.phy_id		= 1,
 };
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..5b1d836 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -330,6 +330,10 @@ static struct platform_device ep93xx_ohci_device = {
 	.resource	= ep93xx_ohci_resources,
 };
 
+
+/*************************************************************************
+ * EP93xx ethernet peripheral handling
+ *************************************************************************/
 static struct ep93xx_eth_data ep93xx_eth_data;
 
 static struct resource ep93xx_eth_resource[] = {
@@ -354,6 +358,12 @@ static struct platform_device ep93xx_eth_device = {
 	.resource	= ep93xx_eth_resource,
 };
 
+/**
+ * ep93xx_register_eth - Register the built-in ethernet platform device.
+ * @data:	platform specific ethernet configuration (__initdata)
+ * @copy_addr:	flag indicating that the MAC address should be copied
+ *		from the IndAd registers (as programmed by the bootloader)
+ */
 void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 {
 	if (copy_addr)
@@ -370,11 +380,19 @@ void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 static struct i2c_gpio_platform_data ep93xx_i2c_data;
 
 static struct platform_device ep93xx_i2c_device = {
-	.name			= "i2c-gpio",
-	.id			= 0,
-	.dev.platform_data	= &ep93xx_i2c_data,
+	.name		= "i2c-gpio",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &ep93xx_i2c_data,
+	},
 };
 
+/**
+ * ep93xx_register_i2c - Register the i2c platform device.
+ * @data:	platform specific i2c-gpio configuration (__initdata)
+ * @devices:	platform specific i2c bus device information (__initdata)
+ * @num:	the number of devices on the i2c bus
+ */
 void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 				struct i2c_board_info *devices, int num)
 {
@@ -404,11 +422,11 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
  *************************************************************************/
 static struct gpio_led ep93xx_led_pins[] = {
 	{
-		.name			= "platform:grled",
-		.gpio			= EP93XX_GPIO_LINE_GRLED,
+		.name	= "platform:grled",
+		.gpio	= EP93XX_GPIO_LINE_GRLED,
 	}, {
-		.name			= "platform:rdled",
-		.gpio			= EP93XX_GPIO_LINE_RDLED,
+		.name	= "platform:rdled",
+		.gpio	= EP93XX_GPIO_LINE_RDLED,
 	},
 };
 
@@ -528,7 +546,7 @@ static struct platform_device ep93xx_fb_device = {
 	.name			= "ep93xx-fb",
 	.id			= -1,
 	.dev			= {
-		.platform_data	= &ep93xxfb_data,
+		.platform_data		= &ep93xxfb_data,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.dma_mask		= &ep93xx_fb_device.dev.coherent_dma_mask,
 	},
@@ -536,6 +554,10 @@ static struct platform_device ep93xx_fb_device = {
 	.resource		= ep93xx_fb_resource,
 };
 
+/**
+ * ep93xx_register_fb - Register the framebuffer platform device.
+ * @data:	platform specific framebuffer configuration (__initdata)
+ */
 void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 {
 	ep93xxfb_data = *data;
@@ -546,6 +568,8 @@ void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 /*************************************************************************
  * EP93xx matrix keypad peripheral handling
  *************************************************************************/
+static struct ep93xx_keypad_platform_data ep93xx_keypad_data;
+
 static struct resource ep93xx_keypad_resource[] = {
 	{
 		.start	= EP93XX_KEY_MATRIX_PHYS_BASE,
@@ -559,15 +583,22 @@ static struct resource ep93xx_keypad_resource[] = {
 };
 
 static struct platform_device ep93xx_keypad_device = {
-	.name			= "ep93xx-keypad",
-	.id			= -1,
-	.num_resources		= ARRAY_SIZE(ep93xx_keypad_resource),
-	.resource		= ep93xx_keypad_resource,
+	.name		= "ep93xx-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &ep93xx_keypad_data,
+	},
+	.num_resources	= ARRAY_SIZE(ep93xx_keypad_resource),
+	.resource	= ep93xx_keypad_resource,
 };
 
+/**
+ * ep93xx_register_keypad - Register the keypad platform device.
+ * @data:	platform specific keypad configuration (__initdata)
+ */
 void __init ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data)
 {
-	ep93xx_keypad_device.dev.platform_data = data;
+	ep93xx_keypad_data = *data;
 	platform_device_register(&ep93xx_keypad_device);
 }
 
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index d22d67a..3884182 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -74,7 +74,7 @@ static void __init edb93xx_register_flash(void)
 	}
 }
 
-static struct ep93xx_eth_data edb93xx_eth_data = {
+static struct ep93xx_eth_data __initdata edb93xx_eth_data = {
 	.phy_id		= 1,
 };
 
@@ -82,7 +82,7 @@ static struct ep93xx_eth_data edb93xx_eth_data = {
 /*************************************************************************
  * EDB93xx i2c peripheral handling
  *************************************************************************/
-static struct i2c_gpio_platform_data edb93xx_i2c_gpio_data = {
+static struct i2c_gpio_platform_data __initdata edb93xx_i2c_gpio_data = {
 	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
 	.sda_is_open_drain	= 0,
 	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 3da7ca8..a809618 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -41,7 +41,7 @@ static struct platform_device gesbc9312_flash = {
 	.resource	= &gesbc9312_flash_resource,
 };
 
-static struct ep93xx_eth_data gesbc9312_eth_data = {
+static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
 	.phy_id		= 1,
 };
 
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index c33360e..1cc911b 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -80,7 +80,7 @@ static void __init micro9_register_flash(void)
 /*************************************************************************
  * Micro9 Ethernet
  *************************************************************************/
-static struct ep93xx_eth_data micro9_eth_data = {
+static struct ep93xx_eth_data __initdata micro9_eth_data = {
 	.phy_id		= 0x1f,
 };
 
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index cd93990..388aec9 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -49,17 +49,17 @@ static struct platform_device simone_flash = {
 	},
 };
 
-static struct ep93xx_eth_data simone_eth_data = {
+static struct ep93xx_eth_data __initdata simone_eth_data = {
 	.phy_id		= 1,
 };
 
-static struct ep93xxfb_mach_info simone_fb_info = {
+static struct ep93xxfb_mach_info __initdata simone_fb_info = {
 	.num_modes	= EP93XXFB_USE_MODEDB,
 	.bpp		= 16,
 	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
 };
 
-static struct i2c_gpio_platform_data simone_i2c_gpio_data = {
+static struct i2c_gpio_platform_data __initdata simone_i2c_gpio_data = {
 	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
 	.sda_is_open_drain	= 0,
 	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 51134b0..38deaee 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -125,11 +125,11 @@ static struct platform_device snappercl15_nand_device = {
 	.num_resources		= ARRAY_SIZE(snappercl15_nand_resource),
 };
 
-static struct ep93xx_eth_data snappercl15_eth_data = {
+static struct ep93xx_eth_data __initdata snappercl15_eth_data = {
 	.phy_id			= 1,
 };
 
-static struct i2c_gpio_platform_data snappercl15_i2c_gpio_data = {
+static struct i2c_gpio_platform_data __initdata snappercl15_i2c_gpio_data = {
 	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
 	.sda_is_open_drain	= 0,
 	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
@@ -145,7 +145,7 @@ static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
 	},
 };
 
-static struct ep93xxfb_mach_info snappercl15_fb_info = {
+static struct ep93xxfb_mach_info __initdata snappercl15_fb_info = {
 	.num_modes		= EP93XXFB_USE_MODEDB,
 	.bpp			= 16,
 };
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index fac1ec7..9553031 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -186,7 +186,7 @@ static struct platform_device ts72xx_wdt_device = {
 	.resource	= ts72xx_wdt_resources,
 };
 
-static struct ep93xx_eth_data ts72xx_eth_data = {
+static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
 	.phy_id		= 1,
 };
 

From: shinel@foxmail.com (Shine Liu)
Date: Wed, 21 Oct 2009 22:13:59 +0800
Subject: [PATCH v2] ARM:S3C2440: MINI2440 Remove some improper __initdata
	qualifiers
In-Reply-To: <200910211129.26044.jbe@pengutronix.de>
References: <1256095984.1600.109.camel@shinel>
	<200910211129.26044.jbe@pengutronix.de>
Message-ID: <1256134439.1940.23.camel@shinel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-10-21 at 11:29 +0200, Juergen Beisert wrote:

> >
> > -struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
> > +struct s3c2410fb_mach_info mini2440_fb_info = {
> >  	.displays	 = &mini2440_lcd_cfg[0], /* not constant! see init */
> >  	.num_displays	 = 1,
> >  	.default_display = 0,
> 
> But the other implementations in this directory are also using __initdata for 
> these structures. Do they also need to remove the __initdata?


> >
> > -static struct platform_device *mini2440_devices[] __initdata = {
> > +static struct platform_device *mini2440_devices[] = {
> 
> You can keep this __initdata. mini2440_devices[] its used only once from a 
> __init marked function.
> 


Updated the patch. Besides above two, the __initdata qualifiers for
mini2440_uartcfgs, mini2440_udc_cfg and mini2440_lcd_cfg are also kept
for these data are used only in the init phase or the drivers make a
local copy of them.



Signed-off-by: Michel Pollet <buserror@gmail.com>
Signed-off-by: Shine Liu <liuxian@redflag-linux.com>
------------------------------------------------------


--- a/arch/arm/mach-s3c2440/mach-mini2440.c	2009-10-21 10:18:52.000000000 +0800
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c	2009-10-21 21:29:44.000000000 +0800
@@ -61,7 +61,7 @@
 
 #define MACH_MINI2440_DM9K_BASE (S3C2410_CS4 + 0x300)
 
-static struct map_desc mini2440_iodesc[] __initdata = {
+static struct map_desc mini2440_iodesc[] = {
 	/* nothing to declare, move along */
 };
 
@@ -233,7 +233,7 @@
 
 /* MMC/SD  */
 
-static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
+static struct s3c24xx_mci_pdata mini2440_mmc_cfg = {
    .gpio_detect   = S3C2410_GPG(8),
    .gpio_wprotect = S3C2410_GPH(8),
    .set_power     = NULL,
@@ -242,7 +242,7 @@
 
 /* NAND Flash on MINI2440 board */
 
-static struct mtd_partition mini2440_default_nand_part[] __initdata = {
+static struct mtd_partition mini2440_default_nand_part[] = {
 	[0] = {
 		.name	= "u-boot",
 		.size	= SZ_256K,
@@ -267,7 +267,7 @@
 	},
 };
 
-static struct s3c2410_nand_set mini2440_nand_sets[] __initdata = {
+static struct s3c2410_nand_set mini2440_nand_sets[] = {
 	[0] = {
 		.name		= "nand",
 		.nr_chips	= 1,
@@ -277,7 +277,7 @@
 	},
 };
 
-static struct s3c2410_platform_nand mini2440_nand_info __initdata = {
+static struct s3c2410_platform_nand mini2440_nand_info = {
 	.tacls		= 0,
 	.twrph0		= 25,
 	.twrph1		= 15,
@@ -288,7 +288,7 @@
 
 /* DM9000AEP 10/100 ethernet controller */
 
-static struct resource mini2440_dm9k_resource[] __initdata = {
+static struct resource mini2440_dm9k_resource[] = {
 	[0] = {
 		.start = MACH_MINI2440_DM9K_BASE,
 		.end   = MACH_MINI2440_DM9K_BASE + 3,
@@ -310,11 +310,11 @@
  * The DM9000 has no eeprom, and it's MAC address is set by
  * the bootloader before starting the kernel.
  */
-static struct dm9000_plat_data mini2440_dm9k_pdata __initdata = {
+static struct dm9000_plat_data mini2440_dm9k_pdata = {
 	.flags		= (DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM),
 };
 
-static struct platform_device mini2440_device_eth __initdata = {
+static struct platform_device mini2440_device_eth = {
 	.name		= "dm9000",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mini2440_dm9k_resource),
@@ -341,7 +341,7 @@
  *	|  |  +----+  +----+
  *	  .....
  */
-static struct gpio_keys_button mini2440_buttons[] __initdata = {
+static struct gpio_keys_button mini2440_buttons[] = {
 	{
 		.gpio		= S3C2410_GPG(0),		/* K1 */
 		.code		= KEY_F1,
@@ -384,12 +384,12 @@
 #endif
 };
 
-static struct gpio_keys_platform_data mini2440_button_data __initdata = {
+static struct gpio_keys_platform_data mini2440_button_data = {
 	.buttons	= mini2440_buttons,
 	.nbuttons	= ARRAY_SIZE(mini2440_buttons),
 };
 
-static struct platform_device mini2440_button_device __initdata = {
+static struct platform_device mini2440_button_device = {
 	.name		= "gpio-keys",
 	.id		= -1,
 	.dev		= {
@@ -399,41 +399,41 @@
 
 /* LEDS */
 
-static struct s3c24xx_led_platdata mini2440_led1_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led1_pdata = {
 	.name		= "led1",
 	.gpio		= S3C2410_GPB(5),
 	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
 	.def_trigger	= "heartbeat",
 };
 
-static struct s3c24xx_led_platdata mini2440_led2_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led2_pdata = {
 	.name		= "led2",
 	.gpio		= S3C2410_GPB(6),
 	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
 	.def_trigger	= "nand-disk",
 };
 
-static struct s3c24xx_led_platdata mini2440_led3_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led3_pdata = {
 	.name		= "led3",
 	.gpio		= S3C2410_GPB(7),
 	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
 	.def_trigger	= "mmc0",
 };
 
-static struct s3c24xx_led_platdata mini2440_led4_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led4_pdata = {
 	.name		= "led4",
 	.gpio		= S3C2410_GPB(8),
 	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
 	.def_trigger	= "",
 };
 
-static struct s3c24xx_led_platdata mini2440_led_backlight_pdata __initdata = {
+static struct s3c24xx_led_platdata mini2440_led_backlight_pdata = {
 	.name		= "backlight",
 	.gpio		= S3C2410_GPG(4),
 	.def_trigger	= "backlight",
 };
 
-static struct platform_device mini2440_led1 __initdata = {
+static struct platform_device mini2440_led1 = {
 	.name		= "s3c24xx_led",
 	.id		= 1,
 	.dev		= {
@@ -441,7 +441,7 @@
 	},
 };
 
-static struct platform_device mini2440_led2 __initdata = {
+static struct platform_device mini2440_led2 = {
 	.name		= "s3c24xx_led",
 	.id		= 2,
 	.dev		= {
@@ -449,7 +449,7 @@
 	},
 };
 
-static struct platform_device mini2440_led3 __initdata = {
+static struct platform_device mini2440_led3 = {
 	.name		= "s3c24xx_led",
 	.id		= 3,
 	.dev		= {
@@ -457,7 +457,7 @@
 	},
 };
 
-static struct platform_device mini2440_led4 __initdata = {
+static struct platform_device mini2440_led4 = {
 	.name		= "s3c24xx_led",
 	.id		= 4,
 	.dev		= {
@@ -465,7 +465,7 @@
 	},
 };
 
-static struct platform_device mini2440_led_backlight __initdata = {
+static struct platform_device mini2440_led_backlight = {
 	.name		= "s3c24xx_led",
 	.id		= 5,
 	.dev		= {
@@ -475,14 +475,14 @@
 
 /* AUDIO */
 
-static struct s3c24xx_uda134x_platform_data mini2440_audio_pins __initdata = {
+static struct s3c24xx_uda134x_platform_data mini2440_audio_pins = {
 	.l3_clk = S3C2410_GPB(4),
 	.l3_mode = S3C2410_GPB(2),
 	.l3_data = S3C2410_GPB(3),
 	.model = UDA134X_UDA1341
 };
 
-static struct platform_device mini2440_audio __initdata = {
+static struct platform_device mini2440_audio = {
 	.name		= "s3c24xx_uda134x",
 	.id		= 0,
 	.dev		= {
@@ -498,7 +498,7 @@
 	.page_size	= 16,
 };
 
-static struct i2c_board_info mini2440_i2c_devs[] __initdata = {
+static struct i2c_board_info mini2440_i2c_devs[] = {
 	{
 		I2C_BOARD_INFO("24c08", 0x50),
 		.platform_data = &at24c08,

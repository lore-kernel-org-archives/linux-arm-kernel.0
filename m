From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:35:30 +0900
Subject: [PATCH 5/7] sh: ecovec24: Use gpio-backlight
In-Reply-To: <cover.1374207161.git.horms+renesas@verge.net.au>
References: <cover.1374207161.git.horms+renesas@verge.net.au>
Message-ID: <fe79f919f47eabf6eae08414dcc078b0d89dfd8e.1374207161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the backlight callback with a gpio-backlight platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/boards/mach-ecovec24/setup.c |   37 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 61fade0..bcbb86b 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -30,6 +30,7 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/platform_data/gpio_backlight.h>
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/videodev2.h>
@@ -303,7 +304,7 @@ static struct platform_device usbhs_device = {
 	.resource	= usbhs_resources,
 };
 
-/* LCDC */
+/* LCDC and backlight */
 static const struct fb_videomode ecovec_lcd_modes[] = {
 	{
 		.name		= "Panel",
@@ -334,13 +335,6 @@ static const struct fb_videomode ecovec_dvi_modes[] = {
 	},
 };
 
-static int ecovec24_set_brightness(int brightness)
-{
-	gpio_set_value(GPIO_PTR1, brightness);
-
-	return 0;
-}
-
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.interface_type = RGB18,
@@ -350,11 +344,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.width = 152,
 			.height = 91,
 		},
-		.bl_info = {
-			.name = "sh_mobile_lcdc_bl",
-			.max_brightness = 1,
-			.set_brightness = ecovec24_set_brightness,
-		},
 	}
 };
 
@@ -380,6 +369,20 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+	.fbdev = &lcdc_device.dev,
+	.gpio = GPIO_PTR1,
+	.def_value = 1,
+	.name = "backlight",
+};
+
+static struct platform_device gpio_backlight_device = {
+	.name = "gpio-backlight",
+	.dev = {
+		.platform_data = &gpio_backlight_data,
+	},
+};
+
 /* CEU0 */
 static struct sh_mobile_ceu_info sh_mobile_ceu0_info = {
 	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
@@ -1049,6 +1052,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&usb1_common_device,
 	&usbhs_device,
 	&lcdc_device,
+	&gpio_backlight_device,
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
@@ -1239,11 +1243,9 @@ static int __init arch_setup(void)
 
 	gpio_request(GPIO_PTE6, NULL);
 	gpio_request(GPIO_PTU1, NULL);
-	gpio_request(GPIO_PTR1, NULL);
 	gpio_request(GPIO_PTA2, NULL);
 	gpio_direction_input(GPIO_PTE6);
 	gpio_direction_output(GPIO_PTU1, 0);
-	gpio_direction_output(GPIO_PTR1, 0);
 	gpio_direction_output(GPIO_PTA2, 0);
 
 	/* I/O buffer drive ability is high */
@@ -1256,6 +1258,9 @@ static int __init arch_setup(void)
 		lcdc_info.ch[0].lcd_modes		= ecovec_dvi_modes;
 		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_dvi_modes);
 
+		/* No backlight */
+		gpio_backlight_data.fbdev = NULL;
+
 		gpio_set_value(GPIO_PTA2, 1);
 		gpio_set_value(GPIO_PTU1, 1);
 	} else {
@@ -1265,8 +1270,6 @@ static int __init arch_setup(void)
 		lcdc_info.ch[0].lcd_modes		= ecovec_lcd_modes;
 		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_lcd_modes);
 
-		gpio_set_value(GPIO_PTR1, 1);
-
 		/* FIXME
 		 *
 		 * LCDDON control is needed for Panel,
-- 
1.7.10.4

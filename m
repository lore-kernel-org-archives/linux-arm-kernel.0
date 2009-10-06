From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Oct 2009 09:46:36 +0200
Subject: spitz: add gpio button support
Message-ID: <20091006074635.GA2775@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is call for testing/comments. It adds support for power button,
SWA and SWB.. I'm not sure what AK_INT is, nor what event it should
generate. Unfortunately, this does _not_ fix suspend/resume, and
neither does switch back to old spitz-keyboard help.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
								Pavel

--- linux-rc/arch/arm.ofic/mach-pxa/spitz.c	2009-09-28 12:09:26.000000000 +0200
+++ linux-rc/arch/arm/mach-pxa/spitz.c	2009-10-04 20:58:32.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
@@ -367,7 +368,8 @@
 };
 
 static struct platform_device spitzkbd_device = {
-	.name		= "matrix-keypad",
+  	.name		= "matrix-keypad",
+	//	.name		= "spitz-keyboard",
 	.id		= -1,
 	.dev		= {
 		.platform_data = &spitzkbd_pdata,
@@ -375,6 +377,48 @@
 };
 
 
+static struct gpio_keys_button spitz_gpio_keys[] = {
+	{
+		.type	= EV_KEY,
+		.code	= KEY_SUSPEND,
+		.gpio	= SPITZ_GPIO_ON_KEY,
+		.desc	= "Poweron",
+		.wakeup	= 1,
+	},
+	{
+		.type	= EV_SW,
+		.code	= 0,
+		.gpio	= SPITZ_GPIO_SWA,
+		.desc	= "SWA",
+	},
+	{
+		.type	= EV_SW,
+		.code	= 1,
+		.gpio	= SPITZ_GPIO_SWB,
+		.desc	= "SWB",
+	},
+	{
+		.type	= EV_KEY,
+		.code	= KEY_F13,
+		.gpio	= SPITZ_GPIO_AK_INT,
+		.desc	= "HP",
+	},
+};
+
+static struct gpio_keys_platform_data spitz_gpio_keys_platform_data = {
+	.buttons	= spitz_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(spitz_gpio_keys),
+};
+
+static struct platform_device spitz_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &spitz_gpio_keys_platform_data,
+	},
+};
+
+
 /*
  * Spitz LEDs
  */
@@ -689,6 +733,7 @@
 static struct platform_device *devices[] __initdata = {
 	&spitzscoop_device,
 	&spitzkbd_device,
+	&spitz_gpio_keys_device,
 	&spitzled_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

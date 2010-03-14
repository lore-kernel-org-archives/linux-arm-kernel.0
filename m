From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 14 Mar 2010 21:16:10 +0100
Subject: HTC Dream: Hook up LEDs
Message-ID: <20100314201610.GF22059@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up LEDS on HTC Dream. 

(#ifdef CONFIG_LEDS_GPIO_PLATFORM is actually neccessary, otherwise it
breaks boot if CONFIG_LEDS_GPIO_PLATFORM is not set).

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-msm/board-dream.c b/arch/arm/mach-msm/board-dream.c
index f48c797..9ef7cc8 100644
--- a/arch/arm/mach-msm/board-dream.c
+++ b/arch/arm/mach-msm/board-dream.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/leds.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -153,6 +154,31 @@ static struct platform_device trout_nav_device = {
 };
 #endif
 
+
+static struct gpio_led android_led_list[] = {
+	{
+		.name = "keyboard-backlight",
+		.gpio = TROUT_GPIO_QTKEY_LED_EN,
+	},
+	{
+		.name = "button-backlight",
+		.gpio = TROUT_GPIO_UI_LED_EN,
+	},
+};
+
+static struct gpio_led_platform_data android_leds_data = {
+	.num_leds	= ARRAY_SIZE(android_led_list),
+	.leds		= android_led_list,
+};
+
+static struct platform_device android_leds = {
+	.name		= "leds-gpio",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &android_leds_data,
+	},
+};
+
 /*
  * Core stuff
  */
@@ -168,6 +194,9 @@ static struct platform_device *devices[] __initdata = {
 #ifdef CONFIG_INPUT_GPIO
 	&trout_nav_device,
 #endif
+#ifdef CONFIG_LEDS_GPIO_PLATFORM
+	&android_leds,
+#endif
 };
 
 extern struct sys_timer msm_timer;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

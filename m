From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 29 Mar 2016 17:35:49 -0300
Subject: [PATCH 3/3] ARM: s3c24xx: Use the panic LED trigger for GTA02
In-Reply-To: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1459283749-22451-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1459283749-22451-4-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's take advantage of the recently introduced panic LED trigger,
and get rid of the open-coded panic_blink usage.

Built tested only.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/arm/mach-s3c24xx/mach-gta02.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 27ae6877550f..e794d55abc9e 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -71,6 +71,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
+#include <linux/platform_data/leds-s3c24xx.h>
 
 #include <mach/fb.h>
 #include <mach/hardware.h>
@@ -89,22 +90,6 @@
 
 static struct pcf50633 *gta02_pcf;
 
-/*
- * This gets called frequently when we paniced.
- */
-
-static long gta02_panic_blink(int state)
-{
-	long delay = 0;
-	char led;
-
-	led = (state) ? 1 : 0;
-	gpio_direction_output(GTA02_GPIO_AUX_LED, led);
-
-	return delay;
-}
-
-
 static struct map_desc gta02_iodesc[] __initdata = {
 	{
 		.virtual	= 0xe0000000,
@@ -500,6 +485,20 @@ static struct platform_device gta02_buttons_device = {
 	},
 };
 
+static struct s3c24xx_led_platdata gta02_panic_led_pdata = {
+	.name = "panic",
+	.gpio = GTA02_GPIO_AUX_LED,
+	.def_trigger = "panic",
+};
+
+static struct platform_device gta02_panic_led_device = {
+	.name = "s3c24xx_led",
+	.id = -1,
+	.dev = {
+		.platform_data = &gta02_panic_led_pdata,
+	},
+};
+
 static void __init gta02_map_io(void)
 {
 	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
@@ -563,9 +562,7 @@ static void gta02_poweroff(void)
 
 static void __init gta02_machine_init(void)
 {
-	/* Set the panic callback to turn AUX LED on or off. */
-	panic_blink = gta02_panic_blink;
-
+	platform_device_register(&gta02_panic_led_device);
 	s3c_pm_init();
 
 #ifdef CONFIG_CHARGER_PCF50633
-- 
2.7.0

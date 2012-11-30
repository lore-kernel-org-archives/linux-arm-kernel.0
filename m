From: dromede@gmail.com (dromede at gmail.com)
Date: Fri, 30 Nov 2012 02:06:17 +0100
Subject: [PATCH] backlight: corgi_lcd: Use gpio_set_value_cansleep() for akita
 machines to avoid WARN_ON trigger
Message-ID: <1354237577-4653-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>

Changing backlight intensity on an Akita (Sharp Zaurus C-1000)
will always trigger a WARN_ON:

WARNING: at drivers/gpio/gpiolib.c:1672 __gpio_set_value+0x38/0xa4()
Modules linked in:
Backtrace:
[<c000c0ac>] (dump_backtrace+0x0/0x110) from [<c02c8278>] (dump_stack+0x18/0x1c)
 r6:c0158fc8 r5:00000009 r4:00000000 r3:c03d4f70
[<c02c8260>] (dump_stack+0x0/0x1c) from [<c0019194>] (warn_slowpath_common+0x54/0x6c)
[<c0019140>] (warn_slowpath_common+0x0/0x6c) from [<c00191d0>] (warn_slowpath_null+0x24/0x2c)
 r8:c38d5c00 r7:c03f82c0 r6:00000000 r5:000000d0 r4:c384e4fc
r3:00000009
[<c00191ac>] (warn_slowpath_null+0x0/0x2c) from [<c0158fc8>] (__gpio_set_value+0x38/0xa4)
[<c0158f90>] (__gpio_set_value+0x0/0xa4) from [<c0169b4c>] (corgi_bl_set_intensity+0x44/0x74)
 r7:c3933418 r6:c3933400 r5:c392cdf0 r4:0000002f
[<c0169b08>] (corgi_bl_set_intensity+0x0/0x74) from [<c0169c1c>] (corgi_bl_update_status+0x5c/0x64)
 r5:c03d31f0 r4:c3933400
[<c0169bc0>] (corgi_bl_update_status+0x0/0x64) from [<c02c3a68>] (corgi_lcd_probe+0x1a8/0x258)
 r4:c392cdf0 r3:c0169bc0
[<c02c38c0>] (corgi_lcd_probe+0x0/0x258) from [<c01da7a4>] (spi_drv_probe+0x20/0x24)
 r8:00000052 r7:c0192d9c r6:c03da6e8 r5:c38d5c34 r4:c38d5c00
[<c01da784>] (spi_drv_probe+0x0/0x24) from [<c0192c44>] (driver_probe_device+0xb0/0x208)
[<c0192b94>] (driver_probe_device+0x0/0x208) from [<c0192e0c>] (__driver_attach+0x70/0x94)
 r6:c03da6e8 r5:c38d5c34 r4:c38d5c00 r3:00000000
[<c0192d9c>] (__driver_attach+0x0/0x94) from [<c0191268>] (bus_for_each_dev+0x54/0x90)
 r6:c03da6e8 r5:c3827e80 r4:00000000 r3:00000000
[<c0191214>] (bus_for_each_dev+0x0/0x90) from [<c01927a4>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c03e29ec r5:c3932980 r4:c03da6e8
[<c0192784>] (driver_attach+0x0/0x28) from [<c0192340>] (bus_add_driver+0xd4/0x22c)
[<c019226c>] (bus_add_driver+0x0/0x22c) from [<c019335c>] (driver_register+0xa4/0x134)
 r8:00000052 r7:c03ea900 r6:c03c32ac r5:c03bdfc8 r4:c03da6e8
[<c01932b8>] (driver_register+0x0/0x134) from [<c01db7ec>] (spi_register_driver+0x4c/0x60)
[<c01db7a0>] (spi_register_driver+0x0/0x60) from [<c03b3ce0>] (corgi_lcd_driver_init+0x14/0x1c)
[<c03b3ccc>] (corgi_lcd_driver_init+0x0/0x1c) from [<c000868c>] (do_one_initcall+0x9c/0x174)
[<c00085f0>] (do_one_initcall+0x0/0x174) from [<c02c1b94>] (kernel_init+0xf4/0x2a8)
[<c02c1aa0>] (kernel_init+0x0/0x2a8) from [<c0009270>] (ret_from_fork+0x14/0x24)
---[ end trace a863a63f242ee38c ]---

Akita machines have backlight controls hooked to a gpio expander chip, max7310.
The driver that controls the max7310 sets the cansleep flag and the corgi_lcd
driver only uses plain gpio_set_value calls for changing backlight controls.
This triggers the WARN_ON on akita machines.

Akita is the only exception in this case since other users of corgi_bl access
backlight gpio controls through a different gpio expander which does not set the cansleep flag.

Fix this by conditionally using gpio_set_value_cansleep() when changing backlight intensity on
akita machines.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 drivers/video/backlight/corgi_lcd.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index c781768..f33e26f 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -26,7 +26,7 @@
 #include <linux/spi/corgi_lcd.h>
 #include <linux/slab.h>
 #include <asm/mach/sharpsl_param.h>
-
+#include <asm/mach-types.h>
 #define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
 
 /* Register Addresses */
@@ -408,11 +408,19 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
 	/* Bit 5 via GPIO_BACKLIGHT_CONT */
 	cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
 
-	if (gpio_is_valid(lcd->gpio_backlight_cont))
-		gpio_set_value(lcd->gpio_backlight_cont, cont);
+	if (gpio_is_valid(lcd->gpio_backlight_cont)) {
+		if (machine_is_akita())
+			gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
+		else
+			gpio_set_value(lcd->gpio_backlight_cont, cont);
+	}
 
-	if (gpio_is_valid(lcd->gpio_backlight_on))
-		gpio_set_value(lcd->gpio_backlight_on, intensity);
+	if (gpio_is_valid(lcd->gpio_backlight_on)) {
+		if (machine_is_akita())
+			gpio_set_value_cansleep(lcd->gpio_backlight_on, intensity);
+		else
+			gpio_set_value(lcd->gpio_backlight_on, intensity);
+	}
 
 	if (lcd->kick_battery)
 		lcd->kick_battery();
-- 
1.7.10.4

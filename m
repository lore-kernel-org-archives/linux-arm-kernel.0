From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  6 Jan 2011 21:52:48 +0200
Subject: [PATCH 3/7] ARM: S3C2410: H1940: Use leds-gpio driver for LEDs
	managing
In-Reply-To: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
References: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1294343572-28518-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can use generic leds-gpio driver, as latch api was converted
to gpiolib.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/h1940-bluetooth.c    |    8 ++-
 arch/arm/mach-s3c2410/include/mach/h1940.h |    3 +
 arch/arm/mach-s3c2410/mach-h1940.c         |   93 +++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
index 6c59ef5..2c126bb 100644
--- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
@@ -18,12 +18,14 @@
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
+#include <linux/leds.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/hardware.h>
 #include <mach/h1940-latch.h>
+#include <mach/h1940.h>
 
-#define DRV_NAME              "h1940-bt"
+#define DRV_NAME "h1940-bt"
 
 /* Bluetooth control */
 static void h1940bt_enable(int on)
@@ -37,6 +39,8 @@ static void h1940bt_enable(int on)
 		gpio_set_value(S3C2410_GPH(1), 1);
 		mdelay(10);
 		gpio_set_value(S3C2410_GPH(1), 0);
+
+		h1940_led_blink_set(-EINVAL, GPIO_LED_BLINK, NULL, NULL);
 	}
 	else {
 		gpio_set_value(S3C2410_GPH(1), 1);
@@ -44,6 +48,8 @@ static void h1940bt_enable(int on)
 		gpio_set_value(S3C2410_GPH(1), 0);
 		mdelay(10);
 		gpio_set_value(H1940_LATCH_BLUETOOTH_POWER, 0);
+
+		h1940_led_blink_set(-EINVAL, GPIO_LED_NO_BLINK_LOW, NULL, NULL);
 	}
 }
 
diff --git a/arch/arm/mach-s3c2410/include/mach/h1940.h b/arch/arm/mach-s3c2410/include/mach/h1940.h
index 4559784..2aa683c 100644
--- a/arch/arm/mach-s3c2410/include/mach/h1940.h
+++ b/arch/arm/mach-s3c2410/include/mach/h1940.h
@@ -17,5 +17,8 @@
 #define H1940_SUSPEND_CHECK		(0x30080000)
 
 extern void h1940_pm_return(void);
+extern int h1940_led_blink_set(unsigned gpio, int state,
+	unsigned long *delay_on, unsigned long *delay_off);
+
 
 #endif /* __ASM_ARCH_H1940_H */
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 641586a..5d0d2ae 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -27,6 +27,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
+
 #include <video/platform_lcd.h>
 
 #include <linux/mmc/host.h>
@@ -235,9 +237,87 @@ static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
 	.gpdup_mask=	0xffffffff,
 };
 
+DEFINE_SPINLOCK(h1940_blink_spin);
+
+int h1940_led_blink_set(unsigned gpio, int state,
+	unsigned long *delay_on, unsigned long *delay_off)
+{
+	int blink_gpio, check_gpio1, check_gpio2;
+
+	switch (gpio) {
+	case H1940_LATCH_LED_GREEN:
+		blink_gpio = S3C2410_GPA(7);
+		check_gpio1 = S3C2410_GPA(1);
+		check_gpio2 = S3C2410_GPA(3);
+		break;
+	case H1940_LATCH_LED_RED:
+		blink_gpio = S3C2410_GPA(1);
+		check_gpio1 = S3C2410_GPA(7);
+		check_gpio2 = S3C2410_GPA(3);
+		break;
+	default:
+		blink_gpio = S3C2410_GPA(3);
+		check_gpio1 = S3C2410_GPA(1);
+		check_gpio1 = S3C2410_GPA(7);
+		break;
+	}
+
+	if (delay_on && delay_off && !*delay_on && !*delay_off)
+		*delay_on = *delay_off = 500;
+
+	spin_lock(&h1940_blink_spin);
+
+	switch (state) {
+	case GPIO_LED_NO_BLINK_LOW:
+	case GPIO_LED_NO_BLINK_HIGH:
+		if (!gpio_get_value(check_gpio1) &&
+		    !gpio_get_value(check_gpio2))
+			gpio_set_value(H1940_LATCH_LED_FLASH, 0);
+		gpio_set_value(blink_gpio, 0);
+		if (gpio_is_valid(gpio))
+			gpio_set_value(gpio, state);
+		break;
+	case GPIO_LED_BLINK:
+		if (gpio_is_valid(gpio))
+			gpio_set_value(gpio, 0);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 1);
+		gpio_set_value(blink_gpio, 1);
+		break;
+	}
+
+	spin_unlock(&h1940_blink_spin);
+
+	return 0;
+}
+EXPORT_SYMBOL(h1940_led_blink_set);
+
+static struct gpio_led h1940_leds_desc[] = {
+	{
+		.name			= "Green",
+		.default_trigger	= "main-battery-charging-or-full",
+		.gpio			= H1940_LATCH_LED_GREEN,
+		.retain_state_suspended	= 1,
+	},
+	{
+		.name			= "Red",
+		.default_trigger	= "main-battery-full",
+		.gpio			= H1940_LATCH_LED_RED,
+		.retain_state_suspended	= 1,
+	},
+};
+
+static struct gpio_led_platform_data h1940_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(h1940_leds_desc),
+	.leds		= h1940_leds_desc,
+	.gpio_blink_set	= h1940_led_blink_set,
+};
+
 static struct platform_device h1940_device_leds = {
-	.name             = "h1940-leds",
-	.id               = -1,
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+			.platform_data = &h1940_leds_pdata,
+	},
 };
 
 static struct platform_device h1940_device_bluetooth = {
@@ -522,6 +602,15 @@ static void __init h1940_init(void)
 
 	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
 
+	gpio_request(S3C2410_GPA(1), "Red LED blink");
+	gpio_request(S3C2410_GPA(3), "Blue LED blink");
+	gpio_request(S3C2410_GPA(7), "Green LED blink");
+	gpio_request(H1940_LATCH_LED_FLASH, "LED blink");
+	gpio_direction_output(S3C2410_GPA(1), 0);
+	gpio_direction_output(S3C2410_GPA(3), 0);
+	gpio_direction_output(S3C2410_GPA(7), 0);
+	gpio_direction_output(H1940_LATCH_LED_FLASH, 0);
+
 	i2c_register_board_info(0, h1940_i2c_devices,
 		ARRAY_SIZE(h1940_i2c_devices));
 }
-- 
1.7.3.2

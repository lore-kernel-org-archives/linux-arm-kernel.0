From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri,  9 Jul 2010 14:27:20 +0300
Subject: [PATCH 1/3] rx1950: add rx1950 LEDs driver
In-Reply-To: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1278674842-17583-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/mach-rx1950.c |    6 +
 drivers/leds/Kconfig                |    6 +
 drivers/leds/Makefile               |    1 +
 drivers/leds/leds-rx1950.c          |  206 +++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-rx1950.c

diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 8603b57..55b806a 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -126,6 +126,11 @@ static struct s3c2410fb_display rx1950_display = {
 
 };
 
+static struct platform_device rx1950_device_leds = {
+	.name             = "rx1950-leds",
+	.id               = -1,
+};
+
 static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
 	.displays = &rx1950_display,
 	.num_displays = 1,
@@ -502,6 +507,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c_device_timer[1],
 	&rx1950_backlight,
 	&rx1950_device_gpiokeys,
+	&rx1950_device_leds,
 };
 
 static struct clk *rx1950_clocks[] __initdata = {
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 81bf25e..f986825 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -102,6 +102,12 @@ config LEDS_H1940
 	help
 	  This option enables support for the LEDs on the h1940.
 
+config LEDS_RX1950
+	tristate "LED Support for iPAQ RX1950 device"
+	depends on MACH_RX1950
+	help
+	  This option enables support for the LEDs on the rx1950.
+
 config LEDS_COBALT_QUBE
 	tristate "LED Support for the Cobalt Qube series front LED"
 	depends on MIPS_COBALT
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 2493de4..faa0d5d 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_LEDS_NET5501)		+= leds-net5501.o
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
 obj-$(CONFIG_LEDS_ALIX2)		+= leds-alix2.o
 obj-$(CONFIG_LEDS_H1940)		+= leds-h1940.o
+obj-$(CONFIG_LEDS_RX1950)		+= leds-rx1950.o
 obj-$(CONFIG_LEDS_COBALT_QUBE)		+= leds-cobalt-qube.o
 obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_SUNFIRE)		+= leds-sunfire.o
diff --git a/drivers/leds/leds-rx1950.c b/drivers/leds/leds-rx1950.c
new file mode 100644
index 0000000..1eed583
--- /dev/null
+++ b/drivers/leds/leds-rx1950.c
@@ -0,0 +1,206 @@
+/*
+ * drivers/leds/leds-rx1950.c
+ *
+ * Based on leds-h1940 by Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) Vasily Khoruzhick <anarsoul@gmail.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * RX1950 leds driver
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+
+#include <mach/regs-gpio.h>
+#include <mach/regs-gpioj.h>
+#include <mach/hardware.h>
+
+/*
+ * Green led.
+ */
+static void rx1950_greenled_set(struct led_classdev *led_dev,
+			       enum led_brightness value)
+{
+	switch (value) {
+	case LED_HALF:
+		gpio_direction_output(S3C2410_GPA(4), 1);
+		gpio_direction_output(S3C2410_GPA(6), 0);
+		gpio_direction_output(S3C2410_GPJ(6), 1);
+		break;
+	case LED_FULL:
+		gpio_direction_output(S3C2410_GPA(4), 0);
+		gpio_direction_output(S3C2410_GPA(6), 1);
+		gpio_direction_output(S3C2410_GPJ(6), 0);
+		break;
+	default:
+	case LED_OFF:
+		gpio_direction_output(S3C2410_GPA(4), 0);
+		gpio_direction_output(S3C2410_GPA(6), 0);
+		gpio_direction_output(S3C2410_GPJ(6), 0);
+		break;
+	}
+}
+
+static struct led_classdev rx1950_greenled = {
+	.name			= "rx1950:green",
+	.brightness_set		= rx1950_greenled_set,
+	.default_trigger	= "s3c-adc-charger",
+};
+
+static void rx1950_redled_set(struct led_classdev *led_dev,
+			     enum led_brightness value)
+{
+	switch (value) {
+	case LED_HALF:
+		gpio_direction_output(S3C2410_GPA(3), 1);
+		gpio_direction_output(S3C2410_GPA(7), 0);
+		gpio_direction_output(S3C2410_GPJ(6), 1);
+		break;
+	case LED_FULL:
+		gpio_direction_output(S3C2410_GPA(3), 0);
+		gpio_direction_output(S3C2410_GPA(7), 1);
+		gpio_direction_output(S3C2410_GPJ(6), 0);
+		break;
+	default:
+	case LED_OFF:
+		gpio_direction_output(S3C2410_GPA(3), 0);
+		gpio_direction_output(S3C2410_GPA(7), 0);
+		gpio_direction_output(S3C2410_GPJ(6), 0);
+		break;
+	}
+}
+
+static struct led_classdev rx1950_redled = {
+	.name			= "rx1950:red",
+	.brightness_set		= rx1950_redled_set,
+	.default_trigger	= "s3c-adc-charger",
+};
+
+/*
+ * Blue led.
+ */
+static void rx1950_blueled_set(struct led_classdev *led_dev,
+			      enum led_brightness value)
+{
+	if (value)
+		gpio_direction_output(S3C2410_GPA(11), 1);
+	else
+		gpio_direction_output(S3C2410_GPA(11), 0);
+}
+
+static struct led_classdev rx1950_blueled = {
+	.name			= "rx1950:blue",
+	.brightness_set		= rx1950_blueled_set,
+	.default_trigger	= "rx1950-acx-mem",
+};
+
+static int __devinit rx1950leds_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = gpio_request(S3C2410_GPA(3), "rx1950:red_led_blink");
+	if (ret)
+		goto err_blink_red;
+
+	ret = gpio_request(S3C2410_GPA(4), "rx1950:green_led_blink");
+	if (ret)
+		goto err_blink_green;
+
+	ret = gpio_request(S3C2410_GPJ(6), "rx1950:led_blink");
+	if (ret)
+		goto err_blink;
+
+	ret = gpio_request(S3C2410_GPA(6), "rx1950:green_led");
+	if (ret)
+		goto err_green;
+	ret = led_classdev_register(&pdev->dev, &rx1950_greenled);
+	if (ret)
+		goto err_green_gpio;
+
+	ret = gpio_request(S3C2410_GPA(7), "rx1950:red_led");
+	if (ret)
+		goto err_red;
+	ret = led_classdev_register(&pdev->dev, &rx1950_redled);
+	if (ret)
+		goto err_red_gpio;
+
+	ret = gpio_request(S3C2410_GPA(11), "rx1950:blue_led");
+	if (ret)
+		goto err_blue;
+	ret = led_classdev_register(&pdev->dev, &rx1950_blueled);
+	if (ret)
+		goto err_blue_gpio;
+
+	return 0;
+
+err_blue_gpio:
+	gpio_free(S3C2410_GPA(11));
+err_blue:
+	led_classdev_unregister(&rx1950_redled);
+err_red_gpio:
+	gpio_free(S3C2410_GPA(6));
+err_red:
+	led_classdev_unregister(&rx1950_greenled);
+err_green_gpio:
+	gpio_free(S3C2410_GPA7);
+err_green:
+	gpio_free(S3C2410_GPJ(6));
+err_blink:
+	gpio_free(S3C2410_GPA(4));
+err_blink_green:
+	gpio_free(S3C2410_GPA(3));
+err_blink_red:
+	return ret;
+}
+
+static int rx1950leds_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&rx1950_greenled);
+	led_classdev_unregister(&rx1950_redled);
+	led_classdev_unregister(&rx1950_blueled);
+	gpio_free(S3C2410_GPA(11));
+	gpio_free(S3C2410_GPA(6));
+	gpio_free(S3C2410_GPA(7));
+	gpio_free(S3C2410_GPJ(6));
+	gpio_free(S3C2410_GPA(3));
+	gpio_free(S3C2410_GPA(4));
+	return 0;
+}
+
+
+static struct platform_driver rx1950leds_driver = {
+	.driver		= {
+		.name	= "rx1950-leds",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= rx1950leds_probe,
+	.remove		= rx1950leds_remove,
+};
+
+
+static int __init rx1950leds_init(void)
+{
+	return platform_driver_register(&rx1950leds_driver);
+}
+
+static void __exit rx1950leds_exit(void)
+{
+	platform_driver_unregister(&rx1950leds_driver);
+}
+
+module_init(rx1950leds_init);
+module_exit(rx1950leds_exit);
+
+MODULE_AUTHOR("Vasily Khoruzhick <anarsoul@gmail.com>");
+MODULE_DESCRIPTION("LED driver for the iPAQ RX1950");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rx1950-leds");
-- 
1.7.1

From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 13 Aug 2010 21:18:07 +0200
Subject: [PATCH 5/5] ARM: S3C64XX: Add wifi RF kill support for SmartQ boards
Message-ID: <4c659a71.d37b0e0a.4deb.ffffcd80@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch create a new platform driver which adds support for RF kill to the
on-board WM-G-MR-09 wifi chip. It also adds the platform device glue to the
SmartQ board definitions.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig       |    7 ++
 arch/arm/mach-s3c64xx/Makefile      |    3 +
 arch/arm/mach-s3c64xx/mach-smartq.c |   38 ++--------
 arch/arm/mach-s3c64xx/smartq-wifi.c |  135 +++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/smartq-wifi.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 071e8a1..42a8c45 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -234,3 +234,10 @@ config MACH_SMARTQ7
 	select MACH_SMARTQ
 	help
 	    Machine support for the SmartQ 7
+
+config SMARTQ_WIFI
+	bool
+	default y
+	depends on MACH_SMARTQ && (RFKILL || !RFKILL)
+	help
+	    RF kill support for SmartQ wifi chip
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 48d3dfa..46af002 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -65,3 +65,6 @@ obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 obj-$(CONFIG_S3C64XX_DEV_TS)	+= dev-ts.o
 obj-$(CONFIG_S3C64XX_DEV_ONENAND1)	+= dev-onenand1.o
+
+# Misc
+obj-$(CONFIG_SMARTQ_WIFI)	+= smartq-wifi.o
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 3a9639b..0e3f43d 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -231,6 +230,12 @@ static struct i2c_board_info smartq_i2c_devs[] __initdata = {
 	{ I2C_BOARD_INFO("wm8987", 0x1a), },
 };
 
+static struct platform_device smartq_wifi_device = {
+	.name			= "smartq-wifi",
+	.id			= -1,
+	.dev.parent		= &s3c_device_hsmmc2.dev,
+};
+
 static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
 	&s3c_device_hsmmc0,	/* ... then the external SD card */
@@ -249,6 +254,7 @@ static struct platform_device *smartq_devices[] __initdata = {
 	&smartq_lcd_control_device,
 	&smartq_lcd_power_device,
 	&smartq_usb_otg_vbus_dev,
+	&smartq_wifi_device,
 };
 
 static void __init smartq_lcd_mode_set(void)
@@ -339,35 +345,6 @@ static int __init smartq_usb_otg_init(void)
 	return 0;
 }
 
-static int __init smartq_wifi_init(void)
-{
-	int ret;
-
-	ret = gpio_request(S3C64XX_GPK(1), "wifi control");
-	if (ret < 0) {
-		pr_err("%s: failed to get GPK1\n", __func__);
-		return ret;
-	}
-
-	ret = gpio_request(S3C64XX_GPK(2), "wifi reset");
-	if (ret < 0) {
-		pr_err("%s: failed to get GPK2\n", __func__);
-		gpio_free(S3C64XX_GPK(1));
-		return ret;
-	}
-
-	/* turn power on */
-	gpio_direction_output(S3C64XX_GPK(1), 1);
-
-	/* reset device */
-	gpio_direction_output(S3C64XX_GPK(2), 0);
-	mdelay(100);
-	gpio_set_value(S3C64XX_GPK(2), 1);
-	gpio_direction_input(S3C64XX_GPK(2));
-
-	return 0;
-}
-
 static struct map_desc smartq_iodesc[] __initdata = {};
 void __init smartq_map_io(void)
 {
@@ -393,7 +370,6 @@ void __init smartq_machine_init(void)
 	WARN_ON(smartq_power_off_init());
 	WARN_ON(smartq_usb_host_init());
 	WARN_ON(smartq_usb_otg_init());
-	WARN_ON(smartq_wifi_init());
 
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
 }
diff --git a/arch/arm/mach-s3c64xx/smartq-wifi.c b/arch/arm/mach-s3c64xx/smartq-wifi.c
new file mode 100644
index 0000000..54b2406
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/smartq-wifi.c
@@ -0,0 +1,135 @@
+/*
+ * linux/arch/arm/mach-s3c64xx/smartq-rfkill.c
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ * Based on h1940 bluetooth RF kill driver
+ *      Copyright (c) Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rfkill.h>
+
+#include <plat/gpio-cfg.h>
+
+#define WIFI_POWER	S3C64XX_GPK(1)
+#define WIFI_RESET	S3C64XX_GPK(2)
+
+#define smartq_wifi_enable(en) smartq_wifi_rfk_block(NULL, !en)
+
+static int smartq_wifi_rfk_block(void *data, bool blocked)
+{
+	/* change power depending on state */
+	gpio_set_value(WIFI_POWER, !blocked);
+
+	if (!blocked) {
+		/* when powering on, reset device */
+		gpio_direction_output(WIFI_RESET, 0);
+		ndelay(100); /* WM-G-MR-09 product spec,
+				6.2.5 RESET AND CONFIGURATION TIMING */
+		gpio_set_value(WIFI_RESET, 1);
+	}
+	gpio_direction_input(WIFI_RESET);
+
+	return 0;
+}
+
+static const struct rfkill_ops smartq_wifi_rfk_ops = {
+	.set_block	= smartq_wifi_rfk_block,
+};
+
+static int __devinit smartq_wifi_probe(struct platform_device *pdev)
+{
+	struct rfkill *rfk;
+	int ret;
+
+	ret = gpio_request(WIFI_POWER, "wifi control");
+	if (ret < 0) {
+		pr_err("%s: failed to get GPK1\n", __func__);
+		return ret;
+	}
+	gpio_direction_output(WIFI_POWER, 0);
+
+	ret = gpio_request(WIFI_RESET, "wifi reset");
+	if (ret < 0) {
+		pr_err("%s: failed to get GPK2\n", __func__);
+		goto err_wifi_control;
+	}
+	gpio_direction_input(WIFI_RESET);
+
+	rfk = rfkill_alloc("smartq-wlan", &pdev->dev, RFKILL_TYPE_WLAN,
+			   &smartq_wifi_rfk_ops, NULL);
+
+	if (!rfk) {
+		ret = -ENOMEM;
+		goto err_rfk_alloc;
+	}
+
+	rfkill_set_led_trigger_name(rfk, "smartq-wlan");
+
+	ret = rfkill_register(rfk);
+	if (ret)
+		goto err_rfk;
+
+	platform_set_drvdata(pdev, rfk);
+
+	return 0;
+
+err_rfk:
+	rfkill_destroy(rfk);
+err_rfk_alloc:
+	gpio_free(S3C64XX_GPK(2));
+err_wifi_control:
+	gpio_free(S3C64XX_GPK(1));
+	return ret;
+}
+
+static int smartq_wifi_remove(struct platform_device *pdev)
+{
+	struct rfkill *rfk = platform_get_drvdata(pdev);
+
+	smartq_wifi_enable(false);
+
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	gpio_free(WIFI_POWER);
+	gpio_free(WIFI_RESET);
+
+	return 0;
+}
+
+static struct platform_driver smartq_wifi_driver = {
+	.driver		= {
+		.name	= "smartq-wifi",
+	},
+	.probe		= smartq_wifi_probe,
+	.remove		= smartq_wifi_remove,
+};
+
+static int __init smartq_wifi_init(void)
+{
+	return platform_driver_register(&smartq_wifi_driver);
+}
+
+static void __exit smartq_wifi_exit(void)
+{
+	platform_driver_unregister(&smartq_wifi_driver);
+}
+
+module_init(smartq_wifi_init);
+module_exit(smartq_wifi_exit);
+
+MODULE_AUTHOR("Maurus Cuelenaere <mcuelenaere@gmail.com>");
+MODULE_DESCRIPTION("SmartQ WiFi RF kill driver");
+MODULE_LICENSE("GPLv2");
-- 
1.7.0.4

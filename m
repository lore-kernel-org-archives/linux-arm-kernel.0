From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 18 Dec 2009 10:01:45 -0500
Subject: [PATCH] backlight: enable max8925 backlight
Message-ID: <mailman.104.1261399623.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/video/backlight/Kconfig      |    7 +
 drivers/video/backlight/Makefile     |    1 +
 drivers/video/backlight/max8925_bl.c |  200 ++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/max8925_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 09bfa96..3aa5b6c 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -212,6 +212,13 @@ config BACKLIGHT_DA903X
 	  If you have a LCD backlight connected to the WLED output of DA9030
 	  or DA9034 WLED output, say Y here to enable this driver.

+config BACKLIGHT_MAX8925
+	tristate "Backlight driver for MAX8925"
+	depends on BACKLIGHT_CLASS_DEVICE && MFD_MAX8925
+	help
+	  If you have a LCD backlight connected to the WLED output of MAX8925
+	  WLED output, say Y here to enable this driver.
+
 config BACKLIGHT_MBP_NVIDIA
        tristate "MacBook Pro Nvidia Backlight Driver"
        depends on BACKLIGHT_CLASS_DEVICE && X86
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 9a40554..5fc3daf 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_BACKLIGHT_PROGEAR) += progear_bl.o
 obj-$(CONFIG_BACKLIGHT_CARILLO_RANCH) += cr_bllcd.o
 obj-$(CONFIG_BACKLIGHT_PWM)	+= pwm_bl.o
 obj-$(CONFIG_BACKLIGHT_DA903X)	+= da903x_bl.o
+obj-$(CONFIG_BACKLIGHT_MAX8925)	+= max8925_bl.o
 obj-$(CONFIG_BACKLIGHT_MBP_NVIDIA) += mbp_nvidia_bl.o
 obj-$(CONFIG_BACKLIGHT_TOSA)	+= tosa_bl.o
 obj-$(CONFIG_BACKLIGHT_SAHARA)	+= kb3886_bl.o
diff --git a/drivers/video/backlight/max8925_bl.c
b/drivers/video/backlight/max8925_bl.c
new file mode 100644
index 0000000..c267069
--- /dev/null
+++ b/drivers/video/backlight/max8925_bl.c
@@ -0,0 +1,200 @@
+/*
+ * Backlight driver for Maxim MAX8925
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *      Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/backlight.h>
+#include <linux/mfd/max8925.h>
+
+#define MAX_BRIGHTNESS		(0xff)
+#define MIN_BRIGHTNESS		(0)
+
+#define LWX_FREQ(x)		(((x - 601) / 100) & 0x7)
+
+struct max8925_backlight_data {
+	struct max8925_chip	*chip;
+
+	int		current_brightness;
+};
+
+static int max8925_backlight_set(struct backlight_device *bl, int brightness)
+{
+	struct max8925_backlight_data *data = bl_get_data(bl);
+	struct max8925_chip *chip = data->chip;
+	unsigned char value;
+	int ret;
+
+	if (brightness > MAX_BRIGHTNESS)
+		value = MAX_BRIGHTNESS;
+	else
+		value = brightness;
+
+	ret = max8925_reg_write(chip->i2c, MAX8925_WLED_CNTL, value);
+	if (ret < 0)
+		goto out;
+
+	if (!data->current_brightness && brightness)
+		/* enable WLED output */
+		ret = max8925_set_bits(chip->i2c, MAX8925_WLED_MODE_CNTL, 1, 1);
+	else if (!brightness)
+		/* disable WLED output */
+		ret = max8925_set_bits(chip->i2c, MAX8925_WLED_MODE_CNTL, 1, 0);
+	if (ret < 0)
+		goto out;
+	dev_dbg(chip->dev, "set brightness %d\n", value);
+	data->current_brightness = value;
+	return 0;
+out:
+	dev_dbg(chip->dev, "set brightness %d failure with return value:%d\n",
+		value, ret);
+	return ret;
+}
+
+static int max8925_backlight_update_status(struct backlight_device *bl)
+{
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	if (bl->props.state & BL_CORE_SUSPENDED)
+		brightness = 0;
+
+	return max8925_backlight_set(bl, brightness);
+}
+
+static int max8925_backlight_get_brightness(struct backlight_device *bl)
+{
+	struct max8925_backlight_data *data = bl_get_data(bl);
+	struct max8925_chip *chip = data->chip;
+	int ret;
+
+	ret = max8925_reg_read(chip->i2c, MAX8925_WLED_CNTL);
+	if (ret < 0)
+		return -EINVAL;
+	data->current_brightness = ret;
+	dev_dbg(chip->dev, "get brightness %d\n", data->current_brightness);
+	return ret;
+}
+
+static struct backlight_ops max8925_backlight_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.update_status	= max8925_backlight_update_status,
+	.get_brightness	= max8925_backlight_get_brightness,
+};
+
+static int __devinit max8925_backlight_probe(struct platform_device *pdev)
+{
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct max8925_platform_data *max8925_pdata;
+	struct max8925_backlight_pdata *pdata = NULL;
+	struct max8925_backlight_data *data;
+	struct backlight_device *bl;
+	struct resource *res;
+	char name[MAX8925_NAME_SIZE];
+	unsigned char value;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "No I/O resource!\n");
+		return -EINVAL;
+	}
+
+	if (pdev->dev.parent->platform_data) {
+		max8925_pdata = pdev->dev.parent->platform_data;
+		pdata = max8925_pdata->backlight;
+	}
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "platform data isn't assigned to "
+			"backlight\n");
+		return -EINVAL;
+	}
+
+	data = kzalloc(sizeof(struct max8925_backlight_data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+	strncpy(name, res->name, MAX8925_NAME_SIZE);
+	data->chip = chip;
+	data->current_brightness = 0;
+
+	bl = backlight_device_register(name, &pdev->dev, data,
+					&max8925_backlight_ops);
+	if (IS_ERR(bl)) {
+		dev_err(&pdev->dev, "failed to register backlight\n");
+		kfree(data);
+		return PTR_ERR(bl);
+	}
+	bl->props.max_brightness = MAX_BRIGHTNESS;
+	bl->props.brightness = MAX_BRIGHTNESS;
+
+	platform_set_drvdata(pdev, bl);
+
+	value = 0;
+	if (pdata->lxw_scl)
+		value |= (1 << 7);
+	if (pdata->lxw_freq)
+		value |= (LWX_FREQ(pdata->lxw_freq) << 4);
+	if (pdata->dual_string)
+		value |= (1 << 1);
+	ret = max8925_set_bits(chip->i2c, MAX8925_WLED_MODE_CNTL, 0xfe, value);
+	if (ret < 0)
+		goto out;
+
+	backlight_update_status(bl);
+	return 0;
+out:
+	kfree(data);
+	return ret;
+}
+
+static int __devexit max8925_backlight_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bl = platform_get_drvdata(pdev);
+	struct max8925_backlight_data *data = bl_get_data(bl);
+
+	backlight_device_unregister(bl);
+	kfree(data);
+	return 0;
+}
+
+static struct platform_driver max8925_backlight_driver = {
+	.driver		= {
+		.name	= "max8925-backlight",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max8925_backlight_probe,
+	.remove		= __devexit_p(max8925_backlight_remove),
+};
+
+static int __init max8925_backlight_init(void)
+{
+	return platform_driver_register(&max8925_backlight_driver);
+}
+module_init(max8925_backlight_init);
+
+static void __exit max8925_backlight_exit(void)
+{
+	platform_driver_unregister(&max8925_backlight_driver);
+};
+module_exit(max8925_backlight_exit);
+
+MODULE_DESCRIPTION("Backlight Driver for Maxim MAX8925");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:max8925-backlight");
-- 
1.5.6.5

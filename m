From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 10 Nov 2009 17:26:22 -0500
Subject: [PATCH] led: enable led in 88pm860x
Message-ID: <mailman.25.1258103022.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable led sub device in Marvell 88PM860x.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/leds/Kconfig         |    7 +
 drivers/leds/Makefile        |    1 +
 drivers/leds/leds-88pm860x.c |  358 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-88pm860x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e4f599f..6dbb85a 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -236,6 +236,13 @@ config LEDS_BD2802
 	  This option enables support for BD2802GU RGB LED driver chips
 	  accessed via the I2C bus.

+config LEDS_88PM860X
+	bool "LED Support for Marvell 88PM860x PMIC"
+	depends on LEDS_CLASS && MFD_88PM860X
+	help
+	  This option enables support for on-chip LED drivers found on Marvell
+	  Semiconductor 88PM8606 PMIC.
+
 comment "LED Triggers"

 config LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 46d7270..361ae38 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_LEDS_DA903X)		+= leds-da903x.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
+obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o

 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
new file mode 100644
index 0000000..5dfd4d8
--- /dev/null
+++ b/drivers/leds/leds-88pm860x.c
@@ -0,0 +1,358 @@
+/*
+ * LED driver for Marvell 88PM860x
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/mfd/88pm860x.h>
+
+#define LED_PWM_SHIFT		(3)
+#define LED_PWM_MASK		(0x1F)
+#define LED_CURRENT_MASK	(0x07 << 5)
+
+#define LED_BLINK_ON_MASK	(0x07)
+#define LED_BLINK_PERIOD_MASK	(0x0F << 3)
+#define LED_BLINK_MASK		(0x7F)
+
+#define LED_BLINK_ON(x)		((x & 0x7) * 66 + 66)
+#define LED_BLINK_PERIOD(x)	((x & 0xF) * 530 + 930)
+#define LED_BLINK_ON_MIN	LED_BLINK_ON(0)
+#define LED_BLINK_ON_MAX	LED_BLINK_ON(0x7)
+#define LED_BLINK_PERIOD_MIN	LED_BLINK_PERIOD(0)
+#define LED_BLINK_PERIOD_MAX	LED_BLINK_PERIOD(0xE)
+#define LED_TO_ON(x)		((x - 66) / 66)
+#define LED_TO_PERIOD(x)	((x - 930) / 530)
+
+#define LED1_BLINK_EN		(1 << 1)
+#define LED2_BLINK_EN		(1 << 2)
+
+struct pm860x_led {
+	struct led_classdev cdev;
+	struct pm860x_chip *chip;
+	struct mutex lock;
+	char name[MFD_NAME_SIZE];
+	int port;
+	int iset;
+
+	int blink;
+	int blink_time;
+	int blink_on;
+	int blink_off;
+	int current_brightness;
+};
+
+/* return offset of color register */
+static inline int __led_off(int port)
+{
+	int ret = -EINVAL;
+
+	if (port < 0)
+		goto out;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = port - PM8606_LED1_RED + PM8606_RGB1B;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = port - PM8606_LED2_RED + PM8606_RGB2B;
+		break;
+	}
+out:
+	return ret;
+}
+
+/* return offset of blink register */
+static inline int __blink_off(int port)
+{
+	int ret = -EINVAL;
+
+	if (port < 0)
+		goto out;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = PM8606_RGB1A;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = PM8606_RGB2A;
+		break;
+	}
+out:
+	return ret;
+}
+
+static inline int __blink_ctl_mask(int port)
+{
+	int ret = -EINVAL;
+
+	if (port < 0)
+		goto out;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret = LED1_BLINK_EN;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret = LED2_BLINK_EN;
+		break;
+	}
+out:
+	return ret;
+}
+
+static void pm860x_led_set(struct led_classdev *cdev,
+			   enum led_brightness value)
+{
+	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip = data->chip;
+	unsigned char brightness;
+	int offset;
+	int ret = -EINVAL;
+
+	if (data->port < 0)
+		return;
+	offset = __led_off(data->port);
+	if (offset < 0)
+		return;
+
+	mutex_lock(&data->lock);
+	brightness = value >> 3;
+
+	if ((data->current_brightness == 0) && brightness) {
+		if (data->iset) {
+			ret = pm860x_set_bits(chip->parent, DESC_8606, offset,
+					      LED_CURRENT_MASK, data->iset);
+			if (ret < 0)
+				goto out;
+		}
+	}
+
+	ret = pm860x_set_bits(chip->parent, DESC_8606, offset,
+			      LED_PWM_MASK, brightness);
+	if (ret < 0)
+		goto out;
+	mutex_unlock(&data->lock);
+
+	data->current_brightness = brightness;
+	dev_dbg(chip->dev, "Update LED. (reg:%d, brightness:%d)\n",
+		offset, brightness);
+	return;
+out:
+	mutex_unlock(&data->lock);
+	dev_err(chip->dev, "Fail on update LED. (reg:%d, brightness:%d)\n",
+		offset, brightness);
+	return;
+}
+
+static enum led_brightness pm860x_led_get(struct led_classdev *cdev)
+{
+	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip = data->chip;
+	enum led_brightness brightness = LED_OFF;
+	int offset = 0, ret = -EINVAL;
+
+	if (data->port < 0)
+		goto out;
+	offset = __led_off(data->port);
+	if (offset < 0)
+		goto out;
+
+	mutex_lock(&data->lock);
+	ret = pm860x_reg_read(chip->parent, DESC_8606, offset);
+	if (ret < 0)
+		goto out_mx;
+	ret &= LED_PWM_MASK;
+	if (ret >= (LED_FULL >> LED_PWM_SHIFT))
+		brightness = LED_FULL;
+	else if (ret < (LED_HALF >> LED_PWM_SHIFT))
+		brightness = LED_OFF;
+	else
+		brightness = LED_HALF;
+out_mx:
+	mutex_unlock(&data->lock);
+out:
+	dev_dbg(chip->dev, "Read LED. (reg:%d, brightness:%d, ret:%d)\n",
+		offset, brightness, ret);
+	return brightness;
+}
+
+static int pm860x_led_blink(struct led_classdev *cdev,
+			    unsigned long *delay_on,
+			    unsigned long *delay_off)
+{
+	struct pm860x_led *data = container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip = data->chip;
+	int period, on, offset, sum;
+	int ret = -EINVAL;
+
+	offset = __blink_off(data->port);
+	if (offset < 0)
+		return ret;
+
+	on = *delay_on;
+	if (on < LED_BLINK_ON_MIN)
+		on = LED_BLINK_ON_MIN;
+	if (on > LED_BLINK_ON_MAX)
+		on = LED_BLINK_ON_MAX;
+
+	on = LED_TO_ON(on);
+	on = LED_BLINK_ON(on);
+
+	period = on + *delay_off;
+	if (period < LED_BLINK_PERIOD_MIN)
+		period = LED_BLINK_PERIOD_MIN;
+	if (period > LED_BLINK_PERIOD_MAX)
+		period = LED_BLINK_PERIOD_MAX;
+	period = LED_TO_PERIOD(period);
+	period = LED_BLINK_PERIOD(period);
+
+	mutex_lock(&data->lock);
+	data->blink_on = on;
+	data->blink_off = period - data->blink_on;
+	sum = (period << 3) | data->blink_on;
+
+	ret = pm860x_set_bits(chip->parent, DESC_8606, offset,
+			      LED_BLINK_MASK, sum);
+	if (ret < 0)
+		goto out;
+
+	offset = __blink_ctl_mask(data->port);
+	if (offset < 0)
+		goto out;
+	ret = pm860x_set_bits(chip->parent, DESC_8606, PM8606_WLED3B,
+			      offset, offset);
+	if (ret < 0)
+		goto out;
+	mutex_unlock(&data->lock);
+
+	dev_dbg(chip->dev, "LED blink delay on:%dms, delay off:%dms\n",
+		data->blink_on, data->blink_off);
+	return 0;
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int __check_device(struct pm860x_led_pdata *pdata, char *name)
+{
+	struct pm860x_led_pdata *p = pdata;
+	int ret = -EINVAL;
+
+	while (p && p->id) {
+		if (p->id != PM8606_ID_LED)
+			break;
+
+		if (!strncmp(name, pm860x_led_name[p->flags],
+			MFD_NAME_SIZE)) {
+			ret = (int)p->flags;
+			break;
+		}
+		p++;
+	}
+	return ret;
+}
+
+static int pm860x_led_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_plat_data *pm860x_pdata;
+	struct pm860x_led_pdata *pdata;
+	struct pm860x_led *data;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "No I/O resource!\n");
+		return -EINVAL;
+	}
+
+	if (pdev->dev.parent->platform_data) {
+		pm860x_pdata = pdev->dev.parent->platform_data;
+		pdata = pm860x_pdata->led;
+	} else
+		pdata = NULL;
+
+	data = kzalloc(sizeof(struct pm860x_led), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+	strncpy(data->name, res->name, MFD_NAME_SIZE);
+	dev_set_drvdata(&pdev->dev, data);
+	data->chip = chip;
+	data->iset = pdata->iset;
+	data->port = __check_device(pdata, data->name);
+	data->current_brightness = 0;
+	data->cdev.name = data->name;
+	data->cdev.brightness_set = pm860x_led_set;
+	data->cdev.brightness_get = pm860x_led_get;
+	data->cdev.blink_set = pm860x_led_blink;
+	mutex_init(&data->lock);
+
+	ret = led_classdev_register(chip->dev, &data->cdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register LED: %d\n", ret);
+		goto out;
+	}
+	return 0;
+out:
+	kfree(data);
+	return ret;
+}
+
+static int pm860x_led_remove(struct platform_device *pdev)
+{
+	struct pm860x_led *data = platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&data->cdev);
+	kfree(data);
+
+	return 0;
+}
+
+static struct platform_driver pm860x_led_driver = {
+	.driver	= {
+		.name	= "88pm860x-led",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= pm860x_led_probe,
+	.remove	= pm860x_led_remove,
+};
+
+static int __devinit pm860x_led_init(void)
+{
+	return platform_driver_register(&pm860x_led_driver);
+}
+module_init(pm860x_led_init);
+
+static void __devexit pm860x_led_exit(void)
+{
+	platform_driver_unregister(&pm860x_led_driver);
+}
+module_exit(pm860x_led_exit);
+
+MODULE_DESCRIPTION("LED driver for Marvell PM860x");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:88pm860x-led");
-- 
1.5.6.5

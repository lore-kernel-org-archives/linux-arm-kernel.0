From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 18 Aug 2015 00:06:20 +0200
Subject: [PATCH v2 19/21] leds: leds-pasic3: Add support for PASIC3 LED
 controller
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Message-ID: <55D25ADC.10703@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for LEDs inside the PASIC3 chip.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/leds/Kconfig       |   9 ++
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-pasic3.c | 232 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/leds/leds-pasic3.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9ad35f7..516ba65 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -586,6 +586,15 @@ config LEDS_PM8941_WLED
 	  This option enables support for the 'White' LED block
 	  on Qualcomm PM8941 PMICs.
 
+config LEDS_PASIC3
+	tristate "LED support for the HTC Magician/Alpine PASIC3"
+	depends on LEDS_CLASS
+	depends on HTC_PASIC3
+	select REGMAP
+	help
+	  This option enables support for the PASIC3 chip (different chip
+	  than Compaq ASIC3).
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 8d6a24a..b1c659c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
 obj-$(CONFIG_LEDS_PM8941_WLED)		+= leds-pm8941-wled.o
 obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
+obj-$(CONFIG_LEDS_PASIC3)		+= leds-pasic3.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-pasic3.c b/drivers/leds/leds-pasic3.c
new file mode 100644
index 0000000..0f95230
--- /dev/null
+++ b/drivers/leds/leds-pasic3.c
@@ -0,0 +1,232 @@
+/*
+ * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not Compaq ASIC3)
+ *
+ * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
+ *
+ * CLK to MS calculation based on leds-asic3.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/htc-pasic3.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * 1 tick is around 62-63 ms, blinking settings (on+off):
+ *	Min: 1+1 ticks ~125ms
+ *	Max: 127+127 ticks ~15?875ms
+ * HW sometimes takes time to change (counter overflow after write?)
+ */
+
+#define MS_TO_CLK(ms)	DIV_ROUND_CLOSEST(((ms)*1024), 64000)
+#define CLK_TO_MS(clk)	(((clk)*64000)/1024)
+#define MAX_CLK		254		/* 127 + 127 (2x 7 bit reg) */
+#define MAX_MS		CLK_TO_MS(MAX_CLK)
+
+spinlock_t lock;
+
+static void brightness_set(struct led_classdev *cdev,
+	enum led_brightness value)
+{
+	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
+	struct pasic3_led *led = dev_get_platdata(cdev->dev);
+	struct pasic3_leds_pdata *pdata = dev_get_platdata(&pdev->dev);
+	unsigned long flags;
+	u8 val;
+
+	spin_lock_irqsave(&lock, flags);
+
+	if (value == LED_OFF) {
+		val = pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
+		pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
+			val & ~(led->bit_blink_en | led->bit_force_on));
+
+		val = pasic3_read_register(pdata->mfd_dev, PASIC3_MASK_A);
+		pasic3_write_register(pdata->mfd_dev, PASIC3_MASK_A,
+			val & ~led->bit_mask);
+
+		if (pdata->power_gpio) {
+			pdata->power_gpio_users--;
+
+			if (pdata->power_gpio_users == 0)
+				gpio_set_value(pdata->power_gpio, 0);
+		}
+	} else {
+		if (pdata->power_gpio) {
+			pdata->power_gpio_users++;
+
+			if (pdata->power_gpio_users != 0)
+				gpio_set_value(pdata->power_gpio, 1);
+		}
+
+		val = pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
+		pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
+			val | led->bit_force_on);
+	}
+
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static int blink_set(struct led_classdev *cdev,
+	unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
+	struct pasic3_led *led = dev_get_platdata(cdev->dev);
+	struct pasic3_leds_pdata *pdata = dev_get_platdata(&pdev->dev);
+	unsigned long flags;
+	u32 on, off;
+	u8 val;
+
+	if (*delay_on > MAX_MS || *delay_off > MAX_MS)
+		return -EINVAL;
+
+	if (*delay_on == 0 && *delay_off == 0) {
+		/* Choose sensible default delays */
+		on = MS_TO_CLK(500);
+		off = MS_TO_CLK(500);
+	} else {
+		on = MS_TO_CLK(*delay_on);
+		off = MS_TO_CLK(*delay_off);
+		if ((on + off) > MAX_CLK)
+			return -EINVAL;
+		/* Minimal on/off value must be 1 */
+		on = on ? on : 1;
+		off = off ? off : 1;
+	}
+
+	spin_lock_irqsave(&lock, flags);
+
+	pasic3_write_register(pdata->mfd_dev, led->reg_delay_on, on);
+	pasic3_write_register(pdata->mfd_dev, led->reg_delay_off, off);
+
+	val = pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
+	pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
+		val | led->bit_blink_en);
+
+	spin_unlock_irqrestore(&lock, flags);
+
+	*delay_on = CLK_TO_MS(on);
+	*delay_off = CLK_TO_MS(off);
+
+	return 0;
+}
+
+static int pasic3_led_probe(struct platform_device *pdev)
+{
+	struct pasic3_leds_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct led_classdev *cdev;
+	int ret;
+	int i;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->leds) {
+		dev_err(&pdev->dev, "no leds data\n");
+		return -EINVAL;
+	}
+
+	if (pdata->power_gpio) {
+		pdata->power_gpio_users = 0;
+
+		ret = gpio_request(pdata->power_gpio,
+			"Red-Blue LED Power");
+		if (ret < 0) {
+			dev_warn(&pdev->dev, "failed to request power GPIO\n");
+			goto err;
+		}
+	}
+
+	spin_lock_init(&lock);
+
+	cdev = devm_kzalloc(&pdev->dev,
+		sizeof(struct led_classdev) * pdata->num_leds, GFP_KERNEL);
+	if (!cdev) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < pdata->num_leds; i++) {
+		cdev[i].name = pdata->leds[i].name;
+		cdev[i].default_trigger = pdata->leds[i].default_trigger;
+		cdev[i].flags = LED_CORE_SUSPENDRESUME;
+		cdev[i].brightness_set = brightness_set;
+		cdev[i].blink_set = blink_set;
+
+		ret = devm_led_classdev_register(&pdev->dev, &cdev[i]);
+		if (ret < 0)
+			goto err;
+
+		cdev[i].dev->platform_data = &pdata->leds[i];
+	}
+
+	return 0;
+
+err:
+	if (pdata->power_gpio)
+		gpio_free(pdata->power_gpio);
+
+	return ret;
+}
+
+static int pasic3_led_remove(struct platform_device *pdev)
+{
+	struct pasic3_leds_pdata *pdata = dev_get_platdata(&pdev->dev);
+
+	if (pdata->power_gpio)
+		gpio_free(pdata->power_gpio);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pasic3_led_suspend(struct device *dev)
+{
+	struct pasic3_leds_pdata *pdata = dev_get_platdata(dev);
+
+	if (pdata->power_gpio)
+		gpio_set_value(pdata->power_gpio, 0);
+
+	return 0;
+}
+
+static int pasic3_led_resume(struct device *dev)
+{
+	struct pasic3_leds_pdata *pdata = dev_get_platdata(dev);
+
+	if (pdata->power_gpio)
+		gpio_set_value(pdata->power_gpio, 1);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pasic3_led_pm_ops, pasic3_led_suspend,
+	pasic3_led_resume);
+
+static struct platform_driver pasic3_led_driver = {
+	.probe		= pasic3_led_probe,
+	.remove		= pasic3_led_remove,
+	.driver		= {
+		.name	= "leds-pasic3",
+		.pm	= &pasic3_led_pm_ops,
+	},
+};
+
+module_platform_driver(pasic3_led_driver);
+
+MODULE_AUTHOR("Petr Cvek <petr.cvek@tul.cz>");
+MODULE_DESCRIPTION("HTC Magician PASIC3 LED driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-pasic3");
-- 
1.7.12.1

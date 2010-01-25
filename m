From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 06:30:29 -0500
Subject: [PATCH] rtc: enable rtc in max8925
Message-ID: <mailman.169.1264417753.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX8925 is a PMIC that contains RTC component.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/Kconfig       |   10 ++
 drivers/rtc/Makefile      |    1 +
 drivers/rtc/rtc-max8925.c |  310 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-max8925.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8167e9e..6c6a42e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -175,6 +175,16 @@ config RTC_DRV_MAX6900
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max6900.

+config RTC_DRV_MAX8925
+	tristate "Maxim MAX8925"
+	depends on MFD_MAX8925
+	help
+	  If you say yes here you will get support for the
+	  RTC of Maxim MAX8925 PMIC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-max8925.
+
 config RTC_DRV_RS5C372
 	tristate "Ricoh R2025S/D, RS5C372A/B, RV5C386, RV5C387A"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e5160fd..f427e39 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_MXC)		+= rtc-mxc.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
+obj-$(CONFIG_RTC_DRV_MAX8925)	+= rtc-max8925.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MC13783)	+= rtc-mc13783.o
 obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
new file mode 100644
index 0000000..38f4828
--- /dev/null
+++ b/drivers/rtc/rtc-max8925.c
@@ -0,0 +1,310 @@
+/*
+ * RTC driver for Maxim MAX8925
+ *
+ * Copyright (C) 2009-2010 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/max8925.h>
+
+enum {
+	RTC_SEC = 0,
+	RTC_MIN,
+	RTC_HOUR,
+	RTC_WEEKDAY,
+	RTC_DATE,
+	RTC_MONTH,
+	RTC_YEAR1,
+	RTC_YEAR2,
+};
+
+#define MAX8925_RTC_SEC			0x00
+#define MAX8925_RTC_MIN			0x01
+#define MAX8925_RTC_HOUR		0x02
+#define MAX8925_RTC_WEEKDAY		0x03
+#define MAX8925_RTC_DATE		0x04
+#define MAX8925_RTC_MONTH		0x05
+#define MAX8925_RTC_YEAR1		0x06
+#define MAX8925_RTC_YEAR2		0x07
+#define MAX8925_ALARM0_SEC		0x08
+#define MAX8925_ALARM0_MIN		0x09
+#define MAX8925_ALARM0_HOUR		0x0a
+#define MAX8925_ALARM0_WEEKDAY		0x0b
+#define MAX8925_ALARM0_DATE		0x0c
+#define MAX8925_ALARM0_MON		0x0d
+#define MAX8925_ALARM0_YEAR1		0x0e
+#define MAX8925_ALARM0_YEAR2		0x0f
+#define MAX8925_ALARM1_SEC		0x10
+#define MAX8925_ALARM1_MIN		0x11
+#define MAX8925_ALARM1_HOUR		0x12
+#define MAX8925_ALARM1_WEEKDAY		0x13
+#define MAX8925_ALARM1_DATE		0x14
+#define MAX8925_ALARM1_MON		0x15
+#define MAX8925_ALARM1_YEAR1		0x16
+#define MAX8925_ALARM1_YEAR2		0x17
+#define MAX8925_RTC_CNTL		0x1b
+#define MAX8925_RTC_STATUS		0x20
+
+#define TIME_NUM			8
+#define ALARM_1SEC			(1 << 7)
+#define HOUR_12				(1 << 7)
+#define HOUR_AM_PM			(1 << 5)
+#define ALARM0_IRQ			(1 << 3)
+#define ALARM1_IRQ			(1 << 2)
+#define ALARM0_STATUS			(1 << 2)
+#define ALARM1_STATUS			(1 << 1)
+
+
+struct max8925_rtc_info {
+	struct rtc_device	*rtc_dev;
+	struct max8925_chip	*chip;
+	struct i2c_client	*i2c;
+	struct i2c_client	*rtc;
+	struct device		*dev;
+};
+
+static irqreturn_t rtc_update_handler(int irq, void *data)
+{
+	struct max8925_rtc_info *info = (struct max8925_rtc_info *)data;
+
+	/* disable ALARM0 except for 1SEC alarm */
+	max8925_set_bits(info->rtc, MAX8925_ALARM0_CNTL, 0x7f, 0);
+	rtc_update_irq(info->rtc_dev, 1, RTC_IRQF | RTC_AF);
+	return IRQ_HANDLED;
+}
+
+static int max8925_rtc_open(struct device *dev)
+{
+	return 0;
+}
+
+static void max8925_rtc_release(struct device *dev)
+{
+}
+
+static int tm_calc(struct rtc_time *tm, unsigned char *buf, int len)
+{
+	if (len < TIME_NUM)
+		return -EINVAL;
+	tm->tm_year = (buf[RTC_YEAR2] >> 4) * 1000
+			+ (buf[RTC_YEAR2] & 0xf) * 100
+			+ (buf[RTC_YEAR1] >> 4) * 10
+			+ (buf[RTC_YEAR1] & 0xf);
+	tm->tm_year -= 1900;
+	tm->tm_mon = ((buf[RTC_MONTH] >> 4) & 0x01) * 10
+			+ (buf[RTC_MONTH] & 0x0f);
+	tm->tm_mday = ((buf[RTC_DATE] >> 4) & 0x03) * 10
+			+ (buf[RTC_DATE] & 0x0f);
+	tm->tm_wday = buf[RTC_WEEKDAY] & 0x07;
+	if (buf[RTC_HOUR] & HOUR_12) {
+		tm->tm_hour = ((buf[RTC_HOUR] >> 4) & 0x1) * 10
+				+ (buf[RTC_HOUR] & 0x0f);
+		if (buf[RTC_HOUR] & HOUR_AM_PM)
+			tm->tm_hour += 12;
+	} else
+		tm->tm_hour = ((buf[RTC_HOUR] >> 4) & 0x03) * 10
+				+ (buf[RTC_HOUR] & 0x0f);
+	tm->tm_min = ((buf[RTC_MIN] >> 4) & 0x7) * 10
+			+ (buf[RTC_MIN] & 0x0f);
+	tm->tm_sec = ((buf[RTC_SEC] >> 4) & 0x7) * 10
+			+ (buf[RTC_SEC] & 0x0f);
+	return 0;
+}
+
+static int data_calc(unsigned char *buf, struct rtc_time *tm, int len)
+{
+	unsigned char high, low;
+
+	if (len < TIME_NUM)
+		return -EINVAL;
+
+	high = (tm->tm_year + 1900) / 1000;
+	low = (tm->tm_year + 1900) / 100;
+	low = low - high * 10;
+	buf[RTC_YEAR2] = (high << 4) + low;
+	high = (tm->tm_year + 1900) / 10;
+	low = tm->tm_year + 1900;
+	low = low - high * 10;
+	high = high - (high / 10) * 10;
+	buf[RTC_YEAR1] = (high << 4) + low;
+	high = tm->tm_mon / 10;
+	low = tm->tm_mon;
+	low = low - high * 10;
+	buf[RTC_MONTH] = (high << 4) + low;
+	high = tm->tm_mday / 10;
+	low = tm->tm_mday;
+	low = low - high * 10;
+	buf[RTC_DATE] = (high << 4) + low;
+	buf[RTC_WEEKDAY] = tm->tm_wday;
+	high = tm->tm_hour / 10;
+	low = tm->tm_hour;
+	low = low - high * 10;
+	buf[RTC_HOUR] = (high << 4) + low;
+	high = tm->tm_min / 10;
+	low = tm->tm_min;
+	low = low - high * 10;
+	buf[RTC_MIN] = (high << 4) + low;
+	high = tm->tm_sec / 10;
+	low = tm->tm_sec;
+	low = low - high * 10;
+	buf[RTC_SEC] = (high << 4) + low;
+	return 0;
+}
+
+static int max8925_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max8925_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[TIME_NUM];
+	int ret;
+
+	max8925_bulk_read(info->rtc, MAX8925_RTC_SEC, TIME_NUM, buf);
+	ret = tm_calc(tm, buf, TIME_NUM);
+	return ret;
+}
+
+static int max8925_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max8925_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[TIME_NUM];
+	int ret;
+
+	ret = data_calc(buf, tm, TIME_NUM);
+	if (ret < 0)
+		return ret;
+	max8925_bulk_write(info->rtc, MAX8925_RTC_SEC, TIME_NUM, buf);
+	return ret;
+}
+
+static int max8925_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max8925_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[TIME_NUM];
+	int ret;
+
+	max8925_bulk_read(info->rtc, MAX8925_ALARM0_SEC, TIME_NUM, buf);
+	ret = tm_calc(&alrm->time, buf, TIME_NUM);
+
+	ret = max8925_reg_read(info->rtc, MAX8925_RTC_IRQ_MASK);
+	if ((ret & ALARM0_IRQ) == 0)
+		alrm->enabled = 1;
+	else
+		alrm->enabled = 0;
+	ret = max8925_reg_read(info->rtc, MAX8925_RTC_STATUS);
+	if (ret & ALARM0_STATUS)
+		alrm->pending = 1;
+	else
+		alrm->pending = 0;
+	return ret;
+}
+
+static int max8925_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max8925_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[TIME_NUM];
+	int ret;
+
+	ret = data_calc(buf, &alrm->time, TIME_NUM);
+	if (ret < 0)
+		return ret;
+	max8925_bulk_write(info->rtc, MAX8925_ALARM0_SEC, TIME_NUM, buf);
+	/* only enable alarm on year/month/day/hour/min/sec */
+	max8925_reg_write(info->rtc, MAX8925_ALARM0_CNTL, 0x77);
+	return ret;
+}
+
+static const struct rtc_class_ops max8925_rtc_ops = {
+	.open		= max8925_rtc_open,
+	.release	= max8925_rtc_release,
+	.read_time	= max8925_rtc_read_time,
+	.set_time	= max8925_rtc_set_time,
+	.read_alarm	= max8925_rtc_read_alarm,
+	.set_alarm	= max8925_rtc_set_alarm,
+};
+
+static int __devinit max8925_rtc_probe(struct platform_device *pdev)
+{
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct max8925_rtc_info *info;
+	int irq, ret;
+
+	info = kzalloc(sizeof(struct max8925_rtc_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->chip = chip;
+	info->i2c = chip->i2c;
+	info->rtc = chip->rtc;
+	info->dev = &pdev->dev;
+	irq = chip->irq_base + MAX8925_IRQ_RTC_ALARM0;
+
+	ret = request_threaded_irq(irq, NULL, rtc_update_handler,
+				   IRQF_ONESHOT, "rtc-alarm0", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			irq, ret);
+		goto out_irq;
+	}
+
+	info->rtc_dev = rtc_device_register("max8925-rtc", &pdev->dev,
+					&max8925_rtc_ops, THIS_MODULE);
+	ret = PTR_ERR(info->rtc_dev);
+	if (IS_ERR(info->rtc_dev)) {
+		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
+		goto out_rtc;
+	}
+
+	dev_set_drvdata(&pdev->dev, info);
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+out_rtc:
+	free_irq(chip->irq_base + MAX8925_IRQ_RTC_ALARM0, info);
+out_irq:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit max8925_rtc_remove(struct platform_device *pdev)
+{
+	struct max8925_rtc_info *info = platform_get_drvdata(pdev);
+
+	if (info) {
+		free_irq(info->chip->irq_base + MAX8925_IRQ_RTC_ALARM0, info);
+		rtc_device_unregister(info->rtc_dev);
+		kfree(info);
+	}
+	return 0;
+}
+
+static struct platform_driver max8925_rtc_driver = {
+	.driver		= {
+		.name	= "max8925-rtc",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max8925_rtc_probe,
+	.remove		= __devexit_p(max8925_rtc_remove),
+};
+
+static int __init max8925_rtc_init(void)
+{
+	return platform_driver_register(&max8925_rtc_driver);
+}
+module_init(max8925_rtc_init);
+
+static void __exit max8925_rtc_exit(void)
+{
+	platform_driver_unregister(&max8925_rtc_driver);
+}
+module_exit(max8925_rtc_exit);
+
+MODULE_DESCRIPTION("Maxim MAX8925 RTC driver");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.5

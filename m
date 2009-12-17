From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 17 Dec 2009 12:30:16 -0500
Subject: [PATCH] mfd: enable max8925
Message-ID: <mailman.102.1261399539.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Max8925 is a Power Management IC from Maxim Semiconductor.

Do basic support on accessing MAX8925.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/Kconfig         |    9 ++
 drivers/mfd/Makefile        |    2 +
 drivers/mfd/max8925-core.c  |  256 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/max8925-i2c.c   |  202 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8925.h |  112 +++++++++++++++++++
 5 files changed, 581 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/max8925-core.c
 create mode 100644 drivers/mfd/max8925-i2c.c
 create mode 100644 include/linux/mfd/max8925.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 570be13..259cabf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -160,6 +160,15 @@ config PMIC_DA903X
 	  individual components like LCD backlight, voltage regulators,
 	  LEDs and battery-charger under the corresponding menus.

+config MFD_MAX8925
+	tristate "Maxim Semiconductor MAX8925 PMIC Support"
+	depends on I2C
+	help
+	  Say yes here to support for Maxim Semiconductor MAX8925. This is
+	  a Power Management IC. This driver provies common support for
+	  accessing the device, additional drivers must be enabled in order
+	  to use the functionality of the device.
+
 config MFD_WM8400
 	tristate "Support Wolfson Microelectronics WM8400"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f3b277b..2809869 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -44,6 +44,8 @@ endif
 obj-$(CONFIG_UCB1400_CORE)	+= ucb1400_core.o

 obj-$(CONFIG_PMIC_DA903X)	+= da903x.o
+max8925-objs			:= max8925-core.o max8925-i2c.o
+obj-$(CONFIG_MFD_MAX8925)	+= max8925.o

 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633-core.o
 obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
new file mode 100644
index 0000000..34c71c8
--- /dev/null
+++ b/drivers/mfd/max8925-core.c
@@ -0,0 +1,256 @@
+/*
+ * Base driver for Maxim MAX8925
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max8925.h>
+
+#define IRQ_MODE_STATUS		0
+#define IRQ_MODE_MASK		1
+
+static int __get_irq_offset(struct max8925_chip *chip, int irq, int mode,
+			    int *offset, int *bit)
+{
+	if (!offset || !bit)
+		return -EINVAL;
+
+	switch (chip->chip_id) {
+	case MAX8925_GPM:
+		*bit = irq % 8;
+		if (irq < 16) {
+			*offset = (mode) ? MAX8925_CHG_IRQ1_MASK
+				: MAX8925_CHG_IRQ1;
+			if (irq >= 8)
+				(*offset)++;
+		} else {
+			*offset = (mode) ? MAX8925_ON_OFF_IRQ1_MASK
+				: MAX8925_ON_OFF_IRQ1;
+			if (irq >= 24)
+				(*offset)++;
+		}
+		break;
+	case MAX8925_ADC:
+		*bit = irq % 8;
+		*offset = (mode) ? MAX8925_TSC_IRQ_MASK : MAX8925_TSC_IRQ;
+		break;
+	default:
+		goto out;
+	}
+	return 0;
+out:
+	dev_err(chip->dev, "Wrong irq #%d is assigned\n", irq);
+	return -EINVAL;
+}
+
+static int __check_irq(int irq)
+{
+	if ((irq < 0) || (irq >= MAX8925_NUM_IRQ))
+		return -EINVAL;
+	return 0;
+}
+
+int max8925_mask_irq(struct max8925_chip *chip, int irq)
+{
+	int offset, bit, ret;
+
+	ret = __get_irq_offset(chip, irq, IRQ_MODE_MASK, &offset, &bit);
+	if (ret < 0)
+		return ret;
+	ret = max8925_set_bits(chip->i2c, offset, 1 << bit, 1 << bit);
+	return ret;
+}
+
+int max8925_unmask_irq(struct max8925_chip *chip, int irq)
+{
+	int offset, bit, ret;
+
+	ret = __get_irq_offset(chip, irq, IRQ_MODE_MASK, &offset, &bit);
+	if (ret < 0)
+		return ret;
+	ret = max8925_set_bits(chip->i2c, offset, 1 << bit, 0);
+	return ret;
+}
+
+#define INT_STATUS_NUM		(4)
+
+static irqreturn_t max8925_irq_thread(int irq, void *data)
+{
+	DECLARE_BITMAP(irq_status, MAX8925_NUM_IRQ);
+	struct max8925_chip *chip = data;
+	unsigned char status_buf[INT_STATUS_NUM << 1];
+	int i, ret;
+
+	irq_status[0] = 0;
+
+	/* all these interrupt status registers are read-only */
+	switch (chip->chip_id) {
+	case MAX8925_GPM:
+		ret = max8925_bulk_read(chip->i2c, MAX8925_CHG_IRQ1,
+					4, status_buf);
+		if (ret < 0)
+			goto out;
+		ret = max8925_bulk_read(chip->i2c, MAX8925_ON_OFF_IRQ1,
+					4, &status_buf[4]);
+		if (ret < 0)
+			goto out;
+		/* clear masked interrupt status */
+		status_buf[0] &= (~status_buf[2] & CHG_IRQ1_MASK);
+		irq_status[0] |= status_buf[0];
+		status_buf[1] &= (~status_buf[3] & CHG_IRQ2_MASK);
+		irq_status[0] |= (status_buf[1] << 8);
+		status_buf[4] &= (~status_buf[6] & ON_OFF_IRQ1_MASK);
+		irq_status[0] |= (status_buf[4] << 16);
+		status_buf[5] &= (~status_buf[7] & ON_OFF_IRQ2_MASK);
+		irq_status[0] |= (status_buf[5] << 24);
+		break;
+	case MAX8925_ADC:
+		ret = max8925_bulk_read(chip->i2c, MAX8925_TSC_IRQ,
+					2, status_buf);
+		if (ret < 0)
+			goto out;
+		/* clear masked interrupt status */
+		status_buf[0] &= (~status_buf[1] & TSC_IRQ_MASK);
+		irq_status[0] |= status_buf[0];
+		break;
+	default:
+		goto out;
+	}
+
+	while (!bitmap_empty(irq_status, MAX8925_NUM_IRQ)) {
+		i = find_first_bit(irq_status, MAX8925_NUM_IRQ);
+		clear_bit(i, irq_status);
+		dev_dbg(chip->dev, "Servicing IRQ #%d in %s\n", i, chip->name);
+
+		mutex_lock(&chip->irq_lock);
+		if (chip->irq[i].handler)
+			chip->irq[i].handler(i, chip->irq[i].data);
+		else {
+			max8925_mask_irq(chip, i);
+			dev_err(chip->dev, "Noboday cares IRQ #%d in %s. "
+				"Now mask it.\n", i, chip->name);
+		}
+		mutex_unlock(&chip->irq_lock);
+	}
+out:
+	return IRQ_HANDLED;
+}
+
+int max8925_request_irq(struct max8925_chip *chip, int irq,
+			irq_handler_t handler, void *data)
+{
+	if ((__check_irq(irq) < 0) || !handler)
+		return -EINVAL;
+
+	mutex_lock(&chip->irq_lock);
+	chip->irq[irq].handler = handler;
+	chip->irq[irq].data = data;
+	mutex_unlock(&chip->irq_lock);
+	return 0;
+}
+EXPORT_SYMBOL(max8925_request_irq);
+
+int max8925_free_irq(struct max8925_chip *chip, int irq)
+{
+	if (__check_irq(irq) < 0)
+		return -EINVAL;
+
+	mutex_lock(&chip->irq_lock);
+	chip->irq[irq].handler = NULL;
+	chip->irq[irq].data = NULL;
+	mutex_unlock(&chip->irq_lock);
+	return 0;
+}
+EXPORT_SYMBOL(max8925_free_irq);
+
+static int __devinit device_gpm_init(struct max8925_chip *chip,
+				      struct i2c_client *i2c,
+				      struct max8925_platform_data *pdata)
+{
+	int ret;
+
+	/* mask all IRQs */
+	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ1_MASK, 0x7, 0x7);
+	if (ret < 0)
+		goto out;
+	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ2_MASK, 0xff, 0xff);
+	if (ret < 0)
+		goto out;
+	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ1_MASK, 0xff, 0xff);
+	if (ret < 0)
+		goto out;
+	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ2_MASK, 0x3, 0x3);
+	if (ret < 0)
+		goto out;
+
+	memcpy(chip->name, "GPM", 3);
+	memset(chip->irq, 0, sizeof(struct max8925_irq) * MAX8925_NUM_IRQ);
+	ret = request_threaded_irq(i2c->irq, NULL, max8925_irq_thread,
+				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"max8925-gpm", chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
+		goto out;
+	}
+	chip->chip_irq = i2c->irq;
+out:
+	return ret;
+}
+
+static int __devinit device_adc_init(struct max8925_chip *chip,
+				     struct i2c_client *i2c,
+				     struct max8925_platform_data *pdata)
+{
+	int ret;
+
+	/* mask all IRQs */
+	ret = max8925_set_bits(i2c, MAX8925_TSC_IRQ_MASK, 3, 3);
+
+	memcpy(chip->name, "ADC", 3);
+	memset(chip->irq, 0, sizeof(struct max8925_irq) * MAX8925_NUM_IRQ);
+	ret = request_threaded_irq(i2c->irq, NULL, max8925_irq_thread,
+				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"max8925-adc", chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
+		goto out;
+	}
+	chip->chip_irq = i2c->irq;
+out:
+	return ret;
+}
+
+int max8925_device_init(struct max8925_chip *chip,
+			struct max8925_platform_data *pdata)
+{
+	switch (chip->chip_id) {
+	case MAX8925_GPM:
+		device_gpm_init(chip, chip->i2c, pdata);
+		break;
+	case MAX8925_ADC:
+		device_adc_init(chip, chip->i2c, pdata);
+		break;
+	}
+	return 0;
+}
+
+void max8925_device_exit(struct max8925_chip *chip)
+{
+	if (chip->chip_irq >= 0)
+		free_irq(chip->chip_irq, chip);
+}
+
+MODULE_DESCRIPTION("PMIC Driver for Maxim MAX8925");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang at marvell.com");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
new file mode 100644
index 0000000..189dbca
--- /dev/null
+++ b/drivers/mfd/max8925-i2c.c
@@ -0,0 +1,202 @@
+/*
+ * I2C driver for Maxim MAX8925
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max8925.h>
+
+static inline int max8925_read_device(struct i2c_client *i2c,
+				      int reg, int bytes, void *dest)
+{
+	unsigned char data;
+	int ret;
+
+	data = (unsigned char)reg;
+	ret = i2c_master_send(i2c, &data, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(i2c, dest, bytes);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static inline int max8925_write_device(struct i2c_client *i2c,
+				       int reg, int bytes, void *src)
+{
+        unsigned char buf[bytes + 1];
+        int ret;
+
+        buf[0] = (unsigned char)reg;
+        memcpy(&buf[1], src, bytes);
+
+        ret = i2c_master_send(i2c, buf, bytes + 1);
+        if (ret < 0)
+                return ret;
+        return 0;
+}
+
+int max8925_reg_read(struct i2c_client *i2c, int reg)
+{
+	struct max8925_chip *chip = i2c_get_clientdata(i2c);
+	unsigned char data;
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = max8925_read_device(i2c, reg, 1, &data);
+	mutex_unlock(&chip->io_lock);
+
+	if (ret < 0)
+		return ret;
+	else
+		return (int)data;
+}
+EXPORT_SYMBOL(max8925_reg_read);
+
+int max8925_reg_write(struct i2c_client *i2c, int reg,
+		unsigned char data)
+{
+	struct max8925_chip *chip = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = max8925_write_device(i2c, reg, 1, &data);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(max8925_reg_write);
+
+int max8925_bulk_read(struct i2c_client *i2c, int reg,
+		int count, unsigned char *buf)
+{
+	struct max8925_chip *chip = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = max8925_read_device(i2c, reg, count, buf);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(max8925_bulk_read);
+
+int max8925_bulk_write(struct i2c_client *i2c, int reg,
+		int count, unsigned char *buf)
+{
+	struct max8925_chip *chip = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = max8925_write_device(i2c, reg, count, buf);
+	mutex_unlock(&chip->io_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(max8925_bulk_write);
+
+int max8925_set_bits(struct i2c_client *i2c, int reg,
+		unsigned char mask, unsigned char data)
+{
+	struct max8925_chip *chip = i2c_get_clientdata(i2c);
+	unsigned char value;
+	int ret;
+
+	mutex_lock(&chip->io_lock);
+	ret = max8925_read_device(i2c, reg, 1, &value);
+	if (ret < 0)
+		goto out;
+	value &= ~mask;
+	value |= data;
+	ret = max8925_write_device(i2c, reg, 1, &value);
+out:
+	mutex_unlock(&chip->io_lock);
+	return ret;
+}
+EXPORT_SYMBOL(max8925_set_bits);
+
+
+static const struct i2c_device_id max8925_id_table[] = {
+	{ "max8925", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, max8925_id_table);
+
+static int __devinit max8925_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct max8925_platform_data *pdata = client->dev.platform_data;
+	struct max8925_chip *chip;
+
+	if (!pdata) {
+		pr_info("%s: platform data is missing\n", __func__);
+		return -EINVAL;
+	}
+	if ((pdata->chip_id <= MAX8925_INVALID)
+		|| (pdata->chip_id >= MAX8925_MAX)) {
+		pr_info("#%s: wrong chip identification\n", __func__);
+		return -EINVAL;
+	}
+
+	chip = kzalloc(sizeof(struct max8925_chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+	chip->i2c = client;
+	chip->chip_id = pdata->chip_id;
+	i2c_set_clientdata(client, chip);
+	chip->dev = &client->dev;
+	mutex_init(&chip->io_lock);
+	dev_set_drvdata(chip->dev, chip);
+
+	return 0;
+}
+
+static int __devexit max8925_remove(struct i2c_client *client)
+{
+	struct max8925_chip *chip = i2c_get_clientdata(client);
+
+	i2c_set_clientdata(client, NULL);
+	kfree(chip);
+	return 0;
+}
+
+static struct i2c_driver max8925_driver = {
+	.driver	= {
+		.name	= "max8925",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max8925_probe,
+	.remove		= __devexit_p(max8925_remove),
+	.id_table	= max8925_id_table,
+};
+
+static int __init max8925_i2c_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&max8925_driver);
+	if (ret != 0)
+		pr_err("Failed to register MAX8925 I2C driver: %d\n", ret);
+	return ret;
+}
+subsys_initcall(max8925_i2c_init);
+
+static void __exit max8925_i2c_exit(void)
+{
+	i2c_del_driver(&max8925_driver);
+}
+module_exit(max8925_i2c_exit);
+
+MODULE_DESCRIPTION("I2C Driver for Maxim 8925");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
new file mode 100644
index 0000000..8cc0608
--- /dev/null
+++ b/include/linux/mfd/max8925.h
@@ -0,0 +1,112 @@
+/*
+ * Maxim8925 Interface
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_MFD_MAX8925_H
+#define __LINUX_MFD_MAX8925_H
+
+#include <linux/interrupt.h>
+
+/* Charger registers */
+#define MAX8925_CHG_IRQ1		(0x7e)
+#define MAX8925_CHG_IRQ2		(0x7f)
+#define MAX8925_CHG_IRQ1_MASK		(0x80)
+#define MAX8925_CHG_IRQ2_MASK		(0x81)
+
+/* GPM registers */
+#define MAX8925_ON_OFF_IRQ1		(0x00)
+#define MAX8925_ON_OFF_IRQ2		(0x01)
+#define MAX8925_ON_OFF_IRQ1_MASK	(0x02)
+#define MAX8925_ON_OFF_IRQ2_MASK	(0x03)
+
+/* Touch registers */
+#define MAX8925_TSC_IRQ			(0x00)
+#define MAX8925_TSC_IRQ_MASK		(0x01)
+
+/* RTC registers */
+#define MAX8925_RTC_STATUS		(0x1a)
+#define MAX8925_RTC_IRQ			(0x1c)
+#define MAX8925_RTC_IRQ_MASK		(0x1d)
+
+/* bit definitions */
+#define CHG_IRQ1_MASK			(0x07)
+#define CHG_IRQ2_MASK			(0xff)
+#define ON_OFF_IRQ1_MASK		(0xff)
+#define ON_OFF_IRQ2_MASK		(0x03)
+#define TSC_IRQ_MASK			(0x03)
+#define RTC_IRQ_MASK			(0x0c)
+
+#define MAX8925_NUM_IRQ			(32)
+
+#define MAX8925_NAME_SIZE		(32)
+
+enum {
+	MAX8925_INVALID = 0,
+	MAX8925_RTC,
+	MAX8925_ADC,
+	MAX8925_GPM,	/* general power management */
+	MAX8925_MAX,
+};
+
+#define MAX8925_IRQ_VCHG_OVP		(0)
+#define MAX8925_IRQ_VCHG_F		(1)
+#define MAX8925_IRQ_VCHG_R		(2)
+#define MAX8925_IRQ_VCHG_THM_OK_R	(8)
+#define MAX8925_IRQ_VCHG_THM_OK_F	(9)
+#define MAX8925_IRQ_VCHG_BATTLOW_F	(10)
+#define MAX8925_IRQ_VCHG_BATTLOW_R	(11)
+#define MAX8925_IRQ_VCHG_RST		(12)
+#define MAX8925_IRQ_VCHG_DONE		(13)
+#define MAX8925_IRQ_VCHG_TOPOFF		(14)
+#define MAX8925_IRQ_VCHG_TMR_FAULT	(15)
+#define MAX8925_IRQ_GPM_RSTIN		(16)
+#define MAX8925_IRQ_GPM_MPL		(17)
+#define MAX8925_IRQ_GPM_SW_3SEC		(18)
+#define MAX8925_IRQ_GPM_EXTON_F		(19)
+#define MAX8925_IRQ_GPM_EXTON_R		(20)
+#define MAX8925_IRQ_GPM_SW_1SEC		(21)
+#define MAX8925_IRQ_GPM_SW_F		(22)
+#define MAX8925_IRQ_GPM_SW_R		(23)
+#define MAX8925_IRQ_GPM_SYSCKEN_F	(24)
+#define MAX8925_IRQ_GPM_SYSCKEN_R	(25)
+
+#define MAX8925_IRQ_TSC_STICK		(0)
+#define MAX8925_IRQ_TSC_NSTICK		(1)
+
+struct max8925_irq {
+	irq_handler_t		handler;
+	void			*data;
+};
+
+struct max8925_chip {
+	struct device		*dev;
+	struct mutex		io_lock;
+	struct mutex		irq_lock;
+	struct i2c_client	*i2c;
+	struct max8925_irq	irq[MAX8925_NUM_IRQ];
+
+	char			name[MAX8925_NAME_SIZE];
+	int			chip_id;
+	int			chip_irq;
+};
+
+struct max8925_platform_data {
+	int	chip_id;
+	int	chip_irq;
+};
+
+extern int max8925_reg_read(struct i2c_client *, int);
+extern int max8925_reg_write(struct i2c_client *, int, unsigned char);
+extern int max8925_bulk_read(struct i2c_client *, int, int, unsigned char *);
+extern int max8925_bulk_write(struct i2c_client *, int, int, unsigned char *);
+extern int max8925_set_bits(struct i2c_client *, int, unsigned char,
+			unsigned char);
+#endif /* __LINUX_MFD_MAX8925_H */
+
-- 
1.5.6.5

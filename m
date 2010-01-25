From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 06:28:57 -0500
Subject: [PATCH] mfd: update irq handler in max8925
Message-ID: <mailman.168.1264417708.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update thread irq handler. Simply the interface of using thread irq.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/max8925-core.c  |  696 ++++++++++++++++++++++++++++++-------------
 include/linux/mfd/max8925.h |  145 +++++++---
 2 files changed, 587 insertions(+), 254 deletions(-)

diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index f36c494..0b979c0 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -1,7 +1,7 @@
 /*
  * Base driver for Maxim MAX8925
  *
- * Copyright (C) 2009 Marvell International Ltd.
+ * Copyright (C) 2009-2010 Marvell International Ltd.
  *	Haojian Zhuang <haojian.zhuang@marvell.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -12,13 +12,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/max8925.h>

-#define IRQ_MODE_STATUS		0
-#define IRQ_MODE_MASK		1
+#include <linux/delay.h>

 static struct resource backlight_resources[] = {
 	{
@@ -56,6 +56,42 @@ static struct mfd_cell touch_devs[] = {
 	},
 };

+static struct resource power_supply_resources[] = {
+	{
+		.name	= "max8925-power",
+		.start	= MAX8925_CHG_IRQ1,
+		.end	= MAX8925_CHG_IRQ1,
+		.flags	= IORESOURCE_IO,
+	},
+};
+
+static struct mfd_cell power_devs[] = {
+	{
+		.name		= "max8925-power",
+		.num_resources	= 1,
+		.resources	= &power_supply_resources[0],
+		.id		= -1,
+	},
+};
+
+static struct resource rtc_resources[] = {
+	{
+		.name	= "max8925-rtc",
+		.start	= MAX8925_RTC_IRQ,
+		.end	= MAX8925_RTC_IRQ,
+		.flags	= IORESOURCE_IO,
+	},
+};
+
+static struct mfd_cell rtc_devs[] = {
+	{
+		.name		= "max8925-rtc",
+		.num_resources	= 1,
+		.resources	= &rtc_resources[0],
+		.id		= -1,
+	},
+};
+
 #define MAX8925_REG_RESOURCE(_start, _end)	\
 {						\
 	.start	= MAX8925_##_start,		\
@@ -123,203 +159,468 @@ static struct mfd_cell regulator_devs[] = {
 	MAX8925_REG_DEVS(LDO20),
 };

-static int __get_irq_offset(struct max8925_chip *chip, int irq, int mode,
-			    int *offset, int *bit)
+enum {
+	FLAGS_ADC = 1,	/* register in ADC component */
+	FLAGS_RTC,	/* register in RTC component */
+};
+
+struct max8925_irq_data {
+	int	reg;
+	int	mask_reg;
+	int	enable;		/* enable or not */
+	int	offs;		/* bit offset in mask register */
+	int	flags;
+	int	tsc_irq;
+};
+
+static struct max8925_irq_data max8925_irqs[] = {
+	[MAX8925_IRQ_VCHG_DC_OVP] = {
+		.reg		= MAX8925_CHG_IRQ1,
+		.mask_reg	= MAX8925_CHG_IRQ1_MASK,
+		.offs		= 1 << 0,
+	},
+	[MAX8925_IRQ_VCHG_DC_F] = {
+		.reg		= MAX8925_CHG_IRQ1,
+		.mask_reg	= MAX8925_CHG_IRQ1_MASK,
+		.offs		= 1 << 1,
+	},
+	[MAX8925_IRQ_VCHG_DC_R] = {
+		.reg		= MAX8925_CHG_IRQ1,
+		.mask_reg	= MAX8925_CHG_IRQ1_MASK,
+		.offs		= 1 << 2,
+	},
+	[MAX8925_IRQ_VCHG_USB_OVP] = {
+		.reg		= MAX8925_CHG_IRQ1,
+		.mask_reg	= MAX8925_CHG_IRQ1_MASK,
+		.offs		= 1 << 3,
+	},
+	[MAX8925_IRQ_VCHG_USB_F] =  {
+		.reg		= MAX8925_CHG_IRQ1,
+		.mask_reg	= MAX8925_CHG_IRQ1_MASK,
+		.offs		= 1 << 4,
+	},
+	[MAX8925_IRQ_VCHG_USB_R] = {
+		.reg		= MAX8925_CHG_IRQ1,
+		.mask_reg	= MAX8925_CHG_IRQ1_MASK,
+		.offs		= 1 << 5,
+	},
+	[MAX8925_IRQ_VCHG_THM_OK_R] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 0,
+	},
+	[MAX8925_IRQ_VCHG_THM_OK_F] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 1,
+	},
+	[MAX8925_IRQ_VCHG_SYSLOW_F] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 2,
+	},
+	[MAX8925_IRQ_VCHG_SYSLOW_R] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 3,
+	},
+	[MAX8925_IRQ_VCHG_RST] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 4,
+	},
+	[MAX8925_IRQ_VCHG_DONE] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 5,
+	},
+	[MAX8925_IRQ_VCHG_TOPOFF] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 6,
+	},
+	[MAX8925_IRQ_VCHG_TMR_FAULT] = {
+		.reg		= MAX8925_CHG_IRQ2,
+		.mask_reg	= MAX8925_CHG_IRQ2_MASK,
+		.offs		= 1 << 7,
+	},
+	[MAX8925_IRQ_GPM_RSTIN] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 0,
+	},
+	[MAX8925_IRQ_GPM_MPL] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 1,
+	},
+	[MAX8925_IRQ_GPM_SW_3SEC] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 2,
+	},
+	[MAX8925_IRQ_GPM_EXTON_F] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 3,
+	},
+	[MAX8925_IRQ_GPM_EXTON_R] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 4,
+	},
+	[MAX8925_IRQ_GPM_SW_1SEC] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 5,
+	},
+	[MAX8925_IRQ_GPM_SW_F] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 6,
+	},
+	[MAX8925_IRQ_GPM_SW_R] = {
+		.reg		= MAX8925_ON_OFF_IRQ1,
+		.mask_reg	= MAX8925_ON_OFF_IRQ1_MASK,
+		.offs		= 1 << 7,
+	},
+	[MAX8925_IRQ_GPM_SYSCKEN_F] = {
+		.reg		= MAX8925_ON_OFF_IRQ2,
+		.mask_reg	= MAX8925_ON_OFF_IRQ2_MASK,
+		.offs		= 1 << 0,
+	},
+	[MAX8925_IRQ_GPM_SYSCKEN_R] = {
+		.reg		= MAX8925_ON_OFF_IRQ2,
+		.mask_reg	= MAX8925_ON_OFF_IRQ2_MASK,
+		.offs		= 1 << 1,
+	},
+	[MAX8925_IRQ_RTC_ALARM1] = {
+		.reg		= MAX8925_RTC_IRQ,
+		.mask_reg	= MAX8925_RTC_IRQ_MASK,
+		.offs		= 1 << 2,
+		.flags		= FLAGS_RTC,
+	},
+	[MAX8925_IRQ_RTC_ALARM0] = {
+		.reg		= MAX8925_RTC_IRQ,
+		.mask_reg	= MAX8925_RTC_IRQ_MASK,
+		.offs		= 1 << 3,
+		.flags		= FLAGS_RTC,
+	},
+	[MAX8925_IRQ_TSC_STICK] = {
+		.reg		= MAX8925_TSC_IRQ,
+		.mask_reg	= MAX8925_TSC_IRQ_MASK,
+		.offs		= 1 << 0,
+		.flags		= FLAGS_ADC,
+		.tsc_irq	= 1,
+	},
+	[MAX8925_IRQ_TSC_NSTICK] = {
+		.reg		= MAX8925_TSC_IRQ,
+		.mask_reg	= MAX8925_TSC_IRQ_MASK,
+		.offs		= 1 << 1,
+		.flags		= FLAGS_ADC,
+		.tsc_irq	= 1,
+	},
+};
+
+static inline struct max8925_irq_data *irq_to_max8925(struct
max8925_chip *chip,
+						      int irq)
 {
-	if (!offset || !bit)
-		return -EINVAL;
+	return &max8925_irqs[irq - chip->irq_base];
+}

-	switch (chip->chip_id) {
-	case MAX8925_GPM:
-		*bit = irq % BITS_PER_BYTE;
-		if (irq < (BITS_PER_BYTE << 1)) {	/* irq = [0,15] */
-			*offset = (mode) ? MAX8925_CHG_IRQ1_MASK
-				: MAX8925_CHG_IRQ1;
-			if (irq >= BITS_PER_BYTE)
-				(*offset)++;
-		} else {				/* irq = [16,31] */
-			*offset = (mode) ? MAX8925_ON_OFF_IRQ1_MASK
-				: MAX8925_ON_OFF_IRQ1;
-			if (irq >= (BITS_PER_BYTE * 3))
-				(*offset)++;
+static irqreturn_t max8925_irq(int irq, void *data)
+{
+	struct max8925_chip *chip = data;
+	struct max8925_irq_data *irq_data;
+	struct i2c_client *i2c;
+	int read_reg = -1, value = 0;
+	int i;
+
+	/* clear status on nIRQ pin in platform */
+	if (chip->clear_irq)
+		chip->clear_irq();
+
+	for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
+		irq_data = &max8925_irqs[i];
+		/* TSC IRQ should be serviced in max8925_tsc_irq() */
+		if (irq_data->tsc_irq)
+			continue;
+		if (irq_data->flags == FLAGS_RTC)
+			i2c = chip->rtc;
+		else if (irq_data->flags == FLAGS_ADC)
+			i2c = chip->adc;
+		else
+			i2c = chip->i2c;
+		if (read_reg != irq_data->reg) {
+			read_reg = irq_data->reg;
+			value = max8925_reg_read(i2c, irq_data->reg);
+		}
+		if (value & irq_data->enable)
+			handle_nested_irq(chip->irq_base + i);
+		else if (value & irq_data->offs) {
+			dev_err(chip->dev, "Noboday cares IRQ #%d. Mask it\n",
+				chip->irq_base + i);
+			max8925_set_bits(i2c, irq_data->mask_reg,
+					irq_data->offs, irq_data->offs);
 		}
-		break;
-	case MAX8925_ADC:
-		*bit = irq % BITS_PER_BYTE;
-		*offset = (mode) ? MAX8925_TSC_IRQ_MASK : MAX8925_TSC_IRQ;
-		break;
-	default:
-		goto out;
 	}
-	return 0;
-out:
-	dev_err(chip->dev, "Wrong irq #%d is assigned\n", irq);
-	return -EINVAL;
+	return IRQ_HANDLED;
 }

-static int __check_irq(int irq)
+static irqreturn_t max8925_tsc_irq(int irq, void *data)
 {
-	if ((irq < 0) || (irq >= MAX8925_NUM_IRQ))
-		return -EINVAL;
-	return 0;
+	struct max8925_chip *chip = data;
+	struct max8925_irq_data *irq_data;
+	struct i2c_client *i2c;
+	int read_reg = -1, value = 0;
+	int i;
+
+	/* clear status on nTIRQ pin in platform */
+	if (chip->clear_tsc_irq)
+		chip->clear_tsc_irq();
+
+	for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
+		irq_data = &max8925_irqs[i];
+		/* non TSC IRQ should be serviced in max8925_irq() */
+		if (!irq_data->tsc_irq)
+			continue;
+		if (irq_data->flags == FLAGS_RTC)
+			i2c = chip->rtc;
+		else if (irq_data->flags == FLAGS_ADC)
+			i2c = chip->adc;
+		else
+			i2c = chip->i2c;
+		if (read_reg != irq_data->reg) {
+			read_reg = irq_data->reg;
+			value = max8925_reg_read(i2c, irq_data->reg);
+		}
+		if (value & irq_data->enable)
+			handle_nested_irq(chip->irq_base + i);
+		else if (value & irq_data->offs) {
+			dev_err(chip->dev, "Noboday cares IRQ #%d. Mask it\n",
+				chip->irq_base + i);
+			max8925_set_bits(i2c, irq_data->mask_reg,
+					irq_data->offs, irq_data->offs);
+		}
+	}
+	return IRQ_HANDLED;
 }

-int max8925_mask_irq(struct max8925_chip *chip, int irq)
+static void max8925_irq_lock(unsigned int irq)
 {
-	int offset, bit, ret;
+	struct max8925_chip *chip = get_irq_chip_data(irq);

-	ret = __get_irq_offset(chip, irq, IRQ_MODE_MASK, &offset, &bit);
-	if (ret < 0)
-		return ret;
-	ret = max8925_set_bits(chip->i2c, offset, 1 << bit, 1 << bit);
-	return ret;
+	mutex_lock(&chip->irq_lock);
 }

-int max8925_unmask_irq(struct max8925_chip *chip, int irq)
+static void max8925_irq_sync_unlock(unsigned int irq)
 {
-	int offset, bit, ret;
+	struct max8925_chip *chip = get_irq_chip_data(irq);
+	struct max8925_irq_data *irq_data;
+	static unsigned char cache_chg[2] = {0xff, 0xff};
+	static unsigned char cache_on[2] = {0xff, 0xff};
+	static unsigned char cache_rtc = 0xff, cache_tsc = 0xff;
+	unsigned char irq_chg[2], irq_on[2];
+	unsigned char irq_rtc, irq_tsc;
+	int i;
+
+	/* Load cached value. In initial, all IRQs are masked */
+	irq_chg[0] = cache_chg[0];
+	irq_chg[1] = cache_chg[1];
+	irq_on[0] = cache_on[0];
+	irq_on[1] = cache_on[1];
+	irq_rtc = cache_rtc;
+	irq_tsc = cache_tsc;
+	for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
+		irq_data = &max8925_irqs[i];
+		switch (irq_data->mask_reg) {
+		case MAX8925_CHG_IRQ1_MASK:
+			irq_chg[0] &= irq_data->enable;
+			break;
+		case MAX8925_CHG_IRQ2_MASK:
+			irq_chg[1] &= irq_data->enable;
+			break;
+		case MAX8925_ON_OFF_IRQ1_MASK:
+			irq_on[0] &= irq_data->enable;
+			break;
+		case MAX8925_ON_OFF_IRQ2_MASK:
+			irq_on[1] &= irq_data->enable;
+			break;
+		case MAX8925_RTC_IRQ_MASK:
+			irq_rtc &= irq_data->enable;
+			break;
+		case MAX8925_TSC_IRQ_MASK:
+			irq_tsc &= irq_data->enable;
+			break;
+		default:
+			dev_err(chip->dev, "wrong IRQ\n");
+			break;
+		}
+	}
+	/* update mask into registers */
+	if (cache_chg[0] != irq_chg[0]) {
+		cache_chg[0] = irq_chg[0];
+		max8925_reg_write(chip->i2c, MAX8925_CHG_IRQ1_MASK,
+			irq_chg[0]);
+	}
+	if (cache_chg[1] != irq_chg[1]) {
+		cache_chg[1] = irq_chg[1];
+		max8925_reg_write(chip->i2c, MAX8925_CHG_IRQ2_MASK,
+			irq_chg[1]);
+	}
+	if (cache_on[0] != irq_on[0]) {
+		cache_on[0] = irq_on[0];
+		max8925_reg_write(chip->i2c, MAX8925_ON_OFF_IRQ1_MASK,
+				irq_on[0]);
+	}
+	if (cache_on[1] != irq_on[1]) {
+		cache_on[1] = irq_on[1];
+		max8925_reg_write(chip->i2c, MAX8925_ON_OFF_IRQ2_MASK,
+				irq_on[1]);
+	}
+	if (cache_rtc != irq_rtc) {
+		cache_rtc = irq_rtc;
+		max8925_reg_write(chip->rtc, MAX8925_RTC_IRQ_MASK, irq_rtc);
+	}
+	if (cache_tsc != irq_tsc) {
+		cache_tsc = irq_tsc;
+		max8925_reg_write(chip->adc, MAX8925_TSC_IRQ_MASK, irq_tsc);
+	}

-	ret = __get_irq_offset(chip, irq, IRQ_MODE_MASK, &offset, &bit);
-	if (ret < 0)
-		return ret;
-	ret = max8925_set_bits(chip->i2c, offset, 1 << bit, 0);
-	return ret;
+	mutex_unlock(&chip->irq_lock);
 }

-#define INT_STATUS_NUM		(MAX8925_NUM_IRQ / BITS_PER_BYTE)
-
-static irqreturn_t max8925_irq_thread(int irq, void *data)
+static void max8925_irq_enable(unsigned int irq)
 {
-	struct max8925_chip *chip = data;
-	unsigned long irq_status[INT_STATUS_NUM];
-	unsigned char status_buf[INT_STATUS_NUM << 1];
-	int i, ret;
-
-	memset(irq_status, 0, sizeof(unsigned long) * INT_STATUS_NUM);
-
-	/* all these interrupt status registers are read-only */
-	switch (chip->chip_id) {
-	case MAX8925_GPM:
-		ret = max8925_bulk_read(chip->i2c, MAX8925_CHG_IRQ1,
-					4, status_buf);
-		if (ret < 0)
-			goto out;
-		ret = max8925_bulk_read(chip->i2c, MAX8925_ON_OFF_IRQ1,
-					2, &status_buf[4]);
-		if (ret < 0)
-			goto out;
-		ret = max8925_bulk_read(chip->i2c, MAX8925_ON_OFF_IRQ2,
-					2, &status_buf[6]);
-		if (ret < 0)
-			goto out;
-		/* clear masked interrupt status */
-		status_buf[0] &= (~status_buf[2] & CHG_IRQ1_MASK);
-		irq_status[0] |= status_buf[0];
-		status_buf[1] &= (~status_buf[3] & CHG_IRQ2_MASK);
-		irq_status[0] |= (status_buf[1] << BITS_PER_BYTE);
-		status_buf[4] &= (~status_buf[5] & ON_OFF_IRQ1_MASK);
-		irq_status[0] |= (status_buf[4] << (BITS_PER_BYTE * 2));
-		status_buf[6] &= (~status_buf[7] & ON_OFF_IRQ2_MASK);
-		irq_status[0] |= (status_buf[6] << (BITS_PER_BYTE * 3));
-		break;
-	case MAX8925_ADC:
-		ret = max8925_bulk_read(chip->i2c, MAX8925_TSC_IRQ,
-					2, status_buf);
-		if (ret < 0)
-			goto out;
-		/* clear masked interrupt status */
-		status_buf[0] &= (~status_buf[1] & TSC_IRQ_MASK);
-		irq_status[0] |= status_buf[0];
-		break;
-	default:
-		goto out;
-	}
-
-	for_each_bit(i, &irq_status[0], MAX8925_NUM_IRQ) {
-		clear_bit(i, irq_status);
-		dev_dbg(chip->dev, "Servicing IRQ #%d in %s\n", i, chip->name);
-
-		mutex_lock(&chip->irq_lock);
-		if (chip->irq[i].handler)
-			chip->irq[i].handler(i, chip->irq[i].data);
-		else {
-			max8925_mask_irq(chip, i);
-			dev_err(chip->dev, "Noboday cares IRQ #%d in %s. "
-				"Now mask it.\n", i, chip->name);
-		}
-		mutex_unlock(&chip->irq_lock);
-	}
-out:
-	return IRQ_HANDLED;
+	struct max8925_chip *chip = get_irq_chip_data(irq);
+	max8925_irqs[irq - chip->irq_base].enable
+		= max8925_irqs[irq - chip->irq_base].offs;
 }

-int max8925_request_irq(struct max8925_chip *chip, int irq,
-			irq_handler_t handler, void *data)
+static void max8925_irq_disable(unsigned int irq)
 {
-	if ((__check_irq(irq) < 0) || !handler)
-		return -EINVAL;
-
-	mutex_lock(&chip->irq_lock);
-	chip->irq[irq].handler = handler;
-	chip->irq[irq].data = data;
-	mutex_unlock(&chip->irq_lock);
-	return 0;
+	struct max8925_chip *chip = get_irq_chip_data(irq);
+	max8925_irqs[irq - chip->irq_base].enable = 0;
 }
-EXPORT_SYMBOL(max8925_request_irq);

-int max8925_free_irq(struct max8925_chip *chip, int irq)
+static struct irq_chip max8925_irq_chip = {
+	.name		= "max8925",
+	.bus_lock	= max8925_irq_lock,
+	.bus_sync_unlock = max8925_irq_sync_unlock,
+	.enable		= max8925_irq_enable,
+	.disable	= max8925_irq_disable,
+};
+
+static int max8925_irq_init(struct max8925_chip *chip, int irq,
+			    struct max8925_platform_data *pdata)
 {
-	if (__check_irq(irq) < 0)
+	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	struct irq_desc *desc;
+	int i, ret;
+	int __irq;
+
+	if (!pdata || !pdata->irq_base) {
+		dev_warn(chip->dev, "No interrupt support on IRQ base\n");
 		return -EINVAL;
+	}
+	/* clear all interrupts */
+	max8925_reg_read(chip->i2c, MAX8925_CHG_IRQ1);
+	max8925_reg_read(chip->i2c, MAX8925_CHG_IRQ2);
+	max8925_reg_read(chip->i2c, MAX8925_ON_OFF_IRQ1);
+	max8925_reg_read(chip->i2c, MAX8925_ON_OFF_IRQ2);
+	max8925_reg_read(chip->rtc, MAX8925_RTC_IRQ);
+	max8925_reg_read(chip->adc, MAX8925_TSC_IRQ);
+	/* mask all interrupts */
+	max8925_reg_write(chip->rtc, MAX8925_ALARM0_CNTL, 0);
+	max8925_reg_write(chip->rtc, MAX8925_ALARM1_CNTL, 0);
+	max8925_reg_write(chip->i2c, MAX8925_CHG_IRQ1_MASK, 0xff);
+	max8925_reg_write(chip->i2c, MAX8925_CHG_IRQ2_MASK, 0xff);
+	max8925_reg_write(chip->i2c, MAX8925_ON_OFF_IRQ1_MASK, 0xff);
+	max8925_reg_write(chip->i2c, MAX8925_ON_OFF_IRQ2_MASK, 0xff);
+	max8925_reg_write(chip->rtc, MAX8925_RTC_IRQ_MASK, 0xff);
+	max8925_reg_write(chip->adc, MAX8925_TSC_IRQ_MASK, 0xff);
+
+	mutex_init(&chip->irq_lock);
+	chip->core_irq = irq;
+	chip->irq_base = pdata->irq_base;
+	chip->clear_irq = pdata->clear_irq;
+	chip->clear_tsc_irq = pdata->clear_tsc_irq;
+	desc = irq_to_desc(chip->core_irq);
+
+	/* register with genirq */
+	for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
+		__irq = i + chip->irq_base;
+		set_irq_chip_data(__irq, chip);
+		set_irq_chip_and_handler(__irq, &max8925_irq_chip,
+					 handle_edge_irq);
+		set_irq_nested_thread(__irq, 1);
+		set_irq_flags(__irq, IRQF_VALID);
+	}
+	if (!irq) {
+		dev_warn(chip->dev, "No interrupt support on core IRQ\n");
+		goto tsc_irq;
+	}

-	mutex_lock(&chip->irq_lock);
-	chip->irq[irq].handler = NULL;
-	chip->irq[irq].data = NULL;
-	mutex_unlock(&chip->irq_lock);
+	ret = request_threaded_irq(irq, NULL, max8925_irq, flags,
+				   "max8925", chip);
+	if (ret) {
+		dev_err(chip->dev, "Failed to request core IRQ: %d\n", ret);
+		chip->core_irq = 0;
+	}
+tsc_irq:
+	if (!pdata->tsc_irq) {
+		dev_warn(chip->dev, "No interrupt support on TSC IRQ\n");
+		return 0;
+	}
+	chip->tsc_irq = pdata->tsc_irq;
+
+	ret = request_threaded_irq(chip->tsc_irq, NULL, max8925_tsc_irq,
+				   flags, "max8925-tsc", chip);
+	if (ret) {
+		dev_err(chip->dev, "Failed to request TSC IRQ: %d\n", ret);
+		chip->tsc_irq = 0;
+	}
 	return 0;
 }
-EXPORT_SYMBOL(max8925_free_irq);

-static int __devinit device_gpm_init(struct max8925_chip *chip,
-				      struct i2c_client *i2c,
-				      struct max8925_platform_data *pdata)
+int __devinit max8925_device_init(struct max8925_chip *chip,
+				  struct max8925_platform_data *pdata)
 {
 	int ret;

-	/* mask all IRQs */
-	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ1_MASK, 0x7, 0x7);
-	if (ret < 0)
-		goto out;
-	ret = max8925_set_bits(i2c, MAX8925_CHG_IRQ2_MASK, 0xff, 0xff);
-	if (ret < 0)
-		goto out;
-	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ1_MASK, 0xff, 0xff);
-	if (ret < 0)
-		goto out;
-	ret = max8925_set_bits(i2c, MAX8925_ON_OFF_IRQ2_MASK, 0x3, 0x3);
-	if (ret < 0)
-		goto out;
-
-	chip->name = "GPM";
-	memset(chip->irq, 0, sizeof(struct max8925_irq) * MAX8925_NUM_IRQ);
-	ret = request_threaded_irq(i2c->irq, NULL, max8925_irq_thread,
-				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-				"max8925-gpm", chip);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
-		goto out;
+	max8925_irq_init(chip, chip->i2c->irq, pdata);
+
+	if (pdata && (pdata->power || pdata->touch)) {
+		/* enable ADC to control internal reference */
+		max8925_set_bits(chip->i2c, MAX8925_RESET_CNFG, 1, 1);
+		/* enable internal reference for ADC */
+		max8925_set_bits(chip->adc, MAX8925_TSC_CNFG1, 3, 2);
+		/* check for internal reference IRQ */
+		do {
+			ret = max8925_reg_read(chip->adc, MAX8925_TSC_IRQ);
+		} while (ret & MAX8925_NREF_OK);
+		/* enaable ADC scheduler, interval is 1 second */
+		max8925_set_bits(chip->adc, MAX8925_ADC_SCHED, 3, 2);
 	}
-	chip->chip_irq = i2c->irq;

-	/* enable hard-reset for ONKEY power-off */
-	max8925_set_bits(i2c, MAX8925_SYSENSEL, 0x80, 0x80);
+	/* enable Momentary Power Loss */
+	max8925_set_bits(chip->rtc, MAX8925_MPL_CNTL, 1 << 4, 1 << 4);

-	ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
-			      ARRAY_SIZE(regulator_devs),
-			      &regulator_resources[0], 0);
+	ret = mfd_add_devices(chip->dev, 0, &rtc_devs[0],
+			      ARRAY_SIZE(rtc_devs),
+			      &rtc_resources[0], 0);
 	if (ret < 0) {
-		dev_err(chip->dev, "Failed to add regulator subdev\n");
-		goto out_irq;
+		dev_err(chip->dev, "Failed to add rtc subdev\n");
+		goto out;
+	}
+	if (pdata && pdata->regulator[0]) {
+		ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
+				      ARRAY_SIZE(regulator_devs),
+				      &regulator_resources[0], 0);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add regulator subdev\n");
+			goto out_dev;
+		}
 	}

 	if (pdata && pdata->backlight) {
@@ -331,35 +632,17 @@ static int __devinit device_gpm_init(struct
max8925_chip *chip,
 			goto out_dev;
 		}
 	}
-	return 0;
-out_dev:
-	mfd_remove_devices(chip->dev);
-out_irq:
-	if (chip->chip_irq)
-		free_irq(chip->chip_irq, chip);
-out:
-	return ret;
-}
-
-static int __devinit device_adc_init(struct max8925_chip *chip,
-				     struct i2c_client *i2c,
-				     struct max8925_platform_data *pdata)
-{
-	int ret;
-
-	/* mask all IRQs */
-	ret = max8925_set_bits(i2c, MAX8925_TSC_IRQ_MASK, 3, 3);

-	chip->name = "ADC";
-	memset(chip->irq, 0, sizeof(struct max8925_irq) * MAX8925_NUM_IRQ);
-	ret = request_threaded_irq(i2c->irq, NULL, max8925_irq_thread,
-				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-				"max8925-adc", chip);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
-		goto out;
+	if (pdata && pdata->power) {
+		ret = mfd_add_devices(chip->dev, 0, &power_devs[0],
+					ARRAY_SIZE(power_devs),
+					&power_supply_resources[0], 0);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add power supply "
+				"subdev\n");
+			goto out_dev;
+		}
 	}
-	chip->chip_irq = i2c->irq;

 	if (pdata && pdata->touch) {
 		ret = mfd_add_devices(chip->dev, 0, &touch_devs[0],
@@ -367,38 +650,27 @@ static int __devinit device_adc_init(struct
max8925_chip *chip,
 				      &touch_resources[0], 0);
 		if (ret < 0) {
 			dev_err(chip->dev, "Failed to add touch subdev\n");
-			goto out_irq;
+			goto out_dev;
 		}
 	}
+
 	return 0;
-out_irq:
-	if (chip->chip_irq)
-		free_irq(chip->chip_irq, chip);
+out_dev:
+	mfd_remove_devices(chip->dev);
 out:
 	return ret;
 }

-int __devinit max8925_device_init(struct max8925_chip *chip,
-				  struct max8925_platform_data *pdata)
+void __devexit max8925_device_exit(struct max8925_chip *chip)
 {
-	switch (chip->chip_id) {
-	case MAX8925_GPM:
-		device_gpm_init(chip, chip->i2c, pdata);
-		break;
-	case MAX8925_ADC:
-		device_adc_init(chip, chip->i2c, pdata);
-		break;
-	}
-	return 0;
-}
-
-void max8925_device_exit(struct max8925_chip *chip)
-{
-	if (chip->chip_irq >= 0)
-		free_irq(chip->chip_irq, chip);
+	if (chip->core_irq)
+		free_irq(chip->core_irq, chip);
+	if (chip->tsc_irq)
+		free_irq(chip->tsc_irq, chip);
 	mfd_remove_devices(chip->dev);
 }

+
 MODULE_DESCRIPTION("PMIC Driver for Maxim MAX8925");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max8925.h b/include/linux/mfd/max8925.h
index b72dbe1..9d02846 100644
--- a/include/linux/mfd/max8925.h
+++ b/include/linux/mfd/max8925.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_MFD_MAX8925_H
 #define __LINUX_MFD_MAX8925_H

+#include <linux/mutex.h>
 #include <linux/interrupt.h>

 /* Unified sub device IDs for MAX8925 */
@@ -39,6 +40,30 @@ enum {
 	MAX8925_ID_LDO18,
 	MAX8925_ID_LDO19,
 	MAX8925_ID_LDO20,
+	MAX8925_ID_MAX,
+};
+
+enum {
+	/*
+	 * Charging current threshold trigger going from fast charge
+	 * to TOPOFF charge. From 5% to 20% of fasting charging current.
+	 */
+	MAX8925_TOPOFF_THR_5PER,
+	MAX8925_TOPOFF_THR_10PER,
+	MAX8925_TOPOFF_THR_15PER,
+	MAX8925_TOPOFF_THR_20PER,
+};
+
+enum {
+	/* Fast charging current */
+	MAX8925_FCHG_85MA,
+	MAX8925_FCHG_300MA,
+	MAX8925_FCHG_460MA,
+	MAX8925_FCHG_600MA,
+	MAX8925_FCHG_700MA,
+	MAX8925_FCHG_800MA,
+	MAX8925_FCHG_900MA,
+	MAX8925_FCHG_1000MA,
 };

 /* Charger registers */
@@ -46,12 +71,13 @@ enum {
 #define MAX8925_CHG_IRQ2		(0x7f)
 #define MAX8925_CHG_IRQ1_MASK		(0x80)
 #define MAX8925_CHG_IRQ2_MASK		(0x81)
+#define MAX8925_CHG_STATUS		(0x82)

 /* GPM registers */
 #define MAX8925_SYSENSEL		(0x00)
 #define MAX8925_ON_OFF_IRQ1		(0x01)
 #define MAX8925_ON_OFF_IRQ1_MASK	(0x02)
-#define MAX8925_ON_OFF_STAT		(0x03)
+#define MAX8925_ON_OFF_STATUS		(0x03)
 #define MAX8925_ON_OFF_IRQ2		(0x0d)
 #define MAX8925_ON_OFF_IRQ2_MASK	(0x0e)
 #define MAX8925_RESET_CNFG		(0x0f)
@@ -59,12 +85,18 @@ enum {
 /* Touch registers */
 #define MAX8925_TSC_IRQ			(0x00)
 #define MAX8925_TSC_IRQ_MASK		(0x01)
+#define MAX8925_TSC_CNFG1		(0x02)
+#define MAX8925_ADC_SCHED		(0x10)
 #define MAX8925_ADC_RES_END		(0x6f)

+#define MAX8925_NREF_OK			(1 << 4)
+
 /* RTC registers */
-#define MAX8925_RTC_STATUS		(0x1a)
+#define MAX8925_ALARM0_CNTL		(0x18)
+#define MAX8925_ALARM1_CNTL		(0x19)
 #define MAX8925_RTC_IRQ			(0x1c)
 #define MAX8925_RTC_IRQ_MASK		(0x1d)
+#define MAX8925_MPL_CNTL		(0x1e)

 /* WLED registers */
 #define MAX8925_WLED_MODE_CNTL		(0x84)
@@ -126,45 +158,48 @@ enum {
 #define TSC_IRQ_MASK			(0x03)
 #define RTC_IRQ_MASK			(0x0c)

-#define MAX8925_NUM_IRQ			(32)
+#define MAX8925_GPM_NUM_IRQ		(40)
+#define MAX8925_ADC_NUM_IRQ		(8)
+#define MAX8925_NUM_IRQ			(MAX8925_GPM_NUM_IRQ	\
+					+ MAX8925_ADC_NUM_IRQ)
+
+#define MAX8925_MAX_REGULATOR		(23)

 #define MAX8925_NAME_SIZE		(32)

+/* IRQ definitions */
 enum {
-	MAX8925_INVALID = 0,
-	MAX8925_RTC,
-	MAX8925_ADC,
-	MAX8925_GPM,	/* general power management */
-	MAX8925_MAX,
+	MAX8925_IRQ_VCHG_DC_OVP,
+	MAX8925_IRQ_VCHG_DC_F,
+	MAX8925_IRQ_VCHG_DC_R,
+	MAX8925_IRQ_VCHG_USB_OVP,
+	MAX8925_IRQ_VCHG_USB_F,
+	MAX8925_IRQ_VCHG_USB_R,
+	MAX8925_IRQ_VCHG_THM_OK_R,
+	MAX8925_IRQ_VCHG_THM_OK_F,
+	MAX8925_IRQ_VCHG_SYSLOW_F,
+	MAX8925_IRQ_VCHG_SYSLOW_R,
+	MAX8925_IRQ_VCHG_RST,
+	MAX8925_IRQ_VCHG_DONE,
+	MAX8925_IRQ_VCHG_TOPOFF,
+	MAX8925_IRQ_VCHG_TMR_FAULT,
+	MAX8925_IRQ_GPM_RSTIN,
+	MAX8925_IRQ_GPM_MPL,
+	MAX8925_IRQ_GPM_SW_3SEC,
+	MAX8925_IRQ_GPM_EXTON_F,
+	MAX8925_IRQ_GPM_EXTON_R,
+	MAX8925_IRQ_GPM_SW_1SEC,
+	MAX8925_IRQ_GPM_SW_F,
+	MAX8925_IRQ_GPM_SW_R,
+	MAX8925_IRQ_GPM_SYSCKEN_F,
+	MAX8925_IRQ_GPM_SYSCKEN_R,
+	MAX8925_IRQ_RTC_ALARM1,
+	MAX8925_IRQ_RTC_ALARM0,
+	MAX8925_IRQ_TSC_STICK,
+	MAX8925_IRQ_TSC_NSTICK,
+	MAX8925_NR_IRQS,
 };

-#define MAX8925_IRQ_VCHG_OVP		(0)
-#define MAX8925_IRQ_VCHG_F		(1)
-#define MAX8925_IRQ_VCHG_R		(2)
-#define MAX8925_IRQ_VCHG_THM_OK_R	(8)
-#define MAX8925_IRQ_VCHG_THM_OK_F	(9)
-#define MAX8925_IRQ_VCHG_BATTLOW_F	(10)
-#define MAX8925_IRQ_VCHG_BATTLOW_R	(11)
-#define MAX8925_IRQ_VCHG_RST		(12)
-#define MAX8925_IRQ_VCHG_DONE		(13)
-#define MAX8925_IRQ_VCHG_TOPOFF		(14)
-#define MAX8925_IRQ_VCHG_TMR_FAULT	(15)
-#define MAX8925_IRQ_GPM_RSTIN		(16)
-#define MAX8925_IRQ_GPM_MPL		(17)
-#define MAX8925_IRQ_GPM_SW_3SEC		(18)
-#define MAX8925_IRQ_GPM_EXTON_F		(19)
-#define MAX8925_IRQ_GPM_EXTON_R		(20)
-#define MAX8925_IRQ_GPM_SW_1SEC		(21)
-#define MAX8925_IRQ_GPM_SW_F		(22)
-#define MAX8925_IRQ_GPM_SW_R		(23)
-#define MAX8925_IRQ_GPM_SYSCKEN_F	(24)
-#define MAX8925_IRQ_GPM_SYSCKEN_R	(25)
-
-#define MAX8925_IRQ_TSC_STICK		(0)
-#define MAX8925_IRQ_TSC_NSTICK		(1)
-
-#define MAX8925_MAX_REGULATOR		(23)
-
 struct max8925_irq {
 	irq_handler_t		handler;
 	void			*data;
@@ -172,14 +207,18 @@ struct max8925_irq {

 struct max8925_chip {
 	struct device		*dev;
+	struct i2c_client	*i2c;
+	struct i2c_client	*adc;
+	struct i2c_client	*rtc;
+	struct max8925_irq	irqs[MAX8925_NUM_IRQ];
 	struct mutex		io_lock;
 	struct mutex		irq_lock;
-	struct i2c_client	*i2c;
-	struct max8925_irq	irq[MAX8925_NUM_IRQ];

-	const char		*name;
-	int			chip_id;
-	int			chip_irq;
+	int			irq_base;
+	int			core_irq;
+	int			tsc_irq;
+	int			(*clear_irq)(void);
+	int			(*clear_tsc_irq)(void);
 };

 struct max8925_backlight_pdata {
@@ -192,13 +231,29 @@ struct max8925_touch_pdata {
 	unsigned int		flags;
 };

+struct max8925_power_pdata {
+	int		(*set_charger)(int);
+	unsigned	batt_detect:1;
+	unsigned	topoff_threshold:2;
+	unsigned	fast_charge:3;	/* charge current */
+};
+
+/*
+ * irq_base: stores IRQ base number of MAX8925 in platform
+ * tsc_irq: stores IRQ number of MAX8925 TSC
+ * clear_irq: operation on clearing status of nIRQ pin in platform
+ * clear_tsc_irq: operation on clearing status of nTIRQ pin in platform
+ */
 struct max8925_platform_data {
 	struct max8925_backlight_pdata	*backlight;
 	struct max8925_touch_pdata	*touch;
+	struct max8925_power_pdata	*power;
 	struct regulator_init_data	*regulator[MAX8925_MAX_REGULATOR];

-	int	chip_id;
-	int	chip_irq;
+	int		irq_base;
+	int		tsc_irq;
+	int		(*clear_irq)(void);
+	int		(*clear_tsc_irq)(void);
 };

 extern int max8925_reg_read(struct i2c_client *, int);
@@ -208,6 +263,12 @@ extern int max8925_bulk_write(struct i2c_client
*, int, int, unsigned char *);
 extern int max8925_set_bits(struct i2c_client *, int, unsigned char,
 			unsigned char);

+extern int max8925_request_irq(struct max8925_chip *, int,
+			irq_handler_t, void *);
+extern int max8925_free_irq(struct max8925_chip *, int);
+extern int max8925_mask_irq(struct max8925_chip *, int);
+extern int max8925_unmask_irq(struct max8925_chip *, int);
+
 extern int max8925_device_init(struct max8925_chip *,
 				struct max8925_platform_data *);
 extern void max8925_device_exit(struct max8925_chip *);
-- 
1.5.6.5

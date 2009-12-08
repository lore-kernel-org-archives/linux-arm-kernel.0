From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 8 Dec 2009 11:43:00 -0500
Subject: [PATCH] mfd: add irq support in 88pm860x
Message-ID: <mailman.82.1260364418.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x is a complex PMIC device. It contains touch, charger, sound, rtc,
backlight, led, and so on.

Host communicates to 88PM860x by I2C bus. Use thread irq to support this
usage case.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  229 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/88pm860x.h |   55 +++++-----
 2 files changed, 250 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 72b0030..613d8c1 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -11,6 +11,7 @@

 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
@@ -67,15 +68,212 @@ static struct mfd_cell pm8607_devs[] = {
 	PM8607_REG_DEVS(ldo14, LDO14),
 };

-static void device_8606_init(struct pm860x_chip *chip, struct i2c_client *i2c,
-			     struct pm860x_platform_data *pdata)
+#define CHECK_IRQ(irq)					\
+do {							\
+	if ((irq < 0) || (irq >= PM860X_NUM_IRQ))	\
+		return -EINVAL;				\
+} while (0)
+
+/* IRQs only occur on 88PM8607 */
+int pm860x_mask_irq(struct pm860x_chip *chip, int irq)
 {
+	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
+				: chip->companion;
+	int offset, data, ret;
+
+	CHECK_IRQ(irq);
+
+	offset = (irq >> 3) + PM8607_INT_MASK_1;
+	data = 1 << (irq % 8);
+	ret = pm860x_set_bits(i2c, offset, data, 0);
+
+	return ret;
 }
+EXPORT_SYMBOL(pm860x_mask_irq);

-static void device_8607_init(struct pm860x_chip *chip, struct i2c_client *i2c,
-			     struct pm860x_platform_data *pdata)
+int pm860x_unmask_irq(struct pm860x_chip *chip, int irq)
 {
-	int i, count;
+	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
+				: chip->companion;
+	int offset, data, ret;
+
+	CHECK_IRQ(irq);
+
+	offset = (irq >> 3) + PM8607_INT_MASK_1;
+	data = 1 << (irq % 8);
+	ret = pm860x_set_bits(i2c, offset, data, data);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm860x_unmask_irq);
+
+#define INT_STATUS_NUM		(3)
+
+static irqreturn_t pm8607_irq_thread(int irq, void *data)
+{
+	DECLARE_BITMAP(irq_status, PM860X_NUM_IRQ);
+	struct pm860x_chip *chip = data;
+	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
+				: chip->companion;
+	unsigned char status_buf[INT_STATUS_NUM << 1];
+	unsigned long value;
+	int i, ret;
+
+	irq_status[0] = 0;
+
+	/* read out status register */
+	ret = pm860x_bulk_read(i2c, PM8607_INT_STATUS1,
+				INT_STATUS_NUM << 1, status_buf);
+	if (ret < 0)
+		goto out;
+	if (chip->irq_mode) {
+		/* 0, clear by read. 1, clear by write */
+		ret = pm860x_bulk_write(i2c, PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+		if (ret < 0)
+			goto out;
+	}
+
+	/* clear masked interrupt status */
+	for (i = 0, value = 0; i < INT_STATUS_NUM; i++) {
+		status_buf[i] &= status_buf[i + INT_STATUS_NUM];
+		irq_status[0] |= status_buf[i] << (i * 8);
+	}
+
+	while (!bitmap_empty(irq_status, PM860X_NUM_IRQ)) {
+		irq = find_first_bit(irq_status, PM860X_NUM_IRQ);
+		clear_bit(irq, irq_status);
+		dev_dbg(chip->dev, "Servicing IRQ #%d\n", irq);
+
+		mutex_lock(&chip->irq_lock);
+		if (chip->irq[irq].handler)
+			chip->irq[irq].handler(irq, chip->irq[irq].data);
+		else {
+			pm860x_mask_irq(chip, irq);
+			dev_err(chip->dev, "Nobody cares IRQ %d. "
+				"Now mask it.\n", irq);
+			for (i = 0; i < (INT_STATUS_NUM << 1); i++) {
+				dev_err(chip->dev, "status[%d]:%x\n", i,
+					status_buf[i]);
+			}
+		}
+		mutex_unlock(&chip->irq_lock);
+	}
+out:
+	return IRQ_HANDLED;
+}
+
+int pm860x_request_irq(struct pm860x_chip *chip, int irq,
+		       irq_handler_t handler, void *data)
+{
+	CHECK_IRQ(irq);
+	if (!handler)
+		return -EINVAL;
+
+	mutex_lock(&chip->irq_lock);
+	chip->irq[irq].handler = handler;
+	chip->irq[irq].data = data;
+	mutex_unlock(&chip->irq_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pm860x_request_irq);
+
+int pm860x_free_irq(struct pm860x_chip *chip, int irq)
+{
+	CHECK_IRQ(irq);
+
+	mutex_lock(&chip->irq_lock);
+	chip->irq[irq].handler = NULL;
+	chip->irq[irq].data = NULL;
+	mutex_unlock(&chip->irq_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pm860x_free_irq);
+
+static int __devinit device_irq_init(struct pm860x_chip *chip,
+				     struct pm860x_platform_data *pdata)
+{
+	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
+				: chip->companion;
+	unsigned char status_buf[INT_STATUS_NUM];
+	int data, mask, ret = -EINVAL;
+
+	mutex_init(&chip->irq_lock);
+
+	mask = PM8607_B0_MISC1_INV_INT | PM8607_B0_MISC1_INT_CLEAR
+		| PM8607_B0_MISC1_INT_MASK;
+	data = 0;
+	chip->irq_mode = 0;
+	if (pdata && pdata->irq_mode) {
+		/*
+		 * irq_mode defines the way of clearing interrupt. If it's 1,
+		 * clear IRQ by write. Otherwise, clear it by read.
+		 * This control bit is valid from 88PM8607 B0 steping.
+		 */
+		data |= PM8607_B0_MISC1_INT_CLEAR;
+		chip->irq_mode = 1;
+	}
+	ret = pm860x_set_bits(i2c, PM8607_B0_MISC1, mask, data);
+	if (ret < 0)
+		goto out;
+
+	/* mask all IRQs */
+	memset(status_buf, 0, INT_STATUS_NUM);
+	ret = pm860x_bulk_write(i2c, PM8607_INT_MASK_1,
+				INT_STATUS_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	if (chip->irq_mode) {
+		/* clear interrupt status by write */
+		memset(status_buf, 0xFF, INT_STATUS_NUM);
+		ret = pm860x_bulk_write(i2c, PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+	} else {
+		/* clear interrupt status by read */
+		ret = pm860x_bulk_read(i2c, PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+	}
+	if (ret < 0)
+		goto out;
+
+	memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
+
+	if (i2c == NULL)
+		goto out;
+
+	ret = request_threaded_irq(i2c->irq, NULL, pm8607_irq_thread,
+				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"88PM8607", chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ #%d.\n", i2c->irq);
+		goto out;
+	}
+	chip->chip_irq = ret;
+	return 0;
+out:
+	return ret;
+}
+
+static void __devexit device_irq_exit(struct pm860x_chip *chip)
+{
+	if (chip->chip_irq >= 0)
+		free_irq(chip->chip_irq, chip);
+}
+
+static void __devinit device_8606_init(struct pm860x_chip *chip,
+				       struct i2c_client *i2c,
+				       struct pm860x_platform_data *pdata)
+{
+}
+
+static void __devinit device_8607_init(struct pm860x_chip *chip,
+				       struct i2c_client *i2c,
+				       struct pm860x_platform_data *pdata)
+{
+	int i, count, data;
 	int ret;

 	ret = pm860x_reg_read(i2c, PM8607_CHIP_ID);
@@ -91,7 +289,6 @@ static void device_8607_init(struct pm860x_chip
*chip, struct i2c_client *i2c,
 			"Chip ID: %02x\n", ret);
 		goto out;
 	}
-	chip->chip_version = ret;

 	ret = pm860x_reg_read(i2c, PM8607_BUCK3);
 	if (ret < 0) {
@@ -101,12 +298,26 @@ static void device_8607_init(struct pm860x_chip
*chip, struct i2c_client *i2c,
 	if (ret & PM8607_BUCK3_DOUBLE)
 		chip->buck3_double = 1;

-	ret = pm860x_reg_read(i2c, PM8607_MISC1);
+	ret = pm860x_reg_read(i2c, PM8607_B0_MISC1);
 	if (ret < 0) {
 		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
 		goto out;
 	}

+	if (pdata && (pdata->i2c_port == PI2C_PORT))
+		data = PM8607_B0_MISC1_PI2C;
+	else
+		data = 0;
+	ret = pm860x_set_bits(i2c, PM8607_B0_MISC1, PM8607_B0_MISC1_PI2C, data);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to access MISC1:%d\n", ret);
+		goto out;
+	}
+
+	ret = device_irq_init(chip, pdata);
+	if (ret < 0)
+		goto out;
+
 	count = ARRAY_SIZE(pm8607_devs);
 	for (i = 0; i < count; i++) {
 		ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
@@ -123,6 +334,8 @@ out:
 int pm860x_device_init(struct pm860x_chip *chip,
 		       struct pm860x_platform_data *pdata)
 {
+	chip->chip_irq = -EINVAL;
+
 	switch (chip->id) {
 	case CHIP_PM8606:
 		device_8606_init(chip, chip->client, pdata);
@@ -142,11 +355,13 @@ int pm860x_device_init(struct pm860x_chip *chip,
 			break;
 		}
 	}
+
 	return 0;
 }

 void pm860x_device_exit(struct pm860x_chip *chip)
 {
+	device_irq_exit(chip);
 	mfd_remove_devices(chip->dev);
 }

diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index b648b9f..b5ab948 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -12,6 +12,8 @@
 #ifndef __LINUX_MFD_88PM860X_H
 #define __LINUX_MFD_88PM860X_H

+#include <linux/interrupt.h>
+
 enum {
 	CHIP_INVALID = 0,
 	CHIP_PM8606,
@@ -109,33 +111,10 @@ enum {

 /* Misc Registers */
 #define PM8607_CHIP_ID			(0x00)
+#define PM8607_B0_MISC1			(0x0C)
 #define PM8607_LDO1			(0x10)
 #define PM8607_DVC3			(0x26)
-#define PM8607_MISC1			(0x40)
-
-/* bit definitions for PM8607 events */
-#define PM8607_EVENT_ONKEY		(1 << 0)
-#define PM8607_EVENT_EXTON		(1 << 1)
-#define PM8607_EVENT_CHG		(1 << 2)
-#define PM8607_EVENT_BAT		(1 << 3)
-#define PM8607_EVENT_RTC		(1 << 4)
-#define PM8607_EVENT_CC			(1 << 5)
-#define PM8607_EVENT_VBAT		(1 << 8)
-#define PM8607_EVENT_VCHG		(1 << 9)
-#define PM8607_EVENT_VSYS		(1 << 10)
-#define PM8607_EVENT_TINT		(1 << 11)
-#define PM8607_EVENT_GPADC0		(1 << 12)
-#define PM8607_EVENT_GPADC1		(1 << 13)
-#define PM8607_EVENT_GPADC2		(1 << 14)
-#define PM8607_EVENT_GPADC3		(1 << 15)
-#define PM8607_EVENT_AUDIO_SHORT	(1 << 16)
-#define PM8607_EVENT_PEN		(1 << 17)
-#define PM8607_EVENT_HEADSET		(1 << 18)
-#define PM8607_EVENT_HOOK		(1 << 19)
-#define PM8607_EVENT_MICIN		(1 << 20)
-#define PM8607_EVENT_CHG_TIMEOUT	(1 << 21)
-#define PM8607_EVENT_CHG_DONE		(1 << 22)
-#define PM8607_EVENT_CHG_FAULT		(1 << 23)
+#define PM8607_A1_MISC1			(0x40)

 /* bit definitions of Status Query Interface */
 #define PM8607_STATUS_CC		(1 << 3)
@@ -154,7 +133,12 @@ enum {
 #define PM8607_BUCK3_DOUBLE		(1 << 6)

 /* bit definitions of Misc1 */
-#define PM8607_MISC1_PI2C		(1 << 0)
+#define PM8607_A1_MISC1_PI2C		(1 << 0)
+#define PM8607_B0_MISC1_INV_INT		(1 << 0)
+#define PM8607_B0_MISC1_INT_CLEAR	(1 << 1)
+#define PM8607_B0_MISC1_INT_MASK	(1 << 2)
+#define PM8607_B0_MISC1_PI2C		(1 << 3)
+#define PM8607_B0_MISC1_RESET		(1 << 6)

 /* Interrupt Number in 88PM8607 */
 enum {
@@ -187,14 +171,24 @@ enum {
 	PM8607_CHIP_B0 = 0x48,
 };

+#define PM860X_NUM_IRQ		24
+
+struct pm860x_irq {
+	irq_handler_t		handler;
+	void			*data;
+};
+
 struct pm860x_chip {
 	struct device		*dev;
-	struct mutex		io_lock;
+	struct mutex		irq_lock;
 	struct i2c_client	*client;
 	struct i2c_client	*companion;	/* companion chip client */
+	struct pm860x_irq	irq[PM860X_NUM_IRQ];

 	int			buck3_double;	/* DVC ramp slope double */
 	int			id;
+	int			irq_mode;
+	int			chip_irq;
 	unsigned char		chip_version;

 };
@@ -209,6 +203,7 @@ enum {
 struct pm860x_platform_data {
 	unsigned short	companion_addr;	/* I2C address of companion chip */
 	int		i2c_port;	/* Controlled by GI2C or PI2C */
+	int		irq_mode;	/* Clear interrupt by read/write(0/1) */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
 };

@@ -219,6 +214,12 @@ extern int pm860x_bulk_write(struct i2c_client *,
int, int, unsigned char *);
 extern int pm860x_set_bits(struct i2c_client *, int, unsigned char,
 			   unsigned char);

+extern int pm860x_mask_irq(struct pm860x_chip *, int);
+extern int pm860x_unmask_irq(struct pm860x_chip *, int);
+extern int pm860x_request_irq(struct pm860x_chip *, int,
+			      irq_handler_t handler, void *);
+extern int pm860x_free_irq(struct pm860x_chip *, int);
+
 extern int pm860x_device_init(struct pm860x_chip *chip,
 			      struct pm860x_platform_data *pdata);
 extern void pm860x_device_exit(struct pm860x_chip *chip);
-- 
1.5.6.5

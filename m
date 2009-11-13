From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 13 Nov 2009 10:19:02 -0500
Subject: [PATCH] mfd: add irq support in 88pm860x
Message-ID: <mailman.22.1258102769.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x is a complex PMIC device. It contains touch, charger, sound, rtc,
backlight, led, and so on.

Host communicates to 88PM860x by I2C bus. Use thread irq to support this
usage case.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  260 +++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/88pm860x.h |   55 +++++-----
 2 files changed, 275 insertions(+), 40 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 0e6e80b..7055c80 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm860x.h>

@@ -69,10 +70,231 @@ static struct mfd_cell pm8607_devs[] = {

 static struct mixed_88pm860x mixed_chip;

+#define CHECK_IRQ(irq)					\
+do {							\
+	if ((irq < 0) || (irq >= PM860X_NUM_IRQ))	\
+		return -EINVAL;				\
+} while (0)
+
+/* IRQs only occur on 88PM8607 */
+int pm860x_mask_irq(struct pm860x_chip *chip, int irq)
+{
+	int offset, data, ret;
+
+	CHECK_IRQ(irq);
+
+	offset = (irq >> 3) + PM8607_INT_MASK_1;
+	data = 1 << (irq % 8);
+	ret = pm860x_set_bits(chip->parent, DESC_8607, offset, data, 0);
+
+	return ret;
+}
+EXPORT_SYMBOL(pm860x_mask_irq);
+
+int pm860x_unmask_irq(struct pm860x_chip *chip, int irq)
+{
+	int offset, data, ret;
+
+	CHECK_IRQ(irq);
+
+	offset = (irq >> 3) + PM8607_INT_MASK_1;
+	data = 1 << (irq % 8);
+	ret = pm860x_set_bits(chip->parent, DESC_8607, offset, data, data);
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
+	unsigned char status_buf[INT_STATUS_NUM << 1];
+	unsigned long value;
+	int i, ret;
+
+	irq_status[0] = 0;
+
+	/* read out status register */
+	ret = pm860x_bulk_read(chip->parent, DESC_8607, PM8607_INT_STATUS1,
+				INT_STATUS_NUM << 1, status_buf);
+	if (ret < 0)
+		goto out;
+	if (chip->irq_mode) {
+		/* 0, clear by read. 1, clear by write */
+		ret = pm860x_bulk_write(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1, INT_STATUS_NUM,
+					status_buf);
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
+		if (chip->irq[irq].handle_irq)
+			chip->irq[irq].handle_irq(chip, irq,
+						chip->irq[irq].data);
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
+		       void (*handle_irq)(struct pm860x_chip *, int, void *),
+		       void *data)
+{
+	CHECK_IRQ(irq);
+	if (handle_irq == NULL)
+		return -EINVAL;
+
+	mutex_lock(&chip->irq_lock);
+	chip->irq[irq].handle_irq = handle_irq;
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
+	chip->irq[irq].handle_irq = NULL;
+	chip->irq[irq].data = NULL;
+	mutex_unlock(&chip->irq_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pm860x_free_irq);
+
+static int __devinit __88pm8607_irq_init(struct pm860x_chip *chip,
+					 struct pm8607_plat_data *pdata)
+{
+	unsigned char status_buf[INT_STATUS_NUM];
+	int irq, data, mask, ret = -EINVAL;
+
+	mutex_init(&chip->irq_lock);
+
+#if 0
+	mask = PM8607_MISC1_INV_INT | PM8607_MISC1_INT_CLEAR
+		| PM8607_MISC1_INT_MASK;
+	data = PM8607_MISC1_INT_CLEAR;
+	chip->irq_mode = 1;
+	if (pdata) {
+		/*
+		 * irq_mode defines the way of clearing interrupt.
+		 * If it's 1, clear IRQ by write. Otherwise, clear it by read.
+		 * This control bit is valid from 88PM8607 B0 steping.
+		 */
+		if ((chip->chip_id >= PM8607_CHIP_B0) && (!pdata->irq_mode)) {
+			data = 0;
+			chip->irq_mode = 0;
+		}
+	}
+	ret = pm860x_set_bits(chip->parent, DESC_8607, PM8607_MISC1,
+			      mask, data);
+#else
+	mask = PM8607_B0_MISC1_INV_INT | PM8607_B0_MISC1_INT_CLEAR
+		| PM8607_B0_MISC1_INT_MASK;
+	data = PM8607_B0_MISC1_INT_CLEAR;
+	chip->irq_mode = 1;
+	switch (chip->chip_id) {
+	case PM8607_CHIP_A0:
+	case PM8607_CHIP_A1:
+		ret = pm860x_set_bits(chip->parent, DESC_8607,
+				PM8607_A1_MISC1, mask, data);
+		break;
+	case PM8607_CHIP_B0:
+	default:
+		if (pdata) {
+			/*
+			 * irq_mode defines the way of clearing interrupt. If
+			 * it's 1, clear IRQ by write. Otherwise, clear it by
+			 * read.
+			 * This control bit is valid from 88PM8607 B0 steping.
+			 */
+			if (!pdata->irq_mode) {
+				data = 0;
+				chip->irq_mode = 0;
+			}
+		}
+		ret = pm860x_set_bits(chip->parent, DESC_8607,
+				PM8607_B0_MISC1, mask, data);
+		break;
+	}
+#endif
+	if (ret < 0)
+		goto out;
+
+	/* mask all IRQs */
+	memset(status_buf, 0, INT_STATUS_NUM);
+	ret = pm860x_bulk_write(chip->parent, DESC_8607, PM8607_INT_MASK_1,
+				INT_STATUS_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	/* clear all interrupt status (just read) */
+	ret = pm860x_bulk_read(chip->parent, DESC_8607, PM8607_INT_STATUS1,
+				INT_STATUS_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	mutex_lock(&chip->irq_lock);
+	memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
+	mutex_unlock(&chip->irq_lock);
+
+	if (chip->client == NULL)
+		goto out;
+
+	irq = chip->client->irq;
+	ret = request_threaded_irq(irq, NULL, pm8607_irq_thread,
+				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"88pm8607", chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ #%d.\n", irq);
+		goto out;
+	}
+	chip->chip_irq = ret;
+	return 0;
+out:
+	return ret;
+}
+
+static void __devexit __88pm860x_irq_exit(struct pm860x_chip *chip)
+{
+	if (chip->chip_irq >= 0)
+		free_irq(chip->chip_irq, chip);
+}
+
 static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata)
 {
 	chip->parent = &mixed_chip;
 	mixed_chip.pm8606 = chip;
+	chip->chip_irq = -EINVAL;

 	return 0;
 }
@@ -80,10 +302,11 @@ static int __devinit __88pm8606_init(struct
pm860x_chip *chip, void *pdata)
 static int __devinit __88pm8607_init(struct pm860x_chip *chip,
 				     struct pm8607_plat_data *pdata)
 {
-	int ret = 0;
+	int data = 0, ret = 0;

 	chip->parent = &mixed_chip;
 	mixed_chip.pm8607 = chip;
+	chip->chip_irq = -EINVAL;

 	ret = pm860x_reg_read(chip->parent, DESC_8607, PM8607_CHIP_ID);
 	if (ret < 0) {
@@ -108,20 +331,30 @@ static int __devinit __88pm8607_init(struct
pm860x_chip *chip,
 	if (ret & PM8607_BUCK3_DOUBLE)
 		chip->parent->buck3_double = 1;

-	ret = pm860x_reg_read(chip->parent, DESC_8607, PM8607_MISC1);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
-		goto out;
+	if (pdata && (pdata->i2c_port == PI2C_PORT)) {
+		switch (chip->chip_id) {
+		case PM8607_CHIP_A0:
+		case PM8607_CHIP_A1:
+			data = PM8607_A1_MISC1_PI2C;
+			ret = pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_A1_MISC1, data, data);
+			break;
+		case PM8607_CHIP_B0:
+		default:
+			data = PM8607_B0_MISC1_PI2C;
+			ret = pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_B0_MISC1, data, data);
+			break;
+		}
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to access MISC1:%d\n", ret);
+			goto out;
+		}
 	}
-	if (pdata && (pdata->i2c_port == PI2C_PORT))
-		ret |= PM8607_MISC1_PI2C;
-	else
-		ret &= ~PM8607_MISC1_PI2C;
-	ret = pm860x_reg_write(chip->parent, DESC_8607, PM8607_MISC1, ret);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
+
+	ret = __88pm8607_irq_init(chip, pdata);
+	if (ret < 0)
 		goto out;
-	}
 out:
 	return ret;
 }
@@ -160,6 +393,7 @@ out:

 void __devexit pm8607_device_exit(struct pm860x_chip *chip)
 {
+	__88pm860x_irq_exit(chip);
 	mfd_remove_devices(chip->dev);
 }

diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index fd8e8ad..92566df 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -109,33 +109,10 @@ enum {

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
@@ -154,7 +131,12 @@ enum {
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
@@ -199,14 +181,25 @@ struct mixed_88pm860x {
 	int			flags;
 };

+#define PM860X_NUM_IRQ		24
+
+struct pm860x_irq {
+	void (*handle_irq)(struct pm860x_chip *, int, void *);
+	void *data;
+};
+
 struct pm860x_chip {
 	struct device		*dev;
-	struct mutex		io_lock;
 	struct i2c_client	*client;
 	struct i2c_device_id	id;
 	struct mixed_88pm860x	*parent;
+	struct mutex		irq_lock;
+	int			chip_irq;
 	unsigned char		chip_id;

+	struct pm860x_irq	irq[PM860X_NUM_IRQ];
+	int			irq_mode;
+
 	int (*read)(struct pm860x_chip *chip, int reg, int bytes, void *dest);
 	int (*write)(struct pm860x_chip *chip, int reg, int bytes, void *src);
 };
@@ -220,6 +213,7 @@ enum {

 struct pm8607_plat_data {
 	int	i2c_port;	/* Controlled by GI2C or PI2C */
+	int	irq_mode;	/* Clear interrupt by read/write (1/0) */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
 };

@@ -232,6 +226,13 @@ extern int pm860x_bulk_write(struct
mixed_88pm860x *, int, int, int,
 extern int pm860x_set_bits(struct mixed_88pm860x *, int, int, unsigned char,
 			   unsigned char);

+extern int pm860x_mask_irq(struct pm860x_chip *, int);
+extern int pm860x_unmask_irq(struct pm860x_chip *, int);
+extern int pm860x_request_irq(struct pm860x_chip *, int,
+			void (*handle_irq)(struct pm860x_chip *, int, void *),
+			void *);
+extern int pm860x_free_irq(struct pm860x_chip *, int);
+
 extern int pm860x_device_init(struct pm860x_chip *chip, void *pdata);
 extern void pm860x_device_exit(struct pm860x_chip *chip);

-- 
1.5.6.5

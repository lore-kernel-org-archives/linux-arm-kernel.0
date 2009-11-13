From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 13 Nov 2009 10:19:02 -0500
Subject: [PATCH] mfd: add irq support in 88pm860x
Message-ID: <mailman.39.1258439572.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860x is a complex PMIC device. It contains touch, charger, sound, rtc,
backlight, led, and so on.

Host communicates to 88PM860x by I2C bus. Use thread irq to support this
usage case.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  249 ++++++++++++++++++++++++++++++++++++++=
+---
 include/linux/mfd/88pm860x.h |   58 +++++-----
 2 files changed, 264 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 0e6e80b..cc86089 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm860x.h>

@@ -69,21 +70,228 @@ static struct mfd_cell pm8607_devs[] =3D {

 static struct mixed_88pm860x mixed_chip;

+#define CHECK_IRQ(irq)					\
+do {							\
+	if ((irq < 0) || (irq >=3D PM860X_NUM_IRQ))	\
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
+	offset =3D (irq >> 3) + PM8607_INT_MASK_1;
+	data =3D 1 << (irq % 8);
+	ret =3D pm860x_set_bits(chip->parent, DESC_8607, offset, data, 0);
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
+	offset =3D (irq >> 3) + PM8607_INT_MASK_1;
+	data =3D 1 << (irq % 8);
+	ret =3D pm860x_set_bits(chip->parent, DESC_8607, offset, data, data);
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
+	struct pm860x_chip *chip =3D data;
+	unsigned char status_buf[INT_STATUS_NUM << 1];
+	unsigned long value;
+	int i, ret;
+
+	irq_status[0] =3D 0;
+
+	/* read out status register */
+	ret =3D pm860x_bulk_read(chip->parent, DESC_8607, PM8607_INT_STATUS1,
+				INT_STATUS_NUM << 1, status_buf);
+	if (ret < 0)
+		goto out;
+	if (chip->irq_mode) {
+		/* 0, clear by read. 1, clear by write */
+		ret =3D pm860x_bulk_write(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1, INT_STATUS_NUM,
+					status_buf);
+		if (ret < 0)
+			goto out;
+	}
+
+	/* clear masked interrupt status */
+	for (i =3D 0, value =3D 0; i < INT_STATUS_NUM; i++) {
+		status_buf[i] &=3D status_buf[i + INT_STATUS_NUM];
+		irq_status[0] |=3D status_buf[i] << (i * 8);
+	}
+
+	while (!bitmap_empty(irq_status, PM860X_NUM_IRQ)) {
+		irq =3D find_first_bit(irq_status, PM860X_NUM_IRQ);
+		clear_bit(irq, irq_status);
+		dev_dbg(chip->dev, "Servicing IRQ #%d\n", irq);
+
+		mutex_lock(&chip->irq_lock);From
7afdf603753cf91e4753ce8f1c179fb55b68bf6d Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Fri, 13 Nov 2009 10:19:02 -0500
Subject: [PATCH] mfd: add irq support in 88pm860x

88PM860x is a complex PMIC device. It contains touch, charger, sound, rtc,
backlight, led, and so on.

Host communicates to 88PM860x by I2C bus. Use thread irq to support this
usage case.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  249 ++++++++++++++++++++++++++++++++++++++=
+---
 include/linux/mfd/88pm860x.h |   58 +++++-----
 2 files changed, 264 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 0e6e80b..cc86089 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm860x.h>

@@ -69,21 +70,228 @@ static struct mfd_cell pm8607_devs[] =3D {

 static struct mixed_88pm860x mixed_chip;

+#define CHECK_IRQ(irq)					\
+do {							\
+	if ((irq < 0) || (irq >=3D PM860X_NUM_IRQ))	\
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
+	offset =3D (irq >> 3) + PM8607_INT_MASK_1;
+	data =3D 1 << (irq % 8);
+	ret =3D pm860x_set_bits(chip->parent, DESC_8607, offset, data, 0);
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
+	offset =3D (irq >> 3) + PM8607_INT_MASK_1;
+	data =3D 1 << (irq % 8);
+	ret =3D pm860x_set_bits(chip->parent, DESC_8607, offset, data, data);
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
+	struct pm860x_chip *chip =3D data;
+	unsigned char status_buf[INT_STATUS_NUM << 1];
+	unsigned long value;
+	int i, ret;
+
+	irq_status[0] =3D 0;
+
+	/* read out status register */
+	ret =3D pm860x_bulk_read(chip->parent, DESC_8607, PM8607_INT_STATUS1,
+				INT_STATUS_NUM << 1, status_buf);
+	if (ret < 0)
+		goto out;
+	if (chip->irq_mode) {
+		/* 0, clear by read. 1, clear by write */
+		ret =3D pm860x_bulk_write(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1, INT_STATUS_NUM,
+					status_buf);
+		if (ret < 0)
+			goto out;
+	}
+
+	/* clear masked interrupt status */
+	for (i =3D 0, value =3D 0; i < INT_STATUS_NUM; i++) {
+		status_buf[i] &=3D status_buf[i + INT_STATUS_NUM];
+		irq_status[0] |=3D status_buf[i] << (i * 8);
+	}
+
+	while (!bitmap_empty(irq_status, PM860X_NUM_IRQ)) {
+		irq =3D find_first_bit(irq_status, PM860X_NUM_IRQ);
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
+			for (i =3D 0; i < (INT_STATUS_NUM << 1); i++) {
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
+	chip->irq[irq].handler =3D handler;
+	chip->irq[irq].data =3D data;
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
+	chip->irq[irq].handler =3D NULL;
+	chip->irq[irq].data =3D NULL;
+	mutex_unlock(&chip->irq_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pm860x_free_irq);
+
+static int __devinit __88pm8607_irq_init(struct pm860x_chip *chip,
+					 struct pm860x_plat_data *pdata)
+{
+	unsigned char status_buf[INT_STATUS_NUM];
+	int irq, data, mask, ret =3D -EINVAL;
+
+	mutex_init(&chip->irq_lock);
+
+	mask =3D PM8607_B0_MISC1_INV_INT | PM8607_B0_MISC1_INT_CLEAR
+		| PM8607_B0_MISC1_INT_MASK;
+	data =3D PM8607_B0_MISC1_INT_CLEAR;
+	chip->irq_mode =3D 1;
+	switch (chip->chip_id) {
+	case PM8607_CHIP_A0:
+	case PM8607_CHIP_A1:
+		ret =3D pm860x_set_bits(chip->parent, DESC_8607,
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
+				data =3D 0;
+				chip->irq_mode =3D 0;
+			}
+		}
+		ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+				PM8607_B0_MISC1, mask, data);
+		break;
+	}
+	if (ret < 0)
+		goto out;
+
+	/* mask all IRQs */
+	memset(status_buf, 0, INT_STATUS_NUM);
+	ret =3D pm860x_bulk_write(chip->parent, DESC_8607, PM8607_INT_MASK_1,
+				INT_STATUS_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	if (chip->irq_mode) {
+		/* clear interrupt status by write */
+		memset(status_buf, 0xFF, INT_STATUS_NUM);
+		ret =3D pm860x_bulk_write(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+	} else {
+		/* clear interrupt status by read */
+		ret =3D pm860x_bulk_read(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+	}
+	if (ret < 0)
+		goto out;
+
+	memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
+
+	if (chip->client =3D=3D NULL)
+		goto out;
+
+	irq =3D chip->client->irq;
+	ret =3D request_threaded_irq(irq, NULL, pm8607_irq_thread,
+				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"88pm8607", chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ #%d.\n", irq);
+		goto out;
+	}
+	chip->chip_irq =3D ret;
+	return 0;
+out:
+	return ret;
+}
+
+static void __devexit __88pm860x_irq_exit(struct pm860x_chip *chip)
+{
+	if (chip->chip_irq >=3D 0)
+		free_irq(chip->chip_irq, chip);
+}
+
 static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata=
)
 {
 	chip->parent =3D &mixed_chip;
 	mixed_chip.pm8606 =3D chip;
+	chip->chip_irq =3D -EINVAL;

 	return 0;
 }

 static int __devinit __88pm8607_init(struct pm860x_chip *chip,
-				     struct pm8607_plat_data *pdata)
+				     struct pm860x_plat_data *pdata)
 {
-	int ret =3D 0;
+	int data =3D 0, ret =3D 0;

 	chip->parent =3D &mixed_chip;
 	mixed_chip.pm8607 =3D chip;
+	chip->chip_irq =3D -EINVAL;

 	ret =3D pm860x_reg_read(chip->parent, DESC_8607, PM8607_CHIP_ID);
 	if (ret < 0) {
@@ -108,20 +316,30 @@ static int __devinit __88pm8607_init(struct
pm860x_chip *chip,
 	if (ret & PM8607_BUCK3_DOUBLE)
 		chip->parent->buck3_double =3D 1;

-	ret =3D pm860x_reg_read(chip->parent, DESC_8607, PM8607_MISC1);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
-		goto out;
+	if (pdata && (pdata->i2c_port =3D=3D PI2C_PORT)) {
+		switch (chip->chip_id) {
+		case PM8607_CHIP_A0:
+		case PM8607_CHIP_A1:
+			data =3D PM8607_A1_MISC1_PI2C;
+			ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_A1_MISC1, data, data);
+			break;
+		case PM8607_CHIP_B0:
+		default:
+			data =3D PM8607_B0_MISC1_PI2C;
+			ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_B0_MISC1, data, data);
+			break;
+		}
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to access MISC1:%d\n", ret);
+			goto out;
+		}
 	}
-	if (pdata && (pdata->i2c_port =3D=3D PI2C_PORT))
-		ret |=3D PM8607_MISC1_PI2C;
-	else
-		ret &=3D ~PM8607_MISC1_PI2C;
-	ret =3D pm860x_reg_write(chip->parent, DESC_8607, PM8607_MISC1, ret);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
+
+	ret =3D __88pm8607_irq_init(chip, pdata);
+	if (ret < 0)
 		goto out;
-	}
 out:
 	return ret;
 }
@@ -136,7 +354,7 @@ int __devinit pm860x_device_init(struct
pm860x_chip *chip, void *pdata)
 		mutex_init(&mixed_chip.io_lock);

 	if (!strcmp(chip->id.name, "88PM8607")) {
-		ret =3D __88pm8607_init(chip, (struct pm8607_plat_data *)pdata);
+		ret =3D __88pm8607_init(chip, (struct pm860x_plat_data *)pdata);
 		if (ret < 0)
 			goto out;

@@ -160,6 +378,7 @@ out:

 void __devexit pm8607_device_exit(struct pm860x_chip *chip)
 {
+	__88pm860x_irq_exit(chip);
 	mfd_remove_devices(chip->dev);
 }

diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index fd8e8ad..99a5a7e 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -12,6 +12,8 @@
 #ifndef __LINUX_MFD_88PM860X_H
 #define __LINUX_MFD_88PM860X_H

+#include <linux/interrupt.h>
+
 enum {
 	DESC_INVAL =3D 0,
 	DESC_8606,
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
@@ -199,14 +183,25 @@ struct mixed_88pm860x {
 	int			flags;
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
@@ -218,8 +213,9 @@ enum {
 	PI2C_PORT,
 };

-struct pm8607_plat_data {
+struct pm860x_plat_data {
 	int	i2c_port;	/* Controlled by GI2C or PI2C */
+	int	irq_mode;	/* Clear interrupt by read/write (1/0) */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
 };

@@ -232,6 +228,12 @@ extern int pm860x_bulk_write(struct
mixed_88pm860x *, int, int, int,
 extern int pm860x_set_bits(struct mixed_88pm860x *, int, int, unsigned cha=
r,
 			   unsigned char);

+extern int pm860x_mask_irq(struct pm860x_chip *, int);
+extern int pm860x_unmask_irq(struct pm860x_chip *, int);
+extern int pm860x_request_irq(struct pm860x_chip *, int,
+			      irq_handler_t handler, void *);
+extern int pm860x_free_irq(struct pm860x_chip *, int);
+
 extern int pm860x_device_init(struct pm860x_chip *chip, void *pdata);
 extern void pm860x_device_exit(struct pm860x_chip *chip);

--=20
1.5.6.5

+		if (chip->irq[irq].handler)
+			chip->irq[irq].handler(irq, chip->irq[irq].data);
+		else {
+			pm860x_mask_irq(chip, irq);
+			dev_err(chip->dev, "Nobody cares IRQ %d. "
+				"Now mask it.\n", irq);
+			for (i =3D 0; i < (INT_STATUS_NUM << 1); i++) {
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
+	chip->irq[irq].handler =3D handler;
+	chip->irq[irq].data =3D data;
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
+	chip->irq[irq].handler =3D NULL;
+	chip->irq[irq].data =3D NULL;
+	mutex_unlock(&chip->irq_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pm860x_free_irq);
+
+static int __devinit __88pm8607_irq_init(struct pm860x_chip *chip,
+					 struct pm860x_plat_data *pdata)
+{
+	unsigned char status_buf[INT_STATUS_NUM];
+	int irq, data, mask, ret =3D -EINVAL;
+
+	mutex_init(&chip->irq_lock);
+
+	mask =3D PM8607_B0_MISC1_INV_INT | PM8607_B0_MISC1_INT_CLEAR
+		| PM8607_B0_MISC1_INT_MASK;
+	data =3D PM8607_B0_MISC1_INT_CLEAR;
+	chip->irq_mode =3D 1;
+	switch (chip->chip_id) {
+	case PM8607_CHIP_A0:
+	case PM8607_CHIP_A1:
+		ret =3D pm860x_set_bits(chip->parent, DESC_8607,
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
+				data =3D 0;
+				chip->irq_mode =3D 0;
+			}
+		}
+		ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+				PM8607_B0_MISC1, mask, data);
+		break;
+	}
+	if (ret < 0)
+		goto out;
+
+	/* mask all IRQs */
+	memset(status_buf, 0, INT_STATUS_NUM);
+	ret =3D pm860x_bulk_write(chip->parent, DESC_8607, PM8607_INT_MASK_1,
+				INT_STATUS_NUM, status_buf);
+	if (ret < 0)
+		goto out;
+
+	if (chip->irq_mode) {
+		/* clear interrupt status by write */
+		memset(status_buf, 0xFF, INT_STATUS_NUM);
+		ret =3D pm860x_bulk_write(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+	} else {
+		/* clear interrupt status by read */
+		ret =3D pm860x_bulk_read(chip->parent, DESC_8607,
+					PM8607_INT_STATUS1,
+					INT_STATUS_NUM, status_buf);
+	}
+	if (ret < 0)
+		goto out;
+
+	memset(chip->irq, 0, sizeof(struct pm860x_irq) * PM860X_NUM_IRQ);
+
+	if (chip->client =3D=3D NULL)
+		goto out;
+
+	irq =3D chip->client->irq;
+	ret =3D request_threaded_irq(irq, NULL, pm8607_irq_thread,
+				IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				"88pm8607", chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ #%d.\n", irq);
+		goto out;
+	}
+	chip->chip_irq =3D ret;
+	return 0;
+out:
+	return ret;
+}
+
+static void __devexit __88pm860x_irq_exit(struct pm860x_chip *chip)
+{
+	if (chip->chip_irq >=3D 0)
+		free_irq(chip->chip_irq, chip);
+}
+
 static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata=
)
 {
 	chip->parent =3D &mixed_chip;
 	mixed_chip.pm8606 =3D chip;
+	chip->chip_irq =3D -EINVAL;

 	return 0;
 }

 static int __devinit __88pm8607_init(struct pm860x_chip *chip,
-				     struct pm8607_plat_data *pdata)
+				     struct pm860x_plat_data *pdata)
 {
-	int ret =3D 0;
+	int data =3D 0, ret =3D 0;

 	chip->parent =3D &mixed_chip;
 	mixed_chip.pm8607 =3D chip;
+	chip->chip_irq =3D -EINVAL;

 	ret =3D pm860x_reg_read(chip->parent, DESC_8607, PM8607_CHIP_ID);
 	if (ret < 0) {
@@ -108,20 +316,30 @@ static int __devinit __88pm8607_init(struct
pm860x_chip *chip,
 	if (ret & PM8607_BUCK3_DOUBLE)
 		chip->parent->buck3_double =3D 1;

-	ret =3D pm860x_reg_read(chip->parent, DESC_8607, PM8607_MISC1);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to read MISC1 register: %d\n", ret);
-		goto out;
+	if (pdata && (pdata->i2c_port =3D=3D PI2C_PORT)) {
+		switch (chip->chip_id) {
+		case PM8607_CHIP_A0:
+		case PM8607_CHIP_A1:
+			data =3D PM8607_A1_MISC1_PI2C;
+			ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_A1_MISC1, data, data);
+			break;
+		case PM8607_CHIP_B0:
+		default:
+			data =3D PM8607_B0_MISC1_PI2C;
+			ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_B0_MISC1, data, data);
+			break;
+		}
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to access MISC1:%d\n", ret);
+			goto out;
+		}
 	}
-	if (pdata && (pdata->i2c_port =3D=3D PI2C_PORT))
-		ret |=3D PM8607_MISC1_PI2C;
-	else
-		ret &=3D ~PM8607_MISC1_PI2C;
-	ret =3D pm860x_reg_write(chip->parent, DESC_8607, PM8607_MISC1, ret);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to write MISC1 register: %d\n", ret);
+
+	ret =3D __88pm8607_irq_init(chip, pdata);
+	if (ret < 0)
 		goto out;
-	}
 out:
 	return ret;
 }
@@ -136,7 +354,7 @@ int __devinit pm860x_device_init(struct
pm860x_chip *chip, void *pdata)
 		mutex_init(&mixed_chip.io_lock);

 	if (!strcmp(chip->id.name, "88PM8607")) {
-		ret =3D __88pm8607_init(chip, (struct pm8607_plat_data *)pdata);
+		ret =3D __88pm8607_init(chip, (struct pm860x_plat_data *)pdata);
 		if (ret < 0)
 			goto out;

@@ -160,6 +378,7 @@ out:

 void __devexit pm8607_device_exit(struct pm860x_chip *chip)
 {
+	__88pm860x_irq_exit(chip);
 	mfd_remove_devices(chip->dev);
 }

diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index fd8e8ad..99a5a7e 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -12,6 +12,8 @@
 #ifndef __LINUX_MFD_88PM860X_H
 #define __LINUX_MFD_88PM860X_H

+#include <linux/interrupt.h>
+
 enum {
 	DESC_INVAL =3D 0,
 	DESC_8606,
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
@@ -199,14 +183,25 @@ struct mixed_88pm860x {
 	int			flags;
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
@@ -218,8 +213,9 @@ enum {
 	PI2C_PORT,
 };

-struct pm8607_plat_data {
+struct pm860x_plat_data {
 	int	i2c_port;	/* Controlled by GI2C or PI2C */
+	int	irq_mode;	/* Clear interrupt by read/write (1/0) */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
 };

@@ -232,6 +228,12 @@ extern int pm860x_bulk_write(struct
mixed_88pm860x *, int, int, int,
 extern int pm860x_set_bits(struct mixed_88pm860x *, int, int, unsigned cha=
r,
 			   unsigned char);

+extern int pm860x_mask_irq(struct pm860x_chip *, int);
+extern int pm860x_unmask_irq(struct pm860x_chip *, int);
+extern int pm860x_request_irq(struct pm860x_chip *, int,
+			      irq_handler_t handler, void *);
+extern int pm860x_free_irq(struct pm860x_chip *, int);
+
 extern int pm860x_device_init(struct pm860x_chip *chip, void *pdata);
 extern void pm860x_device_exit(struct pm860x_chip *chip);

--=20
1.5.6.5

--00151773da30083edf04788b4bfe
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0005-mfd-add-irq-support-in-88pm860x.patch"
Content-Disposition: attachment; 
	filename="0005-mfd-add-irq-support-in-88pm860x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g24r5qk70

RnJvbSA3YWZkZjYwMzc1M2NmOTFlNDc1M2NlOGYxYzE3OWZiNTViNjhiZjZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMTMgTm92IDIwMDkgMTA6MTk6MDIgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBtZmQ6IGFkZCBpcnEgc3VwcG9ydCBpbiA4OHBtODYweAoKODhQTTg2MHggaXMgYSBjb21w
bGV4IFBNSUMgZGV2aWNlLiBJdCBjb250YWlucyB0b3VjaCwgY2hhcmdlciwgc291bmQsIHJ0YywK
YmFja2xpZ2h0LCBsZWQsIGFuZCBzbyBvbi4KCkhvc3QgY29tbXVuaWNhdGVzIHRvIDg4UE04NjB4
IGJ5IEkyQyBidXMuIFVzZSB0aHJlYWQgaXJxIHRvIHN1cHBvcnQgdGhpcwp1c2FnZSBjYXNlLgoK
U2lnbmVkLW9mZi1ieTogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29t
PgotLS0KIGRyaXZlcnMvbWZkLzg4cG04NjB4LWNvcmUuYyAgfCAgMjQ5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLQogaW5jbHVkZS9saW51eC9tZmQvODhwbTg2MHgu
aCB8ICAgNTggKysrKystLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyNjQgaW5zZXJ0aW9ucygrKSwg
NDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvODhwbTg2MHgtY29yZS5j
IGIvZHJpdmVycy9tZmQvODhwbTg2MHgtY29yZS5jCmluZGV4IDBlNmU4MGIuLmNjODYwODkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbWZkLzg4cG04NjB4LWNvcmUuYworKysgYi9kcml2ZXJzL21mZC84
OHBtODYweC1jb3JlLmMKQEAgLTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9pMmMuaD4KICNpbmNsdWRlIDxsaW51eC9tZmQv
Y29yZS5oPgogI2luY2x1ZGUgPGxpbnV4L21mZC84OHBtODYweC5oPgogCkBAIC02OSwyMSArNzAs
MjI4IEBAIHN0YXRpYyBzdHJ1Y3QgbWZkX2NlbGwgcG04NjA3X2RldnNbXSA9IHsKIAogc3RhdGlj
IHN0cnVjdCBtaXhlZF84OHBtODYweCBtaXhlZF9jaGlwOwogCisjZGVmaW5lIENIRUNLX0lSUShp
cnEpCQkJCQlcCitkbyB7CQkJCQkJCVwKKwlpZiAoKGlycSA8IDApIHx8IChpcnEgPj0gUE04NjBY
X05VTV9JUlEpKQlcCisJCXJldHVybiAtRUlOVkFMOwkJCQlcCit9IHdoaWxlICgwKQorCisvKiBJ
UlFzIG9ubHkgb2NjdXIgb24gODhQTTg2MDcgKi8KK2ludCBwbTg2MHhfbWFza19pcnEoc3RydWN0
IHBtODYweF9jaGlwICpjaGlwLCBpbnQgaXJxKQoreworCWludCBvZmZzZXQsIGRhdGEsIHJldDsK
KworCUNIRUNLX0lSUShpcnEpOworCisJb2Zmc2V0ID0gKGlycSA+PiAzKSArIFBNODYwN19JTlRf
TUFTS18xOworCWRhdGEgPSAxIDw8IChpcnEgJSA4KTsKKwlyZXQgPSBwbTg2MHhfc2V0X2JpdHMo
Y2hpcC0+cGFyZW50LCBERVNDXzg2MDcsIG9mZnNldCwgZGF0YSwgMCk7CisKKwlyZXR1cm4gcmV0
OworfQorRVhQT1JUX1NZTUJPTChwbTg2MHhfbWFza19pcnEpOworCitpbnQgcG04NjB4X3VubWFz
a19pcnEoc3RydWN0IHBtODYweF9jaGlwICpjaGlwLCBpbnQgaXJxKQoreworCWludCBvZmZzZXQs
IGRhdGEsIHJldDsKKworCUNIRUNLX0lSUShpcnEpOworCisJb2Zmc2V0ID0gKGlycSA+PiAzKSAr
IFBNODYwN19JTlRfTUFTS18xOworCWRhdGEgPSAxIDw8IChpcnEgJSA4KTsKKwlyZXQgPSBwbTg2
MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVNDXzg2MDcsIG9mZnNldCwgZGF0YSwgZGF0YSk7
CisKKwlyZXR1cm4gcmV0OworfQorRVhQT1JUX1NZTUJPTChwbTg2MHhfdW5tYXNrX2lycSk7CisK
KyNkZWZpbmUgSU5UX1NUQVRVU19OVU0JCSgzKQorCitzdGF0aWMgaXJxcmV0dXJuX3QgcG04NjA3
X2lycV90aHJlYWQoaW50IGlycSwgdm9pZCAqZGF0YSkKK3sKKwlERUNMQVJFX0JJVE1BUChpcnFf
c3RhdHVzLCBQTTg2MFhfTlVNX0lSUSk7CisJc3RydWN0IHBtODYweF9jaGlwICpjaGlwID0gZGF0
YTsKKwl1bnNpZ25lZCBjaGFyIHN0YXR1c19idWZbSU5UX1NUQVRVU19OVU0gPDwgMV07CisJdW5z
aWduZWQgbG9uZyB2YWx1ZTsKKwlpbnQgaSwgcmV0OworCisJaXJxX3N0YXR1c1swXSA9IDA7CisK
KwkvKiByZWFkIG91dCBzdGF0dXMgcmVnaXN0ZXIgKi8KKwlyZXQgPSBwbTg2MHhfYnVsa19yZWFk
KGNoaXAtPnBhcmVudCwgREVTQ184NjA3LCBQTTg2MDdfSU5UX1NUQVRVUzEsCisJCQkJSU5UX1NU
QVRVU19OVU0gPDwgMSwgc3RhdHVzX2J1Zik7CisJaWYgKHJldCA8IDApCisJCWdvdG8gb3V0Owor
CWlmIChjaGlwLT5pcnFfbW9kZSkgeworCQkvKiAwLCBjbGVhciBieSByZWFkLiAxLCBjbGVhciBi
eSB3cml0ZSAqLworCQlyZXQgPSBwbTg2MHhfYnVsa193cml0ZShjaGlwLT5wYXJlbnQsIERFU0Nf
ODYwNywKKwkJCQkJUE04NjA3X0lOVF9TVEFUVVMxLCBJTlRfU1RBVFVTX05VTSwKKwkJCQkJc3Rh
dHVzX2J1Zik7CisJCWlmIChyZXQgPCAwKQorCQkJZ290byBvdXQ7CisJfQorCisJLyogY2xlYXIg
bWFza2VkIGludGVycnVwdCBzdGF0dXMgKi8KKwlmb3IgKGkgPSAwLCB2YWx1ZSA9IDA7IGkgPCBJ
TlRfU1RBVFVTX05VTTsgaSsrKSB7CisJCXN0YXR1c19idWZbaV0gJj0gc3RhdHVzX2J1ZltpICsg
SU5UX1NUQVRVU19OVU1dOworCQlpcnFfc3RhdHVzWzBdIHw9IHN0YXR1c19idWZbaV0gPDwgKGkg
KiA4KTsKKwl9CisKKwl3aGlsZSAoIWJpdG1hcF9lbXB0eShpcnFfc3RhdHVzLCBQTTg2MFhfTlVN
X0lSUSkpIHsKKwkJaXJxID0gZmluZF9maXJzdF9iaXQoaXJxX3N0YXR1cywgUE04NjBYX05VTV9J
UlEpOworCQljbGVhcl9iaXQoaXJxLCBpcnFfc3RhdHVzKTsKKwkJZGV2X2RiZyhjaGlwLT5kZXYs
ICJTZXJ2aWNpbmcgSVJRICMlZFxuIiwgaXJxKTsKKworCQltdXRleF9sb2NrKCZjaGlwLT5pcnFf
bG9jayk7CisJCWlmIChjaGlwLT5pcnFbaXJxXS5oYW5kbGVyKQorCQkJY2hpcC0+aXJxW2lycV0u
aGFuZGxlcihpcnEsIGNoaXAtPmlycVtpcnFdLmRhdGEpOworCQllbHNlIHsKKwkJCXBtODYweF9t
YXNrX2lycShjaGlwLCBpcnEpOworCQkJZGV2X2VycihjaGlwLT5kZXYsICJOb2JvZHkgY2FyZXMg
SVJRICVkLiAiCisJCQkJIk5vdyBtYXNrIGl0LlxuIiwgaXJxKTsKKwkJCWZvciAoaSA9IDA7IGkg
PCAoSU5UX1NUQVRVU19OVU0gPDwgMSk7IGkrKykgeworCQkJCWRldl9lcnIoY2hpcC0+ZGV2LCAi
c3RhdHVzWyVkXToleFxuIiwgaSwKKwkJCQkJc3RhdHVzX2J1ZltpXSk7CisJCQl9CisJCX0KKwkJ
bXV0ZXhfdW5sb2NrKCZjaGlwLT5pcnFfbG9jayk7CisJfQorb3V0OgorCXJldHVybiBJUlFfSEFO
RExFRDsKK30KKworaW50IHBtODYweF9yZXF1ZXN0X2lycShzdHJ1Y3QgcG04NjB4X2NoaXAgKmNo
aXAsIGludCBpcnEsCisJCSAgICAgICBpcnFfaGFuZGxlcl90IGhhbmRsZXIsIHZvaWQgKmRhdGEp
Cit7CisJQ0hFQ0tfSVJRKGlycSk7CisJaWYgKCFoYW5kbGVyKQorCQlyZXR1cm4gLUVJTlZBTDsK
KworCW11dGV4X2xvY2soJmNoaXAtPmlycV9sb2NrKTsKKwljaGlwLT5pcnFbaXJxXS5oYW5kbGVy
ID0gaGFuZGxlcjsKKwljaGlwLT5pcnFbaXJxXS5kYXRhID0gZGF0YTsKKwltdXRleF91bmxvY2so
JmNoaXAtPmlycV9sb2NrKTsKKworCXJldHVybiAwOworfQorRVhQT1JUX1NZTUJPTChwbTg2MHhf
cmVxdWVzdF9pcnEpOworCitpbnQgcG04NjB4X2ZyZWVfaXJxKHN0cnVjdCBwbTg2MHhfY2hpcCAq
Y2hpcCwgaW50IGlycSkKK3sKKwlDSEVDS19JUlEoaXJxKTsKKworCW11dGV4X2xvY2soJmNoaXAt
PmlycV9sb2NrKTsKKwljaGlwLT5pcnFbaXJxXS5oYW5kbGVyID0gTlVMTDsKKwljaGlwLT5pcnFb
aXJxXS5kYXRhID0gTlVMTDsKKwltdXRleF91bmxvY2soJmNoaXAtPmlycV9sb2NrKTsKKworCXJl
dHVybiAwOworfQorRVhQT1JUX1NZTUJPTChwbTg2MHhfZnJlZV9pcnEpOworCitzdGF0aWMgaW50
IF9fZGV2aW5pdCBfXzg4cG04NjA3X2lycV9pbml0KHN0cnVjdCBwbTg2MHhfY2hpcCAqY2hpcCwK
KwkJCQkJIHN0cnVjdCBwbTg2MHhfcGxhdF9kYXRhICpwZGF0YSkKK3sKKwl1bnNpZ25lZCBjaGFy
IHN0YXR1c19idWZbSU5UX1NUQVRVU19OVU1dOworCWludCBpcnEsIGRhdGEsIG1hc2ssIHJldCA9
IC1FSU5WQUw7CisKKwltdXRleF9pbml0KCZjaGlwLT5pcnFfbG9jayk7CisKKwltYXNrID0gUE04
NjA3X0IwX01JU0MxX0lOVl9JTlQgfCBQTTg2MDdfQjBfTUlTQzFfSU5UX0NMRUFSCisJCXwgUE04
NjA3X0IwX01JU0MxX0lOVF9NQVNLOworCWRhdGEgPSBQTTg2MDdfQjBfTUlTQzFfSU5UX0NMRUFS
OworCWNoaXAtPmlycV9tb2RlID0gMTsKKwlzd2l0Y2ggKGNoaXAtPmNoaXBfaWQpIHsKKwljYXNl
IFBNODYwN19DSElQX0EwOgorCWNhc2UgUE04NjA3X0NISVBfQTE6CisJCXJldCA9IHBtODYweF9z
ZXRfYml0cyhjaGlwLT5wYXJlbnQsIERFU0NfODYwNywKKwkJCQlQTTg2MDdfQTFfTUlTQzEsIG1h
c2ssIGRhdGEpOworCQlicmVhazsKKwljYXNlIFBNODYwN19DSElQX0IwOgorCWRlZmF1bHQ6CisJ
CWlmIChwZGF0YSkgeworCQkJLyoKKwkJCSAqIGlycV9tb2RlIGRlZmluZXMgdGhlIHdheSBvZiBj
bGVhcmluZyBpbnRlcnJ1cHQuIElmCisJCQkgKiBpdCdzIDEsIGNsZWFyIElSUSBieSB3cml0ZS4g
T3RoZXJ3aXNlLCBjbGVhciBpdCBieQorCQkJICogcmVhZC4KKwkJCSAqIFRoaXMgY29udHJvbCBi
aXQgaXMgdmFsaWQgZnJvbSA4OFBNODYwNyBCMCBzdGVwaW5nLgorCQkJICovCisJCQlpZiAoIXBk
YXRhLT5pcnFfbW9kZSkgeworCQkJCWRhdGEgPSAwOworCQkJCWNoaXAtPmlycV9tb2RlID0gMDsK
KwkJCX0KKwkJfQorCQlyZXQgPSBwbTg2MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVNDXzg2
MDcsCisJCQkJUE04NjA3X0IwX01JU0MxLCBtYXNrLCBkYXRhKTsKKwkJYnJlYWs7CisJfQorCWlm
IChyZXQgPCAwKQorCQlnb3RvIG91dDsKKworCS8qIG1hc2sgYWxsIElSUXMgKi8KKwltZW1zZXQo
c3RhdHVzX2J1ZiwgMCwgSU5UX1NUQVRVU19OVU0pOworCXJldCA9IHBtODYweF9idWxrX3dyaXRl
KGNoaXAtPnBhcmVudCwgREVTQ184NjA3LCBQTTg2MDdfSU5UX01BU0tfMSwKKwkJCQlJTlRfU1RB
VFVTX05VTSwgc3RhdHVzX2J1Zik7CisJaWYgKHJldCA8IDApCisJCWdvdG8gb3V0OworCisJaWYg
KGNoaXAtPmlycV9tb2RlKSB7CisJCS8qIGNsZWFyIGludGVycnVwdCBzdGF0dXMgYnkgd3JpdGUg
Ki8KKwkJbWVtc2V0KHN0YXR1c19idWYsIDB4RkYsIElOVF9TVEFUVVNfTlVNKTsKKwkJcmV0ID0g
cG04NjB4X2J1bGtfd3JpdGUoY2hpcC0+cGFyZW50LCBERVNDXzg2MDcsCisJCQkJCVBNODYwN19J
TlRfU1RBVFVTMSwKKwkJCQkJSU5UX1NUQVRVU19OVU0sIHN0YXR1c19idWYpOworCX0gZWxzZSB7
CisJCS8qIGNsZWFyIGludGVycnVwdCBzdGF0dXMgYnkgcmVhZCAqLworCQlyZXQgPSBwbTg2MHhf
YnVsa19yZWFkKGNoaXAtPnBhcmVudCwgREVTQ184NjA3LAorCQkJCQlQTTg2MDdfSU5UX1NUQVRV
UzEsCisJCQkJCUlOVF9TVEFUVVNfTlVNLCBzdGF0dXNfYnVmKTsKKwl9CisJaWYgKHJldCA8IDAp
CisJCWdvdG8gb3V0OworCisJbWVtc2V0KGNoaXAtPmlycSwgMCwgc2l6ZW9mKHN0cnVjdCBwbTg2
MHhfaXJxKSAqIFBNODYwWF9OVU1fSVJRKTsKKworCWlmIChjaGlwLT5jbGllbnQgPT0gTlVMTCkK
KwkJZ290byBvdXQ7CisKKwlpcnEgPSBjaGlwLT5jbGllbnQtPmlycTsKKwlyZXQgPSByZXF1ZXN0
X3RocmVhZGVkX2lycShpcnEsIE5VTEwsIHBtODYwN19pcnFfdGhyZWFkLAorCQkJCUlSUUZfT05F
U0hPVCB8IElSUUZfVFJJR0dFUl9MT1csCisJCQkJIjg4cG04NjA3IiwgY2hpcCk7CisJaWYgKHJl
dCA8IDApIHsKKwkJZGV2X2VycihjaGlwLT5kZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBJUlEgIyVk
LlxuIiwgaXJxKTsKKwkJZ290byBvdXQ7CisJfQorCWNoaXAtPmNoaXBfaXJxID0gcmV0OworCXJl
dHVybiAwOworb3V0OgorCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyB2b2lkIF9fZGV2ZXhpdCBf
Xzg4cG04NjB4X2lycV9leGl0KHN0cnVjdCBwbTg2MHhfY2hpcCAqY2hpcCkKK3sKKwlpZiAoY2hp
cC0+Y2hpcF9pcnEgPj0gMCkKKwkJZnJlZV9pcnEoY2hpcC0+Y2hpcF9pcnEsIGNoaXApOworfQor
CiBzdGF0aWMgaW50IF9fZGV2aW5pdCBfXzg4cG04NjA2X2luaXQoc3RydWN0IHBtODYweF9jaGlw
ICpjaGlwLCB2b2lkICpwZGF0YSkKIHsKIAljaGlwLT5wYXJlbnQgPSAmbWl4ZWRfY2hpcDsKIAlt
aXhlZF9jaGlwLnBtODYwNiA9IGNoaXA7CisJY2hpcC0+Y2hpcF9pcnEgPSAtRUlOVkFMOwogCiAJ
cmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgX19kZXZpbml0IF9fODhwbTg2MDdfaW5pdChzdHJ1
Y3QgcG04NjB4X2NoaXAgKmNoaXAsCi0JCQkJICAgICBzdHJ1Y3QgcG04NjA3X3BsYXRfZGF0YSAq
cGRhdGEpCisJCQkJICAgICBzdHJ1Y3QgcG04NjB4X3BsYXRfZGF0YSAqcGRhdGEpCiB7Ci0JaW50
IHJldCA9IDA7CisJaW50IGRhdGEgPSAwLCByZXQgPSAwOwogCiAJY2hpcC0+cGFyZW50ID0gJm1p
eGVkX2NoaXA7CiAJbWl4ZWRfY2hpcC5wbTg2MDcgPSBjaGlwOworCWNoaXAtPmNoaXBfaXJxID0g
LUVJTlZBTDsKIAogCXJldCA9IHBtODYweF9yZWdfcmVhZChjaGlwLT5wYXJlbnQsIERFU0NfODYw
NywgUE04NjA3X0NISVBfSUQpOwogCWlmIChyZXQgPCAwKSB7CkBAIC0xMDgsMjAgKzMxNiwzMCBA
QCBzdGF0aWMgaW50IF9fZGV2aW5pdCBfXzg4cG04NjA3X2luaXQoc3RydWN0IHBtODYweF9jaGlw
ICpjaGlwLAogCWlmIChyZXQgJiBQTTg2MDdfQlVDSzNfRE9VQkxFKQogCQljaGlwLT5wYXJlbnQt
PmJ1Y2szX2RvdWJsZSA9IDE7CiAKLQlyZXQgPSBwbTg2MHhfcmVnX3JlYWQoY2hpcC0+cGFyZW50
LCBERVNDXzg2MDcsIFBNODYwN19NSVNDMSk7Ci0JaWYgKHJldCA8IDApIHsKLQkJZGV2X2Vycihj
aGlwLT5kZXYsICJGYWlsZWQgdG8gcmVhZCBNSVNDMSByZWdpc3RlcjogJWRcbiIsIHJldCk7Ci0J
CWdvdG8gb3V0OworCWlmIChwZGF0YSAmJiAocGRhdGEtPmkyY19wb3J0ID09IFBJMkNfUE9SVCkp
IHsKKwkJc3dpdGNoIChjaGlwLT5jaGlwX2lkKSB7CisJCWNhc2UgUE04NjA3X0NISVBfQTA6CisJ
CWNhc2UgUE04NjA3X0NISVBfQTE6CisJCQlkYXRhID0gUE04NjA3X0ExX01JU0MxX1BJMkM7CisJ
CQlyZXQgPSBwbTg2MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVNDXzg2MDcsCisJCQkJCVBN
ODYwN19BMV9NSVNDMSwgZGF0YSwgZGF0YSk7CisJCQlicmVhazsKKwkJY2FzZSBQTTg2MDdfQ0hJ
UF9CMDoKKwkJZGVmYXVsdDoKKwkJCWRhdGEgPSBQTTg2MDdfQjBfTUlTQzFfUEkyQzsKKwkJCXJl
dCA9IHBtODYweF9zZXRfYml0cyhjaGlwLT5wYXJlbnQsIERFU0NfODYwNywKKwkJCQkJUE04NjA3
X0IwX01JU0MxLCBkYXRhLCBkYXRhKTsKKwkJCWJyZWFrOworCQl9CisJCWlmIChyZXQgPCAwKSB7
CisJCQlkZXZfZXJyKGNoaXAtPmRldiwgIkZhaWxlZCB0byBhY2Nlc3MgTUlTQzE6JWRcbiIsIHJl
dCk7CisJCQlnb3RvIG91dDsKKwkJfQogCX0KLQlpZiAocGRhdGEgJiYgKHBkYXRhLT5pMmNfcG9y
dCA9PSBQSTJDX1BPUlQpKQotCQlyZXQgfD0gUE04NjA3X01JU0MxX1BJMkM7Ci0JZWxzZQotCQly
ZXQgJj0gflBNODYwN19NSVNDMV9QSTJDOwotCXJldCA9IHBtODYweF9yZWdfd3JpdGUoY2hpcC0+
cGFyZW50LCBERVNDXzg2MDcsIFBNODYwN19NSVNDMSwgcmV0KTsKLQlpZiAocmV0IDwgMCkgewot
CQlkZXZfZXJyKGNoaXAtPmRldiwgIkZhaWxlZCB0byB3cml0ZSBNSVNDMSByZWdpc3RlcjogJWRc
biIsIHJldCk7CisKKwlyZXQgPSBfXzg4cG04NjA3X2lycV9pbml0KGNoaXAsIHBkYXRhKTsKKwlp
ZiAocmV0IDwgMCkKIAkJZ290byBvdXQ7Ci0JfQogb3V0OgogCXJldHVybiByZXQ7CiB9CkBAIC0x
MzYsNyArMzU0LDcgQEAgaW50IF9fZGV2aW5pdCBwbTg2MHhfZGV2aWNlX2luaXQoc3RydWN0IHBt
ODYweF9jaGlwICpjaGlwLCB2b2lkICpwZGF0YSkKIAkJbXV0ZXhfaW5pdCgmbWl4ZWRfY2hpcC5p
b19sb2NrKTsKIAogCWlmICghc3RyY21wKGNoaXAtPmlkLm5hbWUsICI4OFBNODYwNyIpKSB7Ci0J
CXJldCA9IF9fODhwbTg2MDdfaW5pdChjaGlwLCAoc3RydWN0IHBtODYwN19wbGF0X2RhdGEgKilw
ZGF0YSk7CisJCXJldCA9IF9fODhwbTg2MDdfaW5pdChjaGlwLCAoc3RydWN0IHBtODYweF9wbGF0
X2RhdGEgKilwZGF0YSk7CiAJCWlmIChyZXQgPCAwKQogCQkJZ290byBvdXQ7CiAKQEAgLTE2MCw2
ICszNzgsNyBAQCBvdXQ6CiAKIHZvaWQgX19kZXZleGl0IHBtODYwN19kZXZpY2VfZXhpdChzdHJ1
Y3QgcG04NjB4X2NoaXAgKmNoaXApCiB7CisJX184OHBtODYweF9pcnFfZXhpdChjaGlwKTsKIAlt
ZmRfcmVtb3ZlX2RldmljZXMoY2hpcC0+ZGV2KTsKIH0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tZmQvODhwbTg2MHguaCBiL2luY2x1ZGUvbGludXgvbWZkLzg4cG04NjB4LmgKaW5kZXgg
ZmQ4ZThhZC4uOTlhNWE3ZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvODhwbTg2MHgu
aAorKysgYi9pbmNsdWRlL2xpbnV4L21mZC84OHBtODYweC5oCkBAIC0xMiw2ICsxMiw4IEBACiAj
aWZuZGVmIF9fTElOVVhfTUZEXzg4UE04NjBYX0gKICNkZWZpbmUgX19MSU5VWF9NRkRfODhQTTg2
MFhfSAogCisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisKIGVudW0gewogCURFU0NfSU5W
QUwgPSAwLAogCURFU0NfODYwNiwKQEAgLTEwOSwzMyArMTExLDEwIEBAIGVudW0gewogCiAvKiBN
aXNjIFJlZ2lzdGVycyAqLwogI2RlZmluZSBQTTg2MDdfQ0hJUF9JRAkJCSgweDAwKQorI2RlZmlu
ZSBQTTg2MDdfQjBfTUlTQzEJCQkoMHgwQykKICNkZWZpbmUgUE04NjA3X0xETzEJCQkoMHgxMCkK
ICNkZWZpbmUgUE04NjA3X0RWQzMJCQkoMHgyNikKLSNkZWZpbmUgUE04NjA3X01JU0MxCQkJKDB4
NDApCi0KLS8qIGJpdCBkZWZpbml0aW9ucyBmb3IgUE04NjA3IGV2ZW50cyAqLwotI2RlZmluZSBQ
TTg2MDdfRVZFTlRfT05LRVkJCSgxIDw8IDApCi0jZGVmaW5lIFBNODYwN19FVkVOVF9FWFRPTgkJ
KDEgPDwgMSkKLSNkZWZpbmUgUE04NjA3X0VWRU5UX0NIRwkJKDEgPDwgMikKLSNkZWZpbmUgUE04
NjA3X0VWRU5UX0JBVAkJKDEgPDwgMykKLSNkZWZpbmUgUE04NjA3X0VWRU5UX1JUQwkJKDEgPDwg
NCkKLSNkZWZpbmUgUE04NjA3X0VWRU5UX0NDCQkJKDEgPDwgNSkKLSNkZWZpbmUgUE04NjA3X0VW
RU5UX1ZCQVQJCSgxIDw8IDgpCi0jZGVmaW5lIFBNODYwN19FVkVOVF9WQ0hHCQkoMSA8PCA5KQot
I2RlZmluZSBQTTg2MDdfRVZFTlRfVlNZUwkJKDEgPDwgMTApCi0jZGVmaW5lIFBNODYwN19FVkVO
VF9USU5UCQkoMSA8PCAxMSkKLSNkZWZpbmUgUE04NjA3X0VWRU5UX0dQQURDMAkJKDEgPDwgMTIp
Ci0jZGVmaW5lIFBNODYwN19FVkVOVF9HUEFEQzEJCSgxIDw8IDEzKQotI2RlZmluZSBQTTg2MDdf
RVZFTlRfR1BBREMyCQkoMSA8PCAxNCkKLSNkZWZpbmUgUE04NjA3X0VWRU5UX0dQQURDMwkJKDEg
PDwgMTUpCi0jZGVmaW5lIFBNODYwN19FVkVOVF9BVURJT19TSE9SVAkoMSA8PCAxNikKLSNkZWZp
bmUgUE04NjA3X0VWRU5UX1BFTgkJKDEgPDwgMTcpCi0jZGVmaW5lIFBNODYwN19FVkVOVF9IRUFE
U0VUCQkoMSA8PCAxOCkKLSNkZWZpbmUgUE04NjA3X0VWRU5UX0hPT0sJCSgxIDw8IDE5KQotI2Rl
ZmluZSBQTTg2MDdfRVZFTlRfTUlDSU4JCSgxIDw8IDIwKQotI2RlZmluZSBQTTg2MDdfRVZFTlRf
Q0hHX1RJTUVPVVQJKDEgPDwgMjEpCi0jZGVmaW5lIFBNODYwN19FVkVOVF9DSEdfRE9ORQkJKDEg
PDwgMjIpCi0jZGVmaW5lIFBNODYwN19FVkVOVF9DSEdfRkFVTFQJCSgxIDw8IDIzKQorI2RlZmlu
ZSBQTTg2MDdfQTFfTUlTQzEJCQkoMHg0MCkKIAogLyogYml0IGRlZmluaXRpb25zIG9mIFN0YXR1
cyBRdWVyeSBJbnRlcmZhY2UgKi8KICNkZWZpbmUgUE04NjA3X1NUQVRVU19DQwkJKDEgPDwgMykK
QEAgLTE1NCw3ICsxMzMsMTIgQEAgZW51bSB7CiAjZGVmaW5lIFBNODYwN19CVUNLM19ET1VCTEUJ
CSgxIDw8IDYpCiAKIC8qIGJpdCBkZWZpbml0aW9ucyBvZiBNaXNjMSAqLwotI2RlZmluZSBQTTg2
MDdfTUlTQzFfUEkyQwkJKDEgPDwgMCkKKyNkZWZpbmUgUE04NjA3X0ExX01JU0MxX1BJMkMJCSgx
IDw8IDApCisjZGVmaW5lIFBNODYwN19CMF9NSVNDMV9JTlZfSU5UCQkoMSA8PCAwKQorI2RlZmlu
ZSBQTTg2MDdfQjBfTUlTQzFfSU5UX0NMRUFSCSgxIDw8IDEpCisjZGVmaW5lIFBNODYwN19CMF9N
SVNDMV9JTlRfTUFTSwkoMSA8PCAyKQorI2RlZmluZSBQTTg2MDdfQjBfTUlTQzFfUEkyQwkJKDEg
PDwgMykKKyNkZWZpbmUgUE04NjA3X0IwX01JU0MxX1JFU0VUCQkoMSA8PCA2KQogCiAvKiBJbnRl
cnJ1cHQgTnVtYmVyIGluIDg4UE04NjA3ICovCiBlbnVtIHsKQEAgLTE5OSwxNCArMTgzLDI1IEBA
IHN0cnVjdCBtaXhlZF84OHBtODYweCB7CiAJaW50CQkJZmxhZ3M7CiB9OwogCisjZGVmaW5lIFBN
ODYwWF9OVU1fSVJRCQkyNAorCitzdHJ1Y3QgcG04NjB4X2lycSB7CisJaXJxX2hhbmRsZXJfdAkJ
aGFuZGxlcjsKKwl2b2lkCQkJKmRhdGE7Cit9OworCiBzdHJ1Y3QgcG04NjB4X2NoaXAgewogCXN0
cnVjdCBkZXZpY2UJCSpkZXY7Ci0Jc3RydWN0IG11dGV4CQlpb19sb2NrOwogCXN0cnVjdCBpMmNf
Y2xpZW50CSpjbGllbnQ7CiAJc3RydWN0IGkyY19kZXZpY2VfaWQJaWQ7CiAJc3RydWN0IG1peGVk
Xzg4cG04NjB4CSpwYXJlbnQ7CisJc3RydWN0IG11dGV4CQlpcnFfbG9jazsKKwlpbnQJCQljaGlw
X2lycTsKIAl1bnNpZ25lZCBjaGFyCQljaGlwX2lkOwogCisJc3RydWN0IHBtODYweF9pcnEJaXJx
W1BNODYwWF9OVU1fSVJRXTsKKwlpbnQJCQlpcnFfbW9kZTsKKwogCWludCAoKnJlYWQpKHN0cnVj
dCBwbTg2MHhfY2hpcCAqY2hpcCwgaW50IHJlZywgaW50IGJ5dGVzLCB2b2lkICpkZXN0KTsKIAlp
bnQgKCp3cml0ZSkoc3RydWN0IHBtODYweF9jaGlwICpjaGlwLCBpbnQgcmVnLCBpbnQgYnl0ZXMs
IHZvaWQgKnNyYyk7CiB9OwpAQCAtMjE4LDggKzIxMyw5IEBAIGVudW0gewogCVBJMkNfUE9SVCwK
IH07CiAKLXN0cnVjdCBwbTg2MDdfcGxhdF9kYXRhIHsKK3N0cnVjdCBwbTg2MHhfcGxhdF9kYXRh
IHsKIAlpbnQJaTJjX3BvcnQ7CS8qIENvbnRyb2xsZWQgYnkgR0kyQyBvciBQSTJDICovCisJaW50
CWlycV9tb2RlOwkvKiBDbGVhciBpbnRlcnJ1cHQgYnkgcmVhZC93cml0ZSAoMS8wKSAqLwogCXN0
cnVjdCByZWd1bGF0b3JfaW5pdF9kYXRhICpyZWd1bGF0b3JbUE04NjA3X01BWF9SRUdVTEFUT1Jd
OwogfTsKIApAQCAtMjMyLDYgKzIyOCwxMiBAQCBleHRlcm4gaW50IHBtODYweF9idWxrX3dyaXRl
KHN0cnVjdCBtaXhlZF84OHBtODYweCAqLCBpbnQsIGludCwgaW50LAogZXh0ZXJuIGludCBwbTg2
MHhfc2V0X2JpdHMoc3RydWN0IG1peGVkXzg4cG04NjB4ICosIGludCwgaW50LCB1bnNpZ25lZCBj
aGFyLAogCQkJICAgdW5zaWduZWQgY2hhcik7CiAKK2V4dGVybiBpbnQgcG04NjB4X21hc2tfaXJx
KHN0cnVjdCBwbTg2MHhfY2hpcCAqLCBpbnQpOworZXh0ZXJuIGludCBwbTg2MHhfdW5tYXNrX2ly
cShzdHJ1Y3QgcG04NjB4X2NoaXAgKiwgaW50KTsKK2V4dGVybiBpbnQgcG04NjB4X3JlcXVlc3Rf
aXJxKHN0cnVjdCBwbTg2MHhfY2hpcCAqLCBpbnQsCisJCQkgICAgICBpcnFfaGFuZGxlcl90IGhh
bmRsZXIsIHZvaWQgKik7CitleHRlcm4gaW50IHBtODYweF9mcmVlX2lycShzdHJ1Y3QgcG04NjB4
X2NoaXAgKiwgaW50KTsKKwogZXh0ZXJuIGludCBwbTg2MHhfZGV2aWNlX2luaXQoc3RydWN0IHBt
ODYweF9jaGlwICpjaGlwLCB2b2lkICpwZGF0YSk7CiBleHRlcm4gdm9pZCBwbTg2MHhfZGV2aWNl
X2V4aXQoc3RydWN0IHBtODYweF9jaGlwICpjaGlwKTsKIAotLSAKMS41LjYuNQoK
--00151773da30083edf04788b4bfe--

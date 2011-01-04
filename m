From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue,  4 Jan 2011 16:34:58 +1100
Subject: [PATCH v4 3/4] mc13xxx-core: Move spi specific code into separate
	module.
In-Reply-To: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1294119299-18352-4-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves all spi specific code into a new module. The mc13xxx
struct moves to the include file by necessity.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/Makefile        |    1 +
 drivers/mfd/mc13xxx-core.c  |  166 ------------------------------------------
 drivers/mfd/mc13xxx-spi.c   |  168 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mc13xxx.h |   21 ++++++
 4 files changed, 190 insertions(+), 166 deletions(-)
 create mode 100644 drivers/mfd/mc13xxx-spi.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f54b365..492e881 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
 obj-$(CONFIG_TWL6030_PWM)	+= twl6030-pwm.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
+obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d1f1d7b..3201041 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -15,31 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/interrupt.h>
-#include <linux/spi/spi.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
 
-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
-};
-
-struct mc13xxx {
-	struct spi_device *spidev;
-
-	struct device *dev;
-	enum mc13xxx_id ictype;
-
-	struct mutex lock;
-
-	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
-	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
-
-	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
-	void *irqdata[MC13XXX_NUM_IRQ];
-};
-
 struct mc13783 {
 	struct mc13xxx mc13xxx;
 
@@ -180,38 +158,6 @@ void mc13xxx_unlock(struct mc13xxx *mc13xxx)
 }
 EXPORT_SYMBOL(mc13xxx_unlock);
 
-#define MC13XXX_REGOFFSET_SHIFT 25
-static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
-				unsigned int offset, u32 *val)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	int ret;
-
-	*val = offset << MC13XXX_REGOFFSET_SHIFT;
-
-	memset(&t, 0, sizeof(t));
-
-	t.tx_buf = val;
-	t.rx_buf = val;
-	t.len = sizeof(u32);
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-
-	ret = spi_sync(mc13xxx->spidev, &m);
-
-	/* error in message.status implies error return from spi_sync */
-	BUG_ON(!ret && m.status);
-
-	if (ret)
-		return ret;
-
-	*val &= 0xffffff;
-
-	return 0;
-}
-
 int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
 {
 	int ret;
@@ -228,35 +174,6 @@ int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
 }
 EXPORT_SYMBOL(mc13xxx_reg_read);
 
-static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int offset,
-		u32 val)
-{
-	u32 buf;
-	struct spi_transfer t;
-	struct spi_message m;
-	int ret;
-
-	buf = 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
-
-	memset(&t, 0, sizeof(t));
-
-	t.tx_buf = &buf;
-	t.rx_buf = &buf;
-	t.len = sizeof(u32);
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t, &m);
-
-	ret = spi_sync(mc13xxx->spidev, &m);
-
-	BUG_ON(!ret && m.status);
-
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
 {
 	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
@@ -717,41 +634,6 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
 	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
 }
 
-static int mc13xxx_probe(struct spi_device *spi)
-{
-	struct mc13xxx *mc13xxx;
-	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
-	int ret;
-
-	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
-	if (!mc13xxx)
-		return -ENOMEM;
-
-	dev_set_drvdata(&spi->dev, mc13xxx);
-	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
-	spi->bits_per_word = 32;
-	spi_setup(spi);
-
-	mc13xxx->dev = &spi->dev;
-	mc13xxx->spidev = spi;
-	mc13xxx->read_dev = mc13xxx_spi_reg_read;
-	mc13xxx->write_dev = mc13xxx_spi_reg_write;
-
-	ret = mc13xxx_common_init(mc13xxx, pdata, spi->irq);
-
-	if (ret) {
-		dev_set_drvdata(&spi->dev, NULL);
-	} else {
-		const struct spi_device_id *devid =
-			spi_get_device_id(mc13xxx->spidev);
-		if (!devid || devid->driver_data != mc13xxx->ictype)
-			dev_warn(mc13xxx->dev,
-				"device id doesn't match auto detection!\n");
-	}
-
-	return ret;
-}
-
 int mc13xxx_common_init(struct mc13xxx *mc13xxx,
 		struct mc13xxx_platform_data *pdata, int irq)
 {
@@ -817,54 +699,6 @@ err_revision:
 }
 EXPORT_SYMBOL_GPL(mc13xxx_common_init);
 
-static int __devexit mc13xxx_remove(struct spi_device *spi)
-{
-	struct mc13xxx *mc13xxx = dev_get_drvdata(&spi->dev);
-
-	free_irq(mc13xxx->spidev->irq, mc13xxx);
-
-	mfd_remove_devices(&spi->dev);
-
-	kfree(mc13xxx);
-
-	return 0;
-}
-
-static const struct spi_device_id mc13xxx_device_id[] = {
-	{
-		.name = "mc13783",
-		.driver_data = MC13XXX_ID_MC13783,
-	}, {
-		.name = "mc13892",
-		.driver_data = MC13XXX_ID_MC13892,
-	}, {
-		/* sentinel */
-	}
-};
-
-static struct spi_driver mc13xxx_driver = {
-	.id_table = mc13xxx_device_id,
-	.driver = {
-		.name = "mc13xxx",
-		.bus = &spi_bus_type,
-		.owner = THIS_MODULE,
-	},
-	.probe = mc13xxx_probe,
-	.remove = __devexit_p(mc13xxx_remove),
-};
-
-static int __init mc13xxx_init(void)
-{
-	return spi_register_driver(&mc13xxx_driver);
-}
-subsys_initcall(mc13xxx_init);
-
-static void __exit mc13xxx_exit(void)
-{
-	spi_unregister_driver(&mc13xxx_driver);
-}
-module_exit(mc13xxx_exit);
-
 MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
 MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
new file mode 100644
index 0000000..d8ffff7
--- /dev/null
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * loosely based on an earlier driver that has
+ * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mc13xxx.h>
+
+#define MC13XXX_REGOFFSET_SHIFT 25
+static int mc13xxx_spi_reg_read(struct mc13xxx *mc13xxx,
+				unsigned int offset, u32 *val)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
+	*val = offset << MC13XXX_REGOFFSET_SHIFT;
+
+	memset(&t, 0, sizeof(t));
+
+	t.tx_buf = val;
+	t.rx_buf = val;
+	t.len = sizeof(u32);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret = spi_sync(mc13xxx->spidev, &m);
+
+	/* error in message.status implies error return from spi_sync */
+	BUG_ON(!ret && m.status);
+
+	if (ret)
+		return ret;
+
+	*val &= 0xffffff;
+
+	return 0;
+}
+
+static int mc13xxx_spi_reg_write(struct mc13xxx *mc13xxx, unsigned int offset,
+		u32 val)
+{
+	u32 buf;
+	struct spi_transfer t;
+	struct spi_message m;
+	int ret;
+
+	buf = 1 << 31 | offset << MC13XXX_REGOFFSET_SHIFT | val;
+
+	memset(&t, 0, sizeof(t));
+
+	t.tx_buf = &buf;
+	t.rx_buf = &buf;
+	t.len = sizeof(u32);
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret = spi_sync(mc13xxx->spidev, &m);
+
+	BUG_ON(!ret && m.status);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mc13xxx_spi_probe(struct spi_device *spi)
+{
+	struct mc13xxx *mc13xxx;
+	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
+	int ret;
+
+	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
+	if (!mc13xxx)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, mc13xxx);
+	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
+	spi->bits_per_word = 32;
+	spi_setup(spi);
+
+	mc13xxx->dev = &spi->dev;
+	mc13xxx->spidev = spi;
+	mc13xxx->read_dev = mc13xxx_spi_reg_read;
+	mc13xxx->write_dev = mc13xxx_spi_reg_write;
+
+	ret = mc13xxx_common_init(mc13xxx, pdata, spi->irq);
+
+	if (ret) {
+		dev_set_drvdata(&spi->dev, NULL);
+	} else {
+		const struct spi_device_id *devid =
+			spi_get_device_id(mc13xxx->spidev);
+		if (!devid || devid->driver_data != mc13xxx->ictype)
+			dev_warn(mc13xxx->dev,
+				"device id doesn't match auto detection!\n");
+	}
+
+	return ret;
+}
+
+static int __devexit mc13xxx_spi_remove(struct spi_device *spi)
+{
+	struct mc13xxx *mc13xxx = dev_get_drvdata(&spi->dev);
+
+	free_irq(mc13xxx->spidev->irq, mc13xxx);
+
+	mfd_remove_devices(&spi->dev);
+
+	kfree(mc13xxx);
+
+	return 0;
+}
+
+static const struct spi_device_id mc13xxx_device_id[] = {
+	{
+		.name = "mc13783",
+		.driver_data = MC13XXX_ID_MC13783,
+	}, {
+		.name = "mc13892",
+		.driver_data = MC13XXX_ID_MC13892,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct spi_driver mc13xxx_spi_driver = {
+	.id_table = mc13xxx_device_id,
+	.driver = {
+		.name = "mc13xxx",
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe = mc13xxx_spi_probe,
+	.remove = __devexit_p(mc13xxx_spi_remove),
+};
+
+static int __init mc13xxx_spi_init(void)
+{
+	return spi_register_driver(&mc13xxx_spi_driver);
+}
+subsys_initcall(mc13xxx_spi_init);
+
+static void __exit mc13xxx_spi_exit(void)
+{
+	spi_unregister_driver(&mc13xxx_spi_driver);
+}
+module_exit(mc13xxx_spi_exit);
+
+MODULE_DESCRIPTION("Core driver for Freescale MC13XXX PMIC");
+MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index f5d277d..ab7deb3 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -66,6 +66,27 @@ int mc13xxx_get_flags(struct mc13xxx *mc13xxx);
 
 #define MC13XXX_NUM_IRQ		46
 
+enum mc13xxx_id {
+	MC13XXX_ID_MC13783,
+	MC13XXX_ID_MC13892,
+	MC13XXX_ID_INVALID,
+};
+
+struct mc13xxx {
+	struct spi_device *spidev;
+
+	struct device *dev;
+	enum mc13xxx_id ictype;
+
+	struct mutex lock;
+
+	int (*read_dev)(struct mc13xxx *, unsigned int, u32 *);
+	int (*write_dev)(struct mc13xxx *, unsigned int, u32);
+
+	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
+	void *irqdata[MC13XXX_NUM_IRQ];
+};
+
 struct regulator_init_data;
 
 struct mc13xxx_regulator_init_data {
-- 
1.7.1

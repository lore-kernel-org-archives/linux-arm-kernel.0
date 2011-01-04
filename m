From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue,  4 Jan 2011 16:34:59 +1100
Subject: [PATCH v4 4/4] mc13xxx-core: Add i2c driver
In-Reply-To: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1294119299-18352-5-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/Kconfig         |    5 ++
 drivers/mfd/Makefile        |    1 +
 drivers/mfd/mc13xxx-i2c.c   |  115 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mc13xxx.h |    5 ++-
 4 files changed, 125 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mfd/mc13xxx-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 9ce1d42..fbbbdaa 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -455,6 +455,11 @@ config MFD_MC13XXX_SPI
 	select MFD_MC13XXX
 	depends on SPI_MASTER && (MFD_MC13783 || MFD_MC13892)
 
+config MFD_MC13XXX_I2C
+	tristate "Support Freescale MC13892 via I2C interface"
+	select MFD_MC13XXX
+	depends on I2C && MFD_MC13892
+
 config PCF50633_ADC
 	tristate "Support for NXP PCF50633 ADC"
 	depends on MFD_PCF50633
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 492e881..b7d774f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_TWL6030_PWM)	+= twl6030-pwm.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
+obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
new file mode 100644
index 0000000..b3f2f2b
--- /dev/null
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright 2009-2010 Creative Product Design
+ * Marc Reilly marc at cpdesign.com.au
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
+#include <linux/mfd/core.h>
+#include <linux/mfd/mc13xxx.h>
+#include <linux/i2c.h>
+
+static int mc13xxx_i2c_reg_read(struct mc13xxx *mc13xxx, unsigned int offset,
+		u32 *val)
+{
+	int ret;
+	unsigned char buf[3] = {0, 0, 0};
+
+	ret = i2c_smbus_read_i2c_block_data(mc13xxx->i2cclient,
+			offset, 3, buf);
+	*val = buf[0] << 16 | buf[1] << 8 | buf[2];
+
+	return ret == 3 ? 0 : ret;
+}
+
+static int mc13xxx_i2c_reg_write(struct mc13xxx *mc13xxx, unsigned int offset,
+		u32 val)
+{
+	int ret;
+	unsigned char buf[3];
+
+	buf[0] = (val >> 16) & 0xff;
+	buf[1] = (val >> 8) & 0xff;
+	buf[2] = val & 0xff;
+
+	ret = i2c_smbus_write_i2c_block_data(mc13xxx->i2cclient,
+			offset, 3, buf);
+
+	return ret;
+}
+
+static int mc13xxx_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct mc13xxx *mc13xxx;
+	struct mc13xxx_platform_data *pdata = dev_get_platdata(&client->dev);
+	int ret;
+
+	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
+	if (!mc13xxx)
+		return -ENOMEM;
+
+	dev_set_drvdata(&client->dev, mc13xxx);
+	mc13xxx->dev = &client->dev;
+	mc13xxx->i2cclient = client;
+	mc13xxx->read_dev = mc13xxx_i2c_reg_read;
+	mc13xxx->write_dev = mc13xxx_i2c_reg_write;
+
+	ret = mc13xxx_common_init(mc13xxx, pdata, client->irq);
+
+	if (ret == 0 && (id->driver_data != mc13xxx->ictype))
+		dev_warn(mc13xxx->dev,
+				"device id doesn't match auto detection!\n");
+
+	return ret;
+}
+
+static int __devexit mc13xxx_i2c_remove(struct i2c_client *client)
+{
+	struct mc13xxx *mc13xxx = dev_get_drvdata(&client->dev);
+
+	free_irq(client->irq, mc13xxx);
+
+	mfd_remove_devices(&client->dev);
+
+	kfree(mc13xxx);
+
+	return 0;
+}
+
+static const struct i2c_device_id mc13xxx_i2c_idtable[] = {
+	{"mc13892", MC13XXX_ID_MC13892},
+	{ }
+};
+
+static struct i2c_driver mc13xxx_i2c_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "mc13xxx-i2c"
+	},
+	.id_table = mc13xxx_i2c_idtable,
+	.probe = mc13xxx_i2c_probe,
+	.remove = __devexit_p(mc13xxx_i2c_remove),
+};
+
+static int __init mc13xxx_i2c_init(void)
+{
+	return i2c_add_driver(&mc13xxx_i2c_driver);
+}
+subsys_initcall(mc13xxx_i2c_init);
+
+static void __exit mc13xxx_i2c_exit(void)
+{
+	i2c_del_driver(&mc13xxx_i2c_driver);
+}
+module_exit(mc13xxx_i2c_exit);
+
+MODULE_DESCRIPTION("i2c driver for Freescale MC13XXX PMIC");
+MODULE_AUTHOR("Marc Reilly <marc@cpdesign.com.au");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index ab7deb3..c5ab08b 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -73,7 +73,10 @@ enum mc13xxx_id {
 };
 
 struct mc13xxx {
-	struct spi_device *spidev;
+	union {
+		struct spi_device *spidev;
+		struct i2c_client *i2cclient;
+	};
 
 	struct device *dev;
 	enum mc13xxx_id ictype;
-- 
1.7.1

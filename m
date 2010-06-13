From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 13 Jun 2010 17:25:51 +0200
Subject: [PATCH v3] ISL6271A voltage regulator support.
Message-ID: <1276442751-3562-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device is very simple, it supports one buck and two LDOs. The LDOs are
fixed-voltage. Only the buck is programable over the I2C bus to 16 possible
voltages.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/regulator/Kconfig              |    6 +
 drivers/regulator/Makefile             |    1 +
 drivers/regulator/isl6271a-regulator.c |  236 ++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/isl6271a-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 04f2e08..6772ca7 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -201,5 +201,11 @@ config REGULATOR_88PM8607
 	help
 	  This driver supports 88PM8607 voltage regulator chips.
 
+config REGULATOR_ISL6271A
+	tristate "Intersil ISL6271A Power regulator"
+	depends on I2C
+	help
+	  This driver supports ISL6271A voltage regulator chip.
+
 endif
 
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 4e7feec..e2191bf 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -31,5 +31,6 @@ obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
 obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6507X) += tps6507x-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
+obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
new file mode 100644
index 0000000..e49d2bd
--- /dev/null
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -0,0 +1,236 @@
+/*
+ * isl6271a-regulator.c
+ *
+ * Support for Intersil ISL6271A voltage regulator
+ *
+ * Copyright (C) 2010 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#define	ISL6271A_VOLTAGE_MIN	850000
+#define	ISL6271A_VOLTAGE_MAX	1600000
+#define	ISL6271A_VOLTAGE_STEP	50000
+
+/* PMIC details */
+struct isl_pmic {
+	struct i2c_client	*client;
+	struct regulator_dev	*rdev[3];
+	struct mutex		mtx;
+};
+
+static int isl6271a_get_voltage(struct regulator_dev *dev)
+{
+	struct isl_pmic *pmic = rdev_get_drvdata(dev);
+	int idx, data;
+
+	mutex_lock(&pmic->mtx);
+
+	idx = i2c_smbus_read_byte(pmic->client);
+	if (idx < 0) {
+		dev_err(&pmic->client->dev, "Error getting voltage\n");
+		data = idx;
+		goto out;
+	}
+
+	/* Convert the data from chip to microvolts */
+	data = ISL6271A_VOLTAGE_MIN + (ISL6271A_VOLTAGE_STEP * (idx & 0xf));
+
+out:
+	mutex_unlock(&pmic->mtx);
+	return data;
+}
+
+static int isl6271a_set_voltage(struct regulator_dev *dev, int minuV, int maxuV)
+{
+	struct isl_pmic *pmic = rdev_get_drvdata(dev);
+	int vsel, err, data;
+
+	if (minuV < ISL6271A_VOLTAGE_MIN || minuV > ISL6271A_VOLTAGE_MAX)
+		return -EINVAL;
+	if (maxuV < ISL6271A_VOLTAGE_MIN || maxuV > ISL6271A_VOLTAGE_MAX)
+		return -EINVAL;
+
+	/* Align to 50000 mV */
+	vsel = minuV - (minuV % ISL6271A_VOLTAGE_STEP);
+
+	/* If the result fell out of [minuV,maxuV] range, put it back */
+	if (vsel < minuV)
+		vsel += ISL6271A_VOLTAGE_STEP;
+
+	/* Convert the microvolts to data for the chip */
+	data = (vsel - ISL6271A_VOLTAGE_MIN) / ISL6271A_VOLTAGE_STEP;
+
+	mutex_lock(&pmic->mtx);
+
+	err = i2c_smbus_write_byte(pmic->client, data);
+	if (err < 0)
+		dev_err(&pmic->client->dev, "Error setting voltage\n");
+
+	mutex_unlock(&pmic->mtx);
+	return err;
+}
+
+static int isl6271a_list_voltage(struct regulator_dev *dev, unsigned selector)
+{
+	return ISL6271A_VOLTAGE_MIN + (ISL6271A_VOLTAGE_STEP * selector);
+}
+
+static struct regulator_ops isl_core_ops = {
+	.get_voltage	= isl6271a_get_voltage,
+	.set_voltage	= isl6271a_set_voltage,
+	.list_voltage	= isl6271a_list_voltage,
+};
+
+static int isl6271a_get_fixed_voltage(struct regulator_dev *dev)
+{
+	int id = rdev_get_id(dev);
+	return (id == 1) ? 1100000 : 1300000;
+}
+
+static int isl6271a_list_fixed_voltage(struct regulator_dev *dev, unsigned selector)
+{
+	int id = rdev_get_id(dev);
+	return (id == 1) ? 1100000 : 1300000;
+}
+
+static struct regulator_ops isl_fixed_ops = {
+	.get_voltage	= isl6271a_get_fixed_voltage,
+	.list_voltage	= isl6271a_list_fixed_voltage,
+};
+
+static struct regulator_desc isl_rd[] = {
+	{
+		.name		= "Core Buck",
+		.id		= 0,
+		.n_voltages	= 16,
+		.ops		= &isl_core_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+	}, {
+		.name		= "LDO1",
+		.id		= 1,
+		.n_voltages	= 1,
+		.ops		= &isl_fixed_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+	}, {
+		.name		= "LDO2",
+		.id		= 2,
+		.n_voltages	= 1,
+		.ops		= &isl_fixed_ops,
+		.type		= REGULATOR_VOLTAGE,
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __devinit isl6271a_probe(struct i2c_client *i2c,
+				     const struct i2c_device_id *id)
+{
+	struct regulator_init_data *init_data	= i2c->dev.platform_data;
+	struct isl_pmic *pmic;
+	int err, i;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	if (!init_data) {
+		dev_err(&i2c->dev, "no platform data supplied\n");
+		return -EIO;
+	}
+
+	pmic = kzalloc(sizeof(struct isl_pmic), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
+	pmic->client = i2c;
+
+	mutex_init(&pmic->mtx);
+
+	for (i = 0; i < 3; i++) {
+		pmic->rdev[i] = regulator_register(&isl_rd[0], &i2c->dev,
+						init_data, pmic);
+		if (IS_ERR(pmic->rdev[i])) {
+			dev_err(&i2c->dev, "failed to register %s\n", id->name);
+			err = PTR_ERR(pmic->rdev);
+			goto error;
+		}
+	}
+
+	i2c_set_clientdata(i2c, pmic);
+
+	return 0;
+
+error:
+	while (--i >= 0)
+		regulator_unregister(pmic->rdev[i]);
+
+	kfree(pmic);
+	return err;
+}
+
+static int __devexit isl6271a_remove(struct i2c_client *i2c)
+{
+	struct isl_pmic *pmic = i2c_get_clientdata(i2c);
+	int i;
+
+	i2c_set_clientdata(i2c, NULL);
+
+	for (i = 0; i < 3; i++)
+		regulator_unregister(pmic->rdev[i]);
+
+	kfree(pmic);
+
+	return 0;
+}
+
+static const struct i2c_device_id isl6271a_id[] = {
+	{.name = "isl6271a", 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, isl6271a_id);
+
+static struct i2c_driver isl6271a_i2c_driver = {
+	.driver = {
+		.name = "isl6271a",
+		.owner = THIS_MODULE,
+	},
+	.probe = isl6271a_probe,
+	.remove = __devexit_p(isl6271a_remove),
+	.id_table = isl6271a_id,
+};
+
+static int __init isl6271a_init(void)
+{
+	return i2c_add_driver(&isl6271a_i2c_driver);
+}
+
+static void __exit isl6271a_cleanup(void)
+{
+	i2c_del_driver(&isl6271a_i2c_driver);
+}
+
+subsys_initcall(isl6271a_init);
+module_exit(isl6271a_cleanup);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("Intersil ISL6271A voltage regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.1

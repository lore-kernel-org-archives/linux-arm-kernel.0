From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 18 Dec 2009 10:02:16 -0500
Subject: [PATCH] regulator: add max8925 support
Message-ID: <mailman.105.1261399667.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX8925 contains 3 Buck and 20 LDO regulator.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/Kconfig   |    6 +
 drivers/regulator/Makefile  |    1 +
 drivers/regulator/max8925.c |  346 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/max8925.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index bcbb161..72b334c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -69,6 +69,12 @@ config REGULATOR_MAX1586
 	  regulator via I2C bus. The provided regulator is suitable
 	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.

+config REGULATOR_MAX8925
+	tristate "Maxim MAX8925 Power Management IC"
+	depends on MFD_MAX8925
+	help
+	  Say y here to support the voltage regulaltor of Maxim MAX8925 PMIC.
+
 config REGULATOR_TWL4030
 	bool "TI TWL4030/TWL5030/TPS695x0 PMIC"
 	depends on TWL4030_CORE
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 4257a86..2c20507 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) +=
userspace-consumer.o
 obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
+obj-$(CONFIG_REGULATOR_MAX8925) += max8925.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
diff --git a/drivers/regulator/max8925.c b/drivers/regulator/max8925.c
new file mode 100644
index 0000000..dca0b17
--- /dev/null
+++ b/drivers/regulator/max8925.c
@@ -0,0 +1,346 @@
+/*
+ * Regulators driver for Maxim max8925
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *      Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/mfd/max8925.h>
+
+#define SD1_DVM_VMIN		(850000)
+#define SD1_DVM_VMAX		(1000000)
+#define SD1_DVM_STEP		(50000)
+#define SD1_DVM_SHIFT		(5)		/* SDCTL1 bit5 */
+#define SD1_DVM_EN		(6)		/* SDV1 bit 6 */
+
+struct max8925_regulator_info {
+	struct regulator_desc	desc;
+	struct regulator_dev	*regulator;
+	struct i2c_client	*i2c;
+	struct max8925_chip	*chip;
+
+	int	min_uV;
+	int	max_uV;
+	int	step_uV;
+	int	vol_reg;
+	int	vol_shift;
+	int	vol_nbits;
+	int	enable_bit;
+	int	enable_reg;
+};
+
+static inline int check_range(struct max8925_regulator_info *info,
+			      int min_uV, int max_uV)
+{
+	if (min_uV < info->min_uV || min_uV > info->max_uV)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int max8925_list_voltage(struct regulator_dev *rdev, unsigned index)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+	return (info->min_uV + index * info->step_uV);
+}
+
+static int max8925_set_voltage(struct regulator_dev *rdev,
+			       int min_uV, int max_uV)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned char data, mask;
+
+	if (check_range(info, min_uV, max_uV)) {
+		dev_err(info->chip->dev, "invalid voltage range (%d, %d) uV\n",
+			min_uV, max_uV);
+		return -EINVAL;
+	}
+	data = (min_uV - info->min_uV + info->step_uV - 1) / info->step_uV;
+	data <<= info->vol_shift;
+	mask = ((1 << info->vol_nbits) - 1) << info->vol_shift;
+
+	return max8925_set_bits(info->i2c, info->vol_reg, mask, data);
+}
+
+static int max8925_get_voltage(struct regulator_dev *rdev)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned char data, mask;
+	int ret;
+
+	ret = max8925_reg_read(info->i2c, info->vol_reg);
+	if (ret < 0)
+		return ret;
+	mask = ((1 << info->vol_nbits) - 1) << info->vol_shift;
+	data = (ret & mask) >> info->vol_shift;
+
+	return max8925_list_voltage(rdev, data);
+}
+
+static int max8925_enable(struct regulator_dev *rdev)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return max8925_set_bits(info->i2c, info->enable_reg,
+				1 << info->enable_bit,
+				1 << info->enable_bit);
+}
+
+static int max8925_disable(struct regulator_dev *rdev)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return max8925_set_bits(info->i2c, info->enable_reg,
+				1 << info->enable_bit, 0);
+}
+
+static int max8925_is_enabled(struct regulator_dev *rdev)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = max8925_reg_read(info->i2c, info->vol_reg);
+	if (ret < 0)
+		return ret;
+
+	return (ret & (1 << info->enable_bit));
+}
+
+static int max8925_set_dvm_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned char data, mask;
+
+	if ((uV < SD1_DVM_VMIN) || (uV > SD1_DVM_VMAX))
+		return -EINVAL;
+
+	data = (uV - SD1_DVM_VMIN + SD1_DVM_STEP - 1) / SD1_DVM_STEP;
+	data <<= SD1_DVM_SHIFT;
+	mask = 3 << SD1_DVM_SHIFT;
+
+	return max8925_set_bits(info->i2c, info->enable_reg, mask, data);
+}
+
+static int max8925_set_dvm_enable(struct regulator_dev *rdev)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return max8925_set_bits(info->i2c, info->vol_reg, 1 << SD1_DVM_EN,
+				1 << SD1_DVM_EN);
+}
+
+static int max8925_set_dvm_disable(struct regulator_dev *rdev)
+{
+	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return max8925_set_bits(info->i2c, info->vol_reg, 1 << SD1_DVM_EN, 0);
+}
+
+static struct regulator_ops max8925_regulator_sdv_ops = {
+	.set_voltage		= max8925_set_voltage,
+	.get_voltage		= max8925_get_voltage,
+	.enable			= max8925_enable,
+	.disable		= max8925_disable,
+	.is_enabled		= max8925_is_enabled,
+	.set_suspend_voltage	= max8925_set_dvm_voltage,
+	.set_suspend_enable	= max8925_set_dvm_enable,
+	.set_suspend_disable	= max8925_set_dvm_disable,
+};
+
+static struct regulator_ops max8925_regulator_ldo_ops = {
+	.set_voltage		= max8925_set_voltage,
+	.get_voltage		= max8925_get_voltage,
+	.enable			= max8925_enable,
+	.disable		= max8925_disable,
+	.is_enabled		= max8925_is_enabled,
+};
+
+#define MAX8925_SDV(_id, min, max, step)			\
+{								\
+	.desc	= {						\
+		.name	= "SDV" #_id,				\
+		.ops	= &max8925_regulator_sdv_ops,		\
+		.type	= REGULATOR_VOLTAGE,			\
+		.id	= MAX8925_ID_SD##_id,			\
+		.owner	= THIS_MODULE,				\
+	},							\
+	.min_uV		= min * 1000,				\
+	.max_uV		= max * 1000,				\
+	.step_uV	= step * 1000,				\
+	.vol_reg	= MAX8925_SDV##_id,			\
+	.vol_shift	= (0),					\
+	.vol_nbits	= (6),					\
+	.enable_reg	= MAX8925_SDCTL##_id,			\
+	.enable_bit	= (0),					\
+}
+
+#define MAX8925_LDO(_id, min, max, step)			\
+{								\
+	.desc	= {						\
+		.name	= "LDO" #_id,				\
+		.ops	= &max8925_regulator_ldo_ops,		\
+		.type	= REGULATOR_VOLTAGE,			\
+		.id	= MAX8925_ID_LDO##_id,			\
+		.owner	= THIS_MODULE,				\
+	},							\
+	.min_uV		= min * 1000,				\
+	.max_uV		= max * 1000,				\
+	.step_uV	= step * 1000,				\
+	.vol_reg	= MAX8925_LDOVOUT##_id,			\
+	.vol_shift	= (0),					\
+	.vol_nbits	= (6),					\
+	.enable_reg	= MAX8925_LDOCTL##_id,			\
+	.enable_bit	= (0),					\
+}
+
+static struct max8925_regulator_info max8925_regulator_info[] = {
+	MAX8925_SDV(1, 637.5, 1425, 12.5),
+	MAX8925_SDV(2,   650, 2225,   25),
+	MAX8925_SDV(3,   750, 3900,   50),
+
+	MAX8925_LDO(1,  750, 3900, 50),
+	MAX8925_LDO(2,  650, 2250, 25),
+	MAX8925_LDO(3,  650, 2250, 25),
+	MAX8925_LDO(4,  750, 3900, 50),
+	MAX8925_LDO(5,  750, 3900, 50),
+	MAX8925_LDO(6,  750, 3900, 50),
+	MAX8925_LDO(7,  750, 3900, 50),
+	MAX8925_LDO(8,  750, 3900, 50),
+	MAX8925_LDO(9,  750, 3900, 50),
+	MAX8925_LDO(10, 750, 3900, 50),
+	MAX8925_LDO(11, 750, 3900, 50),
+	MAX8925_LDO(12, 750, 3900, 50),
+	MAX8925_LDO(13, 750, 3900, 50),
+	MAX8925_LDO(14, 750, 3900, 50),
+	MAX8925_LDO(15, 750, 3900, 50),
+	MAX8925_LDO(16, 750, 3900, 50),
+	MAX8925_LDO(17, 650, 2250, 25),
+	MAX8925_LDO(18, 650, 2250, 25),
+	MAX8925_LDO(19, 750, 3900, 50),
+	MAX8925_LDO(20, 750, 3900, 50),
+};
+
+static inline struct max8925_regulator_info *find_regulator_info(int id)
+{
+	struct max8925_regulator_info *ri;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(max8925_regulator_info); i++) {
+		ri = &max8925_regulator_info[i];
+		if (ri->desc.id == id)
+			return ri;
+	}
+	return NULL;
+}
+
+static int __devinit max8925_regulator_probe(struct platform_device *pdev)
+{
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct max8925_platform_data *pdata = chip->dev->platform_data;
+	struct max8925_regulator_info *ri = NULL;
+	struct regulator_dev *rdev;
+
+	ri = find_regulator_info(pdev->id);
+	if (ri == NULL) {
+		dev_err(&pdev->dev, "invalid regulator ID specified\n");
+		return -EINVAL;
+	}
+	ri->i2c = chip->i2c;
+	ri->chip = chip;
+
+	rdev = regulator_register(&ri->desc, &pdev->dev,
+				  pdata->regulator[pdev->id], ri);
+	if (IS_ERR(rdev)) {
+		dev_err(&pdev->dev, "failed to register regulator %s\n",
+				ri->desc.name);
+		return PTR_ERR(rdev);
+	}
+
+	platform_set_drvdata(pdev, rdev);
+	return 0;
+}
+
+static int __devexit max8925_regulator_remove(struct platform_device *pdev)
+{
+	struct regulator_dev *rdev = platform_get_drvdata(pdev);
+
+	regulator_unregister(rdev);
+	return 0;
+}
+
+#define MAX8925_REGULATOR_DRIVER(_name)				\
+{								\
+	.driver		= {					\
+		.name	= "max8925-" #_name,			\
+		.owner	= THIS_MODULE,				\
+	},							\
+	.probe		= max8925_regulator_probe,		\
+	.remove		= __devexit_p(max8925_regulator_remove),\
+}
+
+static struct platform_driver max8925_regulator_driver[] = {
+	MAX8925_REGULATOR_DRIVER(sd1),
+	MAX8925_REGULATOR_DRIVER(sd2),
+	MAX8925_REGULATOR_DRIVER(sd3),
+	MAX8925_REGULATOR_DRIVER(ldo1),
+	MAX8925_REGULATOR_DRIVER(ldo2),
+	MAX8925_REGULATOR_DRIVER(ldo3),
+	MAX8925_REGULATOR_DRIVER(ldo4),
+	MAX8925_REGULATOR_DRIVER(ldo5),
+	MAX8925_REGULATOR_DRIVER(ldo6),
+	MAX8925_REGULATOR_DRIVER(ldo7),
+	MAX8925_REGULATOR_DRIVER(ldo8),
+	MAX8925_REGULATOR_DRIVER(ldo9),
+	MAX8925_REGULATOR_DRIVER(ldo10),
+	MAX8925_REGULATOR_DRIVER(ldo11),
+	MAX8925_REGULATOR_DRIVER(ldo12),
+	MAX8925_REGULATOR_DRIVER(ldo13),
+	MAX8925_REGULATOR_DRIVER(ldo14),
+	MAX8925_REGULATOR_DRIVER(ldo15),
+	MAX8925_REGULATOR_DRIVER(ldo16),
+	MAX8925_REGULATOR_DRIVER(ldo17),
+	MAX8925_REGULATOR_DRIVER(ldo18),
+	MAX8925_REGULATOR_DRIVER(ldo19),
+	MAX8925_REGULATOR_DRIVER(ldo20),
+};
+
+static int __init max8925_regulator_init(void)
+{
+	int i, count, ret;
+
+	count = ARRAY_SIZE(max8925_regulator_driver);
+	for (i = 0; i < count; i++) {
+		ret = platform_driver_register(&max8925_regulator_driver[i]);
+		if (ret != 0)
+			pr_err("Failed to register regulator driver: %d\n",
+				ret);
+	}
+	return 0;
+}
+module_init(max8925_regulator_init);
+
+static void __exit max8925_regulator_exit(void)
+{
+	int i, count;
+
+	count = ARRAY_SIZE(max8925_regulator_driver);
+	for (i = 0; i < count; i++)
+		platform_driver_unregister(&max8925_regulator_driver[i]);
+}
+module_exit(max8925_regulator_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_DESCRIPTION("Regulator Driver for Maxim 8925 PMIC");
+MODULE_ALIAS("platform:max8925-regulator");
+
-- 
1.5.6.5

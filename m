From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:27 +0100
Subject: [PATCH 07/11] regulators: Versatile Express regulator driver
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-8-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementation of the regulator framework driver for the
Versatile Express voltage control. Devices without
voltage constraints (ie. "regulator-[min|max]-microvolt"
properties in the DT node) are treated as fixed (or rather
read-only) regulators.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/regulator/Kconfig    |    7 ++
 drivers/regulator/Makefile   |    1 +
 drivers/regulator/vexpress.c |  144 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/regulator/vexpress.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4e932cc..7642773 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -404,6 +404,13 @@ config REGULATOR_TWL4030
 	  This driver supports the voltage regulators provided by
 	  this family of companion chips.
 
+config REGULATOR_VEXPRESS
+	tristate "Versatile Express regulators"
+	depends on VEXPRESS_CONFIG_BUS
+	help
+	  This driver provides support for voltage regulators available
+	  on the ARM Ltd's Versatile Express platform.
+
 config REGULATOR_WM831X
 	tristate "Wolfson Microelectronics WM831x PMIC regulators"
 	depends on MFD_WM831X
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3342615..0d4e10f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o
+obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
diff --git a/drivers/regulator/vexpress.c b/drivers/regulator/vexpress.c
new file mode 100644
index 0000000..c659b2e
--- /dev/null
+++ b/drivers/regulator/vexpress.c
@@ -0,0 +1,144 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#define DRVNAME "vexpress-regulator"
+#define pr_fmt(fmt) DRVNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/vexpress.h>
+
+struct vexpress_regulator {
+	struct regulator_desc desc;
+	struct regulator_dev *regdev;
+	struct vexpress_config_device *vecdev;
+};
+
+static int vexpress_regulator_get_voltage(struct regulator_dev *regdev)
+{
+	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
+	u32 uV;
+	int err = vexpress_config_read(reg->vecdev, 0, &uV);
+
+	return err ? err : uV;
+}
+
+static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
+		int min_uV, int max_uV, unsigned *selector)
+{
+	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
+
+	return vexpress_config_write(reg->vecdev, 0, min_uV);
+}
+
+static struct regulator_ops vexpress_regulator_ops_ro = {
+	.get_voltage = vexpress_regulator_get_voltage,
+};
+
+static struct regulator_ops vexpress_regulator_ops = {
+	.get_voltage = vexpress_regulator_get_voltage,
+	.set_voltage = vexpress_regulator_set_voltage,
+};
+
+static int vexpress_regulator_probe(struct vexpress_config_device *vecdev)
+{
+	struct vexpress_regulator *reg;
+	struct regulator_init_data *init_data;
+	struct regulator_config config = { };
+
+	reg = devm_kzalloc(&vecdev->dev, sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	reg->vecdev = vecdev;
+
+	reg->desc.name = dev_name(&vecdev->dev);
+	reg->desc.type = REGULATOR_VOLTAGE;
+	reg->desc.owner = THIS_MODULE;
+
+	init_data = of_get_regulator_init_data(&vecdev->dev,
+			vecdev->dev.of_node);
+	if (!init_data) {
+		dev_err(&vecdev->dev, "Failed to get regulator data!\n");
+		return -EINVAL;
+	}
+
+	init_data->constraints.apply_uV = 0;
+	if (init_data->constraints.min_uV && init_data->constraints.max_uV)
+		reg->desc.ops = &vexpress_regulator_ops;
+	else
+		reg->desc.ops = &vexpress_regulator_ops_ro;
+
+	config.dev = &vecdev->dev;
+	config.init_data = init_data;
+	config.driver_data = reg;
+	config.of_node = vecdev->dev.of_node;
+
+	reg->regdev = regulator_register(&reg->desc, &config);
+	if (IS_ERR(reg->regdev)) {
+		dev_err(&vecdev->dev, "Failed to register regulator! (%ld)\n",
+				PTR_ERR(reg->regdev));
+		return PTR_ERR(reg->regdev);
+	}
+
+	vexpress_config_set_drvdata(vecdev, reg);
+
+	return 0;
+}
+
+static int __devexit vexpress_regulator_remove(struct vexpress_config_device
+		*vecdev)
+{
+	struct vexpress_regulator *reg = vexpress_config_get_drvdata(vecdev);
+
+	regulator_unregister(reg->regdev);
+
+	return 0;
+}
+
+static const unsigned vexpress_regulator_funcs[] = {
+	VEXPRESS_CONFIG_FUNC_VOLT,
+	0,
+};
+
+static struct vexpress_config_driver vexpress_regulator_driver = {
+	.funcs = vexpress_regulator_funcs,
+	.probe = vexpress_regulator_probe,
+	.remove = __devexit_p(vexpress_regulator_remove),
+	.driver	= {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init vexpress_regulator_init(void)
+{
+	return vexpress_config_driver_register(&vexpress_regulator_driver);
+}
+
+static void __exit vexpress_regulator_exit(void)
+{
+	vexpress_config_driver_unregister(&vexpress_regulator_driver);
+}
+
+MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
+MODULE_DESCRIPTION("Versatile Express regulator");
+MODULE_LICENSE("GPL");
+
+module_init(vexpress_regulator_init);
+module_exit(vexpress_regulator_exit);
-- 
1.7.9.5

From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 15:17:46 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
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
 drivers/regulator/vexpress.c |  155 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/regulator/vexpress.c

Hi Liam, Mark,

Do you think it would be possible to have this merged in time for 3.7?

Cheers!

Pawel

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4e932cc..a823951 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -404,6 +404,13 @@ config REGULATOR_TWL4030
 	  This driver supports the voltage regulators provided by
 	  this family of companion chips.
 
+config REGULATOR_VEXPRESS
+	tristate "Versatile Express regulators"
+	depends on VEXPRESS_CONFIG
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
index 0000000..a2682bb
--- /dev/null
+++ b/drivers/regulator/vexpress.c
@@ -0,0 +1,155 @@
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
+	struct vexpress_config_func *func;
+};
+
+static int vexpress_regulator_get_voltage(struct regulator_dev *regdev)
+{
+	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
+	u32 uV;
+	int err = vexpress_config_read(reg->func, 0, &uV);
+
+	return err ? err : uV;
+}
+
+static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
+		int min_uV, int max_uV, unsigned *selector)
+{
+	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
+
+	return vexpress_config_write(reg->func, 0, min_uV);
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
+static int vexpress_regulator_probe(struct platform_device *pdev)
+{
+	int err;
+	struct vexpress_regulator *reg;
+	struct regulator_init_data *init_data;
+	struct regulator_config config = { };
+
+	reg = devm_kzalloc(&pdev->dev, sizeof(*reg), GFP_KERNEL);
+	if (!reg) {
+		err = -ENOMEM;
+		goto error_kzalloc;
+	}
+
+	reg->func = vexpress_config_func_get_by_dev(&pdev->dev);
+	if (!reg->func) {
+		err = -ENXIO;
+		goto error_get_func;
+	}
+
+	reg->desc.name = dev_name(&pdev->dev);
+	reg->desc.type = REGULATOR_VOLTAGE;
+	reg->desc.owner = THIS_MODULE;
+
+	init_data = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node);
+	if (!init_data) {
+		err = -EINVAL;
+		goto error_get_regulator_init_data;
+	}
+
+	init_data->constraints.apply_uV = 0;
+	if (init_data->constraints.min_uV && init_data->constraints.max_uV)
+		reg->desc.ops = &vexpress_regulator_ops;
+	else
+		reg->desc.ops = &vexpress_regulator_ops_ro;
+
+	config.dev = &pdev->dev;
+	config.init_data = init_data;
+	config.driver_data = reg;
+	config.of_node = pdev->dev.of_node;
+
+	reg->regdev = regulator_register(&reg->desc, &config);
+	if (IS_ERR(reg->regdev)) {
+		err = PTR_ERR(reg->regdev);
+		goto error_regulator_register;
+	}
+
+	platform_set_drvdata(pdev, reg);
+
+	return 0;
+
+error_regulator_register:
+error_get_regulator_init_data:
+	vexpress_config_func_put(reg->func);
+error_get_func:
+error_kzalloc:
+	return err;
+}
+
+static int __devexit vexpress_regulator_remove(struct platform_device *pdev)
+{
+	struct vexpress_regulator *reg = platform_get_drvdata(pdev);
+
+	vexpress_config_func_put(reg->func);
+	regulator_unregister(reg->regdev);
+
+	return 0;
+}
+
+static struct of_device_id vexpress_regulator_of_match[] = {
+	{ .compatible = "arm,vexpress-volt", },
+};
+
+static struct platform_driver vexpress_regulator_driver = {
+	.probe = vexpress_regulator_probe,
+	.remove = __devexit_p(vexpress_regulator_remove),
+	.driver	= {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+		.of_match_table = vexpress_regulator_of_match,
+	},
+};
+
+static int __init vexpress_regulator_init(void)
+{
+	return platform_driver_register(&vexpress_regulator_driver);
+}
+
+static void __exit vexpress_regulator_exit(void)
+{
+	platform_driver_unregister(&vexpress_regulator_driver);
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

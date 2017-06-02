From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  2 Jun 2017 18:51:53 +0800
Subject: [PATCH v3 3/6] regulator: hi6421v530: add driver for hi6421v530
 voltage regulator
In-Reply-To: <20170602105156.11351-1-guodong.xu@linaro.org>
References: <20170602105156.11351-1-guodong.xu@linaro.org>
Message-ID: <20170602105156.11351-4-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>

add the driver for hi6421v530 voltage regulator

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/regulator/Kconfig                |  10 ++
 drivers/regulator/Makefile               |   1 +
 drivers/regulator/hi6421v530-regulator.c | 207 +++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/regulator/hi6421v530-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 48db87d..78cd8d8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -296,6 +296,16 @@ config REGULATOR_HI6421
 	  21 general purpose LDOs, 3 dedicated LDOs, and 5 BUCKs. All
 	  of them come with support to either ECO (idle) or sleep mode.
 
+config REGULATOR_HI6421V530
+	tristate "HiSilicon Hi6421v530 PMIC voltage regulator support"
+	depends on MFD_HI6421_PMIC && OF
+	help
+	  This driver provides support for the voltage regulators on
+	  HiSilicon Hi6421v530 PMU / Codec IC.
+	  Hi6421v530 is a multi-function device which, on regulator part,
+	  provides 5 general purpose LDOs, and all of them come with support
+	  to either ECO (idle) or sleep mode.
+
 config REGULATOR_HI655X
 	tristate "Hisilicon HI655X PMIC regulators support"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index dc3503f..36e2b75 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421) += hi6421-regulator.o
+obj-$(CONFIG_REGULATOR_HI6421V530) += hi6421v530-regulator.o
 obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
new file mode 100644
index 0000000..46bbba9
--- /dev/null
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -0,0 +1,207 @@
+/*
+ * Device driver for regulators in Hi6421V530 IC
+ *
+ * Copyright (c) <2017> HiSilicon Technologies Co., Ltd.
+ *              http://www.hisilicon.com
+ * Copyright (c) <2017> Linaro Ltd.
+ *              http://www.linaro.org
+ *
+ * Author: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
+ *         Guodong Xu <guodong.xu@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mfd/hi6421-pmic.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+/*
+ * struct hi6421v530_regulator_info - hi6421v530 regulator information
+ * @desc: regulator description
+ * @mode_mask: ECO mode bitmask of LDOs; for BUCKs, this masks sleep
+ * @eco_microamp: eco mode load upper limit (in uA), valid for LDOs only
+ */
+struct hi6421v530_regulator_info {
+	struct regulator_desc rdesc;
+	u8 mode_mask;
+	u32 eco_microamp;
+};
+
+/* HI6421v530 regulators */
+enum hi6421v530_regulator_id {
+	HI6421V530_LDO3,
+	HI6421V530_LDO9,
+	HI6421V530_LDO11,
+	HI6421V530_LDO15,
+	HI6421V530_LDO16,
+};
+
+static const unsigned int ldo_3_voltages[] = {
+	1800000, 1825000, 1850000, 1875000,
+	1900000, 1925000, 1950000, 1975000,
+	2000000, 2025000, 2050000, 2075000,
+	2100000, 2125000, 2150000, 2200000,
+};
+
+static const unsigned int ldo_9_11_voltages[] = {
+	1750000, 1800000, 1825000, 2800000,
+	2850000, 2950000, 3000000, 3300000,
+};
+
+static const unsigned int ldo_15_16_voltages[] = {
+	1750000, 1800000, 2400000, 2600000,
+	2700000, 2850000, 2950000, 3000000,
+};
+
+static const struct regulator_ops hi6421v530_ldo_ops;
+
+#define HI6421V530_LDO_ENABLE_TIME (350)
+
+/*
+ * _id - LDO id name string
+ * v_table - voltage table
+ * vreg - voltage select register
+ * vmask - voltage select mask
+ * ereg - enable register
+ * emask - enable mask
+ * odelay - off/on delay time in uS
+ * ecomask - eco mode mask
+ * ecoamp - eco mode load uppler limit in uA
+ */
+#define HI6421V530_LDO(_ID, v_table, vreg, vmask, ereg, emask,		\
+		   odelay, ecomask, ecoamp) {				\
+	.rdesc = {							\
+		.name		 = #_ID,				\
+		.of_match        = of_match_ptr(#_ID),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.ops		 = &hi6421v530_ldo_ops,			\
+		.type		 = REGULATOR_VOLTAGE,			\
+		.id		 = HI6421V530_##_ID,			\
+		.owner		 = THIS_MODULE,				\
+		.n_voltages	 = ARRAY_SIZE(v_table),			\
+		.volt_table	 = v_table,				\
+		.vsel_reg	 = HI6421_REG_TO_BUS_ADDR(vreg),	\
+		.vsel_mask	 = vmask,				\
+		.enable_reg	 = HI6421_REG_TO_BUS_ADDR(ereg),	\
+		.enable_mask	 = emask,				\
+		.enable_time	 = HI6421V530_LDO_ENABLE_TIME,		\
+		.off_on_delay	 = odelay,				\
+	},								\
+	.mode_mask	= ecomask,					\
+	.eco_microamp	= ecoamp,					\
+}
+
+/* HI6421V530 regulator information */
+
+static struct hi6421v530_regulator_info hi6421v530_regulator_info[] = {
+	HI6421V530_LDO(LDO3, ldo_3_voltages, 0x061, 0xf, 0x060, 0x2,
+		   20000, 0x6, 8000),
+	HI6421V530_LDO(LDO9, ldo_9_11_voltages, 0x06b, 0x7, 0x06a, 0x2,
+		   40000, 0x6, 8000),
+	HI6421V530_LDO(LDO11, ldo_9_11_voltages, 0x06f, 0x7, 0x06e, 0x2,
+		   40000, 0x6, 8000),
+	HI6421V530_LDO(LDO15, ldo_15_16_voltages, 0x077, 0x7, 0x076, 0x2,
+		   40000, 0x6, 8000),
+	HI6421V530_LDO(LDO16, ldo_15_16_voltages, 0x079, 0x7, 0x078, 0x2,
+		   40000, 0x6, 8000),
+};
+
+static unsigned int hi6421v530_regulator_ldo_get_mode(
+					struct regulator_dev *rdev)
+{
+	struct hi6421v530_regulator_info *info;
+	unsigned int reg_val;
+
+	info = rdev_get_drvdata(rdev);
+	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
+
+	if (reg_val & (info->mode_mask))
+		return REGULATOR_MODE_IDLE;
+
+	return REGULATOR_MODE_NORMAL;
+}
+
+static int hi6421v530_regulator_ldo_set_mode(struct regulator_dev *rdev,
+						unsigned int mode)
+{
+	struct hi6421v530_regulator_info *info;
+	unsigned int new_mode;
+
+	info = rdev_get_drvdata(rdev);
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		new_mode = 0;
+		break;
+	case REGULATOR_MODE_IDLE:
+		new_mode = info->mode_mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+			   info->mode_mask, new_mode);
+
+	return 0;
+}
+
+
+static const struct regulator_ops hi6421v530_ldo_ops = {
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_mode = hi6421v530_regulator_ldo_get_mode,
+	.set_mode = hi6421v530_regulator_ldo_set_mode,
+};
+
+static int hi6421v530_regulator_probe(struct platform_device *pdev)
+{
+	struct hi6421_pmic *pmic;
+	struct regulator_dev *rdev;
+	struct regulator_config config = { };
+	unsigned int i;
+
+	pmic = dev_get_drvdata(pdev->dev.parent);
+	if (!pmic) {
+		dev_err(&pdev->dev, "no pmic in the regulator parent node\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hi6421v530_regulator_info); i++) {
+		config.dev = pdev->dev.parent;
+		config.regmap = pmic->regmap;
+		config.driver_data = &hi6421v530_regulator_info[i];
+
+		rdev = devm_regulator_register(&pdev->dev,
+				&hi6421v530_regulator_info[i].rdesc,
+				&config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register regulator %s\n",
+				hi6421v530_regulator_info[i].rdesc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+	return 0;
+}
+
+static struct platform_driver hi6421v530_regulator_driver = {
+	.driver = {
+		.name	= "hi6421v530-regulator",
+	},
+	.probe	= hi6421v530_regulator_probe,
+};
+module_platform_driver(hi6421v530_regulator_driver);
+
+MODULE_AUTHOR("Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>");
+MODULE_DESCRIPTION("Hi6421v530 regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.10.2

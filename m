From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 28 Nov 2014 11:54:29 +0800
Subject: [PATCH v2 3/8] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1417146874-5232-4-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add MT6397 regulator driver.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   2 +-
 drivers/regulator/mt6397-regulator.c       | 369 +++++++++++++++++++++++++++++
 include/linux/regulator/mt6397-regulator.h |  49 ++++
 4 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 drivers/regulator/mt6397-regulator.c
 create mode 100644 include/linux/regulator/mt6397-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 55d7b7b..38a8d84 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -433,6 +433,15 @@ config REGULATOR_MC13892
 	  Say y here to support the regulators found on the Freescale MC13892
 	  PMIC.
 
+config REGULATOR_MT6397
+	tristate "MediaTek MT6397 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6397 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_PALMAS
 	tristate "TI Palmas PMIC Regulators"
 	depends on MFD_PALMAS
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1029ed3..2f45812 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_REGULATOR_MAX77802) += max77802.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
+obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
@@ -96,5 +97,4 @@ obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
 obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
 obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
 
-
 ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
new file mode 100644
index 0000000..d85d731
--- /dev/null
+++ b/drivers/regulator/mt6397-regulator.c
@@ -0,0 +1,369 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Flora Fu <flora.fu@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6397-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+/*
+ * MT6397 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @voselon_reg: Register sections for hardware control mode of bucks
+ * @nivosel_reg: Register for query output voltage selection of bucks
+ * @qi_mask: Mask for query enable signal status of regulators
+ */
+struct mt6397_regulator_info {
+	struct regulator_desc desc;
+	u32 voselon_reg;
+	u32 nivosel_reg;
+	u32 qi_mask;
+};
+
+#define MT6397_BUCK(vreg, idx, min, max, step, volt_ranges, enreg,	\
+		vosel, vosel_mask, voselon, nivosel)			\
+[MT6397_ID_##idx] = {							\
+	.desc = {							\
+		.name = vreg,						\
+		.ops = &mt6397_volt_range_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6397_ID_##idx,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(0),					\
+	},								\
+	.qi_mask = BIT(13),						\
+	.voselon_reg = voselon,						\
+	.nivosel_reg = nivosel,						\
+}
+
+#define MT6397_LDO(vreg, idx, ldo_volt_table, enreg, enbit, vosel,	\
+		vosel_mask)						\
+[MT6397_ID_##idx] = {							\
+	.desc = {							\
+		.name = vreg,						\
+		.ops = &mt6397_volt_table_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6397_ID_##idx,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+	},								\
+	.qi_mask = BIT(15),						\
+}
+
+#define MT6397_REG_FIXED(vreg, idx, enreg, enbit, volt)			\
+[MT6397_ID_##idx] = {							\
+	.desc = {							\
+		.name = vreg,						\
+		.ops = &mt6397_volt_fixed_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6397_ID_##idx,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.min_uV = volt,						\
+	},								\
+	.qi_mask = BIT(15),						\
+}
+
+static const struct regulator_linear_range buck_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
+};
+
+static const struct regulator_linear_range buck_volt_range2[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0, 0x7f, 6250),
+};
+
+static const struct regulator_linear_range buck_volt_range3[] = {
+	REGULATOR_LINEAR_RANGE(1500000, 0, 0x1f, 20000),
+};
+
+static const u32 ldo_volt_table1[] = {
+	1500000, 1800000, 2500000, 2800000,
+};
+
+static const u32 ldo_volt_table2[] = {
+	1800000, 3300000,
+};
+
+static const u32 ldo_volt_table3[] = {
+	3000000, 3300000,
+};
+
+static const u32 ldo_volt_table4[] = {
+	1220000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 3300000,
+};
+
+static const u32 ldo_volt_table5[] = {
+	1200000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 3300000,
+};
+
+static const u32 ldo_volt_table5_v2[] = {
+	1200000, 1000000, 1500000, 1800000, 2500000, 2800000, 3000000, 3300000,
+};
+
+static const u32 ldo_volt_table6[] = {
+	1200000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 2000000,
+};
+
+static const u32 ldo_volt_table7[] = {
+	1300000, 1500000, 1800000, 2000000, 2500000, 2800000, 3000000, 3300000,
+};
+
+static int mt6397_buck_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
+{
+	int ret;
+	struct mt6397_regulator_info *info = rdev_get_drvdata(rdev);
+
+	/* For HW design, buck voltage control register has two parts.
+	 * part 1: vsel_reg for register mode
+	 * part 2: voselon_reg or hw control mode
+	 * Both parts should be updated and sync when user set voltage.
+	 */
+	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
+		info->desc.vsel_mask, sel);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to update vsel: %d\n", ret);
+		return ret;
+	}
+	ret = regmap_update_bits(rdev->regmap, info->voselon_reg,
+			info->desc.vsel_mask, sel);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to update voselon: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int mt6397_buck_get_voltage_sel(struct regulator_dev *rdev)
+{
+	int ret;
+	u32 regval;
+	struct mt6397_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap, info->nivosel_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get voltage: %d\n", ret);
+		return ret;
+	}
+
+	regval &= info->desc.vsel_mask;
+	regval >>= ffs(info->desc.vsel_mask) - 1;
+
+	return regval;
+}
+
+static int mt6397_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	int ret;
+	u32 regval;
+	struct mt6397_regulator_info *info = rdev_get_drvdata(rdev);
+
+	ret = regmap_read(rdev->regmap,  info->desc.enable_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get enable reg: %d\n", ret);
+		return ret;
+	}
+
+	return (regval & info->qi_mask) ? 1 : 0;
+}
+
+static struct regulator_ops mt6397_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = mt6397_buck_set_voltage_sel,
+	.get_voltage_sel = mt6397_buck_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = mt6397_regulator_is_enabled,
+};
+
+static struct regulator_ops mt6397_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = mt6397_regulator_is_enabled,
+};
+
+static struct regulator_ops mt6397_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = mt6397_regulator_is_enabled,
+};
+
+/* The array is indexed by id(MT6397_ID_XXX) */
+static struct mt6397_regulator_info mt6397_regulators[] = {
+	MT6397_BUCK("buck_vpca15", VPCA15, 700000, 1493750, 6250,
+		buck_volt_range1, MT6397_VCA15_CON7, MT6397_VCA15_CON9, 0x7f,
+		MT6397_VCA15_CON10, MT6397_VCA15_CON12),
+	MT6397_BUCK("buck_vpca7", VPCA7, 700000, 1493750, 6250,
+		buck_volt_range1, MT6397_VPCA7_CON7, MT6397_VPCA7_CON9, 0x7f,
+		MT6397_VPCA7_CON10, MT6397_VPCA7_CON12),
+	MT6397_BUCK("buck_vsramca15", VSRAMCA15, 700000, 1493750, 6250,
+		buck_volt_range1, MT6397_VSRMCA15_CON7, MT6397_VSRMCA15_CON9,
+		0x7f, MT6397_VSRMCA15_CON10, MT6397_VSRMCA15_CON12),
+	MT6397_BUCK("buck_vsramca7", VSRAMCA7, 700000, 1493750, 6250,
+		buck_volt_range1, MT6397_VSRMCA7_CON7, MT6397_VSRMCA7_CON9,
+		0x7f, MT6397_VSRMCA7_CON10, MT6397_VSRMCA7_CON12),
+	MT6397_BUCK("buck_vcore", VCORE, 700000, 1493750, 6250,
+		buck_volt_range1, MT6397_VCORE_CON7, MT6397_VCORE_CON9, 0x7f,
+		MT6397_VCORE_CON10, MT6397_VCORE_CON12),
+	MT6397_BUCK("buck_vgpu", VGPU, 700000, 1493750, 6250, buck_volt_range1,
+		MT6397_VGPU_CON7, MT6397_VGPU_CON9, 0x7f,
+		MT6397_VGPU_CON10, MT6397_VGPU_CON12),
+	MT6397_BUCK("buck_vdrm", VDRM, 800000, 1593750, 6250, buck_volt_range2,
+		MT6397_VDRM_CON7, MT6397_VDRM_CON9, 0x7f,
+		MT6397_VDRM_CON10, MT6397_VDRM_CON12),
+	MT6397_BUCK("buck_vio18", VIO18, 1500000, 2120000, 20000,
+		buck_volt_range3, MT6397_VIO18_CON7, MT6397_VIO18_CON9, 0x1f,
+		MT6397_VIO18_CON10, MT6397_VIO18_CON12),
+	MT6397_REG_FIXED("ldo_vtcxo", VTCXO, MT6397_ANALDO_CON0, 10, 2800000),
+	MT6397_REG_FIXED("ldo_va28", VA28, MT6397_ANALDO_CON1, 14, 2800000),
+	MT6397_LDO("ldo_vcama", VCAMA, ldo_volt_table1,
+		MT6397_ANALDO_CON2, 15, MT6397_ANALDO_CON6, 0xC0),
+	MT6397_REG_FIXED("ldo_vio28", VIO28, MT6397_DIGLDO_CON0, 14, 2800000),
+	MT6397_REG_FIXED("ldo_usb", USB, MT6397_DIGLDO_CON1, 14, 3300000),
+	MT6397_LDO("ldo_vmc", VMC, ldo_volt_table2,
+		MT6397_DIGLDO_CON2, 12, MT6397_DIGLDO_CON29, 0x10),
+	MT6397_LDO("ldo_vmch", VMCH, ldo_volt_table3,
+		MT6397_DIGLDO_CON3, 14, MT6397_DIGLDO_CON17, 0x80),
+	MT6397_LDO("ldo_vemc3v3", VEMC3V3, ldo_volt_table3,
+		MT6397_DIGLDO_CON4, 14, MT6397_DIGLDO_CON18, 0x10),
+	MT6397_LDO("ldo_vcamd", VCAMD, ldo_volt_table4,
+		MT6397_DIGLDO_CON5, 15, MT6397_DIGLDO_CON19, 0xE0),
+	MT6397_LDO("ldo_vcamio", VCAMIO, ldo_volt_table5,
+		MT6397_DIGLDO_CON6, 15, MT6397_DIGLDO_CON20, 0xE0),
+	MT6397_LDO("ldo_vcamaf", VCAMAF, ldo_volt_table5,
+		MT6397_DIGLDO_CON7, 15, MT6397_DIGLDO_CON21, 0xE0),
+	MT6397_LDO("ldo_vgp4", VGP4, ldo_volt_table5,
+		MT6397_DIGLDO_CON8, 15, MT6397_DIGLDO_CON22, 0xE0),
+	MT6397_LDO("ldo_vgp5", VGP5, ldo_volt_table6,
+		MT6397_DIGLDO_CON9, 15, MT6397_DIGLDO_CON23, 0xE0),
+	MT6397_LDO("ldo_vgp6", VGP6, ldo_volt_table5,
+		MT6397_DIGLDO_CON10, 15, MT6397_DIGLDO_CON33, 0xE0),
+	MT6397_LDO("ldo_vibr", VIBR, ldo_volt_table7,
+		MT6397_DIGLDO_CON24, 15, MT6397_DIGLDO_CON25, 0xE00),
+};
+
+static int mt6397_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6397 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	struct of_regulator_match match[MT6397_MAX_REGULATOR];
+	struct device_node *np, *regulators;
+	int matched, i;
+	u32 reg_value, version;
+
+	np = of_node_get(pdev->dev.parent->of_node);
+	if (!np)
+		return -EINVAL;
+
+	regulators = of_get_child_by_name(np, "regulators");
+	if (!regulators) {
+		dev_err(&pdev->dev, "regulators node not found\n");
+		of_node_put(np);
+		return -EINVAL;
+	}
+	of_node_put(np);
+
+	for (i = 0; i < MT6397_MAX_REGULATOR; i++)
+		match[i].name = mt6397_regulators[i].desc.name;
+
+	matched = of_regulator_match(&pdev->dev, regulators, match,
+				MT6397_MAX_REGULATOR);
+	of_node_put(regulators);
+	if (matched < 0) {
+		dev_err(&pdev->dev, "Fail to parse init data: %d\n", matched);
+		return matched;
+	}
+
+	/* Read PMIC chip revision to update constraints and voltage table */
+	if (regmap_read(mt6397->regmap, MT6397_CID, &reg_value) < 0) {
+		dev_err(&pdev->dev, "Failed to read Chip ID\n");
+		return -EIO;
+	}
+	dev_info(&pdev->dev, "Chip ID = 0x%x\n", reg_value);
+	version = (reg_value & 0xFF);
+	switch (version) {
+	case MT6397_REGULATOR_ID91:
+		match[MT6397_ID_VCAMIO].init_data->constraints.min_uV = 1000000;
+		mt6397_regulators[MT6397_ID_VCAMIO].desc.volt_table =
+			ldo_volt_table5_v2;
+		break;
+	default:
+		break;
+	}
+
+	for (i = 0; i < MT6397_MAX_REGULATOR; i++) {
+		config.dev = &pdev->dev;
+		config.init_data = match[i].init_data;
+		config.of_node = match[i].of_node;
+		config.driver_data = &mt6397_regulators[i];
+		config.regmap = mt6397->regmap;
+		rdev = devm_regulator_register(&pdev->dev,
+				&mt6397_regulators[i].desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6397_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6397_regulator_id[] = {
+	{"mt6397-regulator", 0},
+	{ },
+};
+
+static struct platform_driver mt6397_regulator_driver = {
+	.driver = {
+		.name = "mt6397-regulator",
+	},
+	.probe = mt6397_regulator_probe,
+	.id_table = mt6397_regulator_id,
+};
+
+module_platform_driver(mt6397_regulator_driver);
+
+MODULE_AUTHOR("Flora Fu <flora.fu@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6397 PMIC");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mt6397-regulator");
diff --git a/include/linux/regulator/mt6397-regulator.h b/include/linux/regulator/mt6397-regulator.h
new file mode 100644
index 0000000..2169ffc
--- /dev/null
+++ b/include/linux/regulator/mt6397-regulator.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Flora Fu <flora.fu@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6397_H
+#define __LINUX_REGULATOR_MT6397_H
+
+enum {
+	MT6397_ID_VPCA15 = 0,
+	MT6397_ID_VPCA7,
+	MT6397_ID_VSRAMCA15,
+	MT6397_ID_VSRAMCA7,
+	MT6397_ID_VCORE,
+	MT6397_ID_VGPU,
+	MT6397_ID_VDRM,
+	MT6397_ID_VIO18 = 7,
+	MT6397_ID_VTCXO,
+	MT6397_ID_VA28,
+	MT6397_ID_VCAMA,
+	MT6397_ID_VIO28,
+	MT6397_ID_USB,
+	MT6397_ID_VMC,
+	MT6397_ID_VMCH,
+	MT6397_ID_VEMC3V3,
+	MT6397_ID_VCAMD,
+	MT6397_ID_VCAMIO,
+	MT6397_ID_VCAMAF,
+	MT6397_ID_VGP4,
+	MT6397_ID_VGP5,
+	MT6397_ID_VGP6,
+	MT6397_ID_VIBR,
+	MT6397_ID_RG_MAX,
+};
+
+#define MT6397_MAX_REGULATOR	MT6397_ID_RG_MAX
+#define MT6397_REGULATOR_ID97	0x97
+#define MT6397_REGULATOR_ID91	0x91
+
+#endif /* __LINUX_REGULATOR_MT6397_H */
-- 
1.8.1.1.dirty

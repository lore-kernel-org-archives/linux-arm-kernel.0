From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 22 Sep 2016 19:06:23 +0200
Subject: [PATCH v3 1/4] regulator: axp20x: move device independant parts to
 new files
In-Reply-To: <cover.1474621107.git.moinejf@free.fr>
References: <cover.1474621107.git.moinejf@free.fr>
Message-ID: <15d859a9e279da4c9624e195ab958338339ac550.1474621107.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp20x driver contains device specific and device independant parts.
This patch moves the independant parts to new .c/.h files.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/regulator/Makefile           |   2 +-
 drivers/regulator/axp-regulator.c    | 308 ++++++++++++++++++++++++++
 drivers/regulator/axp-regulator.h    | 127 +++++++++++
 drivers/regulator/axp20x-regulator.c | 415 +++--------------------------------
 4 files changed, 464 insertions(+), 388 deletions(-)
 create mode 100644 drivers/regulator/axp-regulator.c
 create mode 100644 drivers/regulator/axp-regulator.h

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2142a5d..225a026 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
 obj-$(CONFIG_REGULATOR_ARIZONA) += arizona-micsupp.o arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
-obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
+obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o axp-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
diff --git a/drivers/regulator/axp-regulator.c b/drivers/regulator/axp-regulator.c
new file mode 100644
index 0000000..0d7adb6
--- /dev/null
+++ b/drivers/regulator/axp-regulator.c
@@ -0,0 +1,308 @@
+/*
+ * AXP regulators driver
+ *
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ * Copyright (C) 2013 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/sunxi-rsb.h>
+
+#include "axp-regulator.h"
+
+#define AXP20X_WORKMODE_DCDC2_MASK	BIT(2)
+#define AXP20X_WORKMODE_DCDC3_MASK	BIT(1)
+#define AXP22X_WORKMODE_DCDCX_MASK(x)	BIT(x)
+
+#define AXP20X_FREQ_DCDC_MASK	0x0f
+
+#define AXP22X_MISC_N_VBUSEN_FUNC	BIT(4)
+
+const struct regulator_ops axp_ops_fixed = {
+	.list_voltage		= regulator_list_voltage_linear,
+};
+EXPORT_SYMBOL_GPL(axp_ops_fixed);
+
+const struct regulator_ops axp_ops_range = {
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(axp_ops_range);
+
+const struct regulator_ops axp_ops = {
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(axp_ops);
+
+const struct regulator_ops axp_ops_sw = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(axp_ops_sw);
+
+static const struct regulator_desc axp22x_drivevbus_regulator = {
+	.name		= "drivevbus",
+	.supply_name	= "drivevbus",
+	.of_match	= of_match_ptr("drivevbus"),
+	.regulators_node = of_match_ptr("regulators"),
+	.type		= REGULATOR_VOLTAGE,
+	.owner		= THIS_MODULE,
+	.enable_reg	= AXP20X_VBUS_IPSOUT_MGMT,
+	.enable_mask	= BIT(2),
+	.ops		= &axp_ops_sw,
+};
+
+static int axp_set_dcdc_freq(struct device *dev,
+					u32 dcdcfreq)
+{
+	struct axp20x_dev *axp20x = dev_get_drvdata(dev);
+	unsigned int reg = AXP20X_DCDC_FREQ;
+	u32 min, max, def, step;
+
+	switch (axp20x->variant) {
+	case AXP202_ID:
+	case AXP209_ID:
+		min = 750;
+		max = 1875;
+		def = 1500;
+		step = 75;
+		break;
+	case AXP806_ID:
+		/*
+		 * AXP806 DCDC work frequency setting has the same range and
+		 * step as AXP22X, but at a different register.
+		 * Fall through to the check below.
+		 * (See include/linux/mfd/axp20x.h)
+		 */
+		reg = AXP806_DCDC_FREQ_CTRL;
+	case AXP221_ID:
+	case AXP223_ID:
+	case AXP809_ID:
+		min = 1800;
+		max = 4050;
+		def = 3000;
+		step = 150;
+		break;
+	default:
+		dev_err(dev,
+			"Setting DCDC frequency for unsupported AXP variant\n");
+		return -EINVAL;
+	}
+
+	if (dcdcfreq == 0)
+		dcdcfreq = def;
+
+	if (dcdcfreq < min) {
+		dcdcfreq = min;
+		dev_warn(dev, "DCDC frequency too low. Set to %ukHz\n",
+			 min);
+	}
+
+	if (dcdcfreq > max) {
+		dcdcfreq = max;
+		dev_warn(dev, "DCDC frequency too high. Set to %ukHz\n",
+			 max);
+	}
+
+	dcdcfreq = (dcdcfreq - min) / step;
+
+	return regmap_update_bits(axp20x->regmap, reg,
+				  AXP20X_FREQ_DCDC_MASK, dcdcfreq);
+}
+
+static int axp_regulator_parse_dt(struct device *dev)
+{
+	struct device_node *np, *regulators;
+	int ret;
+	u32 dcdcfreq = 0;
+
+	np = of_node_get(dev->of_node);
+	if (!np)
+		return 0;
+
+	regulators = of_get_child_by_name(np, "regulators");
+	if (!regulators) {
+		dev_warn(dev, "regulators node not found\n");
+	} else {
+		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
+		ret = axp_set_dcdc_freq(dev, dcdcfreq);
+		if (ret < 0) {
+			dev_err(dev, "Error setting dcdc frequency: %d\n", ret);
+			return ret;
+		}
+
+		of_node_put(regulators);
+	}
+
+	return 0;
+}
+
+static int axp_set_dcdc_workmode(struct regulator_dev *rdev,
+				int id, u32 workmode)
+{
+	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
+	unsigned int reg = AXP20X_DCDC_MODE;
+	unsigned int mask;
+
+	switch (axp20x->variant) {
+	case AXP202_ID:
+	case AXP209_ID:
+		if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
+			return -EINVAL;
+
+		mask = AXP20X_WORKMODE_DCDC2_MASK;
+		if (id == AXP20X_DCDC3)
+			mask = AXP20X_WORKMODE_DCDC3_MASK;
+
+		workmode <<= ffs(mask) - 1;
+		break;
+
+	case AXP806_ID:
+		reg = AXP806_DCDC_MODE_CTRL2;
+		/*
+		 * AXP806 DCDC regulator IDs have the same range as AXP22X.
+		 * Fall through to the check below.
+		 * (See include/linux/mfd/axp20x.h)
+		 */
+	case AXP221_ID:
+	case AXP223_ID:
+	case AXP809_ID:
+		if (id < AXP22X_DCDC1 || id > AXP22X_DCDC5)
+			return -EINVAL;
+
+		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP22X_DCDC1);
+		workmode <<= id - AXP22X_DCDC1;
+		break;
+
+	default:
+		/* should not happen */
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, reg, mask, workmode);
+}
+
+/* create the regulators */
+int axp_regulator_create(struct device *dev,
+			 const struct axp_cfg *axp_cfg)
+{
+	struct regulator_dev *rdev;
+	struct axp20x_dev *axp20x = dev_get_drvdata(dev);
+	struct regulator_config config = {
+		.dev = dev,
+		.regmap = axp20x->regmap,
+		.driver_data = axp20x,
+	};
+	int ret, i;
+	u32 workmode;
+	const char *dcdc1_name = NULL;
+	const char *dcdc5_name = NULL;
+
+	/* This only sets the dcdc freq. Ignore any errors */
+	axp_regulator_parse_dt(dev);
+
+	for (i = 0; i < axp_cfg->nregulators; i++) {
+		const struct regulator_desc *desc = &axp_cfg->regulators[i];
+		struct regulator_desc *new_desc;
+
+		if (axp_cfg->skip_bitmap & (1 << i))
+			continue;
+
+		/*
+		 * Regulators DC1SW and DC5LDO are connected internally,
+		 * so we have to handle their supply names separately.
+		 *
+		 * We always register the regulators in proper sequence,
+		 * so the supply names are correctly read. See the last
+		 * part of this loop to see where we save the DT defined
+		 * name.
+		 */
+		if (i == axp_cfg->dc1sw_ix && dcdc1_name) {
+			new_desc = devm_kzalloc(dev, sizeof(*desc),
+						GFP_KERNEL);
+			*new_desc = *desc;
+			new_desc->supply_name = dcdc1_name;
+			desc = new_desc;
+		}
+
+		if (i == axp_cfg->dc5ldo_ix && dcdc5_name) {
+			new_desc = devm_kzalloc(dev, sizeof(*desc),
+						GFP_KERNEL);
+			*new_desc = *desc;
+			new_desc->supply_name = dcdc5_name;
+			desc = new_desc;
+		}
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "Failed to register %s\n",
+				axp_cfg->regulators[i].name);
+
+			return PTR_ERR(rdev);
+		}
+
+		ret = of_property_read_u32(rdev->dev.of_node,
+					   "x-powers,dcdc-workmode",
+					   &workmode);
+		if (!ret) {
+			if (axp_set_dcdc_workmode(rdev, i, workmode))
+				dev_err(dev, "Failed to set workmode on %s\n",
+					rdev->desc->name);
+		}
+
+		/*
+		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
+		 */
+		if (i == axp_cfg->dcdc1_ix)
+			of_property_read_string(rdev->dev.of_node,
+						"regulator-name",
+						&dcdc1_name);
+		if (i == axp_cfg->dcdc5_ix)
+			of_property_read_string(rdev->dev.of_node,
+						"regulator-name",
+						&dcdc5_name);
+	}
+
+	if (axp_cfg->drivevbus) {
+		/* Change N_VBUSEN sense pin to DRIVEVBUS output pin */
+		regmap_update_bits(axp20x->regmap, AXP20X_OVER_TMP,
+				   AXP22X_MISC_N_VBUSEN_FUNC, 0);
+		rdev = devm_regulator_register(dev,
+					       &axp22x_drivevbus_regulator,
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "Failed to register drivevbus\n");
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(axp_regulator_create);
+
+MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
+MODULE_DESCRIPTION("Regulator Module for AXP PMIC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/axp-regulator.h b/drivers/regulator/axp-regulator.h
new file mode 100644
index 0000000..0adf1b0
--- /dev/null
+++ b/drivers/regulator/axp-regulator.h
@@ -0,0 +1,127 @@
+#ifndef __AXP_REGULATOR_H__
+#define __AXP_REGULATOR_H__
+/*
+ * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#define AXP20X_IO_ENABLED		0x03
+#define AXP20X_IO_DISABLED		0x07
+
+#define AXP22X_IO_ENABLED		0x03
+#define AXP22X_IO_DISABLED		0x04
+
+#define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
+		    _vmask, _ereg, _emask, _enable_val, _disable_val)		\
+	[_family##_##_id] = {							\
+		.name		= (_match),					\
+		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
+		.type		= REGULATOR_VOLTAGE,				\
+		.id		= _family##_##_id,				\
+		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
+		.owner		= THIS_MODULE,					\
+		.min_uV		= (_min) * 1000,				\
+		.uV_step	= (_step) * 1000,				\
+		.vsel_reg	= (_vreg),					\
+		.vsel_mask	= (_vmask),					\
+		.enable_reg	= (_ereg),					\
+		.enable_mask	= (_emask),					\
+		.enable_val	= (_enable_val),				\
+		.disable_val	= (_disable_val),				\
+		.ops		= &axp_ops,					\
+	}
+
+#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
+		 _vmask, _ereg, _emask) 					\
+	[_family##_##_id] = {							\
+		.name		= (_match),					\
+		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
+		.type		= REGULATOR_VOLTAGE,				\
+		.id		= _family##_##_id,				\
+		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
+		.owner		= THIS_MODULE,					\
+		.min_uV		= (_min) * 1000,				\
+		.uV_step	= (_step) * 1000,				\
+		.vsel_reg	= (_vreg),					\
+		.vsel_mask	= (_vmask),					\
+		.enable_reg	= (_ereg),					\
+		.enable_mask	= (_emask),					\
+		.ops		= &axp_ops,					\
+	}
+
+#define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
+	[_family##_##_id] = {							\
+		.name		= (_match),					\
+		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
+		.type		= REGULATOR_VOLTAGE,				\
+		.id		= _family##_##_id,				\
+		.owner		= THIS_MODULE,					\
+		.enable_reg	= (_ereg),					\
+		.enable_mask	= (_emask),					\
+		.ops		= &axp_ops_sw,					\
+	}
+
+#define AXP_DESC_FIXED(_family, _id, _match, _supply, _volt)			\
+	[_family##_##_id] = {							\
+		.name		= (_match),					\
+		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
+		.type		= REGULATOR_VOLTAGE,				\
+		.id		= _family##_##_id,				\
+		.n_voltages	= 1,						\
+		.owner		= THIS_MODULE,					\
+		.min_uV		= (_volt) * 1000,				\
+		.ops		= &axp_ops_fixed				\
+	}
+
+#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+			_vreg, _vmask, _ereg, _emask)				\
+	[_family##_##_id] = {							\
+		.name		= (_match),					\
+		.supply_name	= (_supply),					\
+		.of_match	= of_match_ptr(_match),				\
+		.regulators_node = of_match_ptr("regulators"),			\
+		.type		= REGULATOR_VOLTAGE,				\
+		.id		= _family##_##_id,				\
+		.n_voltages	= (_n_voltages),				\
+		.owner		= THIS_MODULE,					\
+		.vsel_reg	= (_vreg),					\
+		.vsel_mask	= (_vmask),					\
+		.enable_reg	= (_ereg),					\
+		.enable_mask	= (_emask),					\
+		.linear_ranges	= (_ranges),					\
+		.n_linear_ranges = ARRAY_SIZE(_ranges),				\
+		.ops		= &axp_ops_range,				\
+	}
+
+extern const struct regulator_ops axp_ops;
+extern const struct regulator_ops axp_ops_fixed;
+extern const struct regulator_ops axp_ops_range;
+extern const struct regulator_ops axp_ops_sw;
+
+struct axp_cfg {
+	const struct regulator_desc *regulators;
+	u8 nregulators;
+	s8 dcdc1_ix;
+	s8 dcdc5_ix;
+	s8 dc1sw_ix;
+	s8 dc5ldo_ix;
+	u32 skip_bitmap;
+	bool drivevbus;
+};
+
+int axp_regulator_create(struct device *dev,
+			 const struct axp_cfg *axp_cfg);
+
+#endif /* __AXP_REGULATOR_H__ */
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 244ddc3..9dd9ca3 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -24,137 +24,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 
-#define AXP20X_IO_ENABLED		0x03
-#define AXP20X_IO_DISABLED		0x07
-
-#define AXP22X_IO_ENABLED		0x03
-#define AXP22X_IO_DISABLED		0x04
-
-#define AXP20X_WORKMODE_DCDC2_MASK	BIT(2)
-#define AXP20X_WORKMODE_DCDC3_MASK	BIT(1)
-#define AXP22X_WORKMODE_DCDCX_MASK(x)	BIT(x)
-
-#define AXP20X_FREQ_DCDC_MASK		0x0f
-
-#define AXP22X_MISC_N_VBUSEN_FUNC	BIT(4)
-
-#define AXP_DESC_IO(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		    _vmask, _ereg, _emask, _enable_val, _disable_val)		\
-	[_family##_##_id] = {							\
-		.name		= (_match),					\
-		.supply_name	= (_supply),					\
-		.of_match	= of_match_ptr(_match),				\
-		.regulators_node = of_match_ptr("regulators"),			\
-		.type		= REGULATOR_VOLTAGE,				\
-		.id		= _family##_##_id,				\
-		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
-		.owner		= THIS_MODULE,					\
-		.min_uV		= (_min) * 1000,				\
-		.uV_step	= (_step) * 1000,				\
-		.vsel_reg	= (_vreg),					\
-		.vsel_mask	= (_vmask),					\
-		.enable_reg	= (_ereg),					\
-		.enable_mask	= (_emask),					\
-		.enable_val	= (_enable_val),				\
-		.disable_val	= (_disable_val),				\
-		.ops		= &axp20x_ops,					\
-	}
-
-#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		 _vmask, _ereg, _emask) 					\
-	[_family##_##_id] = {							\
-		.name		= (_match),					\
-		.supply_name	= (_supply),					\
-		.of_match	= of_match_ptr(_match),				\
-		.regulators_node = of_match_ptr("regulators"),			\
-		.type		= REGULATOR_VOLTAGE,				\
-		.id		= _family##_##_id,				\
-		.n_voltages	= (((_max) - (_min)) / (_step) + 1),		\
-		.owner		= THIS_MODULE,					\
-		.min_uV		= (_min) * 1000,				\
-		.uV_step	= (_step) * 1000,				\
-		.vsel_reg	= (_vreg),					\
-		.vsel_mask	= (_vmask),					\
-		.enable_reg	= (_ereg),					\
-		.enable_mask	= (_emask),					\
-		.ops		= &axp20x_ops,					\
-	}
-
-#define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
-	[_family##_##_id] = {							\
-		.name		= (_match),					\
-		.supply_name	= (_supply),					\
-		.of_match	= of_match_ptr(_match),				\
-		.regulators_node = of_match_ptr("regulators"),			\
-		.type		= REGULATOR_VOLTAGE,				\
-		.id		= _family##_##_id,				\
-		.owner		= THIS_MODULE,					\
-		.enable_reg	= (_ereg),					\
-		.enable_mask	= (_emask),					\
-		.ops		= &axp20x_ops_sw,				\
-	}
-
-#define AXP_DESC_FIXED(_family, _id, _match, _supply, _volt)			\
-	[_family##_##_id] = {							\
-		.name		= (_match),					\
-		.supply_name	= (_supply),					\
-		.of_match	= of_match_ptr(_match),				\
-		.regulators_node = of_match_ptr("regulators"),			\
-		.type		= REGULATOR_VOLTAGE,				\
-		.id		= _family##_##_id,				\
-		.n_voltages	= 1,						\
-		.owner		= THIS_MODULE,					\
-		.min_uV		= (_volt) * 1000,				\
-		.ops		= &axp20x_ops_fixed				\
-	}
-
-#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
-			_vreg, _vmask, _ereg, _emask)				\
-	[_family##_##_id] = {							\
-		.name		= (_match),					\
-		.supply_name	= (_supply),					\
-		.of_match	= of_match_ptr(_match),				\
-		.regulators_node = of_match_ptr("regulators"),			\
-		.type		= REGULATOR_VOLTAGE,				\
-		.id		= _family##_##_id,				\
-		.n_voltages	= (_n_voltages),				\
-		.owner		= THIS_MODULE,					\
-		.vsel_reg	= (_vreg),					\
-		.vsel_mask	= (_vmask),					\
-		.enable_reg	= (_ereg),					\
-		.enable_mask	= (_emask),					\
-		.linear_ranges	= (_ranges),					\
-		.n_linear_ranges = ARRAY_SIZE(_ranges),				\
-		.ops		= &axp20x_ops_range,				\
-	}
-
-static struct regulator_ops axp20x_ops_fixed = {
-	.list_voltage		= regulator_list_voltage_linear,
-};
-
-static struct regulator_ops axp20x_ops_range = {
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_linear_range,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-};
-
-static struct regulator_ops axp20x_ops = {
-	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.list_voltage		= regulator_list_voltage_linear,
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-};
-
-static struct regulator_ops axp20x_ops_sw = {
-	.enable			= regulator_enable_regmap,
-	.disable		= regulator_disable_regmap,
-	.is_enabled		= regulator_is_enabled_regmap,
-};
+#include "axp-regulator.h"
 
 static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
@@ -232,18 +102,6 @@ static const struct regulator_desc axp22x_regulators[] = {
 	AXP_DESC_FIXED(AXP22X, RTC_LDO, "rtc_ldo", "ips", 3000),
 };
 
-static const struct regulator_desc axp22x_drivevbus_regulator = {
-	.name		= "drivevbus",
-	.supply_name	= "drivevbus",
-	.of_match	= of_match_ptr("drivevbus"),
-	.regulators_node = of_match_ptr("regulators"),
-	.type		= REGULATOR_VOLTAGE,
-	.owner		= THIS_MODULE,
-	.enable_reg	= AXP20X_VBUS_IPSOUT_MGMT,
-	.enable_mask	= BIT(2),
-	.ops		= &axp20x_ops_sw,
-};
-
 static const struct regulator_linear_range axp806_dcdca_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
 	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
@@ -347,135 +205,6 @@ static const struct regulator_desc axp809_regulators[] = {
 	AXP_DESC_SW(AXP809, SW, "sw", "swin", AXP22X_PWR_OUT_CTRL2, BIT(6)),
 };
 
-static int axp20x_set_dcdc_freq(struct device *dev, u32 dcdcfreq)
-{
-	struct axp20x_dev *axp20x = dev_get_drvdata(dev);
-	unsigned int reg = AXP20X_DCDC_FREQ;
-	u32 min, max, def, step;
-
-	switch (axp20x->variant) {
-	case AXP202_ID:
-	case AXP209_ID:
-		min = 750;
-		max = 1875;
-		def = 1500;
-		step = 75;
-		break;
-	case AXP806_ID:
-		/*
-		 * AXP806 DCDC work frequency setting has the same range and
-		 * step as AXP22X, but at a different register.
-		 * Fall through to the check below.
-		 * (See include/linux/mfd/axp20x.h)
-		 */
-		reg = AXP806_DCDC_FREQ_CTRL;
-	case AXP221_ID:
-	case AXP223_ID:
-	case AXP809_ID:
-		min = 1800;
-		max = 4050;
-		def = 3000;
-		step = 150;
-		break;
-	default:
-		dev_err(dev,
-			"Setting DCDC frequency for unsupported AXP variant\n");
-		return -EINVAL;
-	}
-
-	if (dcdcfreq == 0)
-		dcdcfreq = def;
-
-	if (dcdcfreq < min) {
-		dcdcfreq = min;
-		dev_warn(dev, "DCDC frequency too low. Set to %ukHz\n",
-			 min);
-	}
-
-	if (dcdcfreq > max) {
-		dcdcfreq = max;
-		dev_warn(dev, "DCDC frequency too high. Set to %ukHz\n",
-			 max);
-	}
-
-	dcdcfreq = (dcdcfreq - min) / step;
-
-	return regmap_update_bits(axp20x->regmap, reg,
-				  AXP20X_FREQ_DCDC_MASK, dcdcfreq);
-}
-
-static int axp20x_regulator_parse_dt(struct device *dev)
-{
-	struct device_node *np, *regulators;
-	int ret;
-	u32 dcdcfreq = 0;
-
-	np = of_node_get(dev->of_node);
-	if (!np)
-		return 0;
-
-	regulators = of_get_child_by_name(np, "regulators");
-	if (!regulators) {
-		dev_warn(dev, "regulators node not found\n");
-	} else {
-		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
-		ret = axp20x_set_dcdc_freq(dev, dcdcfreq);
-		if (ret < 0) {
-			dev_err(dev, "Error setting dcdc frequency: %d\n", ret);
-			return ret;
-		}
-
-		of_node_put(regulators);
-	}
-
-	return 0;
-}
-
-static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
-{
-	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
-	unsigned int reg = AXP20X_DCDC_MODE;
-	unsigned int mask;
-
-	switch (axp20x->variant) {
-	case AXP202_ID:
-	case AXP209_ID:
-		if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
-			return -EINVAL;
-
-		mask = AXP20X_WORKMODE_DCDC2_MASK;
-		if (id == AXP20X_DCDC3)
-			mask = AXP20X_WORKMODE_DCDC3_MASK;
-
-		workmode <<= ffs(mask) - 1;
-		break;
-
-	case AXP806_ID:
-		reg = AXP806_DCDC_MODE_CTRL2;
-		/*
-		 * AXP806 DCDC regulator IDs have the same range as AXP22X.
-		 * Fall through to the check below.
-		 * (See include/linux/mfd/axp20x.h)
-		 */
-	case AXP221_ID:
-	case AXP223_ID:
-	case AXP809_ID:
-		if (id < AXP22X_DCDC1 || id > AXP22X_DCDC5)
-			return -EINVAL;
-
-		mask = AXP22X_WORKMODE_DCDCX_MASK(id - AXP22X_DCDC1);
-		workmode <<= id - AXP22X_DCDC1;
-		break;
-
-	default:
-		/* should not happen */
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
-	return regmap_update_bits(rdev->regmap, reg, mask, workmode);
-}
-
 /*
  * This function checks which regulators are part of poly-phase
  * output setups based on the registers settings.
@@ -500,60 +229,51 @@ static u32 axp20x_polyphase_slave(struct axp20x_dev *axp20x)
 static int axp20x_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
-	struct regulator_dev *rdev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(dev);
-	const struct regulator_desc *regulators;
-	struct regulator_config config = {
-		.dev = dev,
-		.regmap = axp20x->regmap,
-		.driver_data = axp20x,
-	};
-	int ret, i, nregulators;
-	u32 workmode;
-	const char *dcdc1_name = axp22x_regulators[AXP22X_DCDC1].name;
-	const char *dcdc5_name = axp22x_regulators[AXP22X_DCDC5].name;
-	s8 dcdc1_ix = -1;
-	s8 dcdc5_ix = -1;
-	s8 dc1sw_ix = -1;
-	s8 dc5ldo_ix = -1;
-	bool drivevbus = false;
-	u32 skip_bitmap = 0;
+	struct axp_cfg axp_cfg;
+
+	axp_cfg.dcdc1_ix = -1;
+	axp_cfg.dcdc5_ix = -1;
+	axp_cfg.dc1sw_ix = -1;
+	axp_cfg.dc5ldo_ix = -1;
+	axp_cfg.drivevbus = false;
+	axp_cfg.skip_bitmap = 0;
 
 	switch (axp20x->variant) {
 	case AXP202_ID:
 	case AXP209_ID:
-		regulators = axp20x_regulators;
-		nregulators = AXP20X_REG_ID_MAX;
+		axp_cfg.regulators = axp20x_regulators;
+		axp_cfg.nregulators = AXP20X_REG_ID_MAX;
 		break;
 	case AXP221_ID:
 	case AXP223_ID:
-		regulators = axp22x_regulators;
-		nregulators = AXP22X_REG_ID_MAX;
-		dcdc1_ix = AXP22X_DCDC1;
-		dcdc5_ix = AXP22X_DCDC5;
-		dc1sw_ix = AXP22X_DC1SW;
-		dc5ldo_ix = AXP22X_DC5LDO;
-		drivevbus = of_property_read_bool(dev->of_node,
+		axp_cfg.regulators = axp22x_regulators;
+		axp_cfg.nregulators = AXP22X_REG_ID_MAX;
+		axp_cfg.dcdc1_ix = AXP22X_DCDC1;
+		axp_cfg.dcdc5_ix = AXP22X_DCDC5;
+		axp_cfg.dc1sw_ix = AXP22X_DC1SW;
+		axp_cfg.dc5ldo_ix = AXP22X_DC5LDO;
+		axp_cfg.drivevbus = of_property_read_bool(dev->of_node,
 						  "x-powers,drive-vbus-en");
 		break;
 	case AXP806_ID:
-		regulators = axp806_regulators;
-		nregulators = AXP806_REG_ID_MAX;
+		axp_cfg.regulators = axp806_regulators;
+		axp_cfg.nregulators = AXP806_REG_ID_MAX;
 
 		/*
 		 * The regulators which are slave in a poly-phase setup
 		 * are skipped, as their controls are bound to the master
 		 * regulator and won't work.
 		 */
-		skip_bitmap |= axp20x_polyphase_slave(axp20x);
+		axp_cfg.skip_bitmap |= axp20x_polyphase_slave(axp20x);
 		break;
 	case AXP809_ID:
-		regulators = axp809_regulators;
-		nregulators = AXP809_REG_ID_MAX;
-		dcdc1_ix = AXP809_DCDC1;
-		dcdc5_ix = AXP809_DCDC5;
-		dc1sw_ix = AXP809_DC1SW;
-		dc5ldo_ix = AXP809_DC5LDO;
+		axp_cfg.regulators = axp809_regulators;
+		axp_cfg.nregulators = AXP809_REG_ID_MAX;
+		axp_cfg.dcdc1_ix = AXP809_DCDC1;
+		axp_cfg.dcdc5_ix = AXP809_DCDC5;
+		axp_cfg.dc1sw_ix = AXP809_DC1SW;
+		axp_cfg.dc5ldo_ix = AXP809_DC5LDO;
 		break;
 	default:
 		dev_err(dev, "Unsupported AXP variant: %ld\n",
@@ -561,86 +281,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* This only sets the dcdc freq. Ignore any errors */
-	axp20x_regulator_parse_dt(dev);
-
-	for (i = 0; i < nregulators; i++) {
-		const struct regulator_desc *desc = &regulators[i];
-		struct regulator_desc *new_desc;
-
-		if (skip_bitmap & (1 << i))
-			continue;
-
-		/*
-		 * Regulators DC1SW and DC5LDO are connected internally,
-		 * so we have to handle their supply names separately.
-		 *
-		 * We always register the regulators in proper sequence,
-		 * so the supply names are correctly read. See the last
-		 * part of this loop to see where we save the DT defined
-		 * name.
-		 */
-		if (i == dc1sw_ix && dcdc1_name) {
-			new_desc = devm_kzalloc(dev, sizeof(*desc),
-						GFP_KERNEL);
-			*new_desc = regulators[i];
-			new_desc->supply_name = dcdc1_name;
-			desc = new_desc;
-		}
-
-		if (i == dc5ldo_ix && dcdc5_name) {
-			new_desc = devm_kzalloc(dev, sizeof(*desc),
-						GFP_KERNEL);
-			*new_desc = regulators[i];
-			new_desc->supply_name = dcdc5_name;
-			desc = new_desc;
-		}
-
-		rdev = devm_regulator_register(dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			dev_err(dev, "Failed to register %s\n",
-				regulators[i].name);
-
-			return PTR_ERR(rdev);
-		}
-
-		ret = of_property_read_u32(rdev->dev.of_node,
-					   "x-powers,dcdc-workmode",
-					   &workmode);
-		if (!ret) {
-			if (axp20x_set_dcdc_workmode(rdev, i, workmode))
-				dev_err(dev, "Failed to set workmode on %s\n",
-					rdev->desc->name);
-		}
-
-		/*
-		 * Save AXP22X DCDC1 / DCDC5 regulator names for later.
-		 */
-		if (i == dcdc1_ix)
-			of_property_read_string(rdev->dev.of_node,
-						"regulator-name",
-						&dcdc1_name);
-
-		if (i == dcdc5_ix)
-			of_property_read_string(rdev->dev.of_node,
-						"regulator-name",
-						&dcdc5_name);
-	}
-
-	if (drivevbus) {
-		/* Change N_VBUSEN sense pin to DRIVEVBUS output pin */
-		regmap_update_bits(axp20x->regmap, AXP20X_OVER_TMP,
-				   AXP22X_MISC_N_VBUSEN_FUNC, 0);
-		rdev = devm_regulator_register(dev,
-					       &axp22x_drivevbus_regulator,
-					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(dev, "Failed to register drivevbus\n");
-			return PTR_ERR(rdev);
-		}
-	}
-
-	return 0;
+	return axp_regulator_create(dev, &axp_cfg);
 }
 
 static struct platform_driver axp20x_regulator_driver = {
-- 
2.10.0

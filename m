From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 28 Apr 2015 16:17:40 +0200
Subject: [PATCH 2/2] Regulator: add driver for Freescale MC34708
In-Reply-To: <20150428141736.16243.57292.stgit@localhost>
References: <20150428141736.16243.57292.stgit@localhost>
Message-ID: <20150428141740.16243.79036.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/regulator/Kconfig             |    7 
 drivers/regulator/Makefile            |    1 
 drivers/regulator/mc34708-regulator.c | 1266 +++++++++++++++++++++++++++++++++
 3 files changed, 1274 insertions(+)
 create mode 100644 drivers/regulator/mc34708-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 31ac1bf..0d03c39 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -440,6 +440,13 @@ config REGULATOR_MC13892
 	  Say y here to support the regulators found on the Freescale MC13892
 	  PMIC.
 
+config REGULATOR_MC34708
+	tristate "Freescale MC34708 regulator driver"
+	depends on MFD_MC13XXX
+	help
+	  Say y here to support the regulators found on the Freescale MC34708
+	  and MC34709 PMICs.
+
 config REGULATOR_PALMAS
 	tristate "TI Palmas PMIC Regulators"
 	depends on MFD_PALMAS
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index c1b4fba..6382f6c 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_REGULATOR_MAX77802) += max77802.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
+obj-$(CONFIG_REGULATOR_MC34708) += mc34708-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
diff --git a/drivers/regulator/mc34708-regulator.c b/drivers/regulator/mc34708-regulator.c
new file mode 100644
index 0000000..b5ff727
--- /dev/null
+++ b/drivers/regulator/mc34708-regulator.c
@@ -0,0 +1,1266 @@
+/*
+ * Driver for regulators in the Fresscale MC34708/9 PMICs
+ *
+ * The hardware uses different schemes for the three types of regulators:
+ *
+ * The SWx regulators:
+ *	A single register field multiplexes enable/disable and mode
+ *	selection, for both normal and standby state.
+ *	Independent voltage control in normal and standby states.
+ *
+ * The SWBST regulator:
+ *	One register field for combined enable/disable and mode selection
+ *	in normal state and a second field for standby state.
+ *	Single voltage control for both normal and standby states.
+ *
+ * The LDO regulators:
+ *	Enable bit (not multiplexed with mode)
+ *	Single voltage control for both normal and standby states.
+ *	Standby and Mode bits shared by standby and normal states
+ *
+ * The mc13xxx-regulator-core is not a good fit for the above so it is
+ * not used.
+ *
+ * Copyright 2015 Parkeon
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/mc13xxx.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+struct mc34708_hw_mode {
+	s8	normal;
+	s8	alt_normal;
+	s8	standby;
+};
+
+struct mc34708_regulator;
+
+/* Common to regulators of the same type */
+struct mc34708_regulator_kind {
+	int (*setup)(struct mc34708_regulator *);
+	unsigned int (*of_map_mode)(unsigned int);
+	const struct mc34708_hw_mode *hw_modes;
+	int num_hw_modes;
+	const struct regulator_ops ops;
+};
+
+/* Specific for each regulator */
+struct mc34708_regulator_def {
+	const char *name;
+	const struct mc34708_regulator_kind *kind;
+	const char *supply_name;
+	unsigned int enable_reg;
+	unsigned int enable_mask;
+	unsigned int n_voltages;
+	unsigned int fixed_uV;
+	unsigned int min_uV;
+	unsigned int uV_step;
+	const unsigned int *volt_table;
+	unsigned int vsel_reg;
+	unsigned int vsel_mask;
+	unsigned int vsel_stdby_mask;
+	unsigned int mode_reg;
+	unsigned int mode_mask;
+	unsigned int mode_stdby_mask;
+};
+
+struct mc34708_regulator {
+	struct device *dev;
+	struct mc13xxx  *mc13xxx;
+	const struct mc34708_regulator_def *def;
+	struct regulator_desc desc;
+	struct regulator_config config;
+	unsigned int req_mode_normal;
+	unsigned int req_mode_standby;
+	bool suspend_off;
+};
+
+struct mc34708_drv_data {
+	u32 saved_regmode0;
+	struct	mc34708_regulator regulators[0];
+};
+
+/* ********************************************************************** */
+/* Common helpers */
+/* ********************************************************************** */
+
+static int mc34708_read_bits(struct mc34708_regulator *mc34708_reg,
+			     unsigned int reg, u32 mask)
+{
+	int ret;
+	u32 val;
+
+	ret = mc13xxx_reg_read(mc34708_reg->mc13xxx, reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= mask;
+	val >>= ffs(mask) - 1;
+
+	return val;
+}
+
+static int mc34708_update_bits(struct mc34708_regulator *mc34708_reg,
+			       unsigned int reg, u32 mask, u32 val)
+{
+	val <<= ffs(mask) - 1;
+
+	return mc13xxx_reg_rmw(mc34708_reg->mc13xxx, reg, mask, val);
+}
+
+static int mc34708_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_read_bits(mc34708_reg,
+				rdev->desc->vsel_reg, rdev->desc->vsel_mask);
+}
+
+static int mc34708_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_bits(mc34708_reg,
+					rdev->desc->vsel_reg,
+					rdev->desc->vsel_mask,
+					sel);
+}
+
+static int mc34708_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int sel;
+
+	sel = regulator_map_voltage_linear(rdev, uV, uV);
+	if (sel < 0)
+		return sel;
+
+	return mc34708_update_bits(mc34708_reg,
+					rdev->desc->vsel_reg,
+					mc34708_reg->def->vsel_stdby_mask,
+					sel);
+}
+
+static const struct mc34708_hw_mode *mc34708_get_hw_mode(
+	struct mc34708_regulator *mc34708_reg)
+{
+	int val;
+	const struct mc34708_hw_mode *hwmode;
+
+	val = mc34708_read_bits(mc34708_reg,
+				mc34708_reg->def->mode_reg,
+				mc34708_reg->def->mode_mask);
+	if (val < 0)
+		return ERR_PTR(val);
+
+	BUG_ON(val >= mc34708_reg->def->kind->num_hw_modes);
+	hwmode = &mc34708_reg->def->kind->hw_modes[val];
+
+	dev_dbg(mc34708_reg->dev, "%s: HwMode=0x%x => normal=%d standby=%d\n",
+		mc34708_reg->def->name, val,
+		hwmode->normal, hwmode->standby);
+
+	return hwmode;
+}
+
+static int mc34708_sw_find_hw_mode_sel(
+	const struct mc34708_regulator_kind *kind,
+	unsigned int normal,
+	unsigned int standby)
+{
+	const struct mc34708_hw_mode *mode;
+	int i;
+
+	for (i = 0, mode = kind->hw_modes;
+			i < kind->num_hw_modes; i++, mode++) {
+		if (mode->normal == -1 || mode->standby == -1)
+			continue;
+
+		if (mode->standby != standby)
+			continue;
+
+		if ((mode->normal == normal) ||
+		    (normal && (mode->alt_normal == normal)))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int mc34708_update_hw_mode(
+	struct mc34708_regulator *mc34708_reg,
+	unsigned int normal,
+	unsigned int standby)
+{
+	int sel;
+
+	sel = mc34708_sw_find_hw_mode_sel(mc34708_reg->def->kind,
+					  normal, standby);
+	if (sel < 0) {
+		dev_err(mc34708_reg->dev,
+			"%s: no hardware mode for normal=%d standby=%d\n",
+			mc34708_reg->def->name,
+			normal,
+			standby);
+
+		return sel;
+	}
+
+	dev_dbg(mc34708_reg->dev, "%s: normal=%d standby=%d => HwMODE=0x%x\n",
+		mc34708_reg->def->name,
+		normal,
+		standby,
+		sel);
+
+	return mc34708_update_bits(mc34708_reg,
+					mc34708_reg->def->mode_reg,
+					mc34708_reg->def->mode_mask,
+					sel);
+}
+
+/* ********************************************************************** */
+/* SWx regulator support */
+/* ********************************************************************** */
+
+/*
+ * Mapping of SWxMODE bits to mode in normal and standby state.
+ * The hardware has the follwoing modes (in order of increasing power):
+ *	OFF
+ *	PFM (Pulse Frequency Modulation) for low loads
+ *	APS (Automatic Pulse Skip)
+ *	PWM (Pulse Width Modulation) for high loads
+ *
+ * Not all combinations are possible. The mode in normal state cannot
+ * be lower power than that in standby state.
+ *
+ * We map these to Linux regulator modes as follows:
+ *	PFM : REGULATOR_MODE_STANDBY
+ *	PWM : REGULATOR_MODE_FAST
+ *	APS : REGULATOR_MODE_NORMAL
+ *	OFF : 0
+ *	Reserved : -1
+ */
+static const struct mc34708_hw_mode mc34708_sw_modes[] = {
+	{ .normal = 0,			    .standby = 0 },
+	{ .normal = REGULATOR_MODE_FAST,    .standby = 0 },
+	{ .normal = -1,			    .standby = -1 },
+	{ .normal = REGULATOR_MODE_STANDBY, .standby = 0 },
+	{ .normal = REGULATOR_MODE_NORMAL,  .standby = 0 },
+	{ .normal = REGULATOR_MODE_FAST,    .standby = REGULATOR_MODE_FAST },
+	{ .normal = REGULATOR_MODE_FAST,    .standby = REGULATOR_MODE_NORMAL },
+	{ .normal = 0,			    .standby = 0 },
+	{ .normal = REGULATOR_MODE_NORMAL,  .standby = REGULATOR_MODE_NORMAL },
+	{ .normal = -1,			    .standby = -1 },
+	{ .normal = -1,			    .standby = -1 },
+	{ .normal = -1,			    .standby = -1 },
+	{ .normal = REGULATOR_MODE_NORMAL,  .standby = REGULATOR_MODE_STANDBY },
+	{ .normal = REGULATOR_MODE_FAST,    .standby = REGULATOR_MODE_STANDBY },
+	{ .normal = -1,			    .standby = -1 },
+	{ .normal = REGULATOR_MODE_STANDBY, .standby = REGULATOR_MODE_STANDBY },
+};
+
+#define MC34708_SW_OPMODE_PFM	1
+#define MC34708_SW_OPMODE_APS	2
+#define MC34708_SW_OPMODE_PWM	3
+
+static unsigned int mc34708_sw_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MC34708_SW_OPMODE_PFM:
+		return REGULATOR_MODE_STANDBY;
+	case MC34708_SW_OPMODE_APS:
+		return REGULATOR_MODE_NORMAL;
+	case MC34708_SW_OPMODE_PWM:
+		return REGULATOR_MODE_FAST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mc34708_sw_setup(struct mc34708_regulator *mc34708_reg)
+{
+	const struct mc34708_hw_mode *hw_mode;
+
+	hw_mode = mc34708_get_hw_mode(mc34708_reg);
+	if (IS_ERR(hw_mode))
+		return PTR_ERR(hw_mode);
+
+	/*
+	 * Be safe and bail out without touching hardware if
+	 * the initial state is "reserved"
+	 */
+	if (hw_mode->normal < 0) {
+		dev_err(mc34708_reg->dev,
+			"%s in reserved mode for normal\n",
+			mc34708_reg->def->name);
+		return -EINVAL;
+	}
+	if (hw_mode->standby < 0) {
+		dev_err(mc34708_reg->dev,
+			"%s in reserved mode for standby\n",
+			mc34708_reg->def->name);
+		return -EINVAL;
+	}
+
+	if (hw_mode->normal > 0)
+		mc34708_reg->req_mode_normal = hw_mode->normal;
+	else
+		/*
+		 * If regulator is intially off we don't know the mode
+		 * but we need a mode to be able to enable it later.
+		 */
+		mc34708_reg->req_mode_normal = REGULATOR_MODE_NORMAL;
+
+	mc34708_reg->req_mode_standby = hw_mode->standby;
+	if (!hw_mode->standby)
+		mc34708_reg->suspend_off = true;
+
+	return 0;
+}
+
+static int mc34708_sw_enable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_hw_mode(mc34708_reg,
+						mc34708_reg->req_mode_normal,
+						mc34708_reg->req_mode_standby);
+}
+
+static int mc34708_sw_disable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_hw_mode(mc34708_reg,
+						0,
+						mc34708_reg->req_mode_standby);
+}
+
+static int mc34708_sw_is_enabled(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	const struct mc34708_hw_mode *hw_mode;
+
+	hw_mode = mc34708_get_hw_mode(mc34708_reg);
+	if (IS_ERR(hw_mode))
+		return PTR_ERR(hw_mode);
+
+	return hw_mode->normal > 0;
+}
+
+static unsigned int mc34708_sw_get_mode(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_reg->req_mode_normal;
+}
+
+static int mc34708_sw_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int enabled, ret;
+
+	enabled = mc34708_sw_is_enabled(rdev);
+	if (enabled < 0)
+		return enabled;
+
+	if (enabled) {
+		ret = mc34708_update_hw_mode(mc34708_reg,
+					     mode,
+					     mc34708_reg->req_mode_standby);
+		if (ret)
+			return ret;
+	}
+
+	mc34708_reg->req_mode_normal = mode;
+
+	return 0;
+}
+
+static int mc34708_sw_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     mc34708_reg->req_mode_normal,
+				     mc34708_reg->req_mode_standby);
+	if (!ret)
+		mc34708_reg->suspend_off = false;
+
+	return ret;
+}
+
+static int mc34708_sw_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     mc34708_reg->req_mode_normal,
+				     0);
+	if (!ret)
+		mc34708_reg->suspend_off = true;
+
+	return ret;
+}
+
+static int mc34708_sw_set_suspend_mode(struct regulator_dev *rdev,
+				       unsigned int mode)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int enabled, ret;
+
+	enabled = mc34708_sw_is_enabled(rdev);
+	if (enabled < 0)
+		return enabled;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     enabled ? mc34708_reg->req_mode_normal : 0,
+				     mc34708_reg->suspend_off ? 0 : mode);
+	if (!ret)
+		mc34708_reg->req_mode_standby = mode;
+
+	return ret;
+}
+
+/* ********************************************************************** */
+/* SWBST regulator support */
+/* ********************************************************************** */
+
+static int mc34708_swbst_mode_to_hwmode(unsigned int mode)
+{
+	switch (mode) {
+	case REGULATOR_MODE_IDLE:
+	case REGULATOR_MODE_STANDBY:
+		return  MC34708_SW_OPMODE_PFM;
+
+	case REGULATOR_MODE_NORMAL:
+		return MC34708_SW_OPMODE_APS;
+
+	case REGULATOR_MODE_FAST:
+		return MC34708_SW_OPMODE_PWM;
+
+	default:
+		return -EINVAL;
+	};
+}
+
+static int mc34708_swbst_hwmode_to_mode(unsigned int hwmode)
+{
+	return mc34708_sw_of_map_mode(hwmode);
+}
+
+static int mc34708_swbst_setup(struct mc34708_regulator *mc34708_reg)
+{
+	int val, mode;
+
+	val = mc34708_read_bits(mc34708_reg,
+				mc34708_reg->def->mode_reg,
+				mc34708_reg->def->mode_mask);
+	if (val < 0)
+		return val;
+
+	if (val > 0) {
+		mode = mc34708_swbst_hwmode_to_mode(val);
+		if (mode < 0)
+			return mode;
+
+		mc34708_reg->req_mode_normal = mode;
+	} else {
+		/*
+		 * If regulator is intially off we don't know the mode
+		 * but we need a mode to be able to enable it later.
+		 */
+		mc34708_reg->req_mode_normal = REGULATOR_MODE_NORMAL;
+	}
+
+	dev_dbg(mc34708_reg->dev,
+		"%s: Initial normal mode hw=%d linux=%d\n",
+		mc34708_reg->def->name, val, mc34708_reg->req_mode_normal);
+
+	val = mc34708_read_bits(mc34708_reg,
+				mc34708_reg->def->mode_reg,
+				mc34708_reg->def->mode_stdby_mask);
+	if (val < 0)
+		return val;
+
+	if (val > 0) {
+		mode = mc34708_swbst_hwmode_to_mode(val);
+		if (mode < 0)
+			return mode;
+
+		mc34708_reg->req_mode_standby = mode;
+	} else {
+		/*
+		 * If regulator is intially off we don't know the mode
+		 * but we need a mode to be able to enable it later.
+		 */
+		mc34708_reg->req_mode_standby = REGULATOR_MODE_STANDBY;
+	}
+
+	dev_dbg(mc34708_reg->dev, "Initial standby mode hw=%d linux=%d\n",
+		val,
+		mc34708_reg->req_mode_standby);
+
+	return 0;
+}
+
+static int mc34708_swbst_enable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_bits(mc34708_reg,
+					mc34708_reg->def->mode_reg,
+					mc34708_reg->def->mode_mask,
+					mc34708_reg->req_mode_normal);
+}
+
+static int mc34708_swbst_disable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_bits(mc34708_reg,
+					mc34708_reg->def->mode_reg,
+					mc34708_reg->def->mode_mask,
+					0);
+}
+
+static int mc34708_swbst_is_enabled(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int val;
+
+	val = mc34708_read_bits(mc34708_reg,
+				mc34708_reg->def->mode_reg,
+				mc34708_reg->def->mode_mask);
+
+	if (val < 0)
+		return val;
+
+	return val == 0 ? 0 : 1;
+}
+
+static unsigned int mc34708_swbst_get_mode(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_reg->req_mode_normal;
+}
+
+static int mc34708_swbst_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int enabled, hwmode, ret;
+
+	hwmode = mc34708_swbst_mode_to_hwmode(mode);
+	if (hwmode < 0)
+		return hwmode;
+
+	enabled = mc34708_swbst_is_enabled(rdev);
+	if (enabled < 0)
+		return enabled;
+
+	if (enabled) {
+		ret = mc34708_update_bits(mc34708_reg,
+					  mc34708_reg->def->mode_reg,
+					  mc34708_reg->def->mode_mask,
+					  hwmode);
+		if (ret)
+			return ret;
+	}
+
+	mc34708_reg->req_mode_normal = mode;
+
+	return 0;
+}
+
+static int mc34708_swbst_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int hwmode;
+
+	hwmode = mc34708_swbst_mode_to_hwmode(mc34708_reg->req_mode_standby);
+	if (hwmode < 0)
+		return hwmode;
+
+	return mc34708_update_bits(mc34708_reg,
+					mc34708_reg->def->mode_reg,
+					mc34708_reg->def->mode_stdby_mask,
+					hwmode);
+}
+
+static int mc34708_swbst_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_bits(mc34708_reg,
+					mc34708_reg->def->mode_reg,
+					mc34708_reg->def->mode_stdby_mask,
+					0);
+}
+
+static int mc34708_swbst_set_suspend_mode(struct regulator_dev *rdev,
+					  unsigned int mode)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret, hwmode;
+
+	hwmode = mc34708_swbst_mode_to_hwmode(mode);
+	if (hwmode < 0)
+		return hwmode;
+
+	ret = mc34708_update_bits(mc34708_reg,
+				  mc34708_reg->def->mode_reg,
+				  mc34708_reg->def->mode_stdby_mask,
+				  hwmode);
+	if (!ret)
+		mc34708_reg->req_mode_standby = mode;
+
+	return ret;
+}
+
+/* ********************************************************************** */
+/* LDO regulator support */
+/* ********************************************************************** */
+
+/*
+ * 3 types mode / standby configuration for LDOs:
+ *	No mode configuration
+ *	Single bit mode cofiguration (standby bit)
+ *	2 bit mode configuration mode, standby
+ *
+ * LDO states (excluding enable bit)
+ *	VxMODE	VxSTBY		Normal	Standby
+ *	0	0		ON	ON
+ *	0	1		ON	OFF
+ *	1	0		LP	LP
+ *	1	1		ON	LP
+ *
+ * Note that it is not possible to have Normal=LP, Standby=OFF
+ * If this state is requested we will use Normal=ON, Standby=OFF until exit
+ * from suspend.
+ * Hence the .alt_normal below which is used for extra matching
+ */
+static const struct mc34708_hw_mode mc34708_ldo_modes[] = {
+	{
+		.normal = REGULATOR_MODE_NORMAL,
+		.standby = REGULATOR_MODE_NORMAL
+	},
+	{
+		.normal = REGULATOR_MODE_NORMAL,
+		.alt_normal =  REGULATOR_MODE_STANDBY,
+		.standby = 0
+	},
+	{
+		.normal = REGULATOR_MODE_STANDBY,
+		.standby = REGULATOR_MODE_STANDBY
+	},
+	{
+		.normal = REGULATOR_MODE_NORMAL,
+		.standby = REGULATOR_MODE_STANDBY
+	},
+};
+
+#define MC34708_LDO_OPMODE_LOWPOWER	1
+#define MC34708_LDO_OPMODE_NORMAL	2
+
+static unsigned int mc34708_ldo_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MC34708_LDO_OPMODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MC34708_LDO_OPMODE_LOWPOWER:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool mc34708_ldo_has_mode_bit(struct mc34708_regulator *mc34708_reg)
+{
+	unsigned int mask = mc34708_reg->def->mode_mask;
+
+	if (!mask)
+		return false;
+
+	mask >>= ffs(mask) - 1;
+
+	return mask == 3;
+}
+
+static int mc34708_ldo_setup(struct mc34708_regulator *mc34708_reg)
+{
+	const struct mc34708_hw_mode *hw_mode;
+
+	hw_mode = mc34708_get_hw_mode(mc34708_reg);
+	if (IS_ERR(hw_mode))
+		return PTR_ERR(hw_mode);
+
+	mc34708_reg->req_mode_normal = hw_mode->normal;
+	if (hw_mode->standby) {
+		mc34708_reg->suspend_off = false;
+		mc34708_reg->req_mode_standby = hw_mode->standby;
+	} else {
+		/* If configured for off in standby we still need a mode to
+		 * use when .set_suspend_enable() is called.
+		 * That mode depends if the regulator has a mode bit.
+		 */
+		mc34708_reg->suspend_off = true;
+		if (mc34708_ldo_has_mode_bit(mc34708_reg))
+			mc34708_reg->req_mode_standby = REGULATOR_MODE_STANDBY;
+		else
+			mc34708_reg->req_mode_standby = REGULATOR_MODE_NORMAL;
+	}
+
+	return 0;
+}
+
+static int mc34708_ldo_enable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_bits(mc34708_reg,
+					rdev->desc->enable_reg,
+					rdev->desc->enable_mask,
+					1);
+}
+
+static int mc34708_ldo_disable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_update_bits(mc34708_reg,
+					rdev->desc->enable_reg,
+					rdev->desc->enable_mask,
+					0);
+}
+
+static int mc34708_ldo_is_enabled(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_read_bits(mc34708_reg,
+					rdev->desc->enable_reg,
+					rdev->desc->enable_mask);
+}
+
+static int mc34708_ldo_vhalf_get_voltage(struct regulator_dev *rdev)
+{
+	int ret;
+
+	if (!rdev->supply)
+		return -EINVAL;
+
+	ret = regulator_get_voltage(rdev->supply);
+	if (ret > 0)
+		ret /= 2;
+
+	return ret;
+}
+
+static unsigned int mc34708_ldo_get_mode(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+
+	return mc34708_reg->req_mode_normal;
+}
+
+static int mc34708_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret;
+
+	if (!mc34708_ldo_has_mode_bit(mc34708_reg))
+		return 0;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     mode,
+				     mc34708_reg->req_mode_standby);
+	if (!ret)
+		mc34708_reg->req_mode_normal = mode;
+
+	return ret;
+}
+
+static int mc34708_ldo_set_suspend_enable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     mc34708_reg->req_mode_normal,
+				     mc34708_reg->req_mode_standby);
+	if (!ret)
+		mc34708_reg->suspend_off = false;
+
+	return ret;
+}
+
+static int mc34708_ldo_set_suspend_disable(struct regulator_dev *rdev)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     mc34708_reg->req_mode_normal,
+				     0);
+	if (!ret)
+		mc34708_reg->suspend_off = true;
+
+	return ret;
+}
+
+static int mc34708_ldo_set_suspend_mode(struct regulator_dev *rdev,
+					unsigned int mode)
+{
+	struct mc34708_regulator *mc34708_reg = rdev->reg_data;
+	int ret;
+
+	if (!mc34708_ldo_has_mode_bit(mc34708_reg))
+		return 0;
+
+	ret = mc34708_update_hw_mode(mc34708_reg,
+				     mc34708_reg->req_mode_normal,
+				     mc34708_reg->suspend_off ? 0 : mode);
+	if (!ret)
+		mc34708_reg->req_mode_standby = mode;
+
+	return ret;
+}
+
+static const struct mc34708_regulator_kind mc34708_sw_kind = {
+	.setup		= mc34708_sw_setup,
+	.hw_modes	= mc34708_sw_modes,
+	.num_hw_modes	= ARRAY_SIZE(mc34708_sw_modes),
+	.of_map_mode	= mc34708_sw_of_map_mode,
+	.ops = {
+		.enable			= mc34708_sw_enable,
+		.disable		= mc34708_sw_disable,
+		.is_enabled		= mc34708_sw_is_enabled,
+
+		.list_voltage		= regulator_list_voltage_linear,
+		.get_voltage_sel	= mc34708_get_voltage_sel,
+		.set_voltage_sel	= mc34708_set_voltage_sel,
+
+		.get_mode		= mc34708_sw_get_mode,
+		.set_mode		= mc34708_sw_set_mode,
+
+		.set_suspend_voltage	= mc34708_set_suspend_voltage,
+		.set_suspend_enable	= mc34708_sw_set_suspend_enable,
+		.set_suspend_disable	= mc34708_sw_set_suspend_disable,
+		.set_suspend_mode	= mc34708_sw_set_suspend_mode,
+	},
+};
+
+static const struct mc34708_regulator_kind mc34708_swbst_kind = {
+	.setup		= mc34708_swbst_setup,
+	.of_map_mode	= mc34708_sw_of_map_mode,
+	.ops = {
+		.enable			= mc34708_swbst_enable,
+		.disable		= mc34708_swbst_disable,
+		.is_enabled		= mc34708_swbst_is_enabled,
+
+		.list_voltage		= regulator_list_voltage_linear,
+		.get_voltage_sel	= mc34708_get_voltage_sel,
+		.set_voltage_sel	= mc34708_set_voltage_sel,
+
+		.get_mode		= mc34708_swbst_get_mode,
+		.set_mode		= mc34708_swbst_set_mode,
+
+		.set_suspend_enable	= mc34708_swbst_set_suspend_enable,
+		.set_suspend_disable	= mc34708_swbst_set_suspend_disable,
+		.set_suspend_mode	= mc34708_swbst_set_suspend_mode,
+	},
+};
+
+static const struct mc34708_regulator_kind mc34708_ldo_kind = {
+	.setup		= mc34708_ldo_setup,
+	.hw_modes	= mc34708_ldo_modes,
+	.num_hw_modes	= ARRAY_SIZE(mc34708_ldo_modes),
+	.of_map_mode	= mc34708_ldo_of_map_mode,
+	.ops = {
+		.enable			= mc34708_ldo_enable,
+		.disable		= mc34708_ldo_disable,
+		.is_enabled		= mc34708_ldo_is_enabled,
+
+		.list_voltage		= regulator_list_voltage_table,
+		.get_voltage_sel	= mc34708_get_voltage_sel,
+		.set_voltage_sel	= mc34708_set_voltage_sel,
+
+		.get_mode		= mc34708_ldo_get_mode,
+		.set_mode		= mc34708_ldo_set_mode,
+
+		.set_suspend_enable	= mc34708_ldo_set_suspend_enable,
+		.set_suspend_disable	= mc34708_ldo_set_suspend_disable,
+		.set_suspend_mode	= mc34708_ldo_set_suspend_mode,
+	},
+};
+
+static const struct mc34708_regulator_kind mc34708_ldo_fixed_kind = {
+	.ops = {
+		.enable			= mc34708_ldo_enable,
+		.disable		= mc34708_ldo_disable,
+		.is_enabled		= mc34708_ldo_is_enabled,
+	},
+};
+
+static const struct mc34708_regulator_kind mc34708_ldo_vhalf_kind = {
+	.ops = {
+		.enable			= mc34708_ldo_enable,
+		.disable		= mc34708_ldo_disable,
+		.is_enabled		= mc34708_ldo_is_enabled,
+		.get_voltage		= mc34708_ldo_vhalf_get_voltage,
+	},
+};
+
+static const unsigned int mc34708_pll_volt_table[] = {
+	1200000, 1250000, 1500000, 1800000
+};
+
+static const unsigned int mc34708_vusb2_volt_table[] = {
+	2500000, 2600000, 2750000, 3000000
+};
+
+static const unsigned int mc34708_vdac_volt_table[] = {
+	2500000, 2600000, 270000, 2775000
+};
+
+static const unsigned int mc34708_vgen1_volt_table[] = {
+	1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000
+};
+
+static const unsigned int mc34708_vgen2_volt_table[] = {
+	2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3150000, 3300000
+};
+
+static struct mc34708_regulator_def mc34708_regulator_defs[] = {
+	/* Buck regulators */
+	{
+		.name			= "sw1",
+		.kind			= &mc34708_sw_kind,
+		.supply_name		= "vinsw1",
+		.min_uV			= 650000,
+		.uV_step		= 12500,
+		.n_voltages		= 64,
+		.vsel_reg		= 0x18,
+		.vsel_mask		= (0x3f << 0),
+		.vsel_stdby_mask	= (0x3f << 6),
+		.mode_reg		= 0x1c,
+		.mode_mask		= (0xf << 0),
+	},
+	{
+		.name			= "sw2",
+		.kind			= &mc34708_sw_kind,
+		.supply_name		= "vinsw2",
+		.min_uV			= 650000,
+		.uV_step		= 12500,
+		.n_voltages		= 64,
+		.vsel_reg		= 0x19,
+		.vsel_mask		= (0x3f << 0),
+		.vsel_stdby_mask	= (0x3f << 6),
+		.mode_reg		= 0x1c,
+		.mode_mask		= (0xf << 14),
+	},
+	{
+		.name			= "sw3",
+		.kind			= &mc34708_sw_kind,
+		.supply_name		= "vinsw3",
+		.min_uV			= 650000,
+		.uV_step		= 25000,
+		.n_voltages		= 32,
+		.vsel_reg		= 0x19,
+		.vsel_mask		= (0x1f << 12),
+		.vsel_stdby_mask	= (0x1f << 18),
+		.mode_reg		= 0x1d,
+		.mode_mask		= (0xf << 0),
+	},
+	{
+		.name			= "sw4a",
+		.kind			= &mc34708_sw_kind,
+		.supply_name		= "vinsw4a",
+		.min_uV			= 1200000,
+		.uV_step		= 25000,
+		.n_voltages		= 27,
+		.vsel_reg		= 0x1a,
+		.vsel_mask		= (0x1f << 0),
+		.vsel_stdby_mask	= (0x1f << 5),
+		.mode_reg		= 0x1d,
+		.mode_mask		= (0xf << 6),
+	},
+	{
+		.name			= "sw4b",
+		.kind			= &mc34708_sw_kind,
+		.supply_name		= "vinsw4b",
+		.min_uV			= 1200000,
+		.uV_step		= 25000,
+		.n_voltages		= 27,
+		.vsel_reg		= 0x1a,
+		.vsel_mask		= (0x1f << 12),
+		.vsel_stdby_mask	= (0x1f << 17),
+		.mode_reg		= 0x1d,
+		.mode_mask		= (0xf << 12),
+	},
+	{
+		.name			= "sw5",
+		.kind			= &mc34708_sw_kind,
+		.supply_name		= "vinsw5",
+		.min_uV			= 1200000,
+		.uV_step		= 25000,
+		.n_voltages		= 27,
+		.vsel_reg		= 0x1b,
+		.vsel_mask		= (0x1f << 0),
+		.vsel_stdby_mask	= (0x1f << 10),
+		.mode_reg		= 0x1d,
+		.mode_mask		= (0xf << 18),
+	},
+
+	/* SWBST regulator */
+	{
+		.name			= "swbst",
+		.kind			= &mc34708_swbst_kind,
+		.supply_name		= "vinswbst",
+		.min_uV			= 5000000,
+		.uV_step		= 50000,
+		.n_voltages		= 4,
+		.vsel_reg		= 0x1f,
+		.vsel_mask		= (0x3 << 0),
+		.mode_reg		= 0x1f,
+		.mode_mask		= (0x3 << 2),
+		.mode_stdby_mask	= (0x3 << 5),
+	},
+
+	/* LDO regulators */
+	{
+		.name			= "vpll",
+		.kind			= &mc34708_ldo_kind,
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 15),
+		.volt_table		= mc34708_pll_volt_table,
+		.n_voltages		= ARRAY_SIZE(mc34708_pll_volt_table),
+		.mode_reg		= 0x20,
+		.mode_mask		= (1 << 16),
+	},
+	{
+		.name			= "vrefddr",
+		.kind			= &mc34708_ldo_vhalf_kind,
+		.supply_name		= "vinrefddr",
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 10),
+	},
+	{
+		.name			= "vusb",
+		.kind			= &mc34708_ldo_fixed_kind,
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 3),
+		.fixed_uV		= 3300000,
+		.n_voltages		= 1,
+	},
+	{
+		.name			= "vusb2",
+		.kind			= &mc34708_ldo_kind,
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 18),
+		.volt_table		= mc34708_vusb2_volt_table,
+		.n_voltages		= ARRAY_SIZE(mc34708_vusb2_volt_table),
+		.mode_reg		= 0x20,
+		.mode_mask		= (3 << 19),
+	},
+	{
+		.name			= "vdac",
+		.kind			= &mc34708_ldo_kind,
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 4),
+		.volt_table		= mc34708_vdac_volt_table,
+		.n_voltages		= ARRAY_SIZE(mc34708_vdac_volt_table),
+		.mode_reg		= 0x20,
+		.mode_mask		= (3 << 5),
+	},
+	{
+		.name			= "vgen1",
+		.kind			= &mc34708_ldo_kind,
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 0),
+		.volt_table		= mc34708_vgen1_volt_table,
+		.n_voltages		= ARRAY_SIZE(mc34708_vgen1_volt_table),
+		.mode_reg		= 0x20,
+		.mode_mask		= (1 << 1),
+	},
+	{
+		.name			= "vgen2",
+		.kind			= &mc34708_ldo_kind,
+		.enable_reg		= 0x20,
+		.enable_mask		= (1 << 12),
+		.volt_table		= mc34708_vgen2_volt_table,
+		.n_voltages		= ARRAY_SIZE(mc34708_vgen2_volt_table),
+		.mode_reg		= 0x20,
+		.mode_mask		= (3 << 13),
+	},
+};
+
+/*
+ * Setting some LDO standby states also requires changing the normal state.
+ * Therefore save the LDO configuration register on suspend and restore it
+ * on resume.
+ *
+ * This works because .set_suspend_X are called by the platform suspend handler
+ * AFTER device suspend
+ */
+#define MC34708_REG_REGMODE0 0x20
+
+static int mc34708_suspend(struct device *dev)
+{
+	struct mc34708_drv_data *mc34708_data = dev_get_drvdata(dev);
+
+	return mc13xxx_reg_read(mc34708_data->regulators[0].mc13xxx,
+				MC34708_REG_REGMODE0,
+				&mc34708_data->saved_regmode0);
+}
+
+static int mc34708_resume(struct device *dev)
+{
+	struct mc34708_drv_data *mc34708_data = dev_get_drvdata(dev);
+
+	return mc13xxx_reg_write(mc34708_data->regulators[0].mc13xxx,
+				MC34708_REG_REGMODE0,
+				mc34708_data->saved_regmode0);
+}
+
+static int mc34708_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int num_regs;
+	struct mc34708_drv_data *mc34708_data;
+	struct mc34708_regulator *mc34708_reg;
+	struct device_node *regs_np, *reg_np;
+	struct regulator_dev *rdev;
+	int ret;
+	int i;
+
+	regs_np = of_get_child_by_name(dev->parent->of_node, "regulators");
+	if (!regs_np)
+		return -ENODEV;
+
+	dev->of_node = regs_np;
+
+	num_regs = of_get_child_count(regs_np);
+	mc34708_data = devm_kzalloc(dev, sizeof(*mc34708_data) +
+					num_regs * sizeof(*mc34708_reg),
+					GFP_KERNEL);
+	if (!mc34708_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	dev_set_drvdata(dev, mc34708_data);
+
+	mc34708_reg = mc34708_data->regulators;
+	for_each_child_of_node(regs_np, reg_np) {
+		const struct mc34708_regulator_def *rd;
+		bool found;
+
+		found = false;
+		for (i = 0; i < ARRAY_SIZE(mc34708_regulator_defs); i++) {
+			rd = &mc34708_regulator_defs[i];
+
+			if (!of_node_cmp(reg_np->name, rd->name)) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			dev_warn(dev, "Unknown regulator '%s'\n", reg_np->name);
+			continue;
+		}
+
+		mc34708_reg->mc13xxx = dev_get_drvdata(dev->parent);
+		mc34708_reg->dev = dev;
+		mc34708_reg->def = rd;
+		mc34708_reg->desc.name = rd->name;
+		mc34708_reg->desc.supply_name = rd->supply_name;
+		mc34708_reg->desc.enable_reg = rd->enable_reg;
+		mc34708_reg->desc.enable_mask = rd->enable_mask;
+		mc34708_reg->desc.n_voltages = rd->n_voltages;
+		mc34708_reg->desc.fixed_uV = rd->fixed_uV;
+		mc34708_reg->desc.min_uV = rd->min_uV;
+		mc34708_reg->desc.uV_step = rd->uV_step;
+		mc34708_reg->desc.volt_table = rd->volt_table;
+		mc34708_reg->desc.vsel_reg = rd->vsel_reg;
+		mc34708_reg->desc.vsel_mask = rd->vsel_mask;
+		mc34708_reg->desc.of_map_mode = rd->kind->of_map_mode;
+		mc34708_reg->desc.ops = &rd->kind->ops;
+
+		mc34708_reg->config.init_data = of_get_regulator_init_data(dev,
+							reg_np,
+							&mc34708_reg->desc);
+		mc34708_reg->config.dev = dev;
+		mc34708_reg->config.of_node = reg_np;
+		mc34708_reg->config.driver_data = mc34708_reg;
+
+		if (rd->kind->setup) {
+			ret = rd->kind->setup(mc34708_reg);
+			if (ret)
+				goto out;
+		}
+
+		rdev = devm_regulator_register(dev,
+					       &mc34708_reg->desc,
+					       &mc34708_reg->config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(dev,
+				"Failed to register regulator %s (%d)\n",
+				rd->name, ret);
+			goto out;
+		}
+
+		mc34708_reg++;
+	}
+
+	ret = 0;
+
+out:
+	of_node_put(regs_np);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(mc34708_pm, mc34708_suspend, mc34708_resume);
+
+static struct platform_driver mc34708_regulator_driver = {
+	.driver	= {
+		.name	= "mc34708-regulator",
+		.pm	= &mc34708_pm,
+	},
+	.probe	= mc34708_regulator_probe,
+};
+
+static int __init mc34708_regulator_init(void)
+{
+	return platform_driver_register(&mc34708_regulator_driver);
+}
+subsys_initcall(mc34708_regulator_init);
+
+static void __exit mc34708_regulator_exit(void)
+{
+	platform_driver_unregister(&mc34708_regulator_driver);
+}
+module_exit(mc34708_regulator_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Martin Fuzzey <mfuzzey@parkeon.com>");
+MODULE_DESCRIPTION("Regulator Driver for Freescale MC34708 PMIC");
+MODULE_ALIAS("platform:mc34708-regulator");

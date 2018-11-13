From: Andrei.Stefanescu@microchip.com (Andrei.Stefanescu at microchip.com)
Date: Tue, 13 Nov 2018 11:29:41 +0000
Subject: [PATCH 3/3] regulator: mcp16502: add regulator driver for MCP16502
In-Reply-To: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a regulator driver for the MCP16502 PMIC.
This drivers supports basic operations through the
regulator interface such as:
- setting/reading voltage
- setting/reading operating mode
- reading current status
- transitioning to/from suspend-to-ram and standby
  power states

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/Kconfig    |   9 +
 drivers/regulator/Makefile   |   1 +
 drivers/regulator/mcp16502.c | 524 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 534 insertions(+)
 create mode 100644 drivers/regulator/mcp16502.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 926cee0..719d9d6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -567,6 +567,15 @@ config REGULATOR_MC13892
 	  Say y here to support the regulators found on the Freescale MC13892
 	  PMIC.
 
+config REGULATOR_MCP16502
+	tristate "Microchip MCP16502 PMIC"
+	depends on I2C && OF
+	help
+	  Say y here to support the MCP16502 PMIC. This driver supports
+	  basic operations (get/set voltage, get/set operating mode)
+	  through the regulator interface. In addition it enables
+	  suspend-to-ram/standby transition.
+
 config REGULATOR_MT6311
 	tristate "MediaTek MT6311 PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 72488ef..b12e1c9 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_REGULATOR_MAX77802) += max77802-regulator.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
+obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
new file mode 100644
index 0000000..29c72d3
--- /dev/null
+++ b/drivers/regulator/mcp16502.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MCP16502 PMIC driver
+ *
+ * Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Andrei Stefanescu <andrei.stefanescu@microchip.com>
+ *
+ * Inspired from tps65086-regulator.c
+ */
+
+#include  <linux/gpio.h>
+#include  <linux/i2c.h>
+#include  <linux/init.h>
+#include  <linux/kernel.h>
+#include  <linux/module.h>
+#include  <linux/of.h>
+#include  <linux/regmap.h>
+#include  <linux/regulator/driver.h>
+
+#define VDD_LOW_SEL 0x0D
+#define VDD_HIGH_SEL 0x3F
+
+#define MCP16502_VOL_SEL_MASK 0x3F
+#define MCP16502_EN_MASK BIT(7)
+#define MCP16502_MODE_MASK BIT(6)
+
+/*
+ *
+ * The PMIC has four sets of registers corresponding to four power modes:
+ * Performance, Active, Low-power, Hibernate.
+ *
+ * Registers:
+ * Each regulator has a register for each power mode. To access a register
+ * for a specific regulator and mode BASE_* and OFFSET_* need to be added.
+ *
+ * Operating modes:
+ * In order for the PMIC to transition to operating modes it has to be
+ * controlled via GPIO lines called LPM and HPM.
+ *
+ * The registers are fully configurable such that you can put all regulators in
+ * a low-power state while the PMIC is in Active mode. They are supposed to be
+ * configured at startup and then simply transition to/from a global low-power
+ * state by setting the GPIO lpm pin high/low.
+ *
+ * This driver keeps the PMIC in Active mode, Low-power state is set for the
+ * regulators by enabling/disabling operating mode (FPWM or Auto PFM).
+ *
+ * The PMIC's Low-power and Hibernate modes are used during standby/suspend.
+ * To enter standby/suspend the PMIC will go to Low-power mode. From there, it
+ * will transition to Hibernate when the PWRHLD line is set to low by the MPU.
+ */
+
+/*
+ * This macro is useful for iterating over all regulators and accessing their
+ * registers in a generic way or accessing a regulator device by its id.
+ */
+#define BASE(i) (((i) + 1) << 4)
+
+#define OFFSET_MODE_A 0
+#define OFFSET_MODE_HIB 2
+
+#define MCP16502_MODE_ACTIVE REGULATOR_MODE_NORMAL
+#define MCP16502_MODE_HIB REGULATOR_MODE_STANDBY
+
+#define MCP16502_MODE_AUTO_PFM 0
+#define MCP16502_MODE_FPWM BIT(6)
+
+#define MIN_REG 0x0
+#define MAX_REG 0x65
+
+static unsigned int mcp16502_of_map_mode(unsigned int mode)
+{
+	if (mode == REGULATOR_MODE_NORMAL || mode == REGULATOR_MODE_IDLE)
+		return mode;
+
+	return REGULATOR_MODE_INVALID;
+}
+
+#define MCP16502_REGULATOR(_name, _id, _ranges, _ops)			\
+	[_id] = {							\
+		.name			= _name,			\
+		.regulators_node	= of_match_ptr("regulators"),	\
+		.id			= _id,				\
+		.ops			= &(_ops),			\
+		.type			= REGULATOR_VOLTAGE,		\
+		.owner			= THIS_MODULE,			\
+		.linear_ranges		= _ranges,			\
+		.n_linear_ranges	= ARRAY_SIZE(_ranges),		\
+		.of_match		= of_match_ptr(_name),		\
+		.of_map_mode		= mcp16502_of_map_mode,		\
+	}
+
+enum {
+	BUCK1 = 0,
+	BUCK2,
+	BUCK3,
+	BUCK4,
+	LDO1,
+	LDO2,
+	NUM_REGULATORS
+};
+
+/*
+ * struct mcp16502 - PMIC representation
+ * @rdev: the regulators belonging to this chip
+ * @rmap: regmap to be used for I2C communication
+ * @lpm: LPM GPIO descriptor
+ */
+struct mcp16502 {
+	struct regulator_dev *rdev[NUM_REGULATORS];
+	struct regmap *rmap;
+	struct gpio_desc *lpm;
+};
+
+/*
+ * mcp16502_update_regulator - regmap_update_bits called for registers
+ *			       Active or Low-power depending on hibernate
+ *			       parameter
+ * @hibernate - use the registers for hibernate mode
+ *
+ */
+static int mcp16502_update_regulator(struct regulator_dev *rdev,
+				     bool hibernate,
+				     unsigned int mask, unsigned int val)
+{
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+	unsigned int reg = BASE(rdev_get_id(rdev));
+
+	reg += (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;
+
+	return regmap_update_bits(mcp->rmap, reg, mask, val);
+}
+
+/*
+ * mcp16502_read_regulator - read from Active or Low-power registers depending
+ *			     on the hibernate parameter
+ *
+ * @hibernate - use the registers for hibernate mode
+ *
+ */
+static int mcp16502_read(struct regulator_dev *rdev, bool hibernate,
+			 unsigned int mask)
+{
+	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
+	unsigned int reg = BASE(rdev_get_id(rdev));
+	int ret, val;
+
+	reg += (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;
+
+	ret = regmap_read(mcp->rmap, reg, &val);
+	if (ret)
+		return ret;
+
+	return val & mask;
+}
+
+/*
+ * mcp16502_gpio_set_mode - set the GPIO corresponding value
+ *
+ * Used to prepare transitioning into hibernate or resuming from it.
+ */
+static void mcp16502_gpio_set_mode(struct mcp16502 *mcp, int mode)
+{
+	int lpm = (mode == MCP16502_MODE_HIB);
+
+	gpiod_set_value(mcp->lpm, lpm);
+}
+
+/*
+ * mcp16502_get_mode - return the current operating mode of a regulator
+ *
+ * Note: all functions that are not part of entering/exiting standby/suspend
+ *	 use the Active mode registers.
+ *
+ * Note: this is different from the PMIC's operatig mode, it is the
+ *	 MODE bit from the regulator's register.
+ */
+static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
+{
+	int val;
+
+	val = mcp16502_read(rdev, false, MCP16502_MODE_MASK);
+	if (val < 0)
+		return val;
+
+	if (val == MCP16502_MODE_FPWM)
+		return REGULATOR_MODE_NORMAL;
+	else if (val == MCP16502_MODE_AUTO_PFM)
+		return REGULATOR_MODE_IDLE;
+
+	return REGULATOR_MODE_INVALID;
+}
+
+/*
+ * mcp16502_is_enabled - regulator_ops is_enabled
+ */
+static int mcp16502_is_enabled(struct regulator_dev *rdev)
+{
+	int val;
+
+	val = mcp16502_read(rdev, false, MCP16502_EN_MASK);
+	if (val < 0)
+		return val;
+
+	return !!val;
+}
+
+/*
+ * mcp16502_disable - regulator_ops disable
+ */
+static int mcp16502_disable(struct regulator_dev *rdev)
+{
+	return mcp16502_update_regulator(rdev, false, MCP16502_EN_MASK, 0);
+}
+
+/*
+ * _mcp16502_set_mode - helper for set_mode and set_suspend_mode
+ */
+static int _mcp16502_set_mode(struct regulator_dev *rdev, bool hibernate,
+			      unsigned int mode)
+{
+	int val;
+
+	if (mode != REGULATOR_MODE_NORMAL && mode != REGULATOR_MODE_IDLE)
+		return -EINVAL;
+
+	val = (mode == REGULATOR_MODE_NORMAL) ? MCP16502_MODE_FPWM :
+						MCP16502_MODE_AUTO_PFM;
+
+	return mcp16502_update_regulator(rdev, hibernate, MCP16502_MODE_MASK,
+					 val);
+}
+
+/*
+ * mcp16502_set_mode - regulator_ops set_mode
+ */
+static int mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	return _mcp16502_set_mode(rdev, false, mode);
+}
+
+/*
+ * mcp16502_enable - regulator_ops enable
+ */
+static int mcp16502_enable(struct regulator_dev *rdev)
+{
+	return mcp16502_update_regulator(rdev, false, MCP16502_EN_MASK,
+					 MCP16502_EN_MASK);
+}
+
+/*
+ * mcp16502_get_voltage_sel - regulator_ops get_voltage_sel
+ */
+static int mcp16502_get_voltage_sel(struct regulator_dev *rdev)
+{
+	return mcp16502_read(rdev, false, MCP16502_VOL_SEL_MASK);
+}
+
+/*
+ * mcp16502_set_voltage_sel - regulator_ops set_voltage_sel
+ */
+static int mcp16502_set_voltage_sel(struct regulator_dev *rdev,
+				    unsigned int selector)
+{
+	return mcp16502_update_regulator(rdev, false, MCP16502_VOL_SEL_MASK,
+					 selector);
+}
+
+/*
+ * mcp16502_get_status - regulator_ops get_status
+ */
+static int mcp16502_get_status(struct regulator_dev *rdev)
+{
+	int mode = mcp16502_get_mode(rdev);
+
+	if (!mcp16502_is_enabled(rdev))
+		return REGULATOR_STATUS_OFF;
+	else if (mode == REGULATOR_MODE_NORMAL)
+		return REGULATOR_STATUS_NORMAL;
+	else if (mode == REGULATOR_MODE_IDLE)
+		return REGULATOR_STATUS_IDLE;
+
+	return REGULATOR_STATUS_UNDEFINED;
+}
+
+/*
+ * mcp16502_set_suspend_voltage - regulator_ops set_suspend_voltage
+ */
+int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	int sel = regulator_map_voltage_linear_range(rdev, uV, uV);
+
+	if (sel < 0)
+		return sel;
+
+	return mcp16502_update_regulator(rdev, true, MCP16502_VOL_SEL_MASK,
+					 sel);
+}
+
+/*
+ * mcp16502_set_suspend_mode - regulator_ops set_suspend_mode
+ */
+int mcp16502_set_suspend_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	return _mcp16502_set_mode(rdev, true, mode);
+}
+
+/*
+ * mcp16502_set_suspend_enable - regulator_ops set_suspend_enable
+ */
+static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
+{
+	return mcp16502_update_regulator(rdev, true, MCP16502_EN_MASK,
+					 MCP16502_EN_MASK);
+}
+
+/*
+ * mcp16502_set_suspend_disable - regulator_ops set_suspend_disable
+ */
+static int mcp16502_set_suspend_disable(struct regulator_dev *rdev)
+{
+	return mcp16502_update_regulator(rdev, true, MCP16502_EN_MASK, 0);
+}
+
+static const struct regulator_ops mcp16502_buck_ops = {
+	.list_voltage			= regulator_list_voltage_linear_range,
+	.map_voltage			= regulator_map_voltage_linear_range,
+	.get_voltage_sel		= mcp16502_get_voltage_sel,
+	.set_voltage_sel		= mcp16502_set_voltage_sel,
+	.enable				= mcp16502_enable,
+	.disable			= mcp16502_disable,
+	.is_enabled			= mcp16502_is_enabled,
+	.set_mode			= mcp16502_set_mode,
+	.get_mode			= mcp16502_get_mode,
+	.get_status			= mcp16502_get_status,
+	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
+	.set_suspend_mode		= mcp16502_set_suspend_mode,
+	.set_suspend_enable		= mcp16502_set_suspend_enable,
+	.set_suspend_disable		= mcp16502_set_suspend_disable,
+};
+
+/*
+ * LDOs cannot change operating modes.
+ */
+static const struct regulator_ops mcp16502_ldo_ops = {
+	.list_voltage			= regulator_list_voltage_linear_range,
+	.map_voltage			= regulator_map_voltage_linear_range,
+	.get_voltage_sel		= mcp16502_get_voltage_sel,
+	.set_voltage_sel		= mcp16502_set_voltage_sel,
+	.enable				= mcp16502_enable,
+	.disable			= mcp16502_disable,
+	.is_enabled			= mcp16502_is_enabled,
+	.get_status			= mcp16502_get_status,
+	.set_suspend_voltage		= mcp16502_set_suspend_voltage,
+	.set_suspend_enable		= mcp16502_set_suspend_enable,
+	.set_suspend_disable		= mcp16502_set_suspend_disable,
+};
+
+static const struct of_device_id mcp16502_ids[] = {
+	{ .compatible = "microchip,mcp16502", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mcp16502_ids);
+
+static const struct regulator_linear_range b1l12_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, VDD_LOW_SEL, VDD_HIGH_SEL, 50000),
+};
+
+static const struct regulator_linear_range b234_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, VDD_LOW_SEL, VDD_HIGH_SEL, 25000),
+};
+
+static const struct regulator_desc mcp16502_desc[] = {
+	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops) */
+	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops),
+	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops),
+	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops)
+};
+
+static const struct regmap_range mcp16502_ranges[] = {
+	regmap_reg_range(MIN_REG, MAX_REG)
+};
+
+static const struct regmap_access_table mcp16502_yes_reg_table = {
+	.yes_ranges = mcp16502_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp16502_ranges),
+};
+
+static const struct regmap_config mcp16502_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= MAX_REG,
+	.cache_type	= REGCACHE_NONE,
+	.rd_table	= &mcp16502_yes_reg_table,
+	.wr_table	= &mcp16502_yes_reg_table,
+};
+
+/*
+ * set_up_regulators - initialize all regulators
+ */
+static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
+			    struct regulator_config config)
+{
+	int i;
+
+	for (i = 0; i < NUM_REGULATORS; i++) {
+		mcp->rdev[i] = devm_regulator_register(dev,
+						       &mcp16502_desc[i],
+						       &config);
+		if (IS_ERR(mcp->rdev[i])) {
+			dev_err(dev,
+				"failed to register %s regulator %ld\n",
+				mcp16502_desc[i].name, PTR_ERR(mcp->rdev[i]));
+			return PTR_ERR(mcp->rdev[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int mcp16502_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct regulator_config config = { };
+	struct device *dev;
+	struct mcp16502 *mcp;
+	int ret = 0;
+
+	dev = &client->dev;
+	config.dev = dev;
+
+	mcp = devm_kzalloc(dev, sizeof(*mcp), GFP_KERNEL);
+	if (!mcp)
+		return -ENOMEM;
+
+	mcp->rmap = devm_regmap_init_i2c(client, &mcp16502_regmap_config);
+	if (IS_ERR(mcp->rmap)) {
+		ret = PTR_ERR(mcp->rmap);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, mcp);
+	config.regmap = mcp->rmap;
+	config.driver_data = mcp;
+
+	mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
+	if (IS_ERR(mcp->lpm)) {
+		dev_err(dev, "failed to get lpm pin: %ld\n", PTR_ERR(mcp->lpm));
+		return PTR_ERR(mcp->lpm);
+	}
+
+	ret = setup_regulators(mcp, dev, config);
+	if (ret != 0)
+		return ret;
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_MODE_ACTIVE);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mcp16502_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp16502 *mcp = i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_MODE_HIB);
+
+	return 0;
+}
+
+static int mcp16502_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp16502 *mcp = i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_MODE_ACTIVE);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops mcp16502_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend, mcp16502_resume)
+};
+
+static const struct i2c_device_id mcp16502_i2c_id[] = {
+	{ "mcp16502", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
+
+static struct i2c_driver mcp16502_drv = {
+	.probe		= mcp16502_probe,
+	.driver		= {
+		.name	= "mcp16502-regulator",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(mcp16502_ids),
+		.pm = &mcp16502_pm_ops,
+	},
+	.id_table	= mcp16502_i2c_id,
+};
+
+static int __init mcp16502_init(void)
+{
+	return i2c_add_driver(&mcp16502_drv);
+}
+
+static void __exit mcp16502_exit(void)
+{
+}
+
+module_init(mcp16502_init);
+module_exit(mcp16502_exit);
+
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MCP16502 PMIC driver");
+MODULE_AUTHOR("Andrei Stefanescu andrei.stefanescu at microchip.com");
-- 
2.7.4

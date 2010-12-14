From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Tue, 14 Dec 2010 14:00:54 +0800
Subject: [PATCH 2/3] make mc13783 regulator code generic
In-Reply-To: <1292306455-26752-1-git-send-email-yong.shen@freescale.com>
References: <1292306455-26752-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1292306455-26752-3-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@linaro.org>

move some common functions and micros of mc13783 regulaor driver to
a seperate file, which makes it possible for mc13892 to share code.

Signed-off-by: Yong Shen <yong.shen@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/Kconfig                  |    4 +
 drivers/regulator/Makefile                 |    1 +
 drivers/regulator/mc13783-regulator.c      |  325 ++++------------------------
 drivers/regulator/mc13xxx-regulator-core.c |  234 ++++++++++++++++++++
 drivers/regulator/mc13xxx.h                |  101 +++++++++
 5 files changed, 383 insertions(+), 282 deletions(-)
 create mode 100644 drivers/regulator/mc13xxx-regulator-core.c
 create mode 100644 drivers/regulator/mc13xxx.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index da34981..ce17a03 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -186,9 +186,13 @@ config REGULATOR_PCAP
 	 This driver provides support for the voltage regulators of the
 	 PCAP2 PMIC.
 
+config REGULATOR_MC13XXX_CORE
+	bool
+
 config REGULATOR_MC13783
 	tristate "Support regulators on Freescale MC13783 PMIC"
 	depends on MFD_MC13783
+	select REGULATOR_MC13XXX_CORE
 	help
 	  Say y here to support the regulators found on the Freescale MC13783
 	  PMIC.
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index cf71df7..0b33bac 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
 obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
 obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
+obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
 obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
 
 obj-$(CONFIG_REGULATOR_TPS65023) += tps65023-regulator.o
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 6a6e1d6..3e5d0c3 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -1,6 +1,7 @@
 /*
  * Regulator Driver for Freescale MC13783 PMIC
  *
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
  * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
  * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
  *
@@ -17,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include "mc13xxx.h"
 
 #define MC13783_REG_SWITCHERS5			29
 #define MC13783_REG_SWITCHERS5_SW3EN			(1 << 20)
@@ -89,16 +91,6 @@
 #define MC13783_REG_POWERMISC_PWGTSPI_M			(3 << 15)
 
 
-struct mc13783_regulator {
-	struct regulator_desc desc;
-	int reg;
-	int enable_bit;
-	int vsel_reg;
-	int vsel_shift;
-	int vsel_mask;
-	int const *voltages;
-};
-
 /* Voltage Values */
 static const int mc13783_sw3_val[] = {
 	5000000, 5000000, 5000000, 5500000,
@@ -175,64 +167,26 @@ static const int mc13783_pwgtdrv_val[] = {
 	5500000,
 };
 
-static struct regulator_ops mc13783_regulator_ops;
-static struct regulator_ops mc13783_fixed_regulator_ops;
 static struct regulator_ops mc13783_gpo_regulator_ops;
 
-#define MC13783_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages)	\
-	[MC13783_ ## prefix ## _ ## _name] = {				\
-		.desc = {						\
-			.name = #prefix "_" #_name,			\
-			.n_voltages = ARRAY_SIZE(_voltages),		\
-			.ops = &mc13783_regulator_ops,			\
-			.type = REGULATOR_VOLTAGE,			\
-			.id = MC13783_ ## prefix ## _ ## _name,		\
-			.owner = THIS_MODULE,				\
-		},							\
-		.reg = MC13783_REG_ ## _reg,				\
-		.enable_bit = MC13783_REG_ ## _reg ## _ ## _name ## EN,	\
-		.vsel_reg = MC13783_REG_ ## _vsel_reg,			\
-		.vsel_shift = MC13783_REG_ ## _vsel_reg ## _ ## _name ## VSEL,\
-		.vsel_mask = MC13783_REG_ ## _vsel_reg ## _ ## _name ## VSEL_M,\
-		.voltages =  _voltages,					\
-	}
+#define MC13783_DEFINE(prefix, name, reg, vsel_reg, voltages)	\
+	MC13xxx_DEFINE(MC13783_REG_, name, reg, vsel_reg, voltages, \
+			mc13xxx_regulator_ops)
 
-#define MC13783_FIXED_DEFINE(prefix, _name, _reg, _voltages)		\
-	[MC13783_ ## prefix ## _ ## _name] = {				\
-		.desc = {						\
-			.name = #prefix "_" #_name,			\
-			.n_voltages = ARRAY_SIZE(_voltages),		\
-			.ops = &mc13783_fixed_regulator_ops,		\
-			.type = REGULATOR_VOLTAGE,			\
-			.id = MC13783_ ## prefix ## _ ## _name,		\
-			.owner = THIS_MODULE,				\
-		},							\
-		.reg = MC13783_REG_ ## _reg,				\
-		.enable_bit = MC13783_REG_ ## _reg ## _ ## _name ## EN,	\
-		.voltages =  _voltages,					\
-	}
+#define MC13783_FIXED_DEFINE(prefix, name, reg, voltages)		\
+	MC13xxx_FIXED_DEFINE(MC13783_REG_, name, reg, voltages, \
+			mc13xxx_fixed_regulator_ops)
 
-#define MC13783_GPO_DEFINE(prefix, _name, _reg,  _voltages)		\
-	[MC13783_ ## prefix ## _ ## _name] = {				\
-		.desc = {						\
-			.name = #prefix "_" #_name,			\
-			.n_voltages = ARRAY_SIZE(_voltages),		\
-			.ops = &mc13783_gpo_regulator_ops,		\
-			.type = REGULATOR_VOLTAGE,			\
-			.id = MC13783_ ## prefix ## _ ## _name,		\
-			.owner = THIS_MODULE,				\
-		},							\
-		.reg = MC13783_REG_ ## _reg,				\
-		.enable_bit = MC13783_REG_ ## _reg ## _ ## _name ## EN,	\
-		.voltages =  _voltages,					\
-	}
+#define MC13783_GPO_DEFINE(prefix, name, reg, voltages)		\
+	MC13xxx_GPO_DEFINE(MC13783_REG_, name, reg, voltages, \
+			mc13783_gpo_regulator_ops)
 
 #define MC13783_DEFINE_SW(_name, _reg, _vsel_reg, _voltages)		\
 	MC13783_DEFINE(REG, _name, _reg, _vsel_reg, _voltages)
 #define MC13783_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages)		\
 	MC13783_DEFINE(REG, _name, _reg, _vsel_reg, _voltages)
 
-static struct mc13783_regulator mc13783_regulators[] = {
+static struct mc13xxx_regulator mc13783_regulators[] = {
 	MC13783_DEFINE_SW(SW3, SWITCHERS5, SWITCHERS5, mc13783_sw3_val),
 
 	MC13783_FIXED_DEFINE(REG, VAUDIO, REGULATORMODE0, mc13783_vaudio_val),
@@ -274,213 +228,16 @@ static struct mc13783_regulator mc13783_regulators[] = {
 	MC13783_GPO_DEFINE(REG, PWGT2SPI, POWERMISC, mc13783_pwgtdrv_val),
 };
 
-struct mc13783_regulator_priv {
-	struct mc13783 *mc13783;
-	u32 powermisc_pwgt_state;
-	struct regulator_dev *regulators[];
-};
-
-static int mc13783_regulator_enable(struct regulator_dev *rdev)
-{
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
-	int ret;
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
-
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_reg_rmw(priv->mc13783, mc13783_regulators[id].reg,
-			mc13783_regulators[id].enable_bit,
-			mc13783_regulators[id].enable_bit);
-	mc13783_unlock(priv->mc13783);
-
-	return ret;
-}
-
-static int mc13783_regulator_disable(struct regulator_dev *rdev)
-{
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
-	int id = rdev_get_id(rdev);
-	int ret;
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
-
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_reg_rmw(priv->mc13783, mc13783_regulators[id].reg,
-			mc13783_regulators[id].enable_bit, 0);
-	mc13783_unlock(priv->mc13783);
-
-	return ret;
-}
-
-static int mc13783_regulator_is_enabled(struct regulator_dev *rdev)
-{
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
-	int ret, id = rdev_get_id(rdev);
-	unsigned int val;
-
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_reg_read(priv->mc13783, mc13783_regulators[id].reg, &val);
-	mc13783_unlock(priv->mc13783);
-
-	if (ret)
-		return ret;
-
-	return (val & mc13783_regulators[id].enable_bit) != 0;
-}
-
-static int mc13783_regulator_list_voltage(struct regulator_dev *rdev,
-						unsigned selector)
-{
-	int id = rdev_get_id(rdev);
-
-	if (selector >= mc13783_regulators[id].desc.n_voltages)
-		return -EINVAL;
-
-	return mc13783_regulators[id].voltages[selector];
-}
-
-static int mc13783_get_best_voltage_index(struct regulator_dev *rdev,
-						int min_uV, int max_uV)
-{
-	int reg_id = rdev_get_id(rdev);
-	int i;
-	int bestmatch;
-	int bestindex;
-
-	/*
-	 * Locate the minimum voltage fitting the criteria on
-	 * this regulator. The switchable voltages are not
-	 * in strict falling order so we need to check them
-	 * all for the best match.
-	 */
-	bestmatch = INT_MAX;
-	bestindex = -1;
-	for (i = 0; i < mc13783_regulators[reg_id].desc.n_voltages; i++) {
-		if (mc13783_regulators[reg_id].voltages[i] >= min_uV &&
-		    mc13783_regulators[reg_id].voltages[i] < bestmatch) {
-			bestmatch = mc13783_regulators[reg_id].voltages[i];
-			bestindex = i;
-		}
-	}
-
-	if (bestindex < 0 || bestmatch > max_uV) {
-		dev_warn(&rdev->dev, "no possible value for %d<=x<=%d uV\n",
-				min_uV, max_uV);
-		return -EINVAL;
-	}
-	return bestindex;
-}
-
-static int mc13783_regulator_set_voltage(struct regulator_dev *rdev,
-					 int min_uV, int max_uV,
-					 unsigned *selector)
-{
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
-	int value, id = rdev_get_id(rdev);
-	int ret;
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\n",
-		__func__, id, min_uV, max_uV);
-
-	/* Find the best index */
-	value = mc13783_get_best_voltage_index(rdev, min_uV, max_uV);
-	dev_dbg(rdev_get_dev(rdev), "%s best value: %d \n", __func__, value);
-	if (value < 0)
-		return value;
-
-	*selector = value;
-
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_reg_rmw(priv->mc13783, mc13783_regulators[id].vsel_reg,
-			mc13783_regulators[id].vsel_mask,
-			value << mc13783_regulators[id].vsel_shift);
-	mc13783_unlock(priv->mc13783);
-
-	return ret;
-}
-
-static int mc13783_regulator_get_voltage(struct regulator_dev *rdev)
-{
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
-	int ret, id = rdev_get_id(rdev);
-	unsigned int val;
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
-
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_reg_read(priv->mc13783,
-				mc13783_regulators[id].vsel_reg, &val);
-	mc13783_unlock(priv->mc13783);
-
-	if (ret)
-		return ret;
-
-	val = (val & mc13783_regulators[id].vsel_mask)
-		>> mc13783_regulators[id].vsel_shift;
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d val: %d\n", __func__, id, val);
-
-	BUG_ON(val < 0 || val > mc13783_regulators[id].desc.n_voltages);
-
-	return mc13783_regulators[id].voltages[val];
-}
-
-static struct regulator_ops mc13783_regulator_ops = {
-	.enable = mc13783_regulator_enable,
-	.disable = mc13783_regulator_disable,
-	.is_enabled = mc13783_regulator_is_enabled,
-	.list_voltage = mc13783_regulator_list_voltage,
-	.set_voltage = mc13783_regulator_set_voltage,
-	.get_voltage = mc13783_regulator_get_voltage,
-};
-
-static int mc13783_fixed_regulator_set_voltage(struct regulator_dev *rdev,
-					       int min_uV, int max_uV,
-					       unsigned int *selector)
-{
-	int id = rdev_get_id(rdev);
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\n",
-		__func__, id, min_uV, max_uV);
-
-	*selector = 0;
-
-	if (min_uV >= mc13783_regulators[id].voltages[0] &&
-	    max_uV <= mc13783_regulators[id].voltages[0])
-		return 0;
-	else
-		return -EINVAL;
-}
-
-static int mc13783_fixed_regulator_get_voltage(struct regulator_dev *rdev)
-{
-	int id = rdev_get_id(rdev);
-
-	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
-
-	return mc13783_regulators[id].voltages[0];
-}
-
-static struct regulator_ops mc13783_fixed_regulator_ops = {
-	.enable = mc13783_regulator_enable,
-	.disable = mc13783_regulator_disable,
-	.is_enabled = mc13783_regulator_is_enabled,
-	.list_voltage = mc13783_regulator_list_voltage,
-	.set_voltage = mc13783_fixed_regulator_set_voltage,
-	.get_voltage = mc13783_fixed_regulator_get_voltage,
-};
-
-static int mc13783_powermisc_rmw(struct mc13783_regulator_priv *priv, u32 mask,
-				 u32 val)
+static int mc13783_powermisc_rmw(struct mc13xxx_regulator_priv *priv, u32 mask,
+		u32 val)
 {
-	struct mc13783 *mc13783 = priv->mc13783;
+	struct mc13xxx *mc13783 = priv->mc13xxx;
 	int ret;
 	u32 valread;
 
 	BUG_ON(val & ~mask);
 
-	ret = mc13783_reg_read(mc13783, MC13783_REG_POWERMISC, &valread);
+	ret = mc13xxx_reg_read(mc13783, MC13783_REG_POWERMISC, &valread);
 	if (ret)
 		return ret;
 
@@ -495,15 +252,16 @@ static int mc13783_powermisc_rmw(struct mc13783_regulator_priv *priv, u32 mask,
 	valread = (valread & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
 						priv->powermisc_pwgt_state;
 
-	return mc13783_reg_write(mc13783, MC13783_REG_POWERMISC, valread);
+	return mc13xxx_reg_write(mc13783, MC13783_REG_POWERMISC, valread);
 }
 
 static int mc13783_gpo_regulator_enable(struct regulator_dev *rdev)
 {
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
 	int id = rdev_get_id(rdev);
 	int ret;
-	u32 en_val = mc13783_regulators[id].enable_bit;
+	u32 en_val = mc13xxx_regulators[id].enable_bit;
 
 	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
 
@@ -512,17 +270,18 @@ static int mc13783_gpo_regulator_enable(struct regulator_dev *rdev)
 	    id == MC13783_REG_PWGT2SPI)
 		en_val = 0;
 
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_powermisc_rmw(priv, mc13783_regulators[id].enable_bit,
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13783_powermisc_rmw(priv, mc13xxx_regulators[id].enable_bit,
 					en_val);
-	mc13783_unlock(priv->mc13783);
+	mc13xxx_unlock(priv->mc13xxx);
 
 	return ret;
 }
 
 static int mc13783_gpo_regulator_disable(struct regulator_dev *rdev)
 {
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
 	int id = rdev_get_id(rdev);
 	int ret;
 	u32 dis_val = 0;
@@ -532,25 +291,26 @@ static int mc13783_gpo_regulator_disable(struct regulator_dev *rdev)
 	/* Power Gate disable value is 1 */
 	if (id == MC13783_REG_PWGT1SPI ||
 	    id == MC13783_REG_PWGT2SPI)
-		dis_val = mc13783_regulators[id].enable_bit;
+		dis_val = mc13xxx_regulators[id].enable_bit;
 
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_powermisc_rmw(priv, mc13783_regulators[id].enable_bit,
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13783_powermisc_rmw(priv, mc13xxx_regulators[id].enable_bit,
 					dis_val);
-	mc13783_unlock(priv->mc13783);
+	mc13xxx_unlock(priv->mc13xxx);
 
 	return ret;
 }
 
 static int mc13783_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 {
-	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
 	int ret, id = rdev_get_id(rdev);
 	unsigned int val;
 
-	mc13783_lock(priv->mc13783);
-	ret = mc13783_reg_read(priv->mc13783, mc13783_regulators[id].reg, &val);
-	mc13783_unlock(priv->mc13783);
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13xxx_reg_read(priv->mc13xxx, mc13xxx_regulators[id].reg, &val);
+	mc13xxx_unlock(priv->mc13xxx);
 
 	if (ret)
 		return ret;
@@ -560,22 +320,22 @@ static int mc13783_gpo_regulator_is_enabled(struct regulator_dev *rdev)
 	val = (val & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
 	      (priv->powermisc_pwgt_state ^ MC13783_REG_POWERMISC_PWGTSPI_M);
 
-	return (val & mc13783_regulators[id].enable_bit) != 0;
+	return (val & mc13xxx_regulators[id].enable_bit) != 0;
 }
 
 static struct regulator_ops mc13783_gpo_regulator_ops = {
 	.enable = mc13783_gpo_regulator_enable,
 	.disable = mc13783_gpo_regulator_disable,
 	.is_enabled = mc13783_gpo_regulator_is_enabled,
-	.list_voltage = mc13783_regulator_list_voltage,
-	.set_voltage = mc13783_fixed_regulator_set_voltage,
-	.get_voltage = mc13783_fixed_regulator_get_voltage,
+	.list_voltage = mc13xxx_regulator_list_voltage,
+	.set_voltage = mc13xxx_fixed_regulator_set_voltage,
+	.get_voltage = mc13xxx_fixed_regulator_get_voltage,
 };
 
 static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
 {
-	struct mc13783_regulator_priv *priv;
-	struct mc13783 *mc13783 = dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx_regulator_priv *priv;
+	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
 	struct mc13783_regulator_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
 	struct mc13783_regulator_init_data *init_data;
@@ -589,7 +349,8 @@ static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->mc13783 = mc13783;
+	priv->mc13xxx_regulators = mc13783_regulators;
+	priv->mc13xxx = mc13783;
 
 	for (i = 0; i < pdata->num_regulators; i++) {
 		init_data = &pdata->regulators[i];
@@ -619,7 +380,7 @@ err:
 
 static int __devexit mc13783_regulator_remove(struct platform_device *pdev)
 {
-	struct mc13783_regulator_priv *priv = platform_get_drvdata(pdev);
+	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
 	struct mc13783_regulator_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
 	int i;
diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
new file mode 100644
index 0000000..448e8f4
--- /dev/null
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -0,0 +1,234 @@
+/*
+ * Regulator Driver for Freescale MC13xxx PMIC
+ *
+ * Copyright 2010 Yong Shen <yong.shen@linaro.org>
+ *
+ * Based on mc13783 regulator driver :
+ * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Regs infos taken from mc13xxx drivers from freescale and mc13xxx.pdf file
+ * from freescale
+ */
+
+#include <linux/mfd/mc13xxx.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include "mc13xxx.h"
+
+static int mc13xxx_regulator_enable(struct regulator_dev *rdev)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int id = rdev_get_id(rdev);
+	int ret;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13xxx_reg_rmw(priv->mc13xxx, mc13xxx_regulators[id].reg,
+			mc13xxx_regulators[id].enable_bit,
+			mc13xxx_regulators[id].enable_bit);
+	mc13xxx_unlock(priv->mc13xxx);
+
+	return ret;
+}
+
+static int mc13xxx_regulator_disable(struct regulator_dev *rdev)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int id = rdev_get_id(rdev);
+	int ret;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13xxx_reg_rmw(priv->mc13xxx, mc13xxx_regulators[id].reg,
+			mc13xxx_regulators[id].enable_bit, 0);
+	mc13xxx_unlock(priv->mc13xxx);
+
+	return ret;
+}
+
+static int mc13xxx_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int ret, id = rdev_get_id(rdev);
+	unsigned int val;
+
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13xxx_reg_read(priv->mc13xxx, mc13xxx_regulators[id].reg, &val);
+	mc13xxx_unlock(priv->mc13xxx);
+
+	if (ret)
+		return ret;
+
+	return (val & mc13xxx_regulators[id].enable_bit) != 0;
+}
+
+int mc13xxx_regulator_list_voltage(struct regulator_dev *rdev,
+						unsigned selector)
+{
+	int id = rdev_get_id(rdev);
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+
+	if (selector >= mc13xxx_regulators[id].desc.n_voltages)
+		return -EINVAL;
+
+	return mc13xxx_regulators[id].voltages[selector];
+}
+
+int mc13xxx_get_best_voltage_index(struct regulator_dev *rdev,
+						int min_uV, int max_uV)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int reg_id = rdev_get_id(rdev);
+	int i;
+	int bestmatch;
+	int bestindex;
+
+	/*
+	 * Locate the minimum voltage fitting the criteria on
+	 * this regulator. The switchable voltages are not
+	 * in strict falling order so we need to check them
+	 * all for the best match.
+	 */
+	bestmatch = INT_MAX;
+	bestindex = -1;
+	for (i = 0; i < mc13xxx_regulators[reg_id].desc.n_voltages; i++) {
+		if (mc13xxx_regulators[reg_id].voltages[i] >= min_uV &&
+		    mc13xxx_regulators[reg_id].voltages[i] < bestmatch) {
+			bestmatch = mc13xxx_regulators[reg_id].voltages[i];
+			bestindex = i;
+		}
+	}
+
+	if (bestindex < 0 || bestmatch > max_uV) {
+		dev_warn(&rdev->dev, "no possible value for %d<=x<=%d uV\n",
+				min_uV, max_uV);
+		return -EINVAL;
+	}
+	return bestindex;
+}
+
+static int mc13xxx_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
+		int max_uV, unsigned *selector)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int value, id = rdev_get_id(rdev);
+	int ret;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\n",
+		__func__, id, min_uV, max_uV);
+
+	/* Find the best index */
+	value = mc13xxx_get_best_voltage_index(rdev, min_uV, max_uV);
+	dev_dbg(rdev_get_dev(rdev), "%s best value: %d\n", __func__, value);
+	if (value < 0)
+		return value;
+
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13xxx_reg_rmw(priv->mc13xxx, mc13xxx_regulators[id].vsel_reg,
+			mc13xxx_regulators[id].vsel_mask,
+			value << mc13xxx_regulators[id].vsel_shift);
+	mc13xxx_unlock(priv->mc13xxx);
+
+	return ret;
+}
+
+static int mc13xxx_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int ret, id = rdev_get_id(rdev);
+	unsigned int val;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+	mc13xxx_lock(priv->mc13xxx);
+	ret = mc13xxx_reg_read(priv->mc13xxx,
+				mc13xxx_regulators[id].vsel_reg, &val);
+	mc13xxx_unlock(priv->mc13xxx);
+
+	if (ret)
+		return ret;
+
+	val = (val & mc13xxx_regulators[id].vsel_mask)
+		>> mc13xxx_regulators[id].vsel_shift;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d val: %d\n", __func__, id, val);
+
+	BUG_ON(val < 0 || val > mc13xxx_regulators[id].desc.n_voltages);
+
+	return mc13xxx_regulators[id].voltages[val];
+}
+
+struct regulator_ops mc13xxx_regulator_ops = {
+	.enable = mc13xxx_regulator_enable,
+	.disable = mc13xxx_regulator_disable,
+	.is_enabled = mc13xxx_regulator_is_enabled,
+	.list_voltage = mc13xxx_regulator_list_voltage,
+	.set_voltage = mc13xxx_regulator_set_voltage,
+	.get_voltage = mc13xxx_regulator_get_voltage,
+};
+
+int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
+	       int max_uV, unsigned *selector)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int id = rdev_get_id(rdev);
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\n",
+		__func__, id, min_uV, max_uV);
+
+	if (min_uV >= mc13xxx_regulators[id].voltages[0] &&
+	    max_uV <= mc13xxx_regulators[id].voltages[0])
+		return 0;
+	else
+		return -EINVAL;
+}
+
+int mc13xxx_fixed_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct mc13xxx_regulator_priv *priv = rdev_get_drvdata(rdev);
+	struct mc13xxx_regulator *mc13xxx_regulators = priv->mc13xxx_regulators;
+	int id = rdev_get_id(rdev);
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+	return mc13xxx_regulators[id].voltages[0];
+}
+
+struct regulator_ops mc13xxx_fixed_regulator_ops = {
+	.enable = mc13xxx_regulator_enable,
+	.disable = mc13xxx_regulator_disable,
+	.is_enabled = mc13xxx_regulator_is_enabled,
+	.list_voltage = mc13xxx_regulator_list_voltage,
+	.set_voltage = mc13xxx_fixed_regulator_set_voltage,
+	.get_voltage = mc13xxx_fixed_regulator_get_voltage,
+};
+
+int mc13xxx_sw_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	return 1;
+}
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Yong Shen <yong.shen@linaro.org>");
+MODULE_DESCRIPTION("Regulator Driver for Freescale MC13xxx PMIC");
+MODULE_ALIAS("mc13xxx-regulator-core");
diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
new file mode 100644
index 0000000..2775826
--- /dev/null
+++ b/drivers/regulator/mc13xxx.h
@@ -0,0 +1,101 @@
+/*
+ * mc13xxx.h - regulators for the Freescale mc13xxx PMIC
+ *
+ *  Copyright (C) 2010 Yong Shen <yong.shen@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_REGULATOR_MC13XXX_H
+#define __LINUX_REGULATOR_MC13XXX_H
+
+#include <linux/regulator/driver.h>
+
+struct mc13xxx_regulator {
+	struct regulator_desc desc;
+	int reg;
+	int enable_bit;
+	int vsel_reg;
+	int vsel_shift;
+	int vsel_mask;
+	int hi_bit;
+	int const *voltages;
+};
+
+struct mc13xxx_regulator_priv {
+	struct mc13xxx *mc13xxx;
+	u32 powermisc_pwgt_state;
+	struct mc13xxx_regulator *mc13xxx_regulators;
+	struct regulator_dev *regulators[];
+};
+
+extern int mc13xxx_sw_regulator(struct regulator_dev *rdev);
+extern int mc13xxx_sw_regulator_is_enabled(struct regulator_dev *rdev);
+extern int mc13xxx_get_best_voltage_index(struct regulator_dev *rdev,
+						int min_uV, int max_uV);
+extern int mc13xxx_regulator_list_voltage(struct regulator_dev *rdev,
+						unsigned selector);
+extern int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev,
+		int min_uV, int max_uV, unsigned *selector);
+extern int mc13xxx_fixed_regulator_get_voltage(struct regulator_dev *rdev);
+
+extern struct regulator_ops mc13xxx_regulator_ops;
+extern struct regulator_ops mc13xxx_fixed_regulator_ops;
+
+#define MC13xxx_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages, _ops)	\
+	[prefix ## _name] = {				\
+		.desc = {						\
+			.name = #prefix "_" #_name,			\
+			.n_voltages = ARRAY_SIZE(_voltages),		\
+			.ops = &_ops,			\
+			.type = REGULATOR_VOLTAGE,			\
+			.id = prefix ## _name,		\
+			.owner = THIS_MODULE,				\
+		},							\
+		.reg = prefix ## _reg,				\
+		.enable_bit = prefix ## _reg ## _ ## _name ## EN,	\
+		.vsel_reg = prefix ## _vsel_reg,			\
+		.vsel_shift = prefix ## _vsel_reg ## _ ## _name ## VSEL,\
+		.vsel_mask = prefix ## _vsel_reg ## _ ## _name ## VSEL_M,\
+		.voltages =  _voltages,					\
+	}
+
+#define MC13xxx_FIXED_DEFINE(prefix, _name, _reg, _voltages, _ops)	\
+	[prefix ## _name] = {				\
+		.desc = {						\
+			.name = #prefix "_" #_name,			\
+			.n_voltages = ARRAY_SIZE(_voltages),		\
+			.ops = &_ops,		\
+			.type = REGULATOR_VOLTAGE,			\
+			.id = prefix ## _name,		\
+			.owner = THIS_MODULE,				\
+		},							\
+		.reg = prefix ## _reg,				\
+		.enable_bit = prefix ## _reg ## _ ## _name ## EN,	\
+		.voltages =  _voltages,					\
+	}
+
+#define MC13xxx_GPO_DEFINE(prefix, _name, _reg,  _voltages, _ops)	\
+	[prefix ## _name] = {				\
+		.desc = {						\
+			.name = #prefix "_" #_name,			\
+			.n_voltages = ARRAY_SIZE(_voltages),		\
+			.ops = &_ops,		\
+			.type = REGULATOR_VOLTAGE,			\
+			.id = prefix ## _name,		\
+			.owner = THIS_MODULE,				\
+		},							\
+		.reg = prefix ## _reg,				\
+		.enable_bit = prefix ## _reg ## _ ## _name ## EN,	\
+		.voltages =  _voltages,					\
+	}
+
+#define MC13xxx_DEFINE_SW(_name, _reg, _vsel_reg, _voltages, ops)	\
+	MC13xxx_DEFINE(SW, _name, _reg, _vsel_reg, _voltages, ops)
+#define MC13xxx_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages, ops)	\
+	MC13xxx_DEFINE(REGU, _name, _reg, _vsel_reg, _voltages, ops)
+
+#endif
-- 
1.7.0.4

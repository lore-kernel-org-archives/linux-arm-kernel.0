From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 12 Dec 2009 17:56:16 +0100
Subject: [PATCH 3/4] regulator: add voltage selection capability to mc13783
	regulators.
In-Reply-To: <1260636819.2054.33.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
Message-ID: <1260636976.2054.36.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch, complete the mc13783 regulator subsystem driver with 
voltage selecting capability.
Main Switches (SW1AB, SW2AB) are not supported yet.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/regulator/mc13783-regulator.c |  375 ++++++++++++++++++++++++++++++---
 1 files changed, 348 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 9f99862..ed78137 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -2,6 +2,7 @@
  * Regulator Driver for Freescale MC13783 PMIC
  *
  * Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright 2009 Alberto Panizzo <maramaopercheseimorto@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -18,9 +19,47 @@
 
 #define MC13783_REG_SWITCHERS4			28
 #define MC13783_REG_SWITCHERS4_PLLEN			(1 << 18)
+#define MC13783_REG_SWITCHERS4_PLLVSEL			(1 << 19)
+#define MC13783_REG_SWITCHERS4_PLLVSEL_M		(7 << 19)
 
 #define MC13783_REG_SWITCHERS5			29
 #define MC13783_REG_SWITCHERS5_SW3EN			(1 << 20)
+#define MC13783_REG_SWITCHERS5_SW3VSEL			18
+#define MC13783_REG_SWITCHERS5_SW3VSEL_M		(3 << 18)
+
+#define MC13783_REG_REGULATORSETTING0		30
+#define MC13783_REG_REGULATORSETTING0_VIOLOVSEL		2
+#define MC13783_REG_REGULATORSETTING0_VDIGVSEL		4
+#define MC13783_REG_REGULATORSETTING0_VGENVSEL		6
+#define MC13783_REG_REGULATORSETTING0_VRFDIGVSEL	9
+#define MC13783_REG_REGULATORSETTING0_VRFREFVSEL	11
+#define MC13783_REG_REGULATORSETTING0_VRFCPVSEL		13
+#define MC13783_REG_REGULATORSETTING0_VSIMVSEL		14
+#define MC13783_REG_REGULATORSETTING0_VESIMVSEL		15
+#define MC13783_REG_REGULATORSETTING0_VCAMVSEL		16
+
+#define MC13783_REG_REGULATORSETTING0_VIOLOVSEL_M	(3 << 2)
+#define MC13783_REG_REGULATORSETTING0_VDIGVSEL_M	(3 << 4)
+#define MC13783_REG_REGULATORSETTING0_VGENVSEL_M	(7 << 6)
+#define MC13783_REG_REGULATORSETTING0_VRFDIGVSEL_M	(3 << 9)
+#define MC13783_REG_REGULATORSETTING0_VRFREFVSEL_M	(3 << 11)
+#define MC13783_REG_REGULATORSETTING0_VRFCPVSEL_M	(1 << 13)
+#define MC13783_REG_REGULATORSETTING0_VSIMVSEL_M	(1 << 14)
+#define MC13783_REG_REGULATORSETTING0_VESIMVSEL_M	(1 << 15)
+#define MC13783_REG_REGULATORSETTING0_VCAMVSEL_M	(7 << 16)
+
+#define MC13783_REG_REGULATORSETTING1		31
+#define MC13783_REG_REGULATORSETTING1_VVIBVSEL		0
+#define MC13783_REG_REGULATORSETTING1_VRF1VSEL		2
+#define MC13783_REG_REGULATORSETTING1_VRF2VSEL		4
+#define MC13783_REG_REGULATORSETTING1_VMMC1VSEL		6
+#define MC13783_REG_REGULATORSETTING1_VMMC2VSEL		9
+
+#define MC13783_REG_REGULATORSETTING1_VVIBVSEL_M	(3 << 0)
+#define MC13783_REG_REGULATORSETTING1_VRF1VSEL_M	(3 << 2)
+#define MC13783_REG_REGULATORSETTING1_VRF2VSEL_M	(3 << 4)
+#define MC13783_REG_REGULATORSETTING1_VMMC1VSEL_M	(7 << 6)
+#define MC13783_REG_REGULATORSETTING1_VMMC2VSEL_M	(7 << 9)
 
 #define MC13783_REG_REGULATORMODE0		32
 #define MC13783_REG_REGULATORMODE0_VAUDIOEN		(1 << 0)
@@ -53,11 +92,164 @@ struct mc13783_regulator {
 	struct regulator_desc desc;
 	int reg;
 	int enable_bit;
+	int vsel_reg;
+	int vsel_shift;
+	int vsel_mask;
+	int const *voltages;
+};
+
+/* Voltage Values */
+static const int const mc13783_sw3_val[] = {
+	5000000,
+	5000000,
+	5000000,
+	5500000,
+};
+
+static const int const mc13783_pll_val[] = {
+	28,29,30,31,
+	32,33,34,35,
+};
+
+static const int const mc13783_vaudio_val[] = {
+	2775000,
+};
+
+static const int const mc13783_viohi_val[] = {
+	2775000,
+};
+
+static const int const mc13783_violo_val[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+};
+
+static const int const mc13783_vdig_val[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+};
+
+static const int const mc13783_vgen_val[] = {
+	1200000,
+	1300000,
+	1500000,
+	1800000,
+	1100000,
+	2000000,
+	2775000,
+	2400000,
+};
+
+static const int const mc13783_vrfdig_val[] = {
+	1200000,
+	1500000,
+	1800000,
+	1875000,
+};
+
+static const int const mc13783_vrfref_val[] = {
+	2475000,
+	2600000,
+	2700000,
+	2775000,
+};
+
+static const int const mc13783_vrfcp_val[] = {
+	2700000,
+	2775000,
+};
+
+static const int const mc13783_vsim_val[] = {
+	1800000,
+	2900000,
+	3000000,
+};
+
+static const int const mc13783_vesim_val[] = {
+	1800000,
+	2900000,
+};
+
+static const int const mc13783_vcam_val[] = {
+	1500000,
+	1800000,
+	2500000,
+	2550000,
+	2600000,
+	2750000,
+	2800000,
+	3000000,
+};
+
+static const int const mc13783_vrfbg_val[] = {
+	1250000,
+};
+
+static const int const mc13783_vvib_val[] = {
+	1300000,
+	1800000,
+	2000000,
+	3000000,
+};
+
+static const int const mc13783_vmmc_val[] = {
+	1600000,
+	1800000,
+	2000000,
+	2600000,
+	2700000,
+	2800000,
+	2900000,
+	3000000,
+};
+
+static const int const mc13783_vrf_val[] = {
+	1500000,
+	1875000,
+	2700000,
+	2775000,
 };
 
 static struct regulator_ops mc13783_regulator_ops;
 
-#define MC13783_DEFINE(prefix, _name, _reg)				\
+#define MC13783_DEFINE(prefix, _name, _reg, _vsel_reg, _voltages)	\
+	[MC13783_ ## prefix ## _ ## _name] = {				\
+		.desc = {						\
+			.name = #prefix "_" #_name,			\
+			.n_voltages = ARRAY_SIZE(_voltages),		\
+			.ops = &mc13783_regulator_ops,			\
+			.type = REGULATOR_VOLTAGE,			\
+			.id = MC13783_ ## prefix ## _ ## _name,		\
+			.owner = THIS_MODULE,				\
+		},							\
+		.reg = MC13783_REG_ ## _reg,				\
+		.enable_bit = MC13783_REG_ ## _reg ## _ ## _name ## EN,	\
+		.vsel_reg = MC13783_REG_ ## _vsel_reg,			\
+		.vsel_shift = MC13783_REG_ ## _vsel_reg ## _ ## _name ## VSEL,\
+		.vsel_mask = MC13783_REG_ ## _vsel_reg ## _ ## _name ## VSEL_M,\
+		.voltages =  _voltages,					\
+	}
+
+#define MC13783_FIXED_DEFINE(prefix, _name, _reg, _voltages)		\
+	[MC13783_ ## prefix ## _ ## _name] = {				\
+		.desc = {						\
+			.name = #prefix "_" #_name,			\
+			.n_voltages = ARRAY_SIZE(_voltages),		\
+			.ops = &mc13783_regulator_ops,			\
+			.type = REGULATOR_VOLTAGE,			\
+			.id = MC13783_ ## prefix ## _ ## _name,		\
+			.owner = THIS_MODULE,				\
+		},							\
+		.reg = MC13783_REG_ ## _reg,				\
+		.enable_bit = MC13783_REG_ ## _reg ## _ ## _name ## EN,	\
+		.voltages =  _voltages,					\
+	}
+
+#define MC13783_GPO_DEFINE(prefix, _name, _reg)				\
 	[MC13783_ ## prefix ## _ ## _name] = {				\
 		.desc = {						\
 			.name = #prefix "_" #_name,			\
@@ -70,34 +262,50 @@ static struct regulator_ops mc13783_regulator_ops;
 		.enable_bit = MC13783_REG_ ## _reg ## _ ## _name ## EN,	\
 	}
 
-#define MC13783_DEFINE_SW(_name, _reg) MC13783_DEFINE(SW, _name, _reg)
-#define MC13783_DEFINE_REGU(_name, _reg) MC13783_DEFINE(REGU, _name, _reg)
+#define MC13783_DEFINE_SW(_name, _reg, _vsel_reg, _voltages)		\
+	MC13783_DEFINE(SW, _name, _reg, _vsel_reg, _voltages)
+#define MC13783_DEFINE_REGU(_name, _reg, _vsel_reg, _voltages)		\
+	MC13783_DEFINE(REGU, _name, _reg, _vsel_reg, _voltages)
 
 static struct mc13783_regulator mc13783_regulators[] = {
-	MC13783_DEFINE_SW(SW3, SWITCHERS5),
-	MC13783_DEFINE_SW(PLL, SWITCHERS4),
-
-	MC13783_DEFINE_REGU(VAUDIO, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VIOHI, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VIOLO, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VDIG, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VGEN, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VRFDIG, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VRFREF, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VRFCP, REGULATORMODE0),
-	MC13783_DEFINE_REGU(VSIM, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VESIM, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VCAM, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VRFBG, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VVIB, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VRF1, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VRF2, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VMMC1, REGULATORMODE1),
-	MC13783_DEFINE_REGU(VMMC2, REGULATORMODE1),
-	MC13783_DEFINE_REGU(GPO1, POWERMISC),
-	MC13783_DEFINE_REGU(GPO2, POWERMISC),
-	MC13783_DEFINE_REGU(GPO3, POWERMISC),
-	MC13783_DEFINE_REGU(GPO4, POWERMISC),
+	MC13783_DEFINE_SW(SW3, SWITCHERS5, SWITCHERS5, mc13783_sw3_val),
+	MC13783_DEFINE_SW(PLL, SWITCHERS4, SWITCHERS4, mc13783_pll_val),
+
+	MC13783_FIXED_DEFINE(REGU, VAUDIO, REGULATORMODE0, mc13783_vaudio_val),
+	MC13783_FIXED_DEFINE(REGU, VIOHI, REGULATORMODE0, mc13783_viohi_val),
+	MC13783_DEFINE_REGU(VIOLO, REGULATORMODE0, REGULATORSETTING0,	\
+			    mc13783_violo_val),
+	MC13783_DEFINE_REGU(VDIG, REGULATORMODE0, REGULATORSETTING0,	\
+			    mc13783_vdig_val),
+	MC13783_DEFINE_REGU(VGEN, REGULATORMODE0, REGULATORSETTING0,	\
+			    mc13783_vgen_val),
+	MC13783_DEFINE_REGU(VRFDIG, REGULATORMODE0, REGULATORSETTING0,	\
+			    mc13783_vrfdig_val),
+	MC13783_DEFINE_REGU(VRFREF, REGULATORMODE0, REGULATORSETTING0,	\
+			    mc13783_vrfref_val),
+	MC13783_DEFINE_REGU(VRFCP, REGULATORMODE0, REGULATORSETTING0,	\
+			    mc13783_vrfcp_val),
+	MC13783_DEFINE_REGU(VSIM, REGULATORMODE1, REGULATORSETTING0,	\
+			    mc13783_vsim_val),
+	MC13783_DEFINE_REGU(VESIM, REGULATORMODE1, REGULATORSETTING0,	\
+			    mc13783_vesim_val),
+	MC13783_DEFINE_REGU(VCAM, REGULATORMODE1, REGULATORSETTING0,	\
+			    mc13783_vcam_val),
+	MC13783_FIXED_DEFINE(REGU,VRFBG, REGULATORMODE1, mc13783_vrfbg_val),
+	MC13783_DEFINE_REGU(VVIB, REGULATORMODE1, REGULATORSETTING1,	\
+			    mc13783_vvib_val),
+	MC13783_DEFINE_REGU(VRF1, REGULATORMODE1, REGULATORSETTING1,	\
+			    mc13783_vrf_val),
+	MC13783_DEFINE_REGU(VRF2, REGULATORMODE1, REGULATORSETTING1,	\
+			    mc13783_vrf_val),
+	MC13783_DEFINE_REGU(VMMC1, REGULATORMODE1, REGULATORSETTING1,	\
+			    mc13783_vmmc_val),
+	MC13783_DEFINE_REGU(VMMC2, REGULATORMODE1, REGULATORSETTING1,	\
+			    mc13783_vmmc_val),
+	MC13783_GPO_DEFINE(REGU, GPO1, POWERMISC),
+	MC13783_GPO_DEFINE(REGU, GPO2, POWERMISC),
+	MC13783_GPO_DEFINE(REGU, GPO3, POWERMISC),
+	MC13783_GPO_DEFINE(REGU, GPO4, POWERMISC),
 };
 
 struct mc13783_regulator_priv {
@@ -154,10 +362,123 @@ static int mc13783_regulator_is_enabled(struct regulator_dev *rdev)
 	return (val & mc13783_regulators[id].enable_bit) != 0;
 }
 
+static int mc13783_regulator_list_voltage (struct regulator_dev *rdev, unsigned selector)
+{
+	int id = rdev_get_id(rdev);
+
+	if (selector >= mc13783_regulators[id].desc.n_voltages)
+		return -EINVAL;
+
+	return mc13783_regulators[id].voltages[selector];
+}
+
+static int mc13783_get_best_voltage_index(struct regulator_dev *rdev,
+						int min_uV, int max_uV)
+{
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
+	for (i = 0; i < mc13783_regulators[reg_id].desc.n_voltages; i++) {
+		if (mc13783_regulators[reg_id].voltages[i] <= max_uV &&
+		    mc13783_regulators[reg_id].voltages[i] >= min_uV &&
+		    mc13783_regulators[reg_id].voltages[i] < bestmatch) {
+			bestmatch = mc13783_regulators[reg_id].voltages[i];
+			bestindex = i;
+		}
+	}
+
+	if (bestindex < 0) {
+		dev_warn(&rdev->dev, "requested %d<=x<=%d uV, out of range!\n",
+				min_uV, max_uV);
+		return -EINVAL;
+	}
+	return bestindex;
+}
+
+static int mc13783_regulator_set_voltage (struct regulator_dev *rdev, int min_uV, int max_uV)
+{
+	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
+	int value, id = rdev_get_id(rdev);
+	int ret;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d min_uV: %d max_uV: %d\n",
+		__func__, id, min_uV, max_uV);
+
+	dev_dbg(rdev_get_dev(rdev), "%s n_voltages: %d \n",
+		__func__, mc13783_regulators[id].desc.n_voltages);
+
+	/* If it is a fixed regulator*/
+	if (mc13783_regulators[id].desc.n_voltages == 1)
+	{
+		if (min_uV > mc13783_regulators[id].voltages[0] &&
+		    max_uV < mc13783_regulators[id].voltages[0])
+			return 0;
+		else
+			return -EINVAL;
+	}
+
+	/* Find the best index */
+	value = mc13783_get_best_voltage_index(rdev, min_uV, max_uV);
+	dev_dbg(rdev_get_dev(rdev), "%s best value: %d \n", __func__, value);
+	if (value < 0)
+		return value;
+
+	mc13783_lock(priv->mc13783);
+	ret = mc13783_reg_rmw(priv->mc13783, mc13783_regulators[id].vsel_reg,
+			mc13783_regulators[id].vsel_mask,
+			value << mc13783_regulators[id].vsel_shift);
+	mc13783_unlock(priv->mc13783);
+
+	return ret;
+}
+
+static int mc13783_regulator_get_voltage (struct regulator_dev *rdev)
+{
+	struct mc13783_regulator_priv *priv = rdev_get_drvdata(rdev);
+	int ret, id = rdev_get_id(rdev);
+	unsigned int val;
+
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d\n", __func__, id);
+
+	/* If it is a fixed voltage regulator */
+	if (mc13783_regulators[id].desc.n_voltages == 1)
+		return mc13783_regulators[id].voltages[0];
+
+	mc13783_lock(priv->mc13783);
+	ret = mc13783_reg_read( priv->mc13783,
+				mc13783_regulators[id].vsel_reg, &val);
+	mc13783_unlock(priv->mc13783);
+
+	if (ret)
+		return ret;
+
+	val =(val & mc13783_regulators[id].vsel_mask)
+		>> mc13783_regulators[id].vsel_shift;
+	dev_dbg(rdev_get_dev(rdev), "%s id: %d val: %d\n", __func__, id, val);
+
+	BUG_ON(val < 0 || val > mc13783_regulators[id].desc.n_voltages);
+
+	return mc13783_regulators[id].voltages[val];
+}
+
+
 static struct regulator_ops mc13783_regulator_ops = {
 	.enable = mc13783_regulator_enable,
 	.disable = mc13783_regulator_disable,
 	.is_enabled = mc13783_regulator_is_enabled,
+	.list_voltage = mc13783_regulator_list_voltage,
+	.set_voltage = mc13783_regulator_set_voltage,
+	.get_voltage = mc13783_regulator_get_voltage,
 };
 
 static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
-- 
1.6.3.3

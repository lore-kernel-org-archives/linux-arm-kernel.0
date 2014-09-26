From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 26 Sep 2014 10:57:22 +0200
Subject: [PATCH 1/2] regulator: anatop: allow LDO bypass to be set from
 device-tree
In-Reply-To: <1411711172-16498-2-git-send-email-tharvey@gateworks.com>
References: <1411711172-16498-1-git-send-email-tharvey@gateworks.com>
 <1411711172-16498-2-git-send-email-tharvey@gateworks.com>
Message-ID: <1411721842.4147.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

Am Donnerstag, den 25.09.2014, 22:59 -0700 schrieb Tim Harvey:
> The core regulators provided by the Anatop regulator (reg_core, reg_soc,
> reg_pu) should be set in bypass mode if an extern PMIC regulator is used.

Agreed, but ...

> This allows configuring this from device-tree.

... this should not be configured from the device tree.

If the PMIC driver is not loaded or cpufreq is disabled for other
reasons, the full LDO input voltage will be passed through to the core
all the time. The bypass should only be enabled if there is actually a
driver to reduce the voltage of the PMIC regulators.

I have a patch to imx6q-cpufreq (see below) that uses the regulator API
to enable the bypass on the core LDOs if additional PMIC regulators are
provided in the device tree and regulator-allow-bypass is set on the LDO
regulators. But it has its own problems.
First, it adds even more regulators. I'd rather move the voltage
regulation details out of imx6-cpufreq instead, because ideally that
should only have to care about the ARM voltage.
Second, regulator_allow_bypass does nothing if there are other consumers
that have not allowed bypass yet, but immediately enables bypass once
the last registered consumer allows it. In our case the PU power domain
driver is, or rather will be, a second consumer of the VDDSOC regulator,
even though it does not care about the voltage level. This makes the
allow-bypass ordering a bit of a hassle.

regards
Philipp

--8<--
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] cpufreq: imx6q: Add support for bypass modes

The internal LDOs can be set to bypass if separate external regulators
are available for VDDARM and VDDSOC inputs.

To use external switching regulators, they have to be added to the cpu0
device tree node using the vddarm-supply and vddsoc-supply properties.
Further, the reg_arm, reg_pu, and reg_soc regulators need to have the
regulator-allow-bypass property set.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 152 +++++++++++++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index c2d3076..c0b3558 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -23,6 +23,8 @@
 static struct regulator *arm_reg;
 static struct regulator *pu_reg;
 static struct regulator *soc_reg;
+static struct regulator *vddarm_reg;
+static struct regulator *vddsoc_reg;
 
 static struct clk *arm_clk;
 static struct clk *pll1_sys_clk;
@@ -40,6 +42,7 @@ static u32 soc_opp_count;
 static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct dev_pm_opp *opp;
+	struct regulator *reg;
 	unsigned long freq_hz, volt, volt_old;
 	unsigned int old_freq, new_freq;
 	int ret;
@@ -64,21 +67,31 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 		old_freq / 1000, volt_old / 1000,
 		new_freq / 1000, volt / 1000);
 
+	reg = vddarm_reg ? vddarm_reg : arm_reg;
+
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
-		if (!IS_ERR(pu_reg)) {
-			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+		if (!IS_ERR(vddsoc_reg)) {
+			ret = regulator_set_voltage_tol(vddsoc_reg, imx6_soc_volt[index], 0);
 			if (ret) {
-				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
+				dev_err(cpu_dev, "failed to scale vddsoc up: %d\n", ret);
+				return ret;
+			}
+		} else {
+			if (!IS_ERR(pu_reg)) {
+				ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+				if (ret) {
+					dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
+					return ret;
+				}
+			}
+			ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
+			if (ret) {
+				dev_err(cpu_dev, "failed to scale vddsoc up: %d\n", ret);
 				return ret;
 			}
 		}
-		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
-		if (ret) {
-			dev_err(cpu_dev, "failed to scale vddsoc up: %d\n", ret);
-			return ret;
-		}
-		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
+		ret = regulator_set_voltage_tol(reg, volt, 0);
 		if (ret) {
 			dev_err(cpu_dev,
 				"failed to scale vddarm up: %d\n", ret);
@@ -106,29 +119,37 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	ret = clk_set_rate(arm_clk, new_freq * 1000);
 	if (ret) {
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		regulator_set_voltage_tol(reg, volt_old, 0);
 		return ret;
 	}
 
 	/* scaling down?  scale voltage after frequency */
 	if (new_freq < old_freq) {
-		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
+		ret = regulator_set_voltage_tol(reg, volt, 0);
 		if (ret) {
 			dev_warn(cpu_dev,
 				 "failed to scale vddarm down: %d\n", ret);
 			ret = 0;
 		}
-		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
-		if (ret) {
-			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
-			ret = 0;
-		}
-		if (!IS_ERR(pu_reg)) {
-			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+		if (!IS_ERR(vddsoc_reg)) {
+			ret = regulator_set_voltage_tol(vddsoc_reg, imx6_soc_volt[index], 0);
+			if (ret) {
+				dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
+				ret = 0;
+			}
+		} else {
+			ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
 			if (ret) {
-				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
+				dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
 				ret = 0;
 			}
+			if (!IS_ERR(pu_reg)) {
+				ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+				if (ret) {
+					dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
+					ret = 0;
+				}
+			}
 		}
 	}
 
@@ -155,7 +176,10 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct dev_pm_opp *opp;
+	struct regulator *reg;
 	unsigned long min_volt, max_volt;
+	unsigned long vddarm_old = 0;
+	unsigned long vddsoc_old = 0;
 	int num, ret;
 	const struct property *prop;
 	const __be32 *val;
@@ -185,15 +209,31 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_clk;
 	}
 
+	vddarm_reg = regulator_get_optional(cpu_dev, "vddarm");
+	vddsoc_reg = regulator_get_optional(cpu_dev, "vddsoc");
 	arm_reg = regulator_get(cpu_dev, "arm");
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
 	soc_reg = regulator_get(cpu_dev, "soc");
+	if (PTR_ERR(vddarm_reg) == -EPROBE_DEFER ||
+	    PTR_ERR(vddsoc_reg) == -EPROBE_DEFER ||
+	    PTR_ERR(arm_reg) == -EPROBE_DEFER ||
+	    PTR_ERR(pu_reg) == -EPROBE_DEFER ||
+	    PTR_ERR(soc_reg) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto put_reg;
+	}
 	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
 		dev_err(cpu_dev, "failed to get regulators\n");
 		ret = -ENOENT;
 		goto put_reg;
 	}
 
+	if (!IS_ERR(vddarm_reg) && vddarm_reg == vddsoc_reg) {
+		dev_warn(cpu_dev, "arm and pu/soc supplied from the same regulator\n");
+		ret = -EINVAL;
+		goto put_reg;
+	}
+
 	/*
 	 * We expect an OPP table supplied by platform.
 	 * Just, incase the platform did not supply the OPP
@@ -269,13 +309,19 @@ soc_opp_out:
 	 * Calculate the ramp time for max voltage change in the
 	 * VDDSOC and VDDPU regulators.
 	 */
-	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
-	if (ret > 0)
-		transition_latency += ret * 1000;
-	if (!IS_ERR(pu_reg)) {
-		ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
+	if (!IS_ERR(vddsoc_reg)) {
+		ret = regulator_set_voltage_time(vddsoc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
+		if (ret > 0)
+			transition_latency += ret * 1000;
+	} else {
+		ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
 		if (ret > 0)
 			transition_latency += ret * 1000;
+		if (!IS_ERR(pu_reg)) {
+			ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
+			if (ret > 0)
+				transition_latency += ret * 1000;
+		}
 	}
 
 	/*
@@ -291,22 +337,72 @@ soc_opp_out:
 				  freq_table[--num].frequency * 1000, true);
 	max_volt = dev_pm_opp_get_voltage(opp);
 	rcu_read_unlock();
-	ret = regulator_set_voltage_time(arm_reg, min_volt, max_volt);
+
+	reg = vddarm_reg ? vddarm_reg : arm_reg;
+	ret = regulator_set_voltage_time(reg, min_volt, max_volt);
 	if (ret > 0)
 		transition_latency += ret * 1000;
 
+	/* Bypass internal LDOs if external supplies are given */
+	if (vddarm_reg) {
+		vddarm_old = regulator_get_voltage(vddarm_reg);
+		regulator_set_voltage_tol(vddarm_reg, max_volt, 0);
+		ret = regulator_allow_bypass(arm_reg, true);
+		if (ret) {
+			dev_err(cpu_dev, "failed to bypass arm supply: %d\n",
+				ret);
+			goto restore_vddarm;
+		}
+	}
+	if (vddsoc_reg) {
+		vddsoc_old = regulator_get_voltage(vddsoc_reg);
+		if (freq_table[num].frequency == FREQ_1P2_GHZ / 1000)
+			regulator_set_voltage_tol(vddsoc_reg,
+						  PU_SOC_VOLTAGE_HIGH, 0);
+		else
+			regulator_set_voltage_tol(vddsoc_reg,
+						  PU_SOC_VOLTAGE_NORMAL, 0);
+		ret = regulator_allow_bypass(pu_reg, true);
+		if (ret) {
+			dev_err(cpu_dev, "failed to bypass pu supply: %d\n",
+				ret);
+			goto restore_vddsoc;
+		}
+		ret = regulator_allow_bypass(soc_reg, true);
+		if (ret) {
+			dev_err(cpu_dev, "failed to bypass soc supply: %d\n",
+				ret);
+			goto restore_vddsoc;
+		}
+	}
+
 	ret = cpufreq_register_driver(&imx6q_cpufreq_driver);
 	if (ret) {
 		dev_err(cpu_dev, "failed register driver: %d\n", ret);
-		goto free_freq_table;
+		goto restore_vddsoc;
 	}
 
 	of_node_put(np);
 	return 0;
 
+restore_vddsoc:
+	if (vddsoc_reg) {
+		regulator_allow_bypass(pu_reg, false);
+		regulator_allow_bypass(soc_reg, false);
+		regulator_set_voltage_tol(vddsoc_reg, vddsoc_old, 0);
+	}
+restore_vddarm:
+	if (vddarm_reg) {
+		regulator_allow_bypass(arm_reg, false);
+		regulator_set_voltage_tol(vddarm_reg, vddarm_old, 0);
+	}
 free_freq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 put_reg:
+	if (!IS_ERR_OR_NULL(vddarm_reg))
+		regulator_put(vddarm_reg);
+	if (!IS_ERR_OR_NULL(vddsoc_reg))
+		regulator_put(vddsoc_reg);
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
@@ -332,6 +428,10 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+	if (vddarm_reg)
+		regulator_put(vddarm_reg);
+	if (vddsoc_reg)
+		regulator_put(vddsoc_reg);
 	regulator_put(arm_reg);
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
-- 
2.1.0

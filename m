From: hl@rock-chips.com (Lin Huang)
Date: Fri, 29 Jul 2016 15:57:00 +0800
Subject: [PATCH v4 6/7] PM / devfreq: rockchip: add devfreq driver for rk3399
 dmc
In-Reply-To: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
Message-ID: <1469779021-10426-7-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

base on dfi result, we do ddr frequency scaling, register
dmc driver to devfreq framework, and use simple-ondemand
policy.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v4:
- use arm_smccc_smc() function talk to bl31
- delete rockchip_dmc.c file and config
- delete dmc_notify
- adjust probe order
 
Changes in v3:
- operate dram setting through sip call
- imporve set rate flow

Changes in v2:
- None
 
Changes in v1:
- move dfi controller to event
- fix set voltage sequence when set rate fail
- change Kconfig type from tristate to bool
- move unuse EXPORT_SYMBOL_GPL()

 drivers/devfreq/Kconfig               |   1 +
 drivers/devfreq/Makefile              |   1 +
 drivers/devfreq/rockchip/Kconfig      |   8 +
 drivers/devfreq/rockchip/Makefile     |   1 +
 drivers/devfreq/rockchip/rk3399_dmc.c | 473 ++++++++++++++++++++++++++++++++++
 5 files changed, 484 insertions(+)
 create mode 100644 drivers/devfreq/rockchip/Kconfig
 create mode 100644 drivers/devfreq/rockchip/Makefile
 create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 64281bb..acb2a57 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -99,5 +99,6 @@ config ARM_TEGRA_DEVFREQ
          operating frequencies and voltages with OPP support.
 
 source "drivers/devfreq/event/Kconfig"
+source "drivers/devfreq/rockchip/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 5134f9e..d844e23 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)	+= exynos/
 obj-$(CONFIG_ARM_EXYNOS5_BUS_DEVFREQ)	+= exynos/
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/rockchip/Kconfig b/drivers/devfreq/rockchip/Kconfig
new file mode 100644
index 0000000..d8f9e66
--- /dev/null
+++ b/drivers/devfreq/rockchip/Kconfig
@@ -0,0 +1,8 @@
+config ARM_RK3399_DMC_DEVFREQ
+	tristate "ARM RK3399 DMC DEVFREQ Driver"
+	select PM_OPP
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	help
+          This adds the DEVFREQ driver for the RK3399 dmc. It sets the frequency
+          for the memory controller and reads the usage counts from hardware.
+
diff --git a/drivers/devfreq/rockchip/Makefile b/drivers/devfreq/rockchip/Makefile
new file mode 100644
index 0000000..c62c105
--- /dev/null
+++ b/drivers/devfreq/rockchip/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
diff --git a/drivers/devfreq/rockchip/rk3399_dmc.c b/drivers/devfreq/rockchip/rk3399_dmc.c
new file mode 100644
index 0000000..527aa11
--- /dev/null
+++ b/drivers/devfreq/rockchip/rk3399_dmc.c
@@ -0,0 +1,473 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ * Author: Lin Huang <hl@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-event.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+#include <linux/rwsem.h>
+#include <linux/suspend.h>
+#include <linux/syscore_ops.h>
+
+#include <soc/rockchip/rockchip_sip.h>
+
+struct dram_timing {
+	unsigned int ddr3_speed_bin;
+	unsigned int pd_idle;
+	unsigned int sr_idle;
+	unsigned int sr_mc_gate_idle;
+	unsigned int srpd_lite_idle;
+	unsigned int standby_idle;
+	unsigned int dram_dll_dis_freq;
+	unsigned int phy_dll_dis_freq;
+	unsigned int ddr3_odt_dis_freq;
+	unsigned int ddr3_drv;
+	unsigned int ddr3_odt;
+	unsigned int phy_ddr3_ca_drv;
+	unsigned int phy_ddr3_dq_drv;
+	unsigned int phy_ddr3_odt;
+	unsigned int lpddr3_odt_dis_freq;
+	unsigned int lpddr3_drv;
+	unsigned int lpddr3_odt;
+	unsigned int phy_lpddr3_ca_drv;
+	unsigned int phy_lpddr3_dq_drv;
+	unsigned int phy_lpddr3_odt;
+	unsigned int lpddr4_odt_dis_freq;
+	unsigned int lpddr4_drv;
+	unsigned int lpddr4_dq_odt;
+	unsigned int lpddr4_ca_odt;
+	unsigned int phy_lpddr4_ca_drv;
+	unsigned int phy_lpddr4_ck_cs_drv;
+	unsigned int phy_lpddr4_dq_drv;
+	unsigned int phy_lpddr4_odt;
+};
+
+struct rk3399_dmcfreq {
+	struct device *dev;
+	struct devfreq *devfreq;
+	struct devfreq_simple_ondemand_data ondemand_data;
+	struct clk *dmc_clk;
+	struct devfreq_event_dev *edev;
+	struct mutex lock;
+	struct dram_timing *timing;
+	wait_queue_head_t	wait_dcf_queue;
+	int irq;
+	int wait_dcf_flag;
+	struct regulator *vdd_center;
+	unsigned long rate, target_rate;
+	unsigned long volt, target_volt;
+};
+
+static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
+				 u32 flags)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+	struct dev_pm_opp *opp;
+	unsigned long old_clk_rate = dmcfreq->rate;
+	unsigned long target_volt, target_rate;
+	int err;
+
+	rcu_read_lock();
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp)) {
+		rcu_read_unlock();
+		return PTR_ERR(opp);
+	}
+
+	target_rate = dev_pm_opp_get_freq(opp);
+	target_volt = dev_pm_opp_get_voltage(opp);
+	opp = devfreq_recommended_opp(dev, &dmcfreq->rate, flags);
+	if (IS_ERR(opp)) {
+		rcu_read_unlock();
+		return PTR_ERR(opp);
+	}
+	dmcfreq->volt = dev_pm_opp_get_voltage(opp);
+	rcu_read_unlock();
+
+	if (dmcfreq->rate == target_rate)
+		return 0;
+
+	mutex_lock(&dmcfreq->lock);
+
+	/*
+	 * if frequency scaling from low to high, adjust voltage first;
+	 * if frequency scaling from high to low, adjuset frequency first;
+	 */
+	if (old_clk_rate < target_rate) {
+		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
+					    target_volt);
+		if (err) {
+			dev_err(dev, "Unable to set vol %lu\n", target_volt);
+			goto out;
+		}
+	}
+	dmcfreq->wait_dcf_flag = 1;
+	err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
+	if (err) {
+		dev_err(dev,
+			"Unable to set freq %lu. Current freq %lu. Error %d\n",
+			target_rate, old_clk_rate, err);
+		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
+				      dmcfreq->volt);
+		goto out;
+	}
+
+	/*
+	 * wait until bcf irq happen, it means freq scaling finish in bl31,
+	 * use 100ms as timeout time
+	 */
+	if (!wait_event_timeout(dmcfreq->wait_dcf_queue,
+				!dmcfreq->wait_dcf_flag, HZ / 10))
+		dev_warn(dev, "Timeout waiting for dcf irq\n");
+	/*
+	 * check the dpll rate
+	 * there only two result we will get,
+	 * 1. ddr frequency scaling fail, we still get the old rate
+	 * 2, ddr frequency scaling sucessful, we get the rate we set
+	 */
+	dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
+
+	/* if get the incorrect rate, set voltage to old value */
+	if (dmcfreq->rate != target_rate) {
+		dev_err(dev, "get wrong ddr frequency, Request freq %lu,\
+			Current freq %lu\n", target_rate, dmcfreq->rate);
+		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
+				      dmcfreq->volt);
+	} else if (old_clk_rate > target_rate)
+		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
+					    target_volt);
+	if (err)
+		dev_err(dev, "Unable to set vol %lu\n", target_volt);
+
+out:
+	mutex_unlock(&dmcfreq->lock);
+	return err;
+}
+
+static int rk3399_dmcfreq_get_dev_status(struct device *dev,
+					 struct devfreq_dev_status *stat)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+	struct devfreq_event_data edata;
+
+	devfreq_event_get_event(dmcfreq->edev, &edata);
+
+	stat->current_frequency = dmcfreq->rate;
+	stat->busy_time = edata.load_count;
+	stat->total_time = edata.total_count;
+
+	return 0;
+}
+
+static int rk3399_dmcfreq_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+
+	*freq = dmcfreq->rate;
+
+	return 0;
+}
+
+static void rk3399_dmcfreq_exit(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev,
+						    struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+
+	devfreq_unregister_opp_notifier(dev, dmcfreq->devfreq);
+}
+
+static struct devfreq_dev_profile rk3399_devfreq_dmc_profile = {
+	.polling_ms	= 200,
+	.target		= rk3399_dmcfreq_target,
+	.get_dev_status	= rk3399_dmcfreq_get_dev_status,
+	.get_cur_freq	= rk3399_dmcfreq_get_cur_freq,
+	.exit		= rk3399_dmcfreq_exit,
+};
+
+static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev,
+						    struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+
+	devfreq_event_disable_edev(dmcfreq->edev);
+	devfreq_suspend_device(dmcfreq->devfreq);
+
+	return 0;
+}
+
+static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev,
+						    struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+
+	devfreq_event_enable_edev(dmcfreq->edev);
+	devfreq_resume_device(dmcfreq->devfreq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
+			 rk3399_dmcfreq_resume);
+
+static irqreturn_t rk3399_dmc_irq(int irq, void *dev_id)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_id;
+	struct arm_smccc_res res;
+
+	dmcfreq->wait_dcf_flag = 0;
+	wake_up(&dmcfreq->wait_dcf_queue);
+
+	/* clr dcf irq */
+	arm_smccc_smc(SIP_DDR_FREQ, 0, 0, CONFIG_DRAM_CLR_IRQ,
+		      0, 0, 0, 0, &res);
+
+	return IRQ_HANDLED;
+}
+
+static int of_do_get_timing(struct device_node *np,
+		struct dram_timing *timing)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "ddr3_speed_bin",
+				   &timing->ddr3_speed_bin);
+	ret |= of_property_read_u32(np, "pd_idle", &timing->pd_idle);
+	ret |= of_property_read_u32(np, "sr_idle", &timing->sr_idle);
+	ret |= of_property_read_u32(np, "sr_mc_gate_idle",
+				    &timing->sr_mc_gate_idle);
+	ret |= of_property_read_u32(np, "srpd_lite_idle",
+				    &timing->srpd_lite_idle);
+	ret |= of_property_read_u32(np, "standby_idle", &timing->standby_idle);
+	ret |= of_property_read_u32(np, "dram_dll_dis_freq",
+				    &timing->dram_dll_dis_freq);
+	ret |= of_property_read_u32(np, "phy_dll_dis_freq",
+				    &timing->phy_dll_dis_freq);
+	ret |= of_property_read_u32(np, "ddr3_odt_dis_freq",
+				    &timing->ddr3_odt_dis_freq);
+	ret |= of_property_read_u32(np, "ddr3_drv", &timing->ddr3_drv);
+	ret |= of_property_read_u32(np, "ddr3_odt", &timing->ddr3_odt);
+	ret |= of_property_read_u32(np, "phy_ddr3_ca_drv",
+				    &timing->phy_ddr3_ca_drv);
+	ret |= of_property_read_u32(np, "phy_ddr3_dq_drv",
+				    &timing->phy_ddr3_dq_drv);
+	ret |= of_property_read_u32(np, "phy_ddr3_odt", &timing->phy_ddr3_odt);
+	ret |= of_property_read_u32(np, "lpddr3_odt_dis_freq",
+				    &timing->lpddr3_odt_dis_freq);
+	ret |= of_property_read_u32(np, "lpddr3_drv", &timing->lpddr3_drv);
+	ret |= of_property_read_u32(np, "lpddr3_odt", &timing->lpddr3_odt);
+	ret |= of_property_read_u32(np, "phy_lpddr3_ca_drv",
+				    &timing->phy_lpddr3_ca_drv);
+	ret |= of_property_read_u32(np, "phy_lpddr3_dq_drv",
+				    &timing->phy_lpddr3_dq_drv);
+	ret |= of_property_read_u32(np, "phy_lpddr3_odt",
+				    &timing->phy_lpddr3_odt);
+	ret |= of_property_read_u32(np, "lpddr4_odt_dis_freq",
+				    &timing->lpddr4_odt_dis_freq);
+	ret |= of_property_read_u32(np, "lpddr4_drv",
+				    &timing->lpddr4_drv);
+	ret |= of_property_read_u32(np, "lpddr4_dq_odt",
+				    &timing->lpddr4_dq_odt);
+	ret |= of_property_read_u32(np, "lpddr4_ca_odt",
+				    &timing->lpddr4_ca_odt);
+	ret |= of_property_read_u32(np, "phy_lpddr4_ca_drv",
+				    &timing->phy_lpddr4_ca_drv);
+	ret |= of_property_read_u32(np, "phy_lpddr4_ck_cs_drv",
+				    &timing->phy_lpddr4_ck_cs_drv);
+	ret |= of_property_read_u32(np, "phy_lpddr4_dq_drv",
+				    &timing->phy_lpddr4_dq_drv);
+	ret |= of_property_read_u32(np, "phy_lpddr4_odt",
+				    &timing->phy_lpddr4_odt);
+
+	return ret;
+}
+
+static struct dram_timing *of_get_ddr_timings(struct device *dev,
+					      struct device_node *np)
+{
+	struct dram_timing	*timing = NULL;
+	struct device_node	*np_tim;
+
+	np_tim = of_parse_phandle(np, "ddr_timing", 0);
+	if (np_tim) {
+		timing = devm_kzalloc(dev, sizeof(*timing), GFP_KERNEL);
+		if (!timing)
+			goto err;
+		if (of_do_get_timing(np_tim, timing)) {
+			devm_kfree(dev, timing);
+			goto err;
+		}
+		return timing;
+	}
+
+err:
+	if (timing) {
+		devm_kfree(dev, timing);
+		timing = NULL;
+	}
+
+	return timing;
+}
+
+static int rk3399_dmcfreq_probe(struct platform_device *pdev)
+{
+	struct arm_smccc_res res;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	uint64_t param = 0;
+	struct rk3399_dmcfreq *data;
+	int ret, irq, index;
+	uint32_t *timing;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no dmc irq resource\n");
+		return -EINVAL;
+	}
+	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+
+	data->vdd_center = devm_regulator_get(dev, "center");
+	if (IS_ERR(data->vdd_center)) {
+		dev_err(dev, "Cannot get the regulator \"center\"\n");
+		return PTR_ERR(data->vdd_center);
+	}
+
+	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
+	if (IS_ERR(data->dmc_clk)) {
+		dev_err(dev, "Cannot get the clk dmc_clk\n");
+		return PTR_ERR(data->dmc_clk);
+	};
+
+	data->irq = irq;
+	ret = devm_request_irq(dev, irq, rk3399_dmc_irq, 0,
+			       dev_name(dev), data);
+	if (ret) {
+		dev_err(dev, "failed to request dmc irq: %d\n", ret);
+		return ret;
+	}
+
+	/* get dram timing and pass it to bl31 */
+	data->timing = of_get_ddr_timings(dev, np);
+	if (data->timing) {
+		timing = (uint32_t *)data->timing;
+		for (index = 0; index < (sizeof(struct dram_timing) / 4);
+		     index++) {
+			param = index;
+			param = param << 32 | *timing++;
+			arm_smccc_smc(SIP_DDR_FREQ, param, 0,
+				      CONFIG_DRAM_SET_PARAM, 0, 0, 0, 0, &res);
+			if (res.a0) {
+				dev_err(dev, "failed to set dram param: %ld\n",
+					res.a0);
+				return -EINVAL;
+			}
+			param = 0;
+		}
+	}
+
+	arm_smccc_smc(SIP_DDR_FREQ, 0, 0, CONFIG_DRAM_INIT,
+		      0, 0, 0, 0, &res);
+
+	init_waitqueue_head(&data->wait_dcf_queue);
+	data->wait_dcf_flag = 0;
+
+	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
+	if (IS_ERR(data->edev))
+		return -EPROBE_DEFER;
+
+	ret = devfreq_event_enable_edev(data->edev);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable devfreq-event devices\n");
+		return ret;
+	}
+
+	/*
+	 * We add a devfreq driver to our parent since it has a device tree node
+	 * with operating points.
+	 */
+	if (dev_pm_opp_of_add_table(dev)) {
+		dev_err(dev, "Invalid operating-points in device tree.\n");
+		return -EINVAL;
+	}
+	of_property_read_u32(np, "upthreshold",
+			     &data->ondemand_data.upthreshold);
+	of_property_read_u32(np, "downdifferential",
+			     &data->ondemand_data.downdifferential);
+	data->rate = clk_get_rate(data->dmc_clk);
+	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
+	data->devfreq = devfreq_add_device(dev,
+					   &rk3399_devfreq_dmc_profile,
+					   "simple_ondemand",
+					   &data->ondemand_data);
+	if (IS_ERR(data->devfreq))
+		return PTR_ERR(data->devfreq);
+	devfreq_register_opp_notifier(dev, data->devfreq);
+
+	data->dev = dev;
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int rk3399_dmcfreq_remove(struct platform_device *pdev)
+{
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+
+	devfreq_remove_device(dmcfreq->devfreq);
+	regulator_put(dmcfreq->vdd_center);
+
+	return 0;
+}
+
+static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
+	{ .compatible = "rockchip,rk3399-dmc" },
+	{ },
+};
+
+static struct platform_driver rk3399_dmcfreq_driver = {
+	.probe	= rk3399_dmcfreq_probe,
+	.remove	= rk3399_dmcfreq_remove,
+	.driver = {
+		.name	= "rk3399-dmc-freq",
+		.pm	= &rk3399_dmcfreq_pm,
+		.of_match_table = rk3399dmc_devfreq_of_match,
+	},
+};
+module_platform_driver(rk3399_dmcfreq_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("RK3399 dmcfreq driver with devfreq framework");
-- 
1.9.1

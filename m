From: hl@rock-chips.com (Lin Huang)
Date: Wed,  1 Jun 2016 17:35:38 +0800
Subject: [RFC PATCH 3/4] PM / devfreq: rockchip: add devfreq driver for rk3399
 dmc
In-Reply-To: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
Message-ID: <1464773739-18152-4-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there is dfi controller on rk3399 platform, it can monitor
ddr load, register this controller to devfreq framework, and
default to use simple_ondeamnd policy, and do ddr frequency
scaling base on this result.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/devfreq/Kconfig                 |   2 +-
 drivers/devfreq/Makefile                |   1 +
 drivers/devfreq/rockchip/Kconfig        |  14 +
 drivers/devfreq/rockchip/Makefile       |   2 +
 drivers/devfreq/rockchip/rk3399_dmc.c   | 438 ++++++++++++++++++++++++++++++++
 drivers/devfreq/rockchip/rockchip_dmc.c | 132 ++++++++++
 include/soc/rockchip/rockchip_dmc.h     |  44 ++++
 7 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 drivers/devfreq/rockchip/Kconfig
 create mode 100644 drivers/devfreq/rockchip/Makefile
 create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
 create mode 100644 drivers/devfreq/rockchip/rockchip_dmc.c
 create mode 100644 include/soc/rockchip/rockchip_dmc.h

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 78dac0e..a883744 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -101,5 +101,5 @@ config ARM_TEGRA_DEVFREQ
          operating frequencies and voltages with OPP support.
 
 source "drivers/devfreq/event/Kconfig"
-
+source "drivers/devfreq/rockchip/Kconfig"
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 09f11d9..48e2ae6 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/rockchip/Kconfig b/drivers/devfreq/rockchip/Kconfig
new file mode 100644
index 0000000..617b5fe
--- /dev/null
+++ b/drivers/devfreq/rockchip/Kconfig
@@ -0,0 +1,14 @@
+config ARM_ROCKCHIP_DMC_DEVFREQ
+	tristate "ARM ROCKCHIP DMC DEVFREQ Driver"
+	depends on ARCH_ROCKCHIP
+	help
+	  This adds the DEVFREQ driver framework for the rockchip dmc.
+
+config ARM_RK3399_DMC_DEVFREQ
+	tristate "ARM RK3399 DMC DEVFREQ Driver"
+	depends on ARM_ROCKCHIP_DMC_DEVFREQ
+	select PM_OPP
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	help
+	  This adds the DEVFREQ driver for the RK3399 dmc. It sets the frequency
+	  for the memory controller and reads the usage counts from hardware.
diff --git a/drivers/devfreq/rockchip/Makefile b/drivers/devfreq/rockchip/Makefile
new file mode 100644
index 0000000..caca525
--- /dev/null
+++ b/drivers/devfreq/rockchip/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_ARM_ROCKCHIP_DMC_DEVFREQ)	+= rockchip_dmc.o
+obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
diff --git a/drivers/devfreq/rockchip/rk3399_dmc.c b/drivers/devfreq/rockchip/rk3399_dmc.c
new file mode 100644
index 0000000..4907d38
--- /dev/null
+++ b/drivers/devfreq/rockchip/rk3399_dmc.c
@@ -0,0 +1,438 @@
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
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/devfreq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/rwsem.h>
+#include <linux/suspend.h>
+#include <linux/syscore_ops.h>
+
+#include <soc/rockchip/rockchip_dmc.h>
+
+#define RK3399_DMC_NUM_CH	2
+
+/* DDRMON_CTRL */
+#define DDRMON_CTRL	0x04
+#define CLR_DDRMON_CTRL	(0x1f0000 << 0)
+#define LPDDR4_EN	(0x10001 << 4)
+#define HARDWARE_EN	(0x10001 << 3)
+#define LPDDR3_EN	(0x10001 << 2)
+#define SOFTWARE_EN	(0x10001 << 1)
+#define TIME_CNT_EN	(0x10001 << 0)
+
+#define DDRMON_CH0_COUNT_NUM		0x28
+#define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
+#define DDRMON_CH1_COUNT_NUM		0x3c
+#define DDRMON_CH1_DFI_ACCESS_NUM	0x40
+
+/* pmu grf */
+#define PMUGRF_OS_REG2	0x308
+#define DDRTYPE_SHIFT	13
+#define DDRTYPE_MASK	7
+
+enum {
+	DDR3 = 3,
+	LPDDR3 = 6,
+	LPDDR4 = 7,
+	UNUSED = 0xFF
+};
+
+struct dmc_usage {
+	u32 access;
+	u32 total;
+};
+
+struct rk3399_dmcfreq {
+	struct device *dev;
+	struct devfreq *devfreq;
+	struct devfreq_simple_ondemand_data ondemand_data;
+	struct clk *dmc_clk;
+	struct completion dcf_hold_completion;
+	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
+	struct mutex lock;
+	struct notifier_block dmc_nb;
+	int irq;
+	void __iomem *regs;
+	struct regmap *regmap_pmu;
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
+	target_rate = dev_pm_opp_get_freq(opp);
+	target_volt = dev_pm_opp_get_voltage(opp);
+
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
+
+	dmc_event(DMCFREQ_ADJUST);
+	err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
+	if (err) {
+		dev_err(dev,
+			"Unable to set freq %lu. Current freq %lu. Error %d\n",
+			target_rate, old_clk_rate, err);
+		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
+				      dmcfreq->volt);
+		dmc_event(DMCFREQ_FINISH);
+		goto out;
+	}
+
+	/* wait until bcf irq happen, it means ddr scaling finish in bl31 */
+	reinit_completion(&dmcfreq->dcf_hold_completion);
+	wait_for_completion(&dmcfreq->dcf_hold_completion);
+	dmc_event(DMCFREQ_FINISH);
+
+	if (old_clk_rate > target_rate)
+		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
+					    target_volt);
+	if (err)
+		dev_err(dev, "Unable to set vol %lu\n", target_volt);
+
+	/* check the rate we get whether correct */
+	dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
+	if (dmcfreq->rate != target_rate) {
+		dev_err(dev, "get wrong ddr frequency, Request freq %lu,\
+			Current freq %lu\n", target_rate, dmcfreq->rate);
+		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
+				      dmcfreq->volt);
+	}
+out:
+	mutex_unlock(&dmcfreq->lock);
+	return err;
+}
+
+static void rk3399_dmc_start_hardware_counter(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+	void __iomem *dfi_regs = dmcfreq->regs;
+	u32 val;
+	u32 ddr_type;
+
+	/* get ddr type */
+	regmap_read(dmcfreq->regmap_pmu, PMUGRF_OS_REG2, &val);
+	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
+
+	/* clear DDRMON_CTRL setting */
+	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
+
+	/* set ddr type to dfi */
+	if (ddr_type == LPDDR3)
+		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
+	else if (ddr_type == LPDDR4)
+		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
+
+	/* enable count, use software mode */
+	writel_relaxed(SOFTWARE_EN, dfi_regs + DDRMON_CTRL);
+}
+
+static void rk3399_dmc_stop_hardware_counter(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+	void __iomem *dfi_regs = dmcfreq->regs;
+	u32 val;
+
+	val = readl_relaxed(dfi_regs + DDRMON_CTRL);
+	val &= ~SOFTWARE_EN;
+	writel_relaxed(val, dfi_regs + DDRMON_CTRL);
+}
+
+static int rk3399_dmc_get_busier_ch(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+	u32 tmp, max = 0;
+	u32 i, busier_ch = 0;
+	void __iomem *dfi_regs = dmcfreq->regs;
+
+	rk3399_dmc_stop_hardware_counter(dev);
+
+	/* Find out which channel is busier */
+	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
+		dmcfreq->ch_usage[i].access = readl_relaxed(dfi_regs +
+				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
+		dmcfreq->ch_usage[i].total = readl_relaxed(dfi_regs +
+				DDRMON_CH0_COUNT_NUM + i * 20);
+		tmp = dmcfreq->ch_usage[i].access;
+		if (tmp > max) {
+			busier_ch = i;
+			max = tmp;
+		}
+	}
+	rk3399_dmc_start_hardware_counter(dev);
+
+	return busier_ch;
+}
+
+static int rk3399_dmcfreq_get_dev_status(struct device *dev,
+					 struct devfreq_dev_status *stat)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
+	int busier_ch;
+
+	busier_ch = rk3399_dmc_get_busier_ch(dev);
+	stat->current_frequency = dmcfreq->rate;
+	stat->busy_time = dmcfreq->ch_usage[busier_ch].access;
+	stat->total_time = dmcfreq->ch_usage[busier_ch].total;
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
+	struct platform_device *pdev = container_of(dev, struct platform_device,
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
+	rockchip_dmc_disable();
+	return 0;
+}
+
+static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
+{
+	rockchip_dmc_enable();
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
+			 rk3399_dmcfreq_resume);
+
+static int rk3399_dmc_enable_notify(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct rk3399_dmcfreq *dmcfreq =
+			      container_of(nb, struct rk3399_dmcfreq, dmc_nb);
+	unsigned long freq = ULONG_MAX;
+
+	if (event == DMC_ENABLE) {
+		devfreq_resume_device(dmcfreq->devfreq);
+		rk3399_dmc_start_hardware_counter(dmcfreq->dev);
+		return NOTIFY_OK;
+	} else if (event == DMC_DISABLE) {
+		devfreq_suspend_device(dmcfreq->devfreq);
+		rk3399_dmc_stop_hardware_counter(dmcfreq->dev);
+
+		/* when disable dmc, set sdram to max frequency */
+		rk3399_dmcfreq_target(dmcfreq->dev, &freq, 0);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static irqreturn_t rk3399_dmc_irq(int irq, void *dev_id)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_id;
+
+	complete(&dmcfreq->dcf_hold_completion);
+
+	return IRQ_HANDLED;
+}
+
+static int rk3399_dmcfreq_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rk3399_dmcfreq *data;
+	struct resource *res;
+	int ret, irq;
+	struct device_node *np = pdev->dev.of_node, *node;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no dmc irq resource\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->regs))
+		return PTR_ERR(data->regs);
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
+	/*
+	 * We add a devfreq driver to our parent since it has a device tree node
+	 * with operating points.
+	 */
+	if (dev_pm_opp_of_add_table(dev)) {
+		dev_err(dev, "Invalid operating-points in device tree.\n");
+		return -EINVAL;
+	}
+
+	of_property_read_u32(np, "upthreshold",
+			     &data->ondemand_data.upthreshold);
+
+	of_property_read_u32(np, "downdifferential",
+			     &data->ondemand_data.downdifferential);
+
+	data->devfreq = devfreq_add_device(dev,
+					   &rk3399_devfreq_dmc_profile,
+					   "simple_ondemand",
+					   &data->ondemand_data);
+	if (IS_ERR(data->devfreq))
+		return PTR_ERR(data->devfreq);
+
+	devfreq_register_opp_notifier(dev, data->devfreq);
+
+	data->dmc_nb.notifier_call = rk3399_dmc_enable_notify;
+	dmc_register_notifier(&data->dmc_nb);
+
+	data->irq = irq;
+	ret = devm_request_irq(dev, irq, rk3399_dmc_irq, IRQF_ONESHOT,
+			       dev_name(dev), data);
+	if (ret) {
+		dev_err(dev, "failed to request dmc irq: %d\n", ret);
+		return ret;
+	}
+
+	init_completion(&data->dcf_hold_completion);
+
+	/* try to find the optional reference to the pmu syscon */
+	node = of_parse_phandle(np, "rockchip,pmu", 0);
+	if (node) {
+		data->regmap_pmu = syscon_node_to_regmap(node);
+		if (IS_ERR(data->regmap_pmu))
+			return PTR_ERR(data->regmap_pmu);
+	}
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
diff --git a/drivers/devfreq/rockchip/rockchip_dmc.c b/drivers/devfreq/rockchip/rockchip_dmc.c
new file mode 100644
index 0000000..ecc6598
--- /dev/null
+++ b/drivers/devfreq/rockchip/rockchip_dmc.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ * Author: Lin Huang <hl@rock-chips.com>
+ * Base on: https://chromium-review.googlesource.com/#/c/231477/
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
+#include <linux/mutex.h>
+#include <soc/rockchip/rockchip_dmc.h>
+
+static int num_wait;
+static int num_disable;
+static BLOCKING_NOTIFIER_HEAD(dmc_notifier_list);
+static DEFINE_MUTEX(dmc_en_lock);
+static DEFINE_MUTEX(dmc_sync_lock);
+
+void dmc_event(int event)
+{
+	mutex_lock(&dmc_sync_lock);
+	blocking_notifier_call_chain(&dmc_notifier_list, event, NULL);
+	mutex_unlock(&dmc_sync_lock);
+}
+EXPORT_SYMBOL_GPL(dmc_event);
+
+/**
+ * rockchip_dmc_enabled - Returns true if dmc freq is enabled, false otherwise.
+ */
+bool rockchip_dmc_enabled(void)
+{
+	return num_disable <= 0 && num_wait <= 1;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmc_enabled);
+
+/**
+ * rockchip_dmc_enable - Enable dmc frequency scaling. Will only enable
+ * frequency scaling if there are 1 or fewer notifiers. Call to undo
+ * rockchip_dmc_disable.
+ */
+void rockchip_dmc_enable(void)
+{
+	mutex_lock(&dmc_en_lock);
+	num_disable--;
+	WARN_ON(num_disable < 0);
+	if (rockchip_dmc_enabled())
+		dmc_event(DMC_ENABLE);
+	mutex_unlock(&dmc_en_lock);
+}
+EXPORT_SYMBOL_GPL(rockchip_dmc_enable);
+
+/**
+ * rockchip_dmc_disable - Disable dmc frequency scaling. Call when something
+ * cannot coincide with dmc frequency scaling.
+ */
+void rockchip_dmc_disable(void)
+{
+	mutex_lock(&dmc_en_lock);
+	if (rockchip_dmc_enabled())
+		dmc_event(DMC_DISABLE);
+	num_disable++;
+	mutex_unlock(&dmc_en_lock);
+}
+EXPORT_SYMBOL_GPL(rockchip_dmc_disable);
+
+int dmc_register_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	if (!nb)
+		return -EINVAL;
+
+	ret = blocking_notifier_chain_register(&dmc_notifier_list, nb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dmc_register_notifier);
+
+int dmc_unregister_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	if (!nb)
+		return -EINVAL;
+
+	ret = blocking_notifier_chain_unregister(&dmc_notifier_list, nb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dmc_unregister_notifier);
+
+int rockchip_dmc_get(struct notifier_block *nb)
+{
+	if (!nb)
+		return -EINVAL;
+
+	mutex_lock(&dmc_en_lock);
+
+	/* if use two vop, need to disable dmc */
+	if (num_wait == 1 && num_disable <= 0)
+		dmc_event(DMC_DISABLE);
+	num_wait++;
+	dmc_register_notifier(nb);
+	mutex_unlock(&dmc_en_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmc_get);
+
+int rockchip_dmc_put(struct notifier_block *nb)
+{
+	if (!nb)
+		return -EINVAL;
+
+	mutex_lock(&dmc_en_lock);
+	num_wait--;
+
+	/* from 2 vop back to 1 vop, need enable dmc */
+	if (num_wait == 1 && num_disable <= 0)
+		dmc_event(DMC_ENABLE);
+	dmc_unregister_notifier(nb);
+	mutex_unlock(&dmc_en_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmc_put);
diff --git a/include/soc/rockchip/rockchip_dmc.h b/include/soc/rockchip/rockchip_dmc.h
new file mode 100644
index 0000000..6bb58d6
--- /dev/null
+++ b/include/soc/rockchip/rockchip_dmc.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
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
+#ifndef __SOC_ROCKCHIP_DMC_H
+#define __SOC_ROCKCHIP_DMC_H
+
+#include <linux/notifier.h>
+
+#define DMC_ENABLE	0
+#define DMC_DISABLE	1
+#define DMCFREQ_ADJUST	2
+#define DMCFREQ_FINISH	3
+
+#ifdef CONFIG_ARM_ROCKCHIP_DMC_DEVFREQ
+int rockchip_dmc_get(struct notifier_block *nb);
+int rockchip_dmc_put(struct notifier_block *nb);
+#else
+static inline int rockchip_dmc_get(struct notifier_block *nb)
+{
+	return 0;
+}
+static inline int rockchip_dmc_put(struct notifier_block *nb)
+{
+	return 0;
+}
+#endif
+
+void dmc_event(int event);
+int dmc_register_notifier(struct notifier_block *nb);
+int dmc_unregister_notifier(struct notifier_block *nb);
+void rockchip_dmc_enable(void);
+void rockchip_dmc_disable(void);
+bool rockchip_dmc_enabled(void);
+#endif
-- 
1.9.1

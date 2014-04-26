From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun, 27 Apr 2014 02:08:48 +0530
Subject: [PATCH RFC 8/8] PM / devfreq: Add devfreq driver for Exynos5420
In-Reply-To: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
References: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1398544728-2075-9-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Arjun.K.V" <arjun.kv@samsung.com>

Exynos5420 bus device devfreq driver monitors PPMU counters and
adjusts INT domain operating frequencies and voltages.

Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/devfreq/Kconfig                 |  11 +
 drivers/devfreq/Makefile                |   1 +
 drivers/devfreq/exynos/Makefile         |   1 +
 drivers/devfreq/exynos/exynos5420_bus.c | 706 ++++++++++++++++++++++++++++++++
 4 files changed, 719 insertions(+)
 create mode 100644 drivers/devfreq/exynos/exynos5420_bus.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 40da99f..e14b693 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -90,4 +90,15 @@ config ARM_EXYNOS5250_BUS_DEVFREQ
 	  It reads PPMU counters of memory controllers and adjusts the
 	  operating frequencies and voltages with OPP support.
 
+config ARM_EXYNOS5420_BUS_DEVFREQ
+	bool "ARM Exynos5420 Bus DEVFREQ Driver"
+	depends on SOC_EXYNOS5420
+	select ARCH_HAS_OPP
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select PM_OPP
+	help
+	  This adds the DEVFREQ driver for Exynos5420 bus interface (vdd_int).
+	  It reads PPMU counters of memory controllers and adjusts the
+	  operating frequencies and voltages with OPP support.
+
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index e33ade0..9113762 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)	+= exynos/
 obj-$(CONFIG_ARM_EXYNOS5250_BUS_DEVFREQ)+= exynos/
+obj-$(CONFIG_ARM_EXYNOS5420_BUS_DEVFREQ)+= exynos/
diff --git a/drivers/devfreq/exynos/Makefile b/drivers/devfreq/exynos/Makefile
index f4ab613..c1b192f 100644
--- a/drivers/devfreq/exynos/Makefile
+++ b/drivers/devfreq/exynos/Makefile
@@ -2,3 +2,4 @@
 obj-y		:= exynos_ppmu.o
 obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)		+= exynos4_bus.o
 obj-$(CONFIG_ARM_EXYNOS5250_BUS_DEVFREQ)	+= exynos5250_bus.o
+obj-$(CONFIG_ARM_EXYNOS5420_BUS_DEVFREQ)	+= exynos5420_bus.o
diff --git a/drivers/devfreq/exynos/exynos5420_bus.c b/drivers/devfreq/exynos/exynos5420_bus.c
new file mode 100644
index 0000000..b31aa4d
--- /dev/null
+++ b/drivers/devfreq/exynos/exynos5420_bus.c
@@ -0,0 +1,706 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS542X INT clock frequency scaling support using DEVFREQ framework
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/devfreq.h>
+#include <linux/io.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include "exynos_ppmu.h"
+
+#define INT_BUS_SATURATION_RATIO	15
+#define INT_VOLT_STEP_UV		12500
+
+enum exynos5420_ppmu_list {
+	PPMU_DMC_0_1,
+	PPMU_DMC_1_0,
+	PPMU_DMC_1_1,
+	PPMU_END,
+};
+
+enum int_bus_pll {
+	S_PLL = 0,
+	C_PLL,
+	D_PLL,
+	M_PLL,
+	I_PLL,
+};
+
+struct int_clk_info {
+	unsigned int idx;
+	unsigned long target_freq;
+	enum int_bus_pll src_pll;
+};
+
+struct int_pm_clks {
+	struct list_head node;
+	const char *mux_clk_name;   /* The parent of the div clock */
+	struct clk *mux_clk;
+	const char *div_clk_name;
+	struct clk *div_clk;
+	struct int_clk_info *clk_info;
+};
+
+enum int_level_idx {
+	LV_0,
+	LV_1,
+	LV_2,
+	LV_3,
+	LV_4,
+	_LV_END
+};
+
+struct busfreq_data_int {
+	struct list_head list;
+	struct device *dev;
+	struct devfreq *devfreq;
+	struct regulator *vdd_int;
+	struct busfreq_ppmu_data ppmu_data;
+	unsigned long curr_freq;
+	bool disabled;
+
+	struct mutex lock;
+
+	struct clk *mout_mpll;
+	struct clk *mout_dpll;
+	struct clk *mout_cpll;
+	struct clk *mout_spll;
+	struct clk *mout_ipll;
+};
+
+struct int_bus_opp_table {
+	unsigned int idx;
+	unsigned long clk;
+	unsigned long volt;
+};
+
+static struct int_bus_opp_table int_opp_table[] = {
+	{LV_0, 400000, 1100000},
+	{LV_1, 333000, 1100000},
+	{LV_2, 222000, 1100000},
+	{LV_3, 111000, 1100000},
+	{LV_4,  83000, 1100000},
+	{0, 0, 0},
+};
+
+struct int_clk_info aclk_200_fsys[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 200000, D_PLL},
+	{LV_2, 150000, D_PLL},
+	{LV_3, 100000, D_PLL},
+	{LV_4, 100000, D_PLL},
+};
+
+struct int_clk_info pclk_200_fsys[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 150000, D_PLL},
+	{LV_2, 150000, D_PLL},
+	{LV_3, 100000, D_PLL},
+	{LV_4, 100000, D_PLL},
+};
+
+struct int_clk_info aclk_100_noc[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 100000, D_PLL},
+	{LV_1,  86000, D_PLL},
+	{LV_2,  75000, D_PLL},
+	{LV_3,  75000, D_PLL},
+	{LV_4,  75000, D_PLL},
+};
+
+struct int_clk_info aclk_400_wcore[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 400000, S_PLL},
+	{LV_1, 333000, C_PLL},
+	{LV_2, 333000, C_PLL},
+	{LV_3, 333000, C_PLL},
+	{LV_4, 333000, C_PLL},
+};
+
+struct int_clk_info aclk_200_fsys2[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 200000, D_PLL},
+	{LV_2, 150000, D_PLL},
+	{LV_3, 100000, D_PLL},
+	{LV_4, 100000, D_PLL},
+};
+
+struct int_clk_info aclk_400_mscl[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 400000, S_PLL},
+	{LV_1, 333000, C_PLL},
+	{LV_2, 222000, C_PLL},
+	{LV_3, 167000, C_PLL},
+	{LV_4,  84000, C_PLL},
+};
+
+struct int_clk_info aclk_166[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 167000, C_PLL},
+	{LV_1, 134000, C_PLL},
+	{LV_2, 111000, C_PLL},
+	{LV_3,  84000, C_PLL},
+	{LV_4,  84000, C_PLL},
+};
+
+struct int_clk_info aclk_266[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 267000, M_PLL},
+	{LV_1, 160000, M_PLL},
+	{LV_2, 134000, M_PLL},
+	{LV_3, 134000, M_PLL},
+	{LV_4,  86000, D_PLL},
+};
+
+struct int_clk_info aclk_66[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0,  67000, C_PLL},
+	{LV_1,  67000, C_PLL},
+	{LV_2,  67000, C_PLL},
+	{LV_3,  67000, C_PLL},
+	{LV_4,  67000, C_PLL},
+};
+
+struct int_clk_info aclk_300_disp1[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 200000, D_PLL},
+	{LV_2, 200000, D_PLL},
+	{LV_3, 200000, D_PLL},
+	{LV_4, 120000, D_PLL},
+};
+
+struct int_clk_info aclk_400_disp1[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 300000, D_PLL},
+	{LV_1, 300000, D_PLL},
+	{LV_2, 200000, D_PLL},
+	{LV_3, 200000, D_PLL},
+	{LV_4, 120000, D_PLL},
+};
+
+struct int_clk_info aclk_300_jpeg[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 300000, D_PLL},
+	{LV_1, 300000, D_PLL},
+	{LV_2, 200000, D_PLL},
+	{LV_3, 150000, D_PLL},
+	{LV_4,  75000, D_PLL},
+};
+
+#define EXYNOS5_INT_PM_CLK(NAME, CLK, PCLK, CLK_INFO)	\
+static struct int_pm_clks int_pm_clks_##NAME = {	\
+	.mux_clk_name = CLK,				\
+	.div_clk_name = PCLK,				\
+	.clk_info = CLK_INFO,				\
+}
+
+EXYNOS5_INT_PM_CLK(aclk_200_fsys, "aclk200_fsys",
+			"aclk200_fsys_d", aclk_200_fsys);
+EXYNOS5_INT_PM_CLK(pclk_200_fsys, "pclk200_fsys",
+			"pclk200_fsys_d", pclk_200_fsys);
+EXYNOS5_INT_PM_CLK(aclk_100_noc, "aclk100_noc",
+			"aclk100_noc_d", aclk_100_noc);
+EXYNOS5_INT_PM_CLK(aclk_400_wcore, "aclk400_wcore",
+			"aclk400_wcore_d", aclk_400_wcore);
+EXYNOS5_INT_PM_CLK(aclk_200_fsys2, "aclk200_fsys2",
+			"aclk200_fsys2_d", aclk_200_fsys2);
+EXYNOS5_INT_PM_CLK(aclk_400_mscl, "aclk400_mscl",
+			"aclk400_mscl_d", aclk_400_mscl);
+EXYNOS5_INT_PM_CLK(aclk_166, "aclk166",
+			"aclk166_d", aclk_166);
+EXYNOS5_INT_PM_CLK(aclk_266, "aclk266",
+			"aclk266_d", aclk_266);
+EXYNOS5_INT_PM_CLK(aclk_66, "aclk66",
+			"aclk66_d", aclk_66);
+EXYNOS5_INT_PM_CLK(aclk_300_disp1, "aclk300_disp1",
+			"aclk300_disp1_d", aclk_300_disp1);
+EXYNOS5_INT_PM_CLK(aclk_300_jpeg, "aclk300_jpeg",
+			"aclk300_jpeg_d", aclk_300_jpeg);
+EXYNOS5_INT_PM_CLK(aclk_400_disp1, "aclk400_disp1",
+			"aclk400_disp1_d", aclk_400_disp1);
+
+static struct int_pm_clks *exynos5420_int_pm_clks[] = {
+	&int_pm_clks_aclk_200_fsys,
+	&int_pm_clks_pclk_200_fsys,
+	&int_pm_clks_aclk_100_noc,
+	&int_pm_clks_aclk_400_wcore,
+	&int_pm_clks_aclk_200_fsys2,
+	&int_pm_clks_aclk_400_mscl,
+	&int_pm_clks_aclk_166,
+	&int_pm_clks_aclk_266,
+	&int_pm_clks_aclk_66,
+	&int_pm_clks_aclk_300_disp1,
+	&int_pm_clks_aclk_300_jpeg,
+	&int_pm_clks_aclk_400_disp1,
+	NULL,
+};
+
+static struct clk *exynos5420_find_pll(struct busfreq_data_int *data,
+				    enum int_level_idx target_pll)
+{
+	struct clk *target_src_clk = NULL;
+
+	switch (target_pll) {
+	case S_PLL:
+		target_src_clk = data->mout_spll;
+		break;
+	case C_PLL:
+		target_src_clk = data->mout_cpll;
+		break;
+	case M_PLL:
+		target_src_clk = data->mout_mpll;
+		break;
+	case D_PLL:
+		target_src_clk = data->mout_dpll;
+		break;
+	case I_PLL:
+		target_src_clk = data->mout_ipll;
+		break;
+	default:
+		break;
+	}
+
+	return target_src_clk;
+}
+
+static void exynos5420_int_set_freq(struct busfreq_data_int *data,
+		unsigned long target_freq, unsigned long pre_freq)
+{
+	unsigned int i;
+	unsigned long tar_rate;
+	int target_idx = -EINVAL;
+	int pre_idx = -EINVAL;
+	struct int_pm_clks *int_clk;
+	struct clk *new_src_pll;
+	struct clk *old_src_pll;
+	unsigned long old_src_rate, new_src_rate;
+	unsigned long rate1, rate2, rate3, rate4;
+
+	/* Find the levels for target and previous frequencies */
+	for (i = 0; i < _LV_END; i++) {
+		if (int_opp_table[i].clk == target_freq)
+			target_idx = int_opp_table[i].idx;
+		if (int_opp_table[i].clk == pre_freq)
+			pre_idx = int_opp_table[i].idx;
+	}
+
+	list_for_each_entry(int_clk, &data->list, node) {
+		tar_rate = int_clk->clk_info[target_idx].target_freq * 1000;
+
+		old_src_pll = clk_get_parent(int_clk->mux_clk);
+		new_src_pll = exynos5420_find_pll(data,
+				int_clk->clk_info[target_idx].src_pll);
+
+		if (old_src_pll == new_src_pll) {
+			/* No need to change pll */
+			clk_set_rate(int_clk->div_clk, tar_rate);
+			pr_debug("%s: %s now %lu (%lu)\n", __func__,
+				 int_clk->mux_clk_name,
+				 clk_get_rate(int_clk->div_clk), tar_rate);
+			continue;
+		}
+
+		old_src_rate = clk_get_rate(old_src_pll);
+		new_src_rate = clk_get_rate(new_src_pll);
+		rate1 = clk_get_rate(int_clk->div_clk);
+
+		/*
+		 * If we're switching to a faster PLL we should bump up the
+		 * divider before switching.
+		 */
+		if (new_src_rate > old_src_rate) {
+			int new_div;
+			unsigned long tmp_rate;
+
+			new_div = DIV_ROUND_UP(new_src_rate, tar_rate);
+			tmp_rate = DIV_ROUND_UP(old_src_rate, new_div);
+			clk_set_rate(int_clk->div_clk, tmp_rate);
+		}
+		rate2 = clk_get_rate(int_clk->div_clk);
+
+		/* We can safely change the mux now */
+		clk_set_parent(int_clk->mux_clk, new_src_pll);
+		rate3 = clk_get_rate(int_clk->div_clk);
+
+		/*
+		 * Give us a proper divider; technically not needed in the case
+		 * where we pre-calculated the divider above (the new_src_rate >
+		 * old_src_rate case), but let's be formal about it.
+		 */
+		clk_set_rate(int_clk->div_clk, tar_rate);
+		rate4 = clk_get_rate(int_clk->div_clk);
+
+		pr_debug("%s: %s => PLL %d; %lu=>%lu=>%lu=>%lu (%lu)\n",
+			 __func__, int_clk->mux_clk_name,
+			 int_clk->clk_info[target_idx].src_pll,
+			 rate1, rate2, rate3, rate4, tar_rate);
+	}
+}
+
+static void exynos5420_int_update_state(unsigned int target_freq)
+{
+	unsigned int target_idx = LV_0;
+	unsigned int i;
+
+	/* Find level value with corresponding target frequency */
+	for (i = LV_0; i < _LV_END; i++) {
+		if (int_opp_table[i].clk == target_freq)
+			target_idx = int_opp_table[i].idx;
+	}
+}
+
+static int exynos5420_busfreq_int_target(struct device *dev,
+			unsigned long *_freq, u32 flags)
+{
+	int err = 0;
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data_int *data = platform_get_drvdata(pdev);
+	struct dev_pm_opp *opp;
+	unsigned long old_freq, freq;
+	unsigned long volt;
+
+	rcu_read_lock();
+	opp = devfreq_recommended_opp(dev, _freq, flags);
+	if (IS_ERR(opp)) {
+		rcu_read_unlock();
+		dev_err(dev, "%s: Invalid OPP.\n", __func__);
+		return PTR_ERR(opp);
+	}
+
+	freq = dev_pm_opp_get_freq(opp);
+	volt = dev_pm_opp_get_voltage(opp);
+	rcu_read_unlock();
+
+	old_freq = data->curr_freq;
+
+	exynos5420_int_update_state(old_freq);
+
+	if (old_freq == freq)
+		return 0;
+
+	dev_dbg(dev, "targeting %lukHz %luuV\n", freq, volt);
+
+	mutex_lock(&data->lock);
+
+	if (data->disabled)
+		goto out;
+	/*
+	 * If target frequency is higher than old frequency
+	 * change the voltage before setting freq ratio
+	 */
+	if (old_freq < freq) {
+		err = regulator_set_voltage(data->vdd_int,
+				volt, volt + INT_VOLT_STEP_UV);
+		if (err) {
+			pr_warn("Failed to increase INT voltage: %d\n", err);
+			goto out;
+		}
+
+		exynos5420_int_set_freq(data, freq, old_freq);
+	} else {
+		exynos5420_int_set_freq(data, freq, old_freq);
+
+		err = regulator_set_voltage(data->vdd_int,
+				volt, volt + INT_VOLT_STEP_UV);
+		if (err) {
+			pr_warn("Failed to decrease INT voltage: %d\n", err);
+			goto out;
+		}
+	}
+
+	data->curr_freq = freq;
+out:
+	mutex_unlock(&data->lock);
+
+	return err;
+}
+
+static int exynos5420_int_get_dev_status(struct device *dev,
+				      struct devfreq_dev_status *stat)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data_int *data = platform_get_drvdata(pdev);
+	struct busfreq_ppmu_data *ppmu_data = &data->ppmu_data;
+	int busier_dmc;
+
+	exynos_read_ppmu(ppmu_data);
+	busier_dmc = exynos_get_busier_ppmu(ppmu_data);
+
+	stat->current_frequency = data->curr_freq;
+
+	/* Number of cycles spent on memory access */
+	stat->busy_time = ppmu_data->ppmu[busier_dmc].count[PPMU_PMNCNT3];
+	stat->busy_time *= 100 / INT_BUS_SATURATION_RATIO;
+	stat->total_time = ppmu_data->ppmu[busier_dmc].ccnt;
+
+	return 0;
+}
+static void exynos5420_int_exit(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data_int *data = platform_get_drvdata(pdev);
+
+	devfreq_unregister_opp_notifier(dev, data->devfreq);
+}
+
+static struct devfreq_dev_profile exynos5_devfreq_int_profile = {
+	.initial_freq		= 333000,
+	.polling_ms		= 10,
+	.target			= exynos5420_busfreq_int_target,
+	.get_dev_status		= exynos5420_int_get_dev_status,
+	.exit			= exynos5420_int_exit,
+};
+
+static int exynos5420_init_int_tables(struct busfreq_data_int *data)
+{
+	int i, err = 0;
+
+	for (i = LV_0; i < _LV_END; i++) {
+		err = dev_pm_opp_add(data->dev, int_opp_table[i].clk,
+				int_opp_table[i].volt);
+		if (err) {
+			dev_err(data->dev, "Cannot add opp entries.\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int exynos5420_busfreq_int_probe(struct platform_device *pdev)
+{
+	struct busfreq_data_int *data;
+	struct busfreq_ppmu_data *ppmu_data;
+	struct dev_pm_opp *opp;
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	int err = 0;
+	int i;
+	int nr_clk;
+	struct clk *mux_clk, *div_clk;
+	struct int_pm_clks *int_clk;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct busfreq_data_int),
+				GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(dev, "Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	ppmu_data = &data->ppmu_data;
+	ppmu_data->ppmu_end = PPMU_END;
+	ppmu_data->ppmu = devm_kzalloc(dev,
+				       sizeof(struct exynos_ppmu) * PPMU_END,
+				       GFP_KERNEL);
+	if (!ppmu_data->ppmu) {
+		dev_err(dev, "Failed to allocate memory for exynos_ppmu\n");
+		return -ENOMEM;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "samsung,exynos5420-ppmu");
+	if (np == NULL) {
+		pr_err("Unable to find PPMU node\n");
+		return -ENOENT;
+	}
+
+	for (i = 0; i < ppmu_data->ppmu_end; i++) {
+		/* map PPMU memory region */
+		ppmu_data->ppmu[i].hw_base = of_iomap(np, i);
+		if (ppmu_data->ppmu[i].hw_base == NULL) {
+			dev_err(&pdev->dev, "failed to map memory region\n");
+			return -ENOMEM;
+		}
+	}
+	data->dev = dev;
+	INIT_LIST_HEAD(&data->list);
+	mutex_init(&data->lock);
+
+	err = exynos5420_init_int_tables(data);
+	if (err)
+		return err;
+
+	data->vdd_int = devm_regulator_get(dev, "vdd_int");
+	if (IS_ERR(data->vdd_int)) {
+		dev_err(dev, "Cannot get the regulator \"vdd_int\"\n");
+		return PTR_ERR(data->vdd_int);
+	}
+
+	data->mout_ipll = devm_clk_get(dev, "mout_ipll");
+	if (IS_ERR(data->mout_ipll)) {
+		dev_err(dev, "Cannot get clock \"mout_ipll\"\n");
+		return PTR_ERR(data->mout_ipll);
+	}
+
+	data->mout_mpll = devm_clk_get(dev, "mout_mpll");
+	if (IS_ERR(data->mout_mpll)) {
+		dev_err(dev, "Cannot get clock \"mout_mpll\"\n");
+		return PTR_ERR(data->mout_mpll);
+	}
+
+	data->mout_dpll = devm_clk_get(dev, "mout_dpll");
+	if (IS_ERR(data->mout_dpll)) {
+		dev_err(dev, "Cannot get clock \"mout_dpll\"\n");
+		return PTR_ERR(data->mout_dpll);
+	}
+
+	data->mout_spll = devm_clk_get(dev, "mout_spll");
+	if (IS_ERR(data->mout_spll)) {
+		dev_err(dev, "Cannot get clock \"mout_spll\"\n");
+		return PTR_ERR(data->mout_spll);
+	}
+
+	data->mout_cpll = devm_clk_get(dev, "mout_cpll");
+	if (IS_ERR(data->mout_cpll)) {
+		dev_err(dev, "Cannot get clock \"mout_cpll\"\n");
+		return PTR_ERR(data->mout_cpll);
+	}
+
+	for (nr_clk = 0; exynos5420_int_pm_clks[nr_clk] != NULL; nr_clk++) {
+		int_clk = exynos5420_int_pm_clks[nr_clk];
+		mux_clk = devm_clk_get(dev, int_clk->mux_clk_name);
+		if (IS_ERR(mux_clk)) {
+			dev_err(dev, "Cannot get mux clock: %s\n",
+						int_clk->mux_clk_name);
+			return PTR_ERR(mux_clk);
+		}
+		div_clk = devm_clk_get(dev, int_clk->div_clk_name);
+		if (IS_ERR(div_clk)) {
+			dev_err(dev, "Cannot get div clock: %s\n",
+						int_clk->div_clk_name);
+			return PTR_ERR(div_clk);
+		}
+		int_clk->mux_clk = mux_clk;
+		int_clk->div_clk = div_clk;
+		list_add_tail(&int_clk->node, &data->list);
+	}
+
+	rcu_read_lock();
+	opp = dev_pm_opp_find_freq_floor(dev,
+			&exynos5_devfreq_int_profile.initial_freq);
+	if (IS_ERR(opp)) {
+		rcu_read_unlock();
+		dev_err(dev, "Invalid initial frequency %lu kHz.\n",
+		       exynos5_devfreq_int_profile.initial_freq);
+		return PTR_ERR(opp);
+	}
+	rcu_read_unlock();
+	data->curr_freq = exynos5_devfreq_int_profile.initial_freq;
+
+	platform_set_drvdata(pdev, data);
+
+	busfreq_mon_reset(ppmu_data);
+
+	data->devfreq = devfreq_add_device(dev, &exynos5_devfreq_int_profile,
+					   "simple_ondemand", NULL);
+
+	if (IS_ERR(data->devfreq)) {
+		err = PTR_ERR(data->devfreq);
+		goto err_devfreq_add;
+	}
+
+	devfreq_register_opp_notifier(dev, data->devfreq);
+
+	return 0;
+
+err_devfreq_add:
+	devfreq_remove_device(data->devfreq);
+	return err;
+}
+
+static int exynos5420_busfreq_int_remove(struct platform_device *pdev)
+{
+	struct busfreq_data_int *data = platform_get_drvdata(pdev);
+
+	devfreq_remove_device(data->devfreq);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int exynos5420_busfreq_int_resume(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data_int *data = platform_get_drvdata(pdev);
+	struct busfreq_ppmu_data *ppmu_data = &data->ppmu_data;
+
+	busfreq_mon_reset(ppmu_data);
+
+	return 0;
+}
+static const struct dev_pm_ops exynos5420_busfreq_int_pm = {
+	.resume	= exynos5420_busfreq_int_resume,
+};
+#endif
+static SIMPLE_DEV_PM_OPS(exynos5420_busfreq_int_pm_ops, NULL,
+			 exynos5420_busfreq_int_resume);
+
+/* platform device pointer for exynos5420 devfreq device. */
+static struct platform_device *exynos5420_devfreq_pdev;
+
+static struct platform_driver exynos5420_busfreq_int_driver = {
+	.probe		= exynos5420_busfreq_int_probe,
+	.remove		= exynos5420_busfreq_int_remove,
+	.driver		= {
+		.name		= "exynos5420-bus-int",
+		.owner		= THIS_MODULE,
+		.pm		= &exynos5420_busfreq_int_pm_ops,
+	},
+};
+
+static int __init exynos5420_busfreq_int_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&exynos5420_busfreq_int_driver);
+	if (ret < 0)
+		goto out;
+
+	exynos5420_devfreq_pdev =
+	platform_device_register_simple("exynos5420-bus-int", -1, NULL, 0);
+	if (IS_ERR(exynos5420_devfreq_pdev)) {
+		ret = PTR_ERR(exynos5420_devfreq_pdev);
+		goto out1;
+	}
+
+	return 0;
+out1:
+	platform_driver_unregister(&exynos5420_busfreq_int_driver);
+out:
+	return ret;
+}
+late_initcall(exynos5420_busfreq_int_init);
+
+static void __exit exynos5420_busfreq_int_exit(void)
+{
+	platform_device_unregister(exynos5420_devfreq_pdev);
+	platform_driver_unregister(&exynos5420_busfreq_int_driver);
+}
+module_exit(exynos5420_busfreq_int_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("EXYNOS5420 busfreq driver with devfreq framework");
-- 
1.8.3.2

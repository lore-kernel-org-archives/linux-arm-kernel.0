From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 01 Dec 2011 18:05:15 +0900
Subject: [PATCH 2/4] PM/Devfreq: Add Exynos4210-bus device DVFS driver.
In-Reply-To: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
References: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1322730317-8171-3-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4210-memorybus device driver add DVFS capability for
Exynos4210-Bus (memory). The driver monitors PPMU counters of memory
controllers and adjusts operating frequencies and voltages with OPP.

Dependency (CONFIG_EXYNOS_ASV):
Exynos4210 ASV driver has been posted in the mailing list; however, it
si not yet upstreamed. Although the current revision of Exynos4210 ASV
patch does not contain "CONFIG_EXYNOS_ASV", we have added the symbol
to hide the dependent from compilers for now.

However, enabling ASV is essential in most Exynos4210 chips to reduce
the power consumption of Exynos4210 because without ASV, this Devfreq
driver assumes the worst case scenario, which consumes more power.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/devfreq/Kconfig                |   12 +
 drivers/devfreq/Makefile               |    3 +
 drivers/devfreq/exynos4210_memorybus.c |  636 ++++++++++++++++++++++++++++++++
 3 files changed, 651 insertions(+), 0 deletions(-)
 create mode 100644 drivers/devfreq/exynos4210_memorybus.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 8f04910..5b1b252 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -65,4 +65,16 @@ config DEVFREQ_GOV_USERSPACE
 
 comment "DEVFREQ Drivers"
 
+config ARM_EXYNOS4210_MEMORYBUS_DEVFREQ
+	bool "ARM Exynos4210 Memory Bus DEVFREQ Driver"
+	depends on CPU_EXYNOS4210
+	select ARCH_HAS_OPP
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	help
+	  This adds the DEVFREQ driver for Exynos4210 memory bus.
+	  This driver is supposed to support busses of other Exynos4 series
+	  SoCs as well; however, for now, this driver supports Exynos4210
+	  only. It reads PPMU counters of memory controllers and adjusts
+	  the operating frequencies and voltages with OPP support.
+
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 4564a89..f002de5 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -3,3 +3,6 @@ obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
 obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
+
+# DEVFREQ Drivers
+obj-$(CONFIG_ARM_EXYNOS4210_MEMORYBUS_DEVFREQ)	+= exynos4210_memorybus.o
diff --git a/drivers/devfreq/exynos4210_memorybus.c b/drivers/devfreq/exynos4210_memorybus.c
new file mode 100644
index 0000000..b950005
--- /dev/null
+++ b/drivers/devfreq/exynos4210_memorybus.c
@@ -0,0 +1,636 @@
+/* drivers/devfreq/exynos4210_memorybus.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *	MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * EXYNOS4 - Memory/Bus clock frequency scaling support in DEVFREQ framework
+ *	This version supports EXYNOS4210 only. This changes bus frequencies
+ *	and vddint voltages. Exynos4412/4212 should be able to be supported
+ *	with minor modifications.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/suspend.h>
+#include <linux/opp.h>
+#include <linux/devfreq.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/module.h>
+
+/* Exynos4 ASV has been in the mailing list, but not upstreamed, yet. */
+#ifdef CONFIG_EXYNOS_ASV
+extern unsigned int exynos_result_of_asv;
+#endif
+
+#include <mach/regs-clock.h>
+
+#include <plat/map-s5p.h>
+
+/* Assume that the bus is saturated if the utilization is 40% */
+#define BUS_SATURATION_RATIO	40
+
+enum ppmu_counter {
+	PPMU_PMNCNT0 = 0,
+	PPMU_PMCCNT1,
+	PPMU_PMNCNT2,
+	PPMU_PMNCNT3,
+	PPMU_PMNCNT_MAX,
+};
+struct exynos4_ppmu {
+	void __iomem *hw_base;
+	unsigned int ccnt;
+	unsigned int event;
+	unsigned int count[PPMU_PMNCNT_MAX];
+	bool ccnt_overflow;
+	bool count_overflow[PPMU_PMNCNT_MAX];
+};
+
+struct busfreq_data {
+	struct device *dev;
+	struct devfreq *devfreq;
+	bool disabled;
+	struct regulator *vdd_int;
+	struct opp *curr_opp;
+	struct exynos4_ppmu dmc[2];
+	struct notifier_block pm_notifier;
+
+	struct mutex lock;
+};
+
+enum busclk_level_idx {
+	LV_0 = 0,
+	LV_1,
+	LV_2,
+	LV_END
+};
+
+struct bus_opp_table {
+	unsigned int idx;
+	unsigned long mem_clk;
+	unsigned long volt;
+};
+
+struct bus_clkdiv {
+	unsigned int index;
+	unsigned int clkdiv;
+};
+
+static struct bus_opp_table exynos4_busclk_table[] = {
+	{LV_0, 400000, 1150000},
+	{LV_1, 267000, 1050000},
+	{LV_2, 133000, 1025000},
+	{0, 0, 0},
+};
+
+/* Some chips have different operating voltages */
+static unsigned int exynos4_asv_volt[][LV_END] = {
+	{1150000, 1050000, 1025000},
+	{1125000, 1025000, 1000000},
+	{1100000, 1000000, 975000},
+	{1075000, 975000, 950000},
+	{1050000, 950000, 950000},
+};
+
+static unsigned int clkdiv_dmc0[LV_END][8] = {
+	/*
+	 * Clock divider value for following
+	 * { DIVACP, DIVACP_PCLK, DIVDPHY, DIVDMC, DIVDMCD
+	 *		DIVDMCP, DIVCOPY2, DIVCORE_TIMERS }
+	 */
+
+	/* DMC L0: 400MHz */
+	{ 3, 1, 1, 1, 1, 1, 3, 1 },
+	/* DMC L1: 266.7MHz */
+	{ 4, 1, 1, 2, 1, 1, 3, 1 },
+	/* DMC L2: 133MHz */
+	{ 5, 1, 1, 5, 1, 1, 3, 1 },
+};
+
+static unsigned int clkdiv_top[LV_END][5] = {
+	/*
+	 * Clock divider value for following
+	 * { DIVACLK200, DIVACLK100, DIVACLK160, DIVACLK133, DIVONENAND }
+	 */
+	/* ACLK200 L0: 200MHz */
+	{ 3, 7, 4, 5, 1 },
+	/* ACLK200 L1: 160MHz */
+	{ 4, 7, 5, 6, 1 },
+	/* ACLK200 L2: 133MHz */
+	{ 5, 7, 7, 7, 1 },
+};
+
+static unsigned int clkdiv_lr_bus[LV_END][2] = {
+	/*
+	 * Clock divider value for following
+	 * { DIVGDL/R, DIVGPL/R }
+	 */
+	/* ACLK_GDL/R L1: 200MHz */
+	{ 3, 1 },
+	/* ACLK_GDL/R L2: 160MHz */
+	{ 4, 1 },
+	/* ACLK_GDL/R L3: 133MHz */
+	{ 5, 1 },
+};
+
+static struct bus_clkdiv dmc_divtable[] = {
+	{LV_0, 0},
+	{LV_1, 0},
+	{LV_2, 0},
+};
+
+static struct bus_clkdiv top_divtable[] = {
+	{LV_0, 0},
+	{LV_1, 0},
+	{LV_2, 0},
+};
+
+static int exynos4_set_busclk(struct opp *opp)
+{
+	unsigned int index;
+	unsigned int tmp;
+
+	for (index = LV_0; index < LV_END; index++)
+		if (opp_get_freq(opp) == exynos4_busclk_table[index].mem_clk)
+			break;
+
+	if (index == LV_END)
+		return -EINVAL;
+
+	/* Change Divider - DMC0 */
+	tmp = dmc_divtable[index].clkdiv;
+
+	__raw_writel(tmp, S5P_CLKDIV_DMC0);
+
+	do {
+		tmp = __raw_readl(S5P_CLKDIV_STAT_DMC0);
+	} while (tmp & 0x11111111);
+
+	/* Change Divider - TOP */
+	tmp = top_divtable[index].clkdiv;
+
+	__raw_writel(tmp, S5P_CLKDIV_TOP);
+
+	do {
+		tmp = __raw_readl(S5P_CLKDIV_STAT_TOP);
+	} while (tmp & 0x11111);
+
+	/* Change Divider - LEFTBUS */
+	tmp = __raw_readl(S5P_CLKDIV_LEFTBUS);
+
+	tmp &= ~(S5P_CLKDIV_BUS_GDLR_MASK | S5P_CLKDIV_BUS_GPLR_MASK);
+
+	tmp |= ((clkdiv_lr_bus[index][0] << S5P_CLKDIV_BUS_GDLR_SHIFT) |
+		(clkdiv_lr_bus[index][1] << S5P_CLKDIV_BUS_GPLR_SHIFT));
+
+	__raw_writel(tmp, S5P_CLKDIV_LEFTBUS);
+
+	do {
+		tmp = __raw_readl(S5P_CLKDIV_STAT_LEFTBUS);
+	} while (tmp & 0x11);
+
+	/* Change Divider - RIGHTBUS */
+	tmp = __raw_readl(S5P_CLKDIV_RIGHTBUS);
+
+	tmp &= ~(S5P_CLKDIV_BUS_GDLR_MASK | S5P_CLKDIV_BUS_GPLR_MASK);
+
+	tmp |= ((clkdiv_lr_bus[index][0] << S5P_CLKDIV_BUS_GDLR_SHIFT) |
+		(clkdiv_lr_bus[index][1] << S5P_CLKDIV_BUS_GPLR_SHIFT));
+
+	__raw_writel(tmp, S5P_CLKDIV_RIGHTBUS);
+
+	do {
+		tmp = __raw_readl(S5P_CLKDIV_STAT_RIGHTBUS);
+	} while (tmp & 0x11);
+
+	return 0;
+}
+
+static void busfreq_mon_reset(struct busfreq_data *data)
+{
+	unsigned int i;
+
+	for (i = 0; i < 2; i++) {
+		void __iomem *ppmu_base = data->dmc[i].hw_base;
+
+		/* Reset PPMU */
+		__raw_writel(0x8000000f, ppmu_base + 0xf010);
+		__raw_writel(0x8000000f, ppmu_base + 0xf050);
+		__raw_writel(0x6, ppmu_base + 0xf000);
+		__raw_writel(0x0, ppmu_base + 0xf100);
+
+		/* Set PPMU Event */
+		data->dmc[i].event = 0x6;
+		__raw_writel(((data->dmc[i].event << 12) | 0x1),
+			     ppmu_base + 0xfc);
+
+		/* Start PPMU */
+		__raw_writel(0x1, ppmu_base + 0xf000);
+	}
+}
+
+static void exynos4_read_ppmu(struct busfreq_data *data)
+{
+	int i, j;
+
+	for (i = 0; i < 2; i++) {
+		void __iomem *ppmu_base = data->dmc[i].hw_base;
+		u32 overflow;
+
+		/* Stop PPMU */
+		__raw_writel(0x0, ppmu_base + 0xf000);
+
+		/* Update local data from PPMU */
+		overflow = __raw_readl(ppmu_base + 0xf050);
+
+		data->dmc[i].ccnt = __raw_readl(ppmu_base + 0xf100);
+		data->dmc[i].ccnt_overflow = overflow & (1 << 31);
+
+		for (j = 0; j < PPMU_PMNCNT_MAX; j++) {
+			data->dmc[i].count[j] = __raw_readl(
+					ppmu_base + (0xf110 + (0x10 * j)));
+			data->dmc[i].count_overflow[j] = overflow & (1 << j);
+		}
+	}
+
+	busfreq_mon_reset(data);
+}
+
+static int exynos4_bus_target(struct device *dev, unsigned long *_freq)
+{
+	int err = 0;
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data *data = platform_get_drvdata(pdev);
+	struct opp *opp = devfreq_recommended_opp(dev, _freq);
+	unsigned long old_freq = opp_get_freq(data->curr_opp);
+	unsigned long freq = opp_get_freq(opp);
+	unsigned long volt = opp_get_voltage(opp);
+
+	if (old_freq == freq)
+		return 0;
+
+	dev_info(dev, "targetting %lukHz %luuV\n", freq, volt);
+
+	mutex_lock(&data->lock);
+
+	if (data->disabled)
+		goto out;
+
+	if (old_freq < freq)
+		err = regulator_set_voltage(data->vdd_int, volt, volt);
+	if (err)
+		goto out;
+
+	if (old_freq != freq)
+		err = exynos4_set_busclk(opp);
+	if (err)
+		goto out;
+
+	data->curr_opp = opp;
+
+	if (old_freq > freq)
+		err = regulator_set_voltage(data->vdd_int, volt, volt);
+out:
+	mutex_unlock(&data->lock);
+	return err;
+}
+
+static int exynos4_get_busier_dmc(struct busfreq_data *data)
+{
+	u64 p0 = data->dmc[0].count[0];
+	u64 p1 = data->dmc[1].count[0];
+
+	p0 *= data->dmc[1].ccnt;
+	p1 *= data->dmc[0].ccnt;
+
+	if (data->dmc[1].ccnt == 0)
+		return 0;
+
+	if (p0 > p1)
+		return 0;
+	return 1;
+}
+
+static int exynos4_bus_get_dev_status(struct device *dev,
+				      struct devfreq_dev_status *stat)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data *data = platform_get_drvdata(pdev);
+	int busier_dmc;
+	int cycles_x2 = 2; /* 2 x cycles */
+	void __iomem *addr;
+	u32 timing;
+	u32 memctrl;
+
+	exynos4_read_ppmu(data);
+	busier_dmc = exynos4_get_busier_dmc(data);
+	stat->current_frequency = opp_get_freq(data->curr_opp);
+
+	if (busier_dmc)
+		addr = S5P_VA_DMC1;
+	else
+		addr = S5P_VA_DMC0;
+
+	memctrl = __raw_readl(addr + 0x04); /* one of DDR2/3/LPDDR2 */
+	timing = __raw_readl(addr + 0x38); /* CL or WL/RL values */
+
+	switch ((memctrl >> 8) & 0xf) {
+	case 0x4: /* DDR2 */
+		cycles_x2 = ((timing >> 16) & 0xf) * 2;
+		break;
+	case 0x5: /* LPDDR2 */
+	case 0x6: /* DDR3 */
+		cycles_x2 = ((timing >> 8) & 0xf) + ((timing >> 0) & 0xf);
+		break;
+	default:
+		pr_err("%s: Unknown Memory Type(%d).\n", __func__,
+		       (memctrl >> 8) & 0xf);
+		return -EINVAL;
+	}
+
+	/* Number of cycles spent on memory access */
+	stat->busy_time = data->dmc[busier_dmc].count[0] / 2 * (cycles_x2 + 2);
+	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
+	stat->total_time = data->dmc[busier_dmc].ccnt;
+
+	/* If the counters have overflown, retry */
+	if (data->dmc[busier_dmc].ccnt_overflow ||
+	    data->dmc[busier_dmc].count_overflow[0])
+		return -EAGAIN;
+
+	return 0;
+}
+
+static void exynos4_bus_exit(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data *data = platform_get_drvdata(pdev);
+
+	devfreq_unregister_opp_notifier(dev, data->devfreq);
+}
+
+static struct devfreq_dev_profile exynos4_devfreq_profile = {
+	.initial_freq	= 400000,
+	.polling_ms	= 50,
+	.target		= exynos4_bus_target,
+	.get_dev_status	= exynos4_bus_get_dev_status,
+	.exit		= exynos4_bus_exit,
+};
+
+static void exynos4_init_tables(void)
+{
+	u32 tmp;
+	int mgrp;
+	int i;
+
+	tmp = __raw_readl(S5P_CLKDIV_DMC0);
+	for (i = LV_0; i < LV_END; i++) {
+		tmp &= ~(S5P_CLKDIV_DMC0_ACP_MASK |
+			S5P_CLKDIV_DMC0_ACPPCLK_MASK |
+			S5P_CLKDIV_DMC0_DPHY_MASK |
+			S5P_CLKDIV_DMC0_DMC_MASK |
+			S5P_CLKDIV_DMC0_DMCD_MASK |
+			S5P_CLKDIV_DMC0_DMCP_MASK |
+			S5P_CLKDIV_DMC0_COPY2_MASK |
+			S5P_CLKDIV_DMC0_CORETI_MASK);
+
+		tmp |= ((clkdiv_dmc0[i][0] << S5P_CLKDIV_DMC0_ACP_SHIFT) |
+			(clkdiv_dmc0[i][1] << S5P_CLKDIV_DMC0_ACPPCLK_SHIFT) |
+			(clkdiv_dmc0[i][2] << S5P_CLKDIV_DMC0_DPHY_SHIFT) |
+			(clkdiv_dmc0[i][3] << S5P_CLKDIV_DMC0_DMC_SHIFT) |
+			(clkdiv_dmc0[i][4] << S5P_CLKDIV_DMC0_DMCD_SHIFT) |
+			(clkdiv_dmc0[i][5] << S5P_CLKDIV_DMC0_DMCP_SHIFT) |
+			(clkdiv_dmc0[i][6] << S5P_CLKDIV_DMC0_COPY2_SHIFT) |
+			(clkdiv_dmc0[i][7] << S5P_CLKDIV_DMC0_CORETI_SHIFT));
+
+		dmc_divtable[i].clkdiv = tmp;
+	}
+
+	tmp = __raw_readl(S5P_CLKDIV_TOP);
+	for (i = LV_0; i <  LV_END; i++) {
+		tmp &= ~(S5P_CLKDIV_TOP_ACLK200_MASK |
+			S5P_CLKDIV_TOP_ACLK100_MASK |
+			S5P_CLKDIV_TOP_ACLK160_MASK |
+			S5P_CLKDIV_TOP_ACLK133_MASK |
+			S5P_CLKDIV_TOP_ONENAND_MASK);
+
+		tmp |= ((clkdiv_top[i][0] << S5P_CLKDIV_TOP_ACLK200_SHIFT) |
+			(clkdiv_top[i][1] << S5P_CLKDIV_TOP_ACLK100_SHIFT) |
+			(clkdiv_top[i][2] << S5P_CLKDIV_TOP_ACLK160_SHIFT) |
+			(clkdiv_top[i][3] << S5P_CLKDIV_TOP_ACLK133_SHIFT) |
+			(clkdiv_top[i][4] << S5P_CLKDIV_TOP_ONENAND_SHIFT));
+
+		top_divtable[i].clkdiv = tmp;
+	}
+
+#ifdef CONFIG_EXYNOS_ASV
+	tmp = exynos4_result_of_asv;
+#else
+	tmp = 0; /* Max voltages for the reliability of the unknown */
+#endif
+
+	pr_debug("ASV Group of Exynos4 is %d\n", tmp);
+	/* Use merged grouping for voltage */
+	switch (tmp) {
+	case 0:
+		mgrp = 0;
+		break;
+	case 1:
+	case 2:
+		mgrp = 1;
+		break;
+	case 3:
+	case 4:
+		mgrp = 2;
+		break;
+	case 5:
+	case 6:
+		mgrp = 3;
+		break;
+	case 7:
+		mgrp = 4;
+		break;
+	default:
+		pr_warn("Unknown ASV Group. Use max voltage.\n");
+		mgrp = 0;
+	}
+
+	for (i = LV_0; i < LV_END; i++)
+		exynos4_busclk_table[i].volt = exynos4_asv_volt[mgrp][i];
+}
+
+static int exynos4_busfreq_pm_notifier_event(struct notifier_block *this,
+		unsigned long event, void *ptr)
+{
+	struct busfreq_data *data = container_of(this, struct busfreq_data,
+						 pm_notifier);
+	struct opp *opp;
+	unsigned long maxfreq = ULONG_MAX;
+
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		/* Set Fastest and Deactivate DVFS */
+		mutex_lock(&data->lock);
+
+		data->disabled = true;
+
+		opp = opp_find_freq_floor(data->dev, &maxfreq);
+
+		regulator_set_voltage(data->vdd_int, opp_get_voltage(opp),
+				      opp_get_voltage(opp));
+		exynos4_set_busclk(opp);
+		data->curr_opp = opp;
+
+		mutex_unlock(&data->lock);
+		return NOTIFY_OK;
+	case PM_POST_RESTORE:
+	case PM_POST_SUSPEND:
+		/* Reactivate */
+		mutex_lock(&data->lock);
+		data->disabled = false;
+		mutex_unlock(&data->lock);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static __devinit int exynos4_busfreq_probe(struct platform_device *pdev)
+{
+	struct busfreq_data *data;
+	struct opp *opp;
+	struct device *dev = &pdev->dev;
+	int err = 0;
+	int i;
+
+	exynos4_init_tables();
+
+	data = kzalloc(sizeof(struct busfreq_data), GFP_KERNEL);
+	if (data == NULL) {
+		dev_err(dev, "Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	data->vdd_int = regulator_get(dev, "vdd_int");
+	if (IS_ERR(data->vdd_int)) {
+		dev_err(dev, "Cannot get the regulator \"vdd_int\"\n");
+		err = PTR_ERR(data->vdd_int);
+		goto err_regulator;
+	}
+
+
+	data->dmc[0].hw_base = S5P_VA_DMC0;
+	data->dmc[1].hw_base = S5P_VA_DMC1;
+	data->pm_notifier.notifier_call = exynos4_busfreq_pm_notifier_event;
+	data->dev = dev;
+	mutex_init(&data->lock);
+
+	for (i = LV_0; i < LV_END; i++) {
+		err = opp_add(dev, exynos4_busclk_table[i].mem_clk,
+			      exynos4_busclk_table[i].volt);
+		if (err) {
+			dev_err(dev, "Cannot add opp entries.\n");
+			goto err_opp_add;
+		}
+	}
+
+	opp = opp_find_freq_floor(dev, &exynos4_devfreq_profile.initial_freq);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "Invalid initial frequency %lu kHz.\n",
+		       exynos4_devfreq_profile.initial_freq);
+		err = PTR_ERR(opp);
+		goto err_opp_add;
+	}
+	data->curr_opp = opp;
+
+	platform_set_drvdata(pdev, data);
+
+	busfreq_mon_reset(data);
+
+	data->devfreq = devfreq_add_device(dev, &exynos4_devfreq_profile,
+					   &devfreq_simple_ondemand, NULL);
+	if (IS_ERR(data->devfreq)) {
+		err = PTR_ERR(data->devfreq);
+		goto err_opp_add;
+	}
+
+	devfreq_register_opp_notifier(dev, data->devfreq);
+
+	err = register_pm_notifier(&data->pm_notifier);
+	if (err) {
+		dev_err(dev, "Failed to setup pm notifier\n");
+		goto err_devfreq_add;
+	}
+
+	return 0;
+err_devfreq_add:
+	devfreq_remove_device(data->devfreq);
+err_opp_add:
+	regulator_put(data->vdd_int);
+err_regulator:
+	kfree(data);
+	return err;
+}
+
+static __devexit int exynos4_busfreq_remove(struct platform_device *pdev)
+{
+	struct busfreq_data *data = platform_get_drvdata(pdev);
+
+	unregister_pm_notifier(&data->pm_notifier);
+	devfreq_remove_device(data->devfreq);
+	regulator_put(data->vdd_int);
+	kfree(data);
+
+	return 0;
+}
+
+static int exynos4_busfreq_resume(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+	struct busfreq_data *data = platform_get_drvdata(pdev);
+
+	busfreq_mon_reset(data);
+	return 0;
+}
+
+static const struct dev_pm_ops exynos4_busfreq_pm = {
+	.resume	= exynos4_busfreq_resume,
+};
+
+static struct platform_driver exynos4_busfreq_driver = {
+	.probe	= exynos4_busfreq_probe,
+	.remove	= __devexit_p(exynos4_busfreq_remove),
+	.driver = {
+		.name	= "exynos4210-busfreq",
+		.owner	= THIS_MODULE,
+		.pm	= &exynos4_busfreq_pm,
+	},
+};
+
+static int __init exynos4_busfreq_init(void)
+{
+	return platform_driver_register(&exynos4_busfreq_driver);
+}
+late_initcall(exynos4_busfreq_init);
+
+static void __exit exynos4_busfreq_exit(void)
+{
+	platform_driver_unregister(&exynos4_busfreq_driver);
+}
+module_exit(exynos4_busfreq_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("EXYNOS4 busfreq driver with devfreq framework");
+MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
+MODULE_ALIAS("exynos4-busfreq");
-- 
1.7.4.1

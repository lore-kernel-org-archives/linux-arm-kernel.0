From: boyko.lee@samsung.com (Jongpill Lee)
Date: Thu, 10 Nov 2011 14:48:03 +0900
Subject: [PATCH 3/3] ARM: EXYNOS4: Support ASV for Exynos4210
In-Reply-To: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
References: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
Message-ID: <1320904083-19173-4-git-send-email-boyko.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds function for exynos4210's asv driver.
On Exynos4210, we can get ASV result using by HPM and IDS value.
If you want to use asv result on your driver, please define
exynos_result_of_asv with extern.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
---
 arch/arm/mach-exynos4/Makefile                  |    2 +-
 arch/arm/mach-exynos4/asv-4210.c                |  339 +++++++++++++++++++++++
 arch/arm/mach-exynos4/asv.c                     |    9 +-
 arch/arm/mach-exynos4/include/mach/asv.h        |    3 +
 arch/arm/mach-exynos4/include/mach/map.h        |    2 +
 arch/arm/mach-exynos4/include/mach/regs-clock.h |   18 ++
 arch/arm/mach-exynos4/include/mach/regs-iem.h   |   27 ++
 7 files changed, 397 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/asv-4210.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/regs-iem.h

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 587ce90..5422b01 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
-obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= asv.o
+obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= asv.o asv-4210.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/arch/arm/mach-exynos4/asv-4210.c b/arch/arm/mach-exynos4/asv-4210.c
new file mode 100644
index 0000000..1260ab8
--- /dev/null
+++ b/arch/arm/mach-exynos4/asv-4210.c
@@ -0,0 +1,339 @@
+/* linux/arch/arm/mach-exynos/asv-4210.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4210 - ASV(Adaptive Support Voltage) driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+
+#include <mach/regs-iem.h>
+#include <mach/regs-clock.h>
+#include <mach/asv.h>
+
+/*
+ * exynos_result_of_asv is result of ASV group.
+ * Using by this value, other driver can adjust voltage.
+ */
+unsigned int exynos_result_of_asv;
+
+enum target_asv {
+	EXYNOS4210_1200,
+	EXYNOS4210_1400,
+	EXYNOS4210_SINGLE_1200,
+};
+
+struct asv_judge_table exynos4210_1200_limit[] = {
+	/* HPM , IDS */
+	{8 , 4},
+	{11 , 8},
+	{14 , 12},
+	{18 , 17},
+	{21 , 27},
+	{23 , 45},
+	{25 , 55},
+};
+
+static struct asv_judge_table exynos4210_1400_limit[] = {
+	/* HPM , IDS */
+	{13 , 8},
+	{17 , 12},
+	{22 , 32},
+	{26 , 52},
+};
+
+static struct asv_judge_table exynos4210_single_1200_limit[] = {
+	/* HPM , IDS */
+	{8 , 4},
+	{14 , 12},
+	{21 , 27},
+	{25 , 55},
+};
+
+static int exynos4210_asv_pre_clock_init(void)
+{
+	struct clk *clk_hpm;
+	struct clk *clk_copy;
+	struct clk *clk_parent;
+
+	/* PWI clock setting */
+	clk_copy = clk_get(NULL, "sclk_pwi");
+	if (IS_ERR(clk_copy))
+		goto clock_fail;
+	else {
+		clk_parent = clk_get(NULL, "xusbxti");
+
+		if (IS_ERR(clk_parent)) {
+			clk_put(clk_copy);
+
+			goto clock_fail;
+		}
+		if (clk_set_parent(clk_copy, clk_parent))
+			goto clock_fail;
+
+		clk_put(clk_parent);
+	}
+	clk_set_rate(clk_copy, (48 * MHZ));
+
+	clk_put(clk_copy);
+
+	/* HPM clock setting */
+	clk_copy = clk_get(NULL, "dout_copy");
+	if (IS_ERR(clk_copy))
+		goto clock_fail;
+	else {
+		clk_parent = clk_get(NULL, "mout_mpll");
+		if (IS_ERR(clk_parent)) {
+			clk_put(clk_copy);
+
+			goto clock_fail;
+		}
+		if (clk_set_parent(clk_copy, clk_parent))
+			goto clock_fail;
+
+		clk_put(clk_parent);
+	}
+
+	clk_set_rate(clk_copy, (400 * MHZ));
+
+	clk_put(clk_copy);
+
+	clk_hpm = clk_get(NULL, "sclk_hpm");
+	if (IS_ERR(clk_hpm))
+		goto clock_fail;
+
+	clk_set_rate(clk_hpm, (200 * MHZ));
+
+	clk_put(clk_hpm);
+
+	return 0;
+
+clock_fail:
+	pr_err("EXYNOS4210: ASV: Clock init fail\n");
+
+	return -EBUSY;
+}
+
+static int exynos4210_asv_pre_clock_setup(void)
+{
+	/* APLL_CON0 level register */
+	__raw_writel(0x80FA0601, S5P_APLL_CON0L8);
+	__raw_writel(0x80C80601, S5P_APLL_CON0L7);
+	__raw_writel(0x80C80602, S5P_APLL_CON0L6);
+	__raw_writel(0x80C80604, S5P_APLL_CON0L5);
+	__raw_writel(0x80C80601, S5P_APLL_CON0L4);
+	__raw_writel(0x80C80601, S5P_APLL_CON0L3);
+	__raw_writel(0x80C80601, S5P_APLL_CON0L2);
+	__raw_writel(0x80C80601, S5P_APLL_CON0L1);
+
+	/* IEM Divider register */
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L8);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L7);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L6);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L5);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L4);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L3);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L2);
+	__raw_writel(0x00500000, S5P_CLKDIV_IEM_L1);
+
+	return 0;
+}
+
+static int exynos4210_find_group(struct samsung_asv *asv_info,
+			      enum target_asv exynos4_target)
+{
+	unsigned int ret = 0;
+	unsigned int i;
+
+	if (exynos4_target == EXYNOS4210_1200) {
+		ret = ARRAY_SIZE(exynos4210_1200_limit);
+
+		for (i = 0; i < ARRAY_SIZE(exynos4210_1200_limit); i++) {
+			if (asv_info->hpm_result <= exynos4210_1200_limit[i].hpm_limit ||
+			   asv_info->ids_result <= exynos4210_1200_limit[i].ids_limit) {
+				ret = i;
+				break;
+			}
+		}
+	} else if (exynos4_target == EXYNOS4210_1400) {
+		ret = ARRAY_SIZE(exynos4210_1400_limit);
+
+		for (i = 0; i < ARRAY_SIZE(exynos4210_1400_limit); i++) {
+			if (asv_info->hpm_result <= exynos4210_1400_limit[i].hpm_limit ||
+			   asv_info->ids_result <= exynos4210_1400_limit[i].ids_limit) {
+				ret = i;
+				break;
+			}
+		}
+	} else if (exynos4_target == EXYNOS4210_SINGLE_1200) {
+		ret = ARRAY_SIZE(exynos4210_single_1200_limit);
+
+		for (i = 0; i < ARRAY_SIZE(exynos4210_single_1200_limit); i++) {
+			if (asv_info->hpm_result <= exynos4210_single_1200_limit[i].hpm_limit ||
+			   asv_info->ids_result <= exynos4210_single_1200_limit[i].ids_limit) {
+				ret = i;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+#define PACK_ID				8
+#define PACK_MASK			0x3
+
+#define SUPPORT_1400MHZ			(1 << 31)
+#define SUPPORT_1200MHZ			(1 << 30)
+#define SUPPORT_1000MHZ			(1 << 29)
+
+static int exynos4210_get_hpm(struct samsung_asv *asv_info)
+{
+	unsigned int i;
+	unsigned int tmp;
+	unsigned int hpm_delay = 0;
+	void __iomem *iem_base;
+
+	iem_base = ioremap(EXYNOS4_PA_IEM, SZ_128K);
+
+	if (!iem_base) {
+		pr_err("EXYNOS4210: ASV: ioremap fail\n");
+		return -EPERM;
+	}
+
+	/* Clock setting to get asv value */
+	if (!asv_info->pre_clock_init)
+		goto err;
+	else {
+		if (asv_info->pre_clock_init())
+			goto err;
+		else {
+			/* HPM enable  */
+			tmp = __raw_readl(iem_base + EXYNOS4_APC_CONTROL);
+			tmp |= APC_HPM_EN;
+			__raw_writel(tmp, (iem_base + EXYNOS4_APC_CONTROL));
+
+			asv_info->pre_clock_setup();
+
+			/* IEM enable */
+			tmp = __raw_readl(iem_base + EXYNOS4_IECDPCCR);
+			tmp |= IEC_EN;
+			__raw_writel(tmp, (iem_base + EXYNOS4_IECDPCCR));
+		}
+	}
+
+	/* Get HPM Delay value */
+	for (i = 0; i < EXYNOS4_LOOP_CNT; i++) {
+		tmp = __raw_readb(iem_base + EXYNOS4_APC_DBG_DLYCODE);
+		hpm_delay += tmp;
+	}
+
+	hpm_delay /= EXYNOS4_LOOP_CNT;
+
+	/* Store result of hpm value */
+	asv_info->hpm_result = hpm_delay;
+
+	return 0;
+
+err:
+	pr_err("EXYNOS4210: ASV: Failt to get hpm function\n");
+
+	iounmap(iem_base);
+
+	return -EPERM;
+}
+
+static int exynos4210_get_ids(struct samsung_asv *asv_info)
+{
+	unsigned int pkg_id_val;
+
+	if (!asv_info->ids_offset || !asv_info->ids_mask) {
+		pr_err("EXYNOS4210: ASV: No ids_offset or No ids_mask\n");
+
+		return -EPERM;
+	}
+
+	pkg_id_val = __raw_readl(S5P_VA_CHIPID + 0x4);
+	asv_info->pkg_id = pkg_id_val;
+	asv_info->ids_result = ((pkg_id_val >> asv_info->ids_offset) &
+							asv_info->ids_mask);
+
+	return 0;
+}
+
+static int exynos4210_asv_store_result(struct samsung_asv *asv_info)
+{
+	unsigned int result_grp;
+	char *support_freq;
+	unsigned int exynos_idcode = 0x0;
+
+	exynos_result_of_asv = 0;
+
+	exynos_idcode = __raw_readl(S5P_VA_CHIPID);
+
+	/* Single chip is only support 1.2GHz */
+	if (!((exynos_idcode >> PACK_ID) & PACK_MASK)) {
+		result_grp = exynos4210_find_group(asv_info, EXYNOS4210_SINGLE_1200);
+		result_grp |= SUPPORT_1200MHZ;
+		support_freq = "1.2GHz";
+
+		goto set_reg;
+	}
+
+	/* Check support freq */
+	switch (asv_info->pkg_id & 0x7) {
+	/* Support 1.2GHz */
+	case 1:
+	case 7:
+		result_grp = exynos4210_find_group(asv_info, EXYNOS4210_1200);
+		result_grp |= SUPPORT_1200MHZ;
+		support_freq = "1.2GHz";
+		break;
+	/* Support 1.4GHz */
+	case 5:
+		result_grp = exynos4210_find_group(asv_info, EXYNOS4210_1400);
+		result_grp |= SUPPORT_1200MHZ;
+		support_freq = "1.4GHz";
+		break;
+	/* Defalut support 1.0GHz */
+	default:
+		result_grp = exynos4210_find_group(asv_info, EXYNOS4210_1200);
+		result_grp |= SUPPORT_1000MHZ;
+		support_freq = "1.0GHz";
+		break;
+	}
+
+set_reg:
+	exynos_result_of_asv = result_grp;
+
+	pr_info("EXYNOS4: ASV: Support %s and Group is 0x%x\n",
+					support_freq, result_grp);
+
+	return 0;
+}
+
+void exynos4210_asv_init(struct samsung_asv *asv_info)
+{
+	pr_info("EXYNOS4210: Adaptive Support Voltage init\n");
+
+	asv_info->ids_offset = 24;
+	asv_info->ids_mask = 0xFF;
+
+	asv_info->get_ids = exynos4210_get_ids;
+	asv_info->get_hpm = exynos4210_get_hpm;
+	asv_info->pre_clock_init = exynos4210_asv_pre_clock_init;
+	asv_info->pre_clock_setup = exynos4210_asv_pre_clock_setup;
+	asv_info->store_result = exynos4210_asv_store_result;
+}
diff --git a/arch/arm/mach-exynos4/asv.c b/arch/arm/mach-exynos4/asv.c
index b13d182..85d076e 100644
--- a/arch/arm/mach-exynos4/asv.c
+++ b/arch/arm/mach-exynos4/asv.c
@@ -17,6 +17,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#include <plat/cpu.h>
+
 #include <mach/map.h>
 #include <mach/asv.h>
 
@@ -26,9 +28,12 @@ static int __init exynos_asv_init(void)
 {
 	exynos_asv = kzalloc(sizeof(struct samsung_asv), GFP_KERNEL);
 	if (!exynos_asv)
-		return -ENOMEM;
+		goto out;
 
-	/* I will add asv driver of exynos4 series to regist */
+	if (soc_is_exynos4210())
+		exynos4210_asv_init(exynos_asv);
+	else
+		goto out;
 
 	if (exynos_asv->check_vdd_arm) {
 		if (exynos_asv->check_vdd_arm())
diff --git a/arch/arm/mach-exynos4/include/mach/asv.h b/arch/arm/mach-exynos4/include/mach/asv.h
index 9a4a8f4..cd43c48 100644
--- a/arch/arm/mach-exynos4/include/mach/asv.h
+++ b/arch/arm/mach-exynos4/include/mach/asv.h
@@ -14,6 +14,7 @@
 #define __ASM_ARCH_ASV_H __FILE__
 
 #define JUDGE_TABLE_END			NULL
+#define EXYNOS4_LOOP_CNT		10
 
 struct asv_judge_table {
 	unsigned int hpm_limit; /* HPM value to decide group of target */
@@ -37,4 +38,6 @@ struct samsung_asv {
 	int (*store_result)(struct samsung_asv *asv_info);
 };
 
+extern void exynos4210_asv_init(struct samsung_asv *asv_info);
+
 #endif /* __ASM_ARCH_ASV_H */
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 918a979..81fa158 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -60,6 +60,8 @@
 
 #define EXYNOS4_PA_COMBINER		0x10440000
 
+#define EXYNOS4_PA_IEM			0x10460000
+
 #define EXYNOS4_PA_GIC_CPU		0x10480000
 #define EXYNOS4_PA_GIC_DIST		0x10490000
 
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index 6c37ebe..23ee10f 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -130,6 +130,24 @@
 #define S5P_CLKGATE_SCLKCPU		S5P_CLKREG(0x14800)
 #define S5P_CLKGATE_IP_CPU		S5P_CLKREG(0x14900)
 
+#define S5P_APLL_CON0L8			S5P_CLKREG(0x15100)
+#define S5P_APLL_CON0L7			S5P_CLKREG(0x15104)
+#define S5P_APLL_CON0L6			S5P_CLKREG(0x15108)
+#define S5P_APLL_CON0L5			S5P_CLKREG(0x1510C)
+#define S5P_APLL_CON0L4			S5P_CLKREG(0x15110)
+#define S5P_APLL_CON0L3			S5P_CLKREG(0x15114)
+#define S5P_APLL_CON0L2			S5P_CLKREG(0x15118)
+#define S5P_APLL_CON0L1			S5P_CLKREG(0x1511C)
+
+#define S5P_CLKDIV_IEM_L8		S5P_CLKREG(0x15300)
+#define S5P_CLKDIV_IEM_L7		S5P_CLKREG(0x15304)
+#define S5P_CLKDIV_IEM_L6		S5P_CLKREG(0x15308)
+#define S5P_CLKDIV_IEM_L5		S5P_CLKREG(0x1530C)
+#define S5P_CLKDIV_IEM_L4		S5P_CLKREG(0x15310)
+#define S5P_CLKDIV_IEM_L3		S5P_CLKREG(0x15314)
+#define S5P_CLKDIV_IEM_L2		S5P_CLKREG(0x15318)
+#define S5P_CLKDIV_IEM_L1		S5P_CLKREG(0x1531C)
+
 #define S5P_APLL_LOCKTIME		(0x1C20)	/* 300us */
 
 #define S5P_APLLCON0_ENABLE_SHIFT	(31)
diff --git a/arch/arm/mach-exynos4/include/mach/regs-iem.h b/arch/arm/mach-exynos4/include/mach/regs-iem.h
new file mode 100644
index 0000000..d9bf177
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/regs-iem.h
@@ -0,0 +1,27 @@
+/* linux/arch/arm/mach-exynos/include/mach/regs-iem.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4 - IEM(INTELLIGENT ENERGY MANAGEMENT) register discription
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_IEM_H
+#define __ASM_ARCH_REGS_IEM_H __FILE__
+
+/* Register for IEC  */
+#define EXYNOS4_IECDPCCR		(0x00000)
+
+/* Register for APC */
+#define EXYNOS4_APC_CONTROL		(0x10010)
+#define EXYNOS4_APC_PREDLYSEL		(0x10024)
+#define EXYNOS4_APC_DBG_DLYCODE		(0x100E0)
+
+#define APC_HPM_EN			(1 << 4)
+#define IEC_EN				(1 << 0)
+
+#endif /* __ASM_ARCH_REGS_IEM_H */
-- 
1.7.1

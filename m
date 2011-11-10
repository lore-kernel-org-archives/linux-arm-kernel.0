From: boyko.lee@samsung.com (Jongpill Lee)
Date: Thu, 10 Nov 2011 14:48:01 +0900
Subject: [PATCH 1/3] ARM: EXYNOS4: Add ASV feature for Exynos4 series
In-Reply-To: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
References: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
Message-ID: <1320904083-19173-2-git-send-email-boyko.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ASV feature for exynos4 series.
ASV(Adaptive support voltage) feature support to get spec of SoC.
And we can use to adjust voltage for operation SoC using by ASV result.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
---
 arch/arm/mach-exynos4/Makefile           |    1 +
 arch/arm/mach-exynos4/asv.c              |   66 ++++++++++++++++++++++++++++++
 arch/arm/mach-exynos4/include/mach/asv.h |   40 ++++++++++++++++++
 3 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/asv.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/asv.h

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 2bb18f4..587ce90 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= asv.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/arch/arm/mach-exynos4/asv.c b/arch/arm/mach-exynos4/asv.c
new file mode 100644
index 0000000..b13d182
--- /dev/null
+++ b/arch/arm/mach-exynos4/asv.c
@@ -0,0 +1,66 @@
+/* linux/arch/arm/mach-exynos4/asv.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4 - ASV(Adaptive Support Voltage) driver
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
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include <mach/map.h>
+#include <mach/asv.h>
+
+static struct samsung_asv *exynos_asv;
+
+static int __init exynos_asv_init(void)
+{
+	exynos_asv = kzalloc(sizeof(struct samsung_asv), GFP_KERNEL);
+	if (!exynos_asv)
+		return -ENOMEM;
+
+	/* I will add asv driver of exynos4 series to regist */
+
+	if (exynos_asv->check_vdd_arm) {
+		if (exynos_asv->check_vdd_arm())
+			goto out;
+	}
+
+	/* Get HPM Delay value */
+	if (exynos_asv->get_hpm) {
+		if (exynos_asv->get_hpm(exynos_asv))
+			goto out;
+	} else
+		goto out;
+
+	/* Get IDS ARM Value */
+	if (exynos_asv->get_ids) {
+		if (exynos_asv->get_ids(exynos_asv))
+			goto out;
+	} else
+		goto out;
+
+	if (exynos_asv->store_result) {
+		if (exynos_asv->store_result(exynos_asv))
+			goto out;
+	} else
+		goto out;
+
+	return 0;
+out:
+	pr_err("EXYNOS : Fail to initialize ASV\n");
+
+	kfree(exynos_asv);
+
+	return -EINVAL;
+}
+device_initcall_sync(exynos_asv_init);
diff --git a/arch/arm/mach-exynos4/include/mach/asv.h b/arch/arm/mach-exynos4/include/mach/asv.h
new file mode 100644
index 0000000..9a4a8f4
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/asv.h
@@ -0,0 +1,40 @@
+/* linux/arch/arm/mach-exynos4/include/mach/asv.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * EXYNOS4 - Adaptive Support Voltage Header file
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_ASV_H
+#define __ASM_ARCH_ASV_H __FILE__
+
+#define JUDGE_TABLE_END			NULL
+
+struct asv_judge_table {
+	unsigned int hpm_limit; /* HPM value to decide group of target */
+	unsigned int ids_limit; /* IDS value to decide group of target */
+};
+
+struct samsung_asv {
+	unsigned int pkg_id;			/* fused value for chip */
+	unsigned int ids_offset;		/* ids_offset of chip */
+	unsigned int ids_mask;			/* ids_mask of chip */
+	unsigned int hpm_result;		/* hpm value of chip */
+	unsigned int ids_result;		/* ids value of chip */
+	int (*check_vdd_arm)(void);		/* check vdd_arm value, this function is selectable */
+	int (*pre_clock_init)(void);		/* clock init function to get hpm */
+	int (*pre_clock_setup)(void);		/* clock setup function to get hpm */
+	/* specific get ids function */
+	int (*get_ids)(struct samsung_asv *asv_info);
+	/* specific get hpm function */
+	int (*get_hpm)(struct samsung_asv *asv_info);
+	/* store into some repository to send result of asv */
+	int (*store_result)(struct samsung_asv *asv_info);
+};
+
+#endif /* __ASM_ARCH_ASV_H */
-- 
1.7.1

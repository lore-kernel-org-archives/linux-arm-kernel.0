From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:44 -0800
Subject: [PATCH 07/26] ARM: EXYNOS: move mach/pmu.h file into common.h
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c           |    1 -
 arch/arm/mach-exynos/common.h           |   20 ++++++++++++++++++
 arch/arm/mach-exynos/cpuidle.c          |    3 ++-
 arch/arm/mach-exynos/include/mach/pmu.h |   34 -------------------------------
 arch/arm/mach-exynos/pm.c               |    3 ++-
 arch/arm/mach-exynos/pmu.c              |    3 ++-
 6 files changed, 26 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/pmu.h

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index d6d0dc6..bec1c92 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -35,7 +35,6 @@
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
 #include <mach/regs-gpio.h>
-#include <mach/pmu.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 04744f9..e1af3a9 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -64,4 +64,24 @@ extern struct smp_operations exynos_smp_ops;
 
 extern void exynos_cpu_die(unsigned int cpu);
 
+/* PMU(Power Management Unit) support */
+
+#define PMU_TABLE_END	NULL
+
+enum sys_powerdown {
+	SYS_AFTR,
+	SYS_LPA,
+	SYS_SLEEP,
+	NUM_SYS_POWERDOWN,
+};
+
+extern unsigned long l2x0_regs_phys;
+struct exynos_pmu_conf {
+	void __iomem *reg;
+	unsigned int val[NUM_SYS_POWERDOWN];
+};
+
+extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+extern void s3c_cpu_resume(void);
+
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 0509241..fcfe025 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -23,10 +23,11 @@
 #include <asm/cpuidle.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
-#include <mach/pmu.h>
 
 #include <plat/cpu.h>
 
+#include "common.h"
+
 #define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
diff --git a/arch/arm/mach-exynos/include/mach/pmu.h b/arch/arm/mach-exynos/include/mach/pmu.h
deleted file mode 100644
index 7c27c2d..0000000
--- a/arch/arm/mach-exynos/include/mach/pmu.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/pmu.h
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS4210 - PMU(Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_PMU_H
-#define __ASM_ARCH_PMU_H __FILE__
-
-#define PMU_TABLE_END	NULL
-
-enum sys_powerdown {
-	SYS_AFTR,
-	SYS_LPA,
-	SYS_SLEEP,
-	NUM_SYS_POWERDOWN,
-};
-
-extern unsigned long l2x0_regs_phys;
-struct exynos_pmu_conf {
-	void __iomem *reg;
-	unsigned int val[NUM_SYS_POWERDOWN];
-};
-
-extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
-extern void s3c_cpu_resume(void);
-
-#endif /* __ASM_ARCH_PMU_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index b9b539c..f459afd 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -34,7 +34,8 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
 #include <mach/pm-core.h>
-#include <mach/pmu.h>
+
+#include "common.h"
 
 static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001, },
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 3a48c85..daebc1a 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -14,7 +14,8 @@
 #include <linux/bug.h>
 
 #include <mach/regs-clock.h>
-#include <mach/pmu.h>
+
+#include "common.h"
 
 static struct exynos_pmu_conf *exynos_pmu_config;
 
-- 
1.7.10.4

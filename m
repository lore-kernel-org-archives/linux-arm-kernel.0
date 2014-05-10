From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:56:38 +0900
Subject: [PATCH v4 11/11] ARM: EXYNOS: Move PMU specific definitions from
 common.h
In-Reply-To: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704998-13321-12-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Young-Gun Jang <yg1004.jang@samsung.com>

This patch moves PMU specific definitions into a new file
as exynos-pmu.h. This will help in making PMU implementation
independent of common.h header.

Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h     |   17 -----------------
 arch/arm/mach-exynos/exynos-pmu.h |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c         |    1 +
 arch/arm/mach-exynos/pmu.c        |    2 +-
 4 files changed, 33 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-exynos/exynos-pmu.h

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 58b2b5d..abcb074 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -37,24 +37,7 @@ extern struct smp_operations exynos_smp_ops;
 
 extern void exynos_cpu_die(unsigned int cpu);
 
-/* PMU(Power Management Unit) support */
-
-#define PMU_TABLE_END	(-1U)
-
-enum sys_powerdown {
-	SYS_AFTR,
-	SYS_LPA,
-	SYS_SLEEP,
-	NUM_SYS_POWERDOWN,
-};
-
 extern unsigned long l2x0_regs_phys;
-struct exynos_pmu_conf {
-	unsigned int offset;
-	unsigned int val[NUM_SYS_POWERDOWN];
-};
-
-extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 extern void exynos_enter_aftr(void);
 
 extern struct regmap *get_exynos_pmuregmap(void);
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/arch/arm/mach-exynos/exynos-pmu.h
new file mode 100644
index 0000000..16ff036
--- /dev/null
+++ b/arch/arm/mach-exynos/exynos-pmu.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header for EXYNOS PMU Driver support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __EXYNOS_PMU_H
+#define __EXYNOS_PMU_H
+
+#define PMU_TABLE_END	(-1U)
+
+enum sys_powerdown {
+	SYS_AFTR,
+	SYS_LPA,
+	SYS_SLEEP,
+	NUM_SYS_POWERDOWN,
+};
+
+struct exynos_pmu_conf {
+	unsigned int offset;
+	unsigned int val[NUM_SYS_POWERDOWN];
+};
+
+extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+
+#endif /* __EXYNOS_PMU_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index ee427d7..a7a1b7f 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -38,6 +38,7 @@
 #include "common.h"
 #include "regs-pmu.h"
 #include "regs-sys.h"
+#include "exynos-pmu.h"
 
 static struct regmap *pmu_regmap;
 
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 6a7fa8e..50c33c9 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
 
-#include "common.h"
+#include "exynos-pmu.h"
 #include "regs-pmu.h"
 
 struct exynos_pmu_data {
-- 
1.7.10.4

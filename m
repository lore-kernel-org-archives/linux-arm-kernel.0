From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Apr 2014 21:20:06 +0900
Subject: [RESUBMIT RFC PATCH v2 2/3] ARM: EXYNOS: Move pmu specific header
 files under "linux/mfd/samsung"
In-Reply-To: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
References: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398687607-4554-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving Exynos PMU specific header file into "include/linux/mfd/samsung"
thus updated affected files under "mach-exynos" to use new location of
these header files.

CC: Sangbeom Kim <sbkim73@samsung.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
CC: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c                                    |    4 ++--
 arch/arm/mach-exynos/exynos.c                                     |    2 +-
 arch/arm/mach-exynos/hotplug.c                                    |    2 +-
 arch/arm/mach-exynos/platsmp.c                                    |    2 +-
 arch/arm/mach-exynos/pm.c                                         |    4 ++--
 arch/arm/mach-exynos/pmu.c                                        |    5 ++---
 {arch/arm/mach-exynos => include/linux/mfd/samsung}/exynos-pmu.h  |    0
 .../regs-pmu.h => include/linux/mfd/samsung/exynos-regs-pmu.h     |    0
 8 files changed, 9 insertions(+), 10 deletions(-)
 rename {arch/arm/mach-exynos => include/linux/mfd/samsung}/exynos-pmu.h (100%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/mfd/samsung/exynos-regs-pmu.h (100%)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index ff3be9c..4c18087 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -18,6 +18,8 @@
 #include <linux/time.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/mfd/samsung/exynos-regs-pmu.h>
+#include <linux/mfd/samsung/exynos-pmu.h>
 
 #include <asm/proc-fns.h>
 #include <asm/smp_scu.h>
@@ -31,8 +33,6 @@
 #include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
-#include "exynos-pmu.h"
 
 #define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index b01987e..24c774a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -21,6 +21,7 @@
 #include <linux/pm_domain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/mfd/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -32,7 +33,6 @@
 
 #include "common.h"
 #include "mfc.h"
-#include "regs-pmu.h"
 #include "regs-sys.h"
 
 #define L2_AUX_VAL 0x7C470001
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 7831e64..1d3ad84 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/regmap.h>
+#include <linux/mfd/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -22,7 +23,6 @@
 #include <plat/cpu.h>
 
 #include "common.h"
-#include "regs-pmu.h"
 
 static inline void cpu_enter_lowpower_a9(void)
 {
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 3831e6c..54c0df8 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -19,6 +19,7 @@
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/mfd/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
@@ -29,7 +30,6 @@
 #include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
 
 extern void exynos4_secondary_startup(void);
 static void __iomem *pmu_base;
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 103ab92..3e75565 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -21,6 +21,8 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/mfd/samsung/exynos-regs-pmu.h>
+#include <linux/mfd/samsung/exynos-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -35,9 +37,7 @@
 #include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
 #include "regs-sys.h"
-#include "exynos-pmu.h"
 
 static struct regmap *pmu_regmap;
 
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index d020557..a26332f 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -15,9 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
-
-#include "exynos-pmu.h"
-#include "regs-pmu.h"
+#include <linux/mfd/samsung/exynos-regs-pmu.h>
+#include <linux/mfd/samsung/exynos-pmu.h>
 
 enum exynos_pmu_id {
 	PMU_EXYNOS4210,
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/include/linux/mfd/samsung/exynos-pmu.h
similarity index 100%
rename from arch/arm/mach-exynos/exynos-pmu.h
rename to include/linux/mfd/samsung/exynos-pmu.h
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/include/linux/mfd/samsung/exynos-regs-pmu.h
similarity index 100%
rename from arch/arm/mach-exynos/regs-pmu.h
rename to include/linux/mfd/samsung/exynos-regs-pmu.h
-- 
1.7.10.4

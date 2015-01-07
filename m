From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 07 Jan 2015 11:01:23 +0530
Subject: [PATCH v2 1/6] ARM: EXYNOS: Move pmu specific headers under
 "linux/soc/samsung"
In-Reply-To: <1420608688-10459-1-git-send-email-pankaj.dubey@samsung.com>
References: <1420608688-10459-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1420608688-10459-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Daniel Kachhap <amit.daniel@samsung.com>

Moving Exynos PMU specific header file into "include/linux/soc/samsung"
thus updated affected files under "mach-exynos" to use new location of
these header files.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/exynos.c                                       | 2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                                  | 2 +-
 arch/arm/mach-exynos/platsmp.c                                      | 2 +-
 arch/arm/mach-exynos/pm.c                                           | 4 ++--
 arch/arm/mach-exynos/pmu.c                                          | 6 ++----
 arch/arm/mach-exynos/suspend.c                                      | 4 ++--
 {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h    | 0
 .../regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h       | 0
 8 files changed, 9 insertions(+), 11 deletions(-)
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (100%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (100%)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2c84439..bb5c5ce 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/irqchip.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -31,7 +32,6 @@
 
 #include "common.h"
 #include "mfc.h"
-#include "regs-pmu.h"
 
 void __iomem *pmu_base_addr;
 
diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index b0d3c2e..c5e17b0 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -16,12 +16,12 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cputype.h>
 #include <asm/cp15.h>
 #include <asm/mcpm.h>
 
-#include "regs-pmu.h"
 #include "common.h"
 
 #define EXYNOS5420_CPUS_PER_CLUSTER	4
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 7a1ebfe..d6e7f49 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -20,6 +20,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -30,7 +31,6 @@
 #include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
 
 extern void exynos4_secondary_startup(void);
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index dfc8594..6acc97c 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -18,6 +18,8 @@
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
 #include <asm/firmware.h>
 #include <asm/smp_scu.h>
@@ -28,8 +30,6 @@
 #include <plat/pm-common.h>
 
 #include "common.h"
-#include "exynos-pmu.h"
-#include "regs-pmu.h"
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index c15761c..7eb5b0b 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -16,10 +16,8 @@
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
-
-
-#include "exynos-pmu.h"
-#include "regs-pmu.h"
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+#include <linux/soc/samsung/exynos-pmu.h>
 
 #define PMU_TABLE_END	(-1U)
 
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 342797b..310b89d 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -21,6 +21,8 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/err.h>
 #include <linux/regulator/machine.h>
+#include <linux/soc/samsung/exynos-pmu.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -33,8 +35,6 @@
 #include <plat/regs-srom.h>
 
 #include "common.h"
-#include "regs-pmu.h"
-#include "exynos-pmu.h"
 
 #define S5P_CHECK_SLEEP 0x00000BAD
 
diff --git a/arch/arm/mach-exynos/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
similarity index 100%
rename from arch/arm/mach-exynos/exynos-pmu.h
rename to include/linux/soc/samsung/exynos-pmu.h
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
similarity index 100%
rename from arch/arm/mach-exynos/regs-pmu.h
rename to include/linux/soc/samsung/exynos-regs-pmu.h
-- 
2.2.0

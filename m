From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:48:00 +0200
Subject: [PATCH 14/17] ARM: exynos: cpuidle: Move the boot vector in pm.c
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-15-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, move the boot vector setting in the pm.c file and use the cpu_pm
notifier to set it up.

Remove the unused headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   22 ----------------------
 arch/arm/mach-exynos/pm.c      |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 3872c1e..1916dc6 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -8,42 +8,20 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <linux/time.h>
 #include <linux/platform_device.h>
 
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
-#include <asm/unified.h>
 #include <asm/cpuidle.h>
 
 #include <plat/cpu.h>
-#include <plat/pm.h>
-
-#include <mach/pm-core.h>
-#include <mach/map.h>
 
 #include "common.h"
-#include "regs-pmu.h"
-
-#define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
-#define REG_DIRECTGO_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
-			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
 
 static int idle_finisher(unsigned long flags)
 {
-
-	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
-
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 1c9d253..47fa9bd 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -79,6 +79,14 @@
 #define EXYNOS5_PWR_CTRL2_CORE2_UP_RATIO	(1 << 4)
 #define EXYNOS5_PWR_CTRL2_CORE1_UP_RATIO	(1 << 0)
 
+#define EXYNOS_BOOT_VECTOR_ADDR (samsung_rev() == EXYNOS4210_REV_1_1 ? \
+			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
+			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
+
+#define EXYNOS_BOOT_VECTOR_FLAG (samsung_rev() == EXYNOS4210_REV_1_1 ? \
+			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
+			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
+
 static const struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001, },
 	{ .reg = EXYNOS4_CLKSRC_MASK_CAM		, .val = 0x11111111, },
@@ -189,6 +197,12 @@ static void __init exynos5_core_down_clk(void)
 	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
 }
 
+static void exynos_cpu_set_boot_vector(void)
+{
+	__raw_writel(virt_to_phys(s3c_cpu_resume), EXYNOS_BOOT_VECTOR_ADDR);
+	__raw_writel(S5P_CHECK_AFTR, EXYNOS_BOOT_VECTOR_FLAG);
+}
+
 static int exynos_cpu_suspend(unsigned long arg)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -450,6 +464,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 		exynos_pm_central_suspend();
 		exynos_cpu_save_register();
 		exynos_set_wakeupmask();
+		exynos_cpu_set_boot_vector();
 		break;
 
 	case CPU_PM_EXIT:
-- 
1.7.9.5

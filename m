From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:50 +0200
Subject: [PATCH 04/17] ARM: exynos: cpuidle: encapsulate register access
 inside a function
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That makes the code cleaner and encapsulted. The function will be reused in the
next patch.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/pm.c |   65 ++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index e00025b..2326c67 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -102,6 +102,42 @@ static struct sleep_save exynos_core_save[] = {
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
+static void exynos_cpu_save_register(void)
+{
+	unsigned long tmp;
+
+	/* Save Power control register */
+	asm ("mrc p15, 0, %0, c15, c0, 0"
+	     : "=r" (tmp) : : "cc");
+
+	save_arm_register[0] = tmp;
+
+	/* Save Diagnostic register */
+	asm ("mrc p15, 0, %0, c15, c0, 1"
+	     : "=r" (tmp) : : "cc");
+
+	save_arm_register[1] = tmp;
+}
+
+static void exynos_cpu_restore_register(void)
+{
+	unsigned long tmp;
+
+	/* Restore Power control register */
+	tmp = save_arm_register[0];
+
+	asm volatile ("mcr p15, 0, %0, c15, c0, 0"
+		      : : "r" (tmp)
+		      : "cc");
+
+	/* Restore Diagnostic register */
+	tmp = save_arm_register[1];
+
+	asm volatile ("mcr p15, 0, %0, c15, c0, 1"
+		      : : "r" (tmp)
+		      : "cc");
+}
+
 static int exynos_cpu_suspend(unsigned long arg)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -279,17 +315,8 @@ static int exynos_pm_suspend(void)
 	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
 
-	if (!soc_is_exynos5250()) {
-		/* Save Power control register */
-		asm ("mrc p15, 0, %0, c15, c0, 0"
-		     : "=r" (tmp) : : "cc");
-		save_arm_register[0] = tmp;
-
-		/* Save Diagnostic register */
-		asm ("mrc p15, 0, %0, c15, c0, 1"
-		     : "=r" (tmp) : : "cc");
-		save_arm_register[1] = tmp;
-	}
+	if (!soc_is_exynos5250())
+		exynos_cpu_save_register();
 
 	return 0;
 }
@@ -313,19 +340,9 @@ static void exynos_pm_resume(void)
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
-	if (!soc_is_exynos5250()) {
-		/* Restore Power control register */
-		tmp = save_arm_register[0];
-		asm volatile ("mcr p15, 0, %0, c15, c0, 0"
-			      : : "r" (tmp)
-			      : "cc");
-
-		/* Restore Diagnostic register */
-		tmp = save_arm_register[1];
-		asm volatile ("mcr p15, 0, %0, c15, c0, 1"
-			      : : "r" (tmp)
-			      : "cc");
-	}
+
+	if (!soc_is_exynos5250())
+		exynos_cpu_restore_register();
 
 	/* For release retention */
 
-- 
1.7.9.5

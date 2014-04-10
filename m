From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:35 +0200
Subject: [PATCH V4 04/20] ARM: exynos: cpuidle: Encapsulate register access
 inside a function
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That makes the code cleaner and encapsulted. The function will be reused in the
next patch.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/pm.c |   65 ++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 15af0ce..adfdf4b 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -103,6 +103,42 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
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
@@ -162,17 +198,8 @@ static int exynos_pm_suspend(void)
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
@@ -196,19 +223,9 @@ static void exynos_pm_resume(void)
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

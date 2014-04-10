From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:38 +0200
Subject: [PATCH V4 07/20] ARM: exynos: cpuidle: Use the cpu_pm notifier
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the cpu_pm_enter/exit notifier to group some pm code inside the pm file.

The save and restore code is duplicated across pm.c and cpuidle.c. By using
the cpu_pm notifier, we can factor out the routine.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |   24 ------------------------
 arch/arm/mach-exynos/pm.c      |   29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 6663349..7f1f4ef 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -65,26 +65,6 @@ static void exynos_set_wakeupmask(void)
 	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
 }
 
-static unsigned int g_pwr_ctrl, g_diag_reg;
-
-static void save_cpu_arch_register(void)
-{
-	/*read power control register*/
-	asm("mrc p15, 0, %0, c15, c0, 0" : "=r"(g_pwr_ctrl) : : "cc");
-	/*read diagnostic register*/
-	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
-	return;
-}
-
-static void restore_cpu_arch_register(void)
-{
-	/*write power control register*/
-	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
-	/*write diagnostic register*/
-	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
-	return;
-}
-
 static int idle_finisher(unsigned long flags)
 {
 	exynos_set_wakeupmask();
@@ -106,8 +86,6 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 {
 	unsigned long tmp;
 
-	save_cpu_arch_register();
-
 	/* Setting Central Sequence Register for power down mode */
 	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
@@ -122,8 +100,6 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 #endif
 	cpu_pm_exit();
 
-	restore_cpu_arch_register();
-
 	/*
 	 * If PMU failed while entering sleep mode, WFI will be
 	 * ignored by PMU and then exiting cpu_do_idle().
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index adfdf4b..67d75fe 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
+#include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/err.h>
@@ -321,10 +322,38 @@ static const struct platform_suspend_ops exynos_suspend_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+static int exynos_cpu_pm_notifier(struct notifier_block *self,
+				  unsigned long cmd, void *v)
+{
+	int cpu = smp_processor_id();
+
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (cpu == 0) {
+			exynos_cpu_save_register();
+		}
+		break;
+
+	case CPU_PM_EXIT:
+		if (cpu == 0) {
+			exynos_cpu_restore_register();
+		}
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block exynos_cpu_pm_notifier_block = {
+	.notifier_call = exynos_cpu_pm_notifier,
+};
+
 void __init exynos_pm_init(void)
 {
 	u32 tmp;
 
+	cpu_pm_register_notifier(&exynos_cpu_pm_notifier_block);
+
 	/* Platform-specific GIC callback */
 	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
 
-- 
1.7.9.5

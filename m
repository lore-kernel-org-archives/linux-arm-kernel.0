From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:46:56 +0530
Subject: [PATCH v9 02/12] ARM: EXYNOS: remove usage of soc_is_exynosMMMM from
 pm.c
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131421epcas5p40b0ad9c1003d3ab807667ae2b05d25bc@epcas5p4.samsung.com>
Message-ID: <1490879826-16754-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc_is_exynosMMMM is staged for removal after adopting to exynos-chipid
driver, so let's remove/minimize usage of any such helper function usage
from pm.c.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pm.c                   | 22 ++++++++++++----------
 include/linux/soc/samsung/exynos-regs-pmu.h |  3 +++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 1a7e5b5..4a73b02 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -123,11 +123,13 @@ int exynos_pm_central_resume(void)
 }
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos_set_wakeupmask(long mask)
+static void exynos_set_wakeupmask(void)
 {
-	pmu_raw_writel(mask, S5P_WAKEUP_MASK);
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250")) {
+		pmu_raw_writel(EXYNOS3_WAKEUP_MASK_VAL, S5P_WAKEUP_MASK);
 		pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
+	} else
+		pmu_raw_writel(EXYNOS_WAKEUP_MASK_VAL, S5P_WAKEUP_MASK);
 }
 
 static void exynos_cpu_set_boot_vector(long flags)
@@ -141,7 +143,7 @@ static int exynos_aftr_finisher(unsigned long flags)
 {
 	int ret;
 
-	exynos_set_wakeupmask(soc_is_exynos3250() ? 0x40003ffe : 0x0000ff3e);
+	exynos_set_wakeupmask();
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
@@ -162,7 +164,7 @@ void exynos_enter_aftr(void)
 
 	cpu_pm_enter();
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		exynos_set_boot_flag(cpuid, C2_STATE);
 
 	exynos_pm_central_suspend();
@@ -184,7 +186,7 @@ void exynos_enter_aftr(void)
 
 	exynos_pm_central_resume();
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		exynos_clear_boot_flag(cpuid, C2_STATE);
 
 	cpu_pm_exit();
@@ -255,7 +257,7 @@ static int exynos_cpu0_enter_aftr(void)
 		while (exynos_cpu_power_state(1) != S5P_CORE_LOCAL_PWR_EN)
 			cpu_relax();
 
-		if (soc_is_exynos3250()) {
+		if (of_machine_is_compatible("samsung,exynos3250")) {
 			while (!pmu_raw_readl(S5P_PMU_SPARE2) &&
 			       !atomic_read(&cpu1_wakeup))
 				cpu_relax();
@@ -277,7 +279,7 @@ static int exynos_cpu0_enter_aftr(void)
 
 			call_firmware_op(cpu_boot, 1);
 
-			if (soc_is_exynos3250())
+			if (of_machine_is_compatible("samsung,exynos3250"))
 				dsb_sev();
 			else
 				arch_send_wakeup_ipi_mask(cpumask_of(1));
@@ -289,7 +291,7 @@ static int exynos_cpu0_enter_aftr(void)
 
 static int exynos_wfi_finisher(unsigned long flags)
 {
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		flush_cache_all();
 	cpu_do_idle();
 
@@ -311,7 +313,7 @@ static int exynos_cpu1_powerdown(void)
 	 */
 	exynos_cpu_power_down(1);
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		pmu_raw_writel(0, S5P_PMU_SPARE2);
 
 	ret = cpu_suspend(0, exynos_wfi_finisher);
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 49df0a01..3a7e63f 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -50,6 +50,9 @@
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
 
+#define EXYNOS_WAKEUP_MASK_VAL			0x0000FF3E
+#define EXYNOS3_WAKEUP_MASK_VAL			0x40003FFE
+
 #define S5P_INFORM0				0x0800
 #define S5P_INFORM1				0x0804
 #define S5P_INFORM5				0x0814
-- 
2.7.4

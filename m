From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 18:38:40 +0530
Subject: [PATCH v8 5/8] ARM: EXYNOS: refactor power management specific
 routines
In-Reply-To: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1481375323-29724-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To remove dependency on soc_is_exynosMMMM macros and remove
multiple checks for such macros lets refactor code in pm.c

This patch matches SoC specific information via private data
of soc_device_attribute and initialize it at one place and then
uses it all other places

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 185 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 155 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c0b46c3..d43bea8 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
+#include <linux/sys_soc.h>
 
 #include <asm/firmware.h>
 #include <asm/smp_scu.h>
@@ -28,22 +29,49 @@
 
 #include "common.h"
 
+struct exynos_s2r_data {
+	void __iomem* (*boot_vector_addr)(void);
+	void __iomem* (*boot_vector_flag)(void);
+	void (*set_wakeupmask)(void);
+	void (*enter_aftr)(void);
+};
+
+static const struct exynos_s2r_data *s2r_data;
+
+static void __iomem *exynos4210_rev11_boot_vector_addr(void)
+{
+	return pmu_base_addr + S5P_INFORM7;
+}
+
+static void __iomem *exynos4210_rev10_boot_vector_addr(void)
+{
+	return sysram_base_addr + 0x24;
+}
+
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
-		return pmu_base_addr + S5P_INFORM7;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
-		return sysram_base_addr + 0x24;
-	return pmu_base_addr + S5P_INFORM0;
+	if (s2r_data && s2r_data->boot_vector_addr)
+		return s2r_data->boot_vector_addr();
+	else
+		return pmu_base_addr + S5P_INFORM0;
+}
+
+static void __iomem *exynos4210_rev11_boot_vector_flag(void)
+{
+	return pmu_base_addr + S5P_INFORM6;
+}
+
+static void __iomem *exynos4210_rev10_boot_vector_flag(void)
+{
+	return sysram_base_addr + 0x20;
 }
 
 static inline void __iomem *exynos_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
-		return pmu_base_addr + S5P_INFORM6;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
-		return sysram_base_addr + 0x20;
-	return pmu_base_addr + S5P_INFORM1;
+	if (s2r_data && s2r_data->boot_vector_flag)
+		return s2r_data->boot_vector_flag();
+	else
+		return pmu_base_addr + S5P_INFORM1;
 }
 
 #define S5P_CHECK_AFTR  0xFCBA0D10
@@ -120,12 +148,19 @@ int exynos_pm_central_resume(void)
 	return 0;
 }
 
+static void exynos3250_set_wakeupmask(void)
+{
+	pmu_raw_writel(0x40003ffe, S5P_WAKEUP_MASK);
+	pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
+}
+
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos_set_wakeupmask(long mask)
+static void exynos_set_wakeupmask(void)
 {
-	pmu_raw_writel(mask, S5P_WAKEUP_MASK);
-	if (soc_is_exynos3250())
-		pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
+	if (s2r_data && s2r_data->set_wakeupmask)
+		s2r_data->set_wakeupmask();
+	else
+		pmu_raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
 }
 
 static void exynos_cpu_set_boot_vector(long flags)
@@ -139,7 +174,7 @@ static int exynos_aftr_finisher(unsigned long flags)
 {
 	int ret;
 
-	exynos_set_wakeupmask(soc_is_exynos3250() ? 0x40003ffe : 0x0000ff3e);
+	exynos_set_wakeupmask();
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
@@ -154,23 +189,30 @@ static int exynos_aftr_finisher(unsigned long flags)
 	return 1;
 }
 
-void exynos_enter_aftr(void)
+static void exynos3250_enter_aftr(void)
 {
 	unsigned int cpuid = smp_processor_id();
 
 	cpu_pm_enter();
 
-	if (soc_is_exynos3250())
-		exynos_set_boot_flag(cpuid, C2_STATE);
+	exynos_set_boot_flag(cpuid, C2_STATE);
+	exynos_pm_central_suspend();
+	cpu_suspend(0, exynos_aftr_finisher);
+	exynos_pm_central_resume();
+	exynos_clear_boot_flag(cpuid, C2_STATE);
+
+	cpu_pm_exit();
+}
+
+void exynos4x12_enter_aftr(void)
+{
+	cpu_pm_enter();
 
 	exynos_pm_central_suspend();
 
-	if (of_machine_is_compatible("samsung,exynos4212") ||
-	    of_machine_is_compatible("samsung,exynos4412")) {
-		/* Setting SEQ_OPTION register */
-		pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
-			       S5P_CENTRAL_SEQ_OPTION);
-	}
+	/* Setting SEQ_OPTION register */
+	pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
+			S5P_CENTRAL_SEQ_OPTION);
 
 	cpu_suspend(0, exynos_aftr_finisher);
 
@@ -182,12 +224,95 @@ void exynos_enter_aftr(void)
 
 	exynos_pm_central_resume();
 
-	if (soc_is_exynos3250())
-		exynos_clear_boot_flag(cpuid, C2_STATE);
+	cpu_pm_exit();
+}
+
+void exynos_common_enter_aftr(void)
+{
+	cpu_pm_enter();
+
+	exynos_pm_central_suspend();
+	cpu_suspend(0, exynos_aftr_finisher);
+
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		exynos_scu_enable();
+		if (call_firmware_op(resume) == -ENOSYS)
+			exynos_cpu_restore_register();
+	}
+
+	exynos_pm_central_resume();
 
 	cpu_pm_exit();
 }
 
+void exynos_enter_aftr(void)
+{
+	if (s2r_data && s2r_data->enter_aftr)
+		s2r_data->enter_aftr();
+}
+
+static const struct exynos_s2r_data exynos_common_s2r_data = {
+	.enter_aftr		= exynos_common_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos3250_s2r_data = {
+	.set_wakeupmask		= exynos3250_set_wakeupmask,
+	.enter_aftr		= exynos3250_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos4210_rev11_s2r_data = {
+	.boot_vector_addr	= exynos4210_rev11_boot_vector_addr,
+	.boot_vector_flag	= exynos4210_rev11_boot_vector_flag,
+	.enter_aftr		= exynos_common_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos4210_rev10_s2r_data = {
+	.boot_vector_addr	= exynos4210_rev10_boot_vector_addr,
+	.boot_vector_flag	= exynos4210_rev10_boot_vector_flag,
+	.enter_aftr		= exynos_common_enter_aftr,
+};
+
+static const struct exynos_s2r_data exynos4x12_s2r_data = {
+	.enter_aftr		= exynos4x12_enter_aftr,
+};
+
+static const struct soc_device_attribute exynos_soc_revision[] = {
+	{ .soc_id = "EXYNOS3250", .data = &exynos3250_s2r_data },
+	{
+		.soc_id = "EXYNOS4210", .revision = "11",
+		.data = &exynos4210_rev11_s2r_data
+	},
+	{
+		.soc_id = "EXYNOS4210", .revision = "10",
+		.data = &exynos4210_rev10_s2r_data
+	},
+	{ .soc_id = "EXYNOS4212", .data = &exynos4x12_s2r_data },
+	{ .soc_id = "EXYNOS4412", .data = &exynos4x12_s2r_data },
+	{ .soc_id = "EXYNOS4415", .data = &exynos_common_s2r_data },
+	{ .soc_id = "EXYNOS5250", .data = &exynos_common_s2r_data },
+	{ .soc_id = "EXYNOS5260", .data = &exynos_common_s2r_data },
+	{ .soc_id = "EXYNOS5410", .data = &exynos_common_s2r_data },
+	{ .soc_id = "EXYNOS5420", .data = &exynos_common_s2r_data },
+	{ .soc_id = "EXYNOS5440", .data = &exynos_common_s2r_data },
+	{ .soc_id = "EXYNOS5800", .data = &exynos_common_s2r_data },
+};
+
+int __init exynos_s2r_init(void)
+{
+	const struct soc_device_attribute *match;
+
+	match = soc_device_match(exynos_soc_revision);
+
+	if (match)
+		s2r_data = (const struct exynos_s2r_data *) match->data;
+
+	if (!s2r_data)
+		return -ENODEV;
+
+	return 0;
+}
+arch_initcall(exynos_s2r_init);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_ARM_EXYNOS_CPUIDLE)
 static atomic_t cpu1_wakeup = ATOMIC_INIT(0);
 
@@ -253,7 +378,7 @@ static int exynos_cpu0_enter_aftr(void)
 		while (exynos_cpu_power_state(1) != S5P_CORE_LOCAL_PWR_EN)
 			cpu_relax();
 
-		if (soc_is_exynos3250()) {
+		if (of_machine_is_compatible("samsung,exynos3250")) {
 			while (!pmu_raw_readl(S5P_PMU_SPARE2) &&
 			       !atomic_read(&cpu1_wakeup))
 				cpu_relax();
@@ -275,7 +400,7 @@ static int exynos_cpu0_enter_aftr(void)
 
 			call_firmware_op(cpu_boot, 1);
 
-			if (soc_is_exynos3250())
+			if (of_machine_is_compatible("samsung,exynos3250"))
 				dsb_sev();
 			else
 				arch_send_wakeup_ipi_mask(cpumask_of(1));
@@ -287,7 +412,7 @@ static int exynos_cpu0_enter_aftr(void)
 
 static int exynos_wfi_finisher(unsigned long flags)
 {
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		flush_cache_all();
 	cpu_do_idle();
 
@@ -309,7 +434,7 @@ static int exynos_cpu1_powerdown(void)
 	 */
 	exynos_cpu_power_down(1);
 
-	if (soc_is_exynos3250())
+	if (of_machine_is_compatible("samsung,exynos3250"))
 		pmu_raw_writel(0, S5P_PMU_SPARE2);
 
 	ret = cpu_suspend(0, exynos_wfi_finisher);
-- 
2.7.4

From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 15 Nov 2018 16:11:34 +0100
Subject: [PATCH 5/9] ARM: EXYNOS: use chipid driver
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151230epcas1p35afa7ac09774a6e6256523b3a77453c3@epcas1p3.samsung.com>
Message-ID: <1542294698-17470-6-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add soc_dev_is_exynos*() helpers and use them instead of
soc_is_exynos*() ones.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/common.h   |  6 ++++++
 arch/arm/mach-exynos/exynos.c   | 39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/firmware.c |  8 ++++----
 arch/arm/mach-exynos/platsmp.c  | 12 ++++++------
 arch/arm/mach-exynos/pm.c       | 17 +++++++++--------
 5 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 1b8699e..20d205e 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -9,8 +9,14 @@
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
+#include <linux/sys_soc.h>
 #include <linux/platform_data/cpuidle-exynos.h>
 
+extern bool soc_dev_is_exynos3250(void);
+extern bool soc_dev_is_exynos4210_rev11(void);
+extern bool soc_dev_is_exynos4412(void);
+extern bool soc_dev_is_exynos542x(void);
+
 #define EXYNOS3250_SOC_ID	0xE3472000
 #define EXYNOS3_SOC_MASK	0xFFFFF000
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 865dcc4..463e457 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -24,6 +24,45 @@
 
 #include "common.h"
 
+static const struct soc_device_attribute exynos3250_soc_id[] = {
+	{ .soc_id = "EXYNOS3250" },
+	{ /* sentinel */ }
+};
+
+static const struct soc_device_attribute exynos4210_rev11_soc_id[] = {
+	{ .soc_id = "EXYNOS4210", .revision = "11" },
+	{ /* sentinel */ }
+};
+
+static const struct soc_device_attribute exynos4412_soc_id[] = {
+	{ .soc_id = "EXYNOS4412" },
+	{ /* sentinel */ }
+};
+
+static const struct soc_device_attribute exynos542x_soc_id[] = {
+	{ .soc_id = "EXYNOS5420" },
+	{ .soc_id = "EXYNOS5800" },
+	{ /* sentinel */ }
+};
+
+#define SOC_DEV_IS_EXYNOS(ver)						\
+bool soc_dev_is_exynos##ver(void)					\
+{									\
+	static bool init_done, is_exynos##ver;				\
+									\
+	if (!init_done) {						\
+		is_exynos##ver = !!soc_device_match(exynos##ver##_soc_id); \
+		init_done = true;					\
+	}								\
+									\
+	return is_exynos##ver;						\
+}
+
+SOC_DEV_IS_EXYNOS(3250);
+SOC_DEV_IS_EXYNOS(4210_rev11);
+SOC_DEV_IS_EXYNOS(4412);
+SOC_DEV_IS_EXYNOS(542x);
+
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
 #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index d602e3b..d526d5e 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -40,7 +40,7 @@ static int exynos_do_idle(unsigned long mode)
 		writel_relaxed(__pa_symbol(exynos_cpu_resume_ns),
 			       sysram_ns_base_addr + 0x24);
 		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
-		if (soc_is_exynos3250()) {
+		if (soc_dev_is_exynos3250()) {
 			flush_cache_all();
 			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
 				   SMC_POWERSTATE_IDLE, 0);
@@ -61,7 +61,7 @@ static int exynos_cpu_boot(int cpu)
 	 * Exynos3250 doesn't need to send smc command for secondary CPU boot
 	 * because Exynos3250 removes WFE in secure mode.
 	 */
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		return 0;
 
 	/*
@@ -85,7 +85,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	 * additional offset for every CPU, with Exynos4412 being the only
 	 * exception.
 	 */
-	if (soc_is_exynos4412())
+	if (soc_dev_is_exynos4412())
 		boot_reg += 4 * cpu;
 
 	writel_relaxed(boot_addr, boot_reg);
@@ -101,7 +101,7 @@ static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
 
 	boot_reg = sysram_ns_base_addr + 0x1c;
 
-	if (soc_is_exynos4412())
+	if (soc_dev_is_exynos4412())
 		boot_reg += 4 * cpu;
 
 	*boot_addr = readl_relaxed(boot_reg);
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index c39ffd2..e2ba70f 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -88,7 +88,7 @@ void exynos_cpu_power_down(int cpu)
 {
 	u32 core_conf;
 
-	if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
+	if (cpu == 0 && soc_dev_is_exynos542x()) {
 		/*
 		 * Bypass power down for CPU0 during suspend. Check for
 		 * the SYS_PWR_REG value to decide if we are suspending
@@ -115,7 +115,7 @@ void exynos_cpu_power_up(int cpu)
 {
 	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
 
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		core_conf |= S5P_CORE_AUTOWAKEUP_EN;
 
 	pmu_raw_writel(core_conf,
@@ -185,7 +185,7 @@ void exynos_scu_enable(void)
 
 static void __iomem *cpu_boot_reg_base(void)
 {
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
+	if (soc_dev_is_exynos4210_rev11())
 		return pmu_base_addr + S5P_INFORM5;
 	return sysram_base_addr;
 }
@@ -197,9 +197,9 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 	boot_reg = cpu_boot_reg_base();
 	if (!boot_reg)
 		return IOMEM_ERR_PTR(-ENODEV);
-	if (soc_is_exynos4412())
+	if (soc_dev_is_exynos4412())
 		boot_reg += 4*cpu;
-	else if (soc_is_exynos5420() || soc_is_exynos5800())
+	else if (soc_dev_is_exynos542x())
 		boot_reg += 4;
 	return boot_reg;
 }
@@ -371,7 +371,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		call_firmware_op(cpu_boot, core_id);
 
-		if (soc_is_exynos3250())
+		if (soc_dev_is_exynos3250())
 			dsb_sev();
 		else
 			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 48e7fb3..88c1bce 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -120,7 +120,7 @@ int exynos_pm_central_resume(void)
 static void exynos_set_wakeupmask(long mask)
 {
 	pmu_raw_writel(mask, S5P_WAKEUP_MASK);
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		pmu_raw_writel(0x0, S5P_WAKEUP_MASK2);
 }
 
@@ -135,7 +135,8 @@ static int exynos_aftr_finisher(unsigned long flags)
 {
 	int ret;
 
-	exynos_set_wakeupmask(soc_is_exynos3250() ? 0x40003ffe : 0x0000ff3e);
+	exynos_set_wakeupmask(soc_dev_is_exynos3250() ? 0x40003ffe
+						      : 0x0000ff3e);
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
@@ -156,12 +157,12 @@ void exynos_enter_aftr(void)
 
 	cpu_pm_enter();
 
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		exynos_set_boot_flag(cpuid, C2_STATE);
 
 	exynos_pm_central_suspend();
 
-	if (soc_is_exynos4412()) {
+	if (soc_dev_is_exynos4412()) {
 		/* Setting SEQ_OPTION register */
 		pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
 			       S5P_CENTRAL_SEQ_OPTION);
@@ -177,7 +178,7 @@ void exynos_enter_aftr(void)
 
 	exynos_pm_central_resume();
 
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		exynos_clear_boot_flag(cpuid, C2_STATE);
 
 	cpu_pm_exit();
@@ -248,7 +249,7 @@ static int exynos_cpu0_enter_aftr(void)
 		while (exynos_cpu_power_state(1) != S5P_CORE_LOCAL_PWR_EN)
 			cpu_relax();
 
-		if (soc_is_exynos3250()) {
+		if (soc_dev_is_exynos3250()) {
 			while (!pmu_raw_readl(S5P_PMU_SPARE2) &&
 			       !atomic_read(&cpu1_wakeup))
 				cpu_relax();
@@ -278,7 +279,7 @@ static int exynos_cpu0_enter_aftr(void)
 
 static int exynos_wfi_finisher(unsigned long flags)
 {
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		flush_cache_all();
 	cpu_do_idle();
 
@@ -300,7 +301,7 @@ static int exynos_cpu1_powerdown(void)
 	 */
 	exynos_cpu_power_down(1);
 
-	if (soc_is_exynos3250())
+	if (soc_dev_is_exynos3250())
 		pmu_raw_writel(0, S5P_PMU_SPARE2);
 
 	ret = cpu_suspend(0, exynos_wfi_finisher);
-- 
1.9.1

From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 07 Jul 2014 18:31:30 +0530
Subject: [PATCH v6 2/4] ARM: EXYNOS: Refactor the code to use DT based lookup
Message-ID: <1404738090-30522-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactoring the pm.c to avoid using "soc_is_exynos" checks,
instead use the DT based lookup.

While at it, consolidate the common code across SoCs
and create a static helper functions.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/pm.c       |  232 +++++++++++++++++++++++++++++++--------
 arch/arm/mach-exynos/regs-pmu.h |    1 +
 2 files changed, 189 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index ba75171..c0dae28 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -38,6 +38,8 @@
 #include "regs-pmu.h"
 #include "regs-sys.h"
 
+#define REG_TABLE_END (-1U)
+
 /**
  * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
  * @hwirq: Hardware IRQ signal of the GIC
@@ -61,6 +63,19 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
+struct exynos_pm_data {
+	const struct exynos_wkup_irq *wkup_irq;
+	unsigned int wake_disable_mask;
+	unsigned int *release_ret_regs;
+
+	void (*pm_prepare)(void);
+	void (*pm_resume)(void);
+	int (*pm_suspend)(void);
+	int (*cpu_suspend)(unsigned long);
+};
+
+struct exynos_pm_data *pm_data;
+
 /*
  * GIC wake-up support
  */
@@ -89,14 +104,21 @@ static inline u32 pmu_raw_readl(u32 offset)
 	return __raw_readl(pmu_base_addr + offset);
 }
 
+unsigned int exynos_release_ret_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+	REG_TABLE_END,
+};
+
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
-
-	if (soc_is_exynos5250())
-		wkup_irq = exynos5250_wkup_irq;
-	else
-		wkup_irq = exynos4_wkup_irq;
+	wkup_irq = pm_data->wkup_irq;
 
 	while (wkup_irq->mask) {
 		if (wkup_irq->hwirq == data->hwirq) {
@@ -253,13 +275,13 @@ static void exynos_cpu_restore_register(void)
 
 static int exynos_cpu_suspend(unsigned long arg)
 {
-#ifdef CONFIG_CACHE_L2X0
-	outer_flush_all();
-#endif
-
-	if (soc_is_exynos5250())
-		flush_cache_all();
+	if (pm_data->cpu_suspend)
+		return pm_data->cpu_suspend(arg);
+	return -1;
+}
 
+static int exynos_cpu_do_idle(void)
+{
 	/* issue the standby signal into the pm unit. */
 	cpu_do_idle();
 
@@ -269,32 +291,73 @@ static int exynos_cpu_suspend(unsigned long arg)
 
 static void exynos_pm_prepare(void)
 {
-	unsigned int tmp;
+	if (pm_data->pm_prepare)
+		pm_data->pm_prepare();
+}
+
+static int exynos4_cpu_suspend(unsigned long arg)
+{
+#ifdef CONFIG_CACHE_L2X0
+	outer_flush_all();
+#endif
+	return exynos_cpu_do_idle();
+}
+
+static int exynos5250_cpu_suspend(unsigned long arg)
+{
+#ifdef CONFIG_CACHE_L2X0
+	outer_flush_all();
+#endif
+	flush_cache_all();
+	return exynos_cpu_do_idle();
+}
 
+static void exynos_pm_set_wakeup_mask(void)
+{
 	/* Set wake-up mask registers */
 	pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
 	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
+}
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
-	if (soc_is_exynos5250()) {
-		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
-		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
-		tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
-		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
-		pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
-	}
-
+static void exynos_pm_enter_sleep_mode(void)
+{
 	/* Set value of power down register for sleep mode */
-
 	exynos_sys_powerdown_conf(SYS_SLEEP);
 	pmu_raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
 
 	/* ensure@least INFORM0 has the resume address */
-
 	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
 }
 
+static void exynos5250_pm_prepare(void)
+{
+	unsigned int tmp;
+
+	/* Set wake-up mask registers */
+	exynos_pm_set_wakeup_mask();
+
+	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+
+	s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
+
+	/* Disable USE_RETENTION of JPEG_MEM_OPTION */
+	tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
+	tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
+	pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
+
+	exynos_pm_enter_sleep_mode();
+}
+
+static void exynos4_pm_prepare(void)
+{
+	/* Set wake-up mask registers */
+	exynos_pm_set_wakeup_mask();
+
+	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+
+	exynos_pm_enter_sleep_mode();
+}
+
 static void exynos_pm_central_suspend(void)
 {
 	unsigned long tmp;
@@ -307,6 +370,13 @@ static void exynos_pm_central_suspend(void)
 
 static int exynos_pm_suspend(void)
 {
+	if (pm_data->pm_suspend)
+		return pm_data->pm_suspend();
+	return -1;
+}
+
+static int exynos4_pm_suspend(void)
+{
 	unsigned long tmp;
 
 	exynos_pm_central_suspend();
@@ -316,9 +386,20 @@ static int exynos_pm_suspend(void)
 	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
 	pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_save_register();
+	exynos_cpu_save_register();
+	return 0;
+}
+
+static int exynos5250_pm_suspend(void)
+{
+	unsigned long tmp;
+
+	exynos_pm_central_suspend();
+
+	/* Setting SEQ_OPTION register */
 
+	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+	pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
 	return 0;
 }
 
@@ -345,39 +426,57 @@ static int exynos_pm_central_resume(void)
 	return 0;
 }
 
+static void exynos_pm_set_release_retention(void)
+{
+	unsigned int i;
+
+	for (i = 0; (pm_data->release_ret_regs[i] != REG_TABLE_END); i++)
+		pmu_raw_writel(EXYNOS_WAKEUP_FROM_LOWPWR,
+				pm_data->release_ret_regs[i]);
+}
+
 static void exynos_pm_resume(void)
 {
+	if (pm_data->pm_resume)
+		pm_data->pm_resume();
+}
+
+static void exynos4_pm_resume(void)
+{
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-		exynos_cpu_restore_register();
+	exynos_cpu_restore_register();
 
 	/* For release retention */
-
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
-
-	if (soc_is_exynos5250())
-		s3c_pm_do_restore(exynos5_sys_save,
-			ARRAY_SIZE(exynos5_sys_save));
+	exynos_pm_set_release_retention();
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
-		scu_enable(S5P_VA_SCU);
+	scu_enable(S5P_VA_SCU);
 
 early_wakeup:
 
 	/* Clear SLEEP mode set in INFORM1 */
 	pmu_raw_writel(0x0, S5P_INFORM1);
+}
+
+static void exynos5250_pm_resume(void)
+{
+	if (exynos_pm_central_resume())
+		goto early_wakeup;
 
-	return;
+	/* For release retention */
+	exynos_pm_set_release_retention();
+
+	s3c_pm_do_restore(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
+
+	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+
+early_wakeup:
+
+	/* Clear SLEEP mode set in INFORM1 */
+	pmu_raw_writel(0x0, S5P_INFORM1);
 }
 
 static struct syscore_ops exynos_pm_syscore_ops = {
@@ -480,18 +579,63 @@ static struct notifier_block exynos_cpu_pm_notifier_block = {
 	.notifier_call = exynos_cpu_pm_notifier,
 };
 
+static struct exynos_pm_data exynos4_pm_data = {
+	.wkup_irq	= exynos4_wkup_irq,
+	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
+	.release_ret_regs = exynos_release_ret_regs,
+	.pm_suspend	= exynos4_pm_suspend,
+	.pm_resume	= exynos4_pm_resume,
+	.pm_prepare	= exynos4_pm_prepare,
+	.cpu_suspend	= exynos4_cpu_suspend,
+};
+
+static struct exynos_pm_data exynos5250_pm_data = {
+	.wkup_irq	= exynos5250_wkup_irq,
+	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
+	.release_ret_regs = exynos_release_ret_regs,
+	.pm_suspend	= exynos5250_pm_suspend,
+	.pm_resume	= exynos5250_pm_resume,
+	.pm_prepare	= exynos5250_pm_prepare,
+	.cpu_suspend	= exynos5250_cpu_suspend,
+};
+
+static struct of_device_id exynos_pmu_of_device_ids[] = {
+	{
+		.compatible = "samsung,exynos4210-pmu",
+		.data = (void *)&exynos4_pm_data,
+	}, {
+		.compatible = "samsung,exynos4212-pmu",
+		.data = (void *)&exynos4_pm_data,
+	}, {
+		.compatible = "samsung,exynos4412-pmu",
+		.data = (void *)&exynos4_pm_data,
+	}, {
+		.compatible = "samsung,exynos5250-pmu",
+		.data = (void *)&exynos5250_pm_data,
+	},
+	{ /*sentinel*/ },
+};
+
 void __init exynos_pm_init(void)
 {
 	u32 tmp;
+	const struct of_device_id *match;
 
 	cpu_pm_register_notifier(&exynos_cpu_pm_notifier_block);
 
+	of_find_matching_node_and_match(NULL, exynos_pmu_of_device_ids, &match);
+
+	if (!match)
+		panic("Failed to find PMU node\n");
+
+	pm_data = (struct exynos_pm_data *) match->data;
+
 	/* Platform-specific GIC callback */
 	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
 
 	/* All wakeup disable */
 	tmp = pmu_raw_readl(S5P_WAKEUP_MASK);
-	tmp |= ((0xFF << 8) | (0x1F << 1));
+	tmp |= pm_data->wake_disable_mask;
 	pmu_raw_writel(tmp, S5P_WAKEUP_MASK);
 
 	register_syscore_ops(&exynos_pm_syscore_ops);
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 9b46a52..3a6a559 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -21,6 +21,7 @@
 #define S5P_USE_STANDBY_WFI0			(1 << 16)
 #define S5P_USE_STANDBY_WFE0			(1 << 24)
 
+#define EXYNOS_WAKEUP_FROM_LOWPWR		(1 << 28)
 #define EXYNOS_SWRESET				0x0400
 #define EXYNOS5440_SWRESET			0x00C4
 
-- 
1.7.9.5

From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 08 Jan 2015 10:50:38 +0900
Subject: [RESEND PATCH] ARM: EXYNOS: Add exynos3250 suspend-to-ram support
Message-ID: <1420681838-4292-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for suspend-to-ram feature of Exynos3250 SoC.
Exynos3250 don't contain the L2 cache.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Depend on:
- v3.19-rc3

 arch/arm/mach-exynos/regs-pmu.h |  3 ++
 arch/arm/mach-exynos/suspend.c  | 77 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index b5f4406..eb461e1 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -160,12 +160,14 @@
 #define EXYNOS5_L2RSTDISABLE_VALUE		BIT(3)
 
 #define S5P_PAD_RET_MAUDIO_OPTION		0x3028
+#define S5P_PAD_RET_MMC2_OPTION			0x30c8
 #define S5P_PAD_RET_GPIO_OPTION			0x3108
 #define S5P_PAD_RET_UART_OPTION			0x3128
 #define S5P_PAD_RET_MMCA_OPTION			0x3148
 #define S5P_PAD_RET_MMCB_OPTION			0x3168
 #define S5P_PAD_RET_EBIA_OPTION			0x3188
 #define S5P_PAD_RET_EBIB_OPTION			0x31A8
+#define S5P_PAD_RET_SPI_OPTION			0x31c8
 
 #define S5P_PS_HOLD_CONTROL			0x330C
 #define S5P_PS_HOLD_EN				(1 << 31)
@@ -326,6 +328,7 @@
 			(EXYNOS3_ARM_CORE0_OPTION + ((_nr) * 0x80))
 
 #define EXYNOS3_ARM_COMMON_OPTION			0x2408
+#define EXYNOS3_ARM_L2_OPTION				0x2608
 #define EXYNOS3_TOP_PWR_OPTION				0x2C48
 #define EXYNOS3_CORE_TOP_PWR_OPTION			0x2CA8
 #define EXYNOS3_XUSBXTI_DURATION			0x341C
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f8e7dcd..d6feef3 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -91,6 +91,12 @@ static unsigned int exynos_pmu_spare3;
 
 static u32 exynos_irqwake_intmask = 0xffffffff;
 
+static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
+	{ 73, BIT(1) }, /* RTC alarm */
+	{ 74, BIT(2) }, /* RTC tick */
+	{ /* sentinel */ },
+};
+
 static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
 	{ 76, BIT(1) }, /* RTC alarm */
 	{ 77, BIT(2) }, /* RTC tick */
@@ -114,6 +120,19 @@ unsigned int exynos_release_ret_regs[] = {
 	REG_TABLE_END,
 };
 
+unsigned int exynos3250_release_ret_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+	S5P_PAD_RET_MMC2_OPTION,
+	S5P_PAD_RET_SPI_OPTION,
+	REG_TABLE_END,
+};
+
 unsigned int exynos5420_release_ret_regs[] = {
 	EXYNOS_PAD_RET_DRAM_OPTION,
 	EXYNOS_PAD_RET_MAUDIO_OPTION,
@@ -173,6 +192,12 @@ static int exynos_cpu_suspend(unsigned long arg)
 	return exynos_cpu_do_idle();
 }
 
+static int exynos3250_cpu_suspend(unsigned long arg)
+{
+	flush_cache_all();
+	return exynos_cpu_do_idle();
+}
+
 static int exynos5420_cpu_suspend(unsigned long arg)
 {
 	/* MCPM works with HW CPU identifiers */
@@ -230,6 +255,23 @@ static void exynos_pm_prepare(void)
 	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
 }
 
+static void exynos3250_pm_prepare(void)
+{
+	unsigned int tmp;
+
+	/* Set wake-up mask registers */
+	exynos_pm_set_wakeup_mask();
+
+	tmp = pmu_raw_readl(EXYNOS3_ARM_L2_OPTION);
+	tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
+	pmu_raw_writel(tmp, EXYNOS3_ARM_L2_OPTION);
+
+	exynos_pm_enter_sleep_mode();
+
+	/* ensure@least INFORM0 has the resume address */
+	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
+}
+
 static void exynos5420_pm_prepare(void)
 {
 	unsigned int tmp;
@@ -344,6 +386,28 @@ early_wakeup:
 	pmu_raw_writel(0x0, S5P_INFORM1);
 }
 
+static void exynos3250_pm_resume(void)
+{
+	u32 cpuid = read_cpuid_part();
+
+	if (exynos_pm_central_resume())
+		goto early_wakeup;
+
+	/* For release retention */
+	exynos_pm_release_retention();
+
+	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
+
+	if (call_firmware_op(resume) == -ENOSYS
+	    && cpuid == ARM_CPU_PART_CORTEX_A9)
+		exynos_cpu_restore_register();
+
+early_wakeup:
+
+	/* Clear SLEEP mode set in INFORM1 */
+	pmu_raw_writel(0x0, S5P_INFORM1);
+}
+
 static void exynos5420_prepare_pm_resume(void)
 {
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM))
@@ -483,6 +547,16 @@ static const struct platform_suspend_ops exynos_suspend_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+static const struct exynos_pm_data exynos3250_pm_data = {
+	.wkup_irq	= exynos3250_wkup_irq,
+	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
+	.release_ret_regs = exynos3250_release_ret_regs,
+	.pm_suspend	= exynos_pm_suspend,
+	.pm_resume	= exynos3250_pm_resume,
+	.pm_prepare	= exynos3250_pm_prepare,
+	.cpu_suspend	= exynos3250_cpu_suspend,
+};
+
 static const struct exynos_pm_data exynos4_pm_data = {
 	.wkup_irq	= exynos4_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
@@ -518,6 +592,9 @@ static struct exynos_pm_data exynos5420_pm_data = {
 
 static struct of_device_id exynos_pmu_of_device_ids[] = {
 	{
+		.compatible = "samsung,exynos3250-pmu",
+		.data = &exynos3250_pm_data,
+	}, {
 		.compatible = "samsung,exynos4210-pmu",
 		.data = &exynos4_pm_data,
 	}, {
-- 
1.8.5.5

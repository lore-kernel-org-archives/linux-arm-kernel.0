From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 21 Aug 2014 18:44:42 +0545
Subject: [PATCH v7 2/2] ARM: exynos5: Add Suspend-to-RAM support for 5420
In-Reply-To: <1408625982-3267-1-git-send-email-vikas.sajjan@samsung.com>
References: <1408625982-3267-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1408625982-3267-3-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

Adds Suspend-to-RAM support for EXYNOS5420

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/pm.c |  149 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 4153b5d..b6a957d 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -39,6 +39,8 @@
 
 #define REG_TABLE_END (-1U)
 
+#define EXYNOS5420_CPU_STATE	0x28
+
 /**
  * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
  * @hwirq: Hardware IRQ signal of the GIC
@@ -77,6 +79,9 @@ struct exynos_pm_data {
 
 struct exynos_pm_data *pm_data;
 
+static int exynos5420_cpu_state;
+static unsigned int exynos_pmu_spare3;
+
 /*
  * GIC wake-up support
  */
@@ -106,6 +111,23 @@ unsigned int exynos_release_ret_regs[] = {
 	REG_TABLE_END,
 };
 
+unsigned int exynos5420_release_ret_regs[] = {
+	EXYNOS_PAD_RET_DRAM_OPTION,
+	EXYNOS_PAD_RET_MAUDIO_OPTION,
+	EXYNOS_PAD_RET_JTAG_OPTION,
+	EXYNOS5420_PAD_RET_GPIO_OPTION,
+	EXYNOS5420_PAD_RET_UART_OPTION,
+	EXYNOS5420_PAD_RET_MMCA_OPTION,
+	EXYNOS5420_PAD_RET_MMCB_OPTION,
+	EXYNOS5420_PAD_RET_MMCC_OPTION,
+	EXYNOS5420_PAD_RET_HSI_OPTION,
+	EXYNOS_PAD_RET_EBIA_OPTION,
+	EXYNOS_PAD_RET_EBIB_OPTION,
+	EXYNOS5420_PAD_RET_SPI_OPTION,
+	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
+	REG_TABLE_END,
+};
+
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
@@ -266,10 +288,22 @@ static int exynos_cpu_do_idle(void)
 	return 1; /* Aborting suspend */
 }
 
-static int exynos_cpu_suspend(unsigned long arg)
+static void exynos_flush_cache_all(void)
 {
 	flush_cache_all();
 	outer_flush_all();
+}
+
+static int exynos_cpu_suspend(unsigned long arg)
+{
+	exynos_flush_cache_all();
+	return exynos_cpu_do_idle();
+}
+
+static int exynos5420_cpu_suspend(unsigned long arg)
+{
+	exynos_flush_cache_all();
+	__raw_writel(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
 	return exynos_cpu_do_idle();
 }
 
@@ -304,6 +338,49 @@ static void exynos_pm_prepare(void)
 	exynos_pm_enter_sleep_mode();
 }
 
+static void exynos5420_pm_prepare(void)
+{
+	unsigned int tmp;
+
+	/* Set wake-up mask registers */
+	exynos_pm_set_wakeup_mask();
+
+	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+
+	exynos_pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
+	/*
+	 * The cpu state needs to be saved and restored so that the
+	 * secondary CPUs will enter low power start. Though the U-Boot
+	 * is setting the cpu state with low power flag, the kernel
+	 * needs to restore it back in case, the primary cpu fails to
+	 * suspend for any reason.
+	 */
+	exynos5420_cpu_state = __raw_readl(sysram_base_addr +
+						EXYNOS5420_CPU_STATE);
+
+	exynos_pm_enter_sleep_mode();
+
+	tmp = pmu_raw_readl(EXYNOS5_ARM_L2_OPTION);
+	tmp &= ~EXYNOS5_USE_RETENTION;
+	pmu_raw_writel(tmp, EXYNOS5_ARM_L2_OPTION);
+
+	tmp = pmu_raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
+	tmp |= EXYNOS5420_UFS;
+	pmu_raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
+
+	tmp = pmu_raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
+	tmp &= ~EXYNOS5420_L2RSTDISABLE_VALUE;
+	pmu_raw_writel(tmp, EXYNOS5420_ARM_COMMON_OPTION);
+
+	tmp = pmu_raw_readl(EXYNOS5420_FSYS2_OPTION);
+	tmp |= EXYNOS5420_EMULATION;
+	pmu_raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
+
+	tmp = pmu_raw_readl(EXYNOS5420_PSGEN_OPTION);
+	tmp |= EXYNOS5420_EMULATION;
+	pmu_raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
+}
+
 static int exynos_pm_suspend(void)
 {
 	unsigned long tmp;
@@ -321,6 +398,24 @@ static int exynos_pm_suspend(void)
 	return 0;
 }
 
+static int exynos5420_pm_suspend(void)
+{
+	u32 this_cluster;
+
+	exynos_pm_central_suspend();
+
+	/* Setting SEQ_OPTION register */
+
+	this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
+	if (!this_cluster)
+		pmu_raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
+				S5P_CENTRAL_SEQ_OPTION);
+	else
+		pmu_raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
+				S5P_CENTRAL_SEQ_OPTION);
+	return 0;
+}
+
 static void exynos_pm_release_retention(void)
 {
 	unsigned int i;
@@ -356,6 +451,45 @@ early_wakeup:
 	pmu_raw_writel(0x0, S5P_INFORM1);
 }
 
+static void exynos5420_pm_resume(void)
+{
+	unsigned long tmp;
+
+	/* Restore the sysram cpu state register */
+	__raw_writel(exynos5420_cpu_state,
+		sysram_base_addr + EXYNOS5420_CPU_STATE);
+
+	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
+			S5P_CENTRAL_SEQ_OPTION);
+
+	if (exynos_pm_central_resume())
+		goto early_wakeup;
+
+	/* For release retention */
+	exynos_pm_release_retention();
+
+	pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
+
+	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+
+early_wakeup:
+
+	tmp = pmu_raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
+	tmp &= ~EXYNOS5420_UFS;
+	pmu_raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
+
+	tmp = pmu_raw_readl(EXYNOS5420_FSYS2_OPTION);
+	tmp &= ~EXYNOS5420_EMULATION;
+	pmu_raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
+
+	tmp = pmu_raw_readl(EXYNOS5420_PSGEN_OPTION);
+	tmp &= ~EXYNOS5420_EMULATION;
+	pmu_raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
+
+	/* Clear SLEEP mode set in INFORM1 */
+	pmu_raw_writel(0x0, S5P_INFORM1);
+}
+
 /*
  * Suspend Ops
  */
@@ -441,6 +575,16 @@ static const struct exynos_pm_data exynos5250_pm_data = {
 	.cpu_suspend	= exynos_cpu_suspend,
 };
 
+static struct exynos_pm_data exynos5420_pm_data = {
+	.wkup_irq	= exynos5250_wkup_irq,
+	.wake_disable_mask = (0x7F << 7) | (0x1F << 1),
+	.release_ret_regs = exynos5420_release_ret_regs,
+	.pm_resume	= exynos5420_pm_resume,
+	.pm_suspend	= exynos5420_pm_suspend,
+	.pm_prepare	= exynos5420_pm_prepare,
+	.cpu_suspend	= exynos5420_cpu_suspend,
+};
+
 static struct of_device_id exynos_pmu_of_device_ids[] = {
 	{
 		.compatible = "samsung,exynos4210-pmu",
@@ -454,6 +598,9 @@ static struct of_device_id exynos_pmu_of_device_ids[] = {
 	}, {
 		.compatible = "samsung,exynos5250-pmu",
 		.data = &exynos5250_pm_data,
+	}, {
+		.compatible = "samsung,exynos5420-pmu",
+		.data = &exynos5420_pm_data,
 	},
 	{ /*sentinel*/ },
 };
-- 
1.7.9.5

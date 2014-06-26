From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 26 Jun 2014 16:42:14 +0530
Subject: [PATCH v5 2/3] arm: exynos5: Add Suspend-to-RAM support for 5420
In-Reply-To: <1403781135-6538-1-git-send-email-vikas.sajjan@samsung.com>
References: <1403781135-6538-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1403781135-6538-3-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

Adds Suspend-to-RAM support for EXYNOS5420

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/pm.c |  150 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 134 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index de61d48..bf8564a 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -38,9 +38,13 @@
 #include "regs-pmu.h"
 #include "regs-sys.h"
 
+#define EXYNOS5420_CPU_STATE	0x28
+
 #define pmu_raw_writel(val, offset) \
 		__raw_writel(val, pmu_base_addr + offset)
 
+static int exynos5420_cpu_state;
+
 /**
  * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
  * @hwirq: Hardware IRQ signal of the GIC
@@ -64,6 +68,10 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
+static struct sleep_save exynos5420_pmu_reg_save[] = {
+	SAVE_ITEM((void __iomem *)S5P_PMU_SPARE3),
+};
+
 /*
  * GIC wake-up support
  */
@@ -86,7 +94,7 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		wkup_irq = exynos5250_wkup_irq;
 	else
 		wkup_irq = exynos4_wkup_irq;
@@ -250,7 +258,16 @@ static int exynos_cpu_suspend(unsigned long arg)
 	outer_flush_all();
 #endif
 
-	if (soc_is_exynos5250())
+	/*
+	 * Clear sysram register for cpu state so that primary CPU does
+	 * not enter low power start in U-Boot.
+	 * This is specific to exynos5420 SoC only.
+	 */
+	if (soc_is_exynos5420())
+		__raw_writel(0x0,
+			sysram_base_addr + EXYNOS5420_CPU_STATE);
+
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -276,6 +293,22 @@ static void exynos_pm_prepare(void)
 		tmp = __raw_readl(pmu_base_addr + EXYNOS5_JPEG_MEM_OPTION);
 		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
 		pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
+	} else if (soc_is_exynos5420()) {
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(exynos5420_pmu_reg_save); i++)
+			exynos5420_pmu_reg_save[i].val =
+				__raw_readl(pmu_base_addr +
+				(unsigned int)exynos5420_pmu_reg_save[i].reg);
+		/*
+		 * The cpu state needs to be saved and restored so that the
+		 * secondary CPUs will enter low power start. Though the U-Boot
+		 * is setting the cpu state with low power flag, the kernel
+		 * needs to restore it back in case, the primary cpu fails to
+		 * suspend for any reason.
+		 */
+		exynos5420_cpu_state =
+		__raw_readl(sysram_base_addr + EXYNOS5420_CPU_STATE);
 	}
 
 	/* Set value of power down register for sleep mode */
@@ -286,6 +319,27 @@ static void exynos_pm_prepare(void)
 	/* ensure@least INFORM0 has the resume address */
 
 	pmu_raw_writel(virt_to_phys(exynos_cpu_resume), S5P_INFORM0);
+
+	if (soc_is_exynos5420()) {
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5_ARM_L2_OPTION);
+		tmp &= ~EXYNOS5_USE_RETENTION;
+		pmu_raw_writel(tmp, EXYNOS5_ARM_L2_OPTION);
+
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5420_SFR_AXI_CGDIS1);
+		tmp |= EXYNOS5420_UFS;
+		pmu_raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
+
+		tmp = __raw_readl(pmu_base_addr +
+				EXYNOS5420_ARM_COMMON_OPTION);
+		tmp &= ~EXYNOS5420_L2RSTDISABLE_VALUE;
+		pmu_raw_writel(tmp, EXYNOS5420_ARM_COMMON_OPTION);
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5420_FSYS2_OPTION);
+		tmp |= EXYNOS5420_EMULATION;
+		pmu_raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5420_PSGEN_OPTION);
+		tmp |= EXYNOS5420_EMULATION;
+		pmu_raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
+	}
 }
 
 static void exynos_pm_central_suspend(void)
@@ -301,13 +355,24 @@ static void exynos_pm_central_suspend(void)
 static int exynos_pm_suspend(void)
 {
 	unsigned long tmp;
+	unsigned int  this_cluster;
 
 	exynos_pm_central_suspend();
 
 	/* Setting SEQ_OPTION register */
 
-	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
-	pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	if (soc_is_exynos5420()) {
+		this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
+		if (!this_cluster)
+			pmu_raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
+					S5P_CENTRAL_SEQ_OPTION);
+		else
+			pmu_raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
+					S5P_CENTRAL_SEQ_OPTION);
+	} else {
+		tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+		pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	}
 
 	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		exynos_cpu_save_register();
@@ -340,6 +405,17 @@ static int exynos_pm_central_resume(void)
 
 static void exynos_pm_resume(void)
 {
+	unsigned int tmp;
+
+	if (soc_is_exynos5420()) {
+		/* Restore the sysram cpu state register */
+		__raw_writel(exynos5420_cpu_state,
+		sysram_base_addr + EXYNOS5420_CPU_STATE);
+
+		pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
+				S5P_CENTRAL_SEQ_OPTION);
+	}
+
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
@@ -347,18 +423,42 @@ static void exynos_pm_resume(void)
 		exynos_cpu_restore_register();
 
 	/* For release retention */
+	if (soc_is_exynos5420()) {
+		pmu_raw_writel((1 << 28), EXYNOS_PAD_RET_DRAM_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS_PAD_RET_MAUDIO_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS_PAD_RET_JTAG_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_GPIO_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_UART_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCA_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCB_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCC_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_HSI_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS_PAD_RET_EBIA_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS_PAD_RET_EBIB_OPTION);
+		pmu_raw_writel((1 << 28), EXYNOS5420_PAD_RET_SPI_OPTION);
+		pmu_raw_writel((1 << 28),
+				EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION);
+	} else {
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
+		pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
+	}
 
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
-	pmu_raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
-
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250()) {
 		s3c_pm_do_restore(exynos5_sys_save,
 			ARRAY_SIZE(exynos5_sys_save));
+	} else if (soc_is_exynos5420()) {
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(exynos5420_pmu_reg_save); i++)
+			pmu_raw_writel(
+			(unsigned int)exynos5420_pmu_reg_save[i].val,
+			(unsigned int)exynos5420_pmu_reg_save[i].reg);
+	}
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
@@ -367,6 +467,18 @@ static void exynos_pm_resume(void)
 
 early_wakeup:
 
+	if (soc_is_exynos5420()) {
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5420_SFR_AXI_CGDIS1);
+		tmp &= ~EXYNOS5420_UFS;
+		pmu_raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5420_FSYS2_OPTION);
+		tmp &= ~EXYNOS5420_EMULATION;
+		pmu_raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
+		tmp = __raw_readl(pmu_base_addr + EXYNOS5420_PSGEN_OPTION);
+		tmp &= ~EXYNOS5420_EMULATION;
+		pmu_raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
+	}
+
 	/* Clear SLEEP mode set in INFORM1 */
 	pmu_raw_writel(0x0, S5P_INFORM1);
 
@@ -483,9 +595,15 @@ void __init exynos_pm_init(void)
 	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
 
 	/* All wakeup disable */
-	tmp = __raw_readl(pmu_base_addr + S5P_WAKEUP_MASK);
-	tmp |= ((0xFF << 8) | (0x1F << 1));
-	pmu_raw_writel(tmp, S5P_WAKEUP_MASK);
+	if (soc_is_exynos5420()) {
+		tmp = __raw_readl(pmu_base_addr + S5P_WAKEUP_MASK);
+		tmp |= ((0x7F << 7) | (0x1F << 1));
+		pmu_raw_writel(tmp, S5P_WAKEUP_MASK);
+	} else {
+		tmp = __raw_readl(pmu_base_addr + S5P_WAKEUP_MASK);
+		tmp |= ((0xFF << 8) | (0x1F << 1));
+		pmu_raw_writel(tmp, S5P_WAKEUP_MASK);
+	}
 
 	register_syscore_ops(&exynos_pm_syscore_ops);
 	suspend_set_ops(&exynos_suspend_ops);
-- 
1.7.9.5

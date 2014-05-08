From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 08 May 2014 16:22:48 +0530
Subject: [PATCH V3 2/3] ARM: EXYNOS5: Add Suspend-to-RAM support for 5420
Message-ID: <1399546368-30537-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds Suspend-to-RAM support for EXYNOS5420

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/pm.c       |  163 ++++++++++++++++++++++++++++++++++-----
 arch/arm/mach-exynos/regs-pmu.h |    2 +
 2 files changed, 146 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index a7a1b7f..87ccac7 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -40,6 +40,9 @@
 #include "regs-sys.h"
 #include "exynos-pmu.h"
 
+#define EXYNOS5420_VA_CPU_STATE (S5P_VA_SYSRAM + 0x28)
+#define EXYNOS5420_VA_CPU_ADDR  (S5P_VA_SYSRAM_NS + 0x1C)
+
 static struct regmap *pmu_regmap;
 
 /**
@@ -65,6 +68,19 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
+static struct sleep_save exynos5420_cpustate_save[] = {
+	SAVE_ITEM(EXYNOS5420_VA_CPU_STATE),
+	SAVE_ITEM(EXYNOS5420_VA_CPU_ADDR),
+};
+
+static struct sleep_save exynos5420_pmu_reg_save[] = {
+	SAVE_ITEM(S5P_PMU_SPARE3),
+};
+
+static struct sleep_save exynos5420_reg_save[] = {
+	SAVE_ITEM(EXYNOS5_SYS_DISP1_BLK_CFG),
+};
+
 /*
  * GIC wake-up support
  */
@@ -87,7 +103,7 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		wkup_irq = exynos5250_wkup_irq;
 	else
 		wkup_irq = exynos4_wkup_irq;
@@ -188,7 +204,15 @@ static int exynos_cpu_suspend(unsigned long arg)
 	outer_flush_all();
 #endif
 
-	if (soc_is_exynos5250())
+	/*
+	 * Clear IRAM register for cpu state so that primary CPU does
+	 * not enter low power start in U-Boot.
+	 * This is specific to exynos5420 SoC only.
+	 */
+	if (soc_is_exynos5420())
+		__raw_writel(0x0, EXYNOS5420_VA_CPU_STATE);
+
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -216,6 +240,26 @@ static void exynos_pm_prepare(void)
 		regmap_read(pmu_regmap, EXYNOS5_JPEG_MEM_OPTION, &tmp);
 		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
 		regmap_write(pmu_regmap, EXYNOS5_JPEG_MEM_OPTION, tmp);
+	} else if (soc_is_exynos5420()) {
+
+		unsigned i;
+
+		s3c_pm_do_save(exynos5420_reg_save,
+			ARRAY_SIZE(exynos5420_reg_save));
+
+		for (i = 0; i < ARRAY_SIZE(exynos5420_pmu_reg_save); i++)
+			regmap_read(pmu_regmap,
+				(unsigned int)exynos5420_pmu_reg_save[i].reg,
+				(unsigned int *)&exynos5420_pmu_reg_save[i].val);
+		/*
+		 * The cpu state needs to be saved and restored so that the
+		 * secondary CPUs will enter low power start. Though the U-Boot
+		 * is setting the cpu state with low power flag, the kernel
+		 * needs to restore it back in case, the primary cpu fails to
+		 * suspend for any reason
+		 */
+		s3c_pm_do_save(exynos5420_cpustate_save,
+			ARRAY_SIZE(exynos5420_cpustate_save));
 	}
 
 	/* Set value of power down register for sleep mode */
@@ -226,6 +270,26 @@ static void exynos_pm_prepare(void)
 	/* ensure@least INFORM0 has the resume address */
 
 	regmap_write(pmu_regmap, S5P_INFORM0, virt_to_phys(exynos_cpu_resume));
+
+	if (soc_is_exynos5420()) {
+		regmap_read(pmu_regmap, EXYNOS5_ARM_L2_OPTION, &tmp);
+		tmp &= ~EXYNOS5_USE_RETENTION;
+		regmap_write(pmu_regmap, EXYNOS5_ARM_L2_OPTION, tmp);
+
+		regmap_read(pmu_regmap, EXYNOS5420_SFR_AXI_CGDIS1, &tmp);
+		tmp |= EXYNOS5420_UFS;
+		regmap_write(pmu_regmap, EXYNOS5420_SFR_AXI_CGDIS1, tmp);
+
+		regmap_read(pmu_regmap, EXYNOS5420_ARM_COMMON_OPTION, &tmp);
+		tmp &= ~EXYNOS5420_L2RSTDISABLE_VALUE;
+		regmap_write(pmu_regmap, EXYNOS5420_ARM_COMMON_OPTION, tmp);
+		regmap_read(pmu_regmap, EXYNOS5420_FSYS2_OPTION, &tmp);
+		tmp |= EXYNOS5420_EMULATION;
+		regmap_write(pmu_regmap, EXYNOS5420_FSYS2_OPTION, tmp);
+		regmap_read(pmu_regmap, EXYNOS5420_PSGEN_OPTION, &tmp);
+		tmp |= EXYNOS5420_EMULATION;
+		regmap_write(pmu_regmap, EXYNOS5420_PSGEN_OPTION, tmp);
+	}
 }
 
 static void exynos_pm_central_suspend(void)
@@ -242,12 +306,20 @@ static int exynos_pm_suspend(void)
 {
 	unsigned int tmp;
 
+	unsigned int this_cluster;
 	exynos_pm_central_suspend();
 
 	/* Setting SEQ_OPTION register */
-
-	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
-	regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, tmp);
+	if (soc_is_exynos5420()) {
+		this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
+		if (!this_cluster)
+			regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, EXYNOS5420_ARM_USE_STANDBY_WFI0);
+		else
+			regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, EXYNOS5420_KFC_USE_STANDBY_WFI0);
+	} else {
+		tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+		regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, tmp);
+	}
 
 	if (!soc_is_exynos5250())
 		exynos_cpu_save_register();
@@ -280,33 +352,80 @@ static int exynos_pm_central_resume(void)
 
 static void exynos_pm_resume(void)
 {
+	unsigned int tmp;
+	if (soc_is_exynos5420()) {
+		/* Restore the IRAM register cpu state */
+		s3c_pm_do_restore(exynos5420_cpustate_save,
+			ARRAY_SIZE(exynos5420_cpustate_save));
+
+		regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION,
+				EXYNOS5420_USE_STANDBY_WFI_ALL);
+	}
+
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (!soc_is_exynos5250())
+	if (!(soc_is_exynos5250() || soc_is_exynos5420()))
 		exynos_cpu_restore_register();
 
 	/* For release retention */
 
-	regmap_write(pmu_regmap, S5P_PAD_RET_MAUDIO_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_GPIO_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_UART_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_MMCA_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_MMCB_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
+	if (soc_is_exynos5250()) {
+		regmap_write(pmu_regmap, S5P_PAD_RET_MAUDIO_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_GPIO_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_UART_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_MMCA_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_MMCB_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
+	} else if (soc_is_exynos5420()) {
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_DRAM_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_MAUDIO_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_JTAG_OPTION,  (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_GPIO_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_UART_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_MMCA_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_MMCB_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_MMCC_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_HSI_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_EBIA_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_EBIB_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_SPI_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION, (1 << 28));
+	}
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250()) {
 		s3c_pm_do_restore(exynos5_sys_save,
 			ARRAY_SIZE(exynos5_sys_save));
+	} else if (soc_is_exynos5420()) {
+		unsigned int i;
+		s3c_pm_do_restore(exynos5420_reg_save,
+			ARRAY_SIZE(exynos5420_reg_save));
+			for (i = 0; i < ARRAY_SIZE(exynos5420_pmu_reg_save); i++)
+				regmap_write(pmu_regmap,
+					(unsigned int)exynos5420_pmu_reg_save[i].reg,
+					(unsigned int)exynos5420_pmu_reg_save[i].val);
+	}
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250())
+	if (!soc_is_exynos5250() && !soc_is_exynos5420())
 		scu_enable(S5P_VA_SCU);
 
 early_wakeup:
 
+	if (soc_is_exynos5420()) {
+		regmap_read(pmu_regmap, EXYNOS5420_SFR_AXI_CGDIS1, &tmp);
+		tmp &= ~EXYNOS5420_UFS;
+		regmap_write(pmu_regmap, EXYNOS5420_SFR_AXI_CGDIS1, tmp);
+		regmap_read(pmu_regmap, EXYNOS5420_FSYS2_OPTION, &tmp);
+		tmp &= ~EXYNOS5420_EMULATION;
+		regmap_write(pmu_regmap, EXYNOS5420_FSYS2_OPTION, tmp);
+		regmap_read(pmu_regmap, EXYNOS5420_PSGEN_OPTION, &tmp);
+		tmp &= ~EXYNOS5420_EMULATION;
+		regmap_write(pmu_regmap, EXYNOS5420_PSGEN_OPTION, tmp);
+	}
+
 	/* Clear SLEEP mode set in INFORM1 */
 	regmap_write(pmu_regmap, S5P_INFORM1, 0x0);
 
@@ -395,7 +514,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 
 	case CPU_PM_EXIT:
 		if (cpu == 0) {
-			if (!soc_is_exynos5250())
+			if (!(soc_is_exynos5250() || soc_is_exynos5420()))
 				scu_enable(S5P_VA_SCU);
 			exynos_cpu_restore_register();
 			exynos_pm_central_resume();
@@ -421,9 +540,15 @@ void __init exynos_pm_init(void)
 	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
 
 	/* All wakeup disable */
-	regmap_read(pmu_regmap, S5P_WAKEUP_MASK, &tmp);
-	tmp |= ((0xFF << 8) | (0x1F << 1));
-	regmap_write(pmu_regmap, S5P_WAKEUP_MASK, tmp);
+	if (soc_is_exynos5420()) {
+		regmap_read(pmu_regmap, S5P_WAKEUP_MASK, &tmp);
+		tmp |= ((0x7F << 7) | (0x1F << 1));
+		regmap_write(pmu_regmap, S5P_WAKEUP_MASK, tmp);
+	} else {
+		regmap_read(pmu_regmap, S5P_WAKEUP_MASK, &tmp);
+		tmp |= ((0xFF << 8) | (0x1F << 1));
+		regmap_write(pmu_regmap, S5P_WAKEUP_MASK, tmp);
+	}
 
 	register_syscore_ops(&exynos_pm_syscore_ops);
 	suspend_set_ops(&exynos_suspend_ops);
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 39a8300..955ee07 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -35,6 +35,7 @@
 #define S5P_INFORM5				(0x0814)
 #define S5P_INFORM6				(0x0818)
 #define S5P_INFORM7				(0x081C)
+#define S5P_PMU_SPARE3				(0x090c)
 
 #define EXYNOS_IROM_DATA2			(0x0988)
 #define S5P_ARM_CORE0_LOWPWR			(0x1000)
@@ -211,6 +212,7 @@
 
 /* For EXYNOS5 */
 
+#define EXYNOS5_SYS_DISP1_BLK_CFG				S5P_SYSREG(0x0214)
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				(0x0408)
 #define EXYNOS5_MASK_WDTRESET_REQUEST				(0x040C)
 
-- 
1.7.9.5

From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:32:01 +0530
Subject: [PATCH v4 3/4] arm: exynos5: Add Suspend-to-RAM support for 5420
In-Reply-To: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
References: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399982522-27928-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds Suspend-to-RAM support for EXYNOS5420

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/pm.c       |  201 +++++++++++++++++++++++++++++++++++----
 arch/arm/mach-exynos/regs-pmu.h |    1 +
 2 files changed, 186 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 95f8086..fddb559 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -39,7 +40,13 @@
 #include "regs-sys.h"
 #include "exynos-pmu.h"
 
+#define EXYNOS5420_CPU_ADDR	0x1c
+#define EXYNOS5420_CPU_STATE	0x28
+
 static struct regmap *pmu_regmap;
+static int exynos5420_cpu_state[2];
+static void __iomem *exynos5420_sysram_base;
+static void __iomem *exynos5420_ns_sysram_base;
 
 /**
  * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
@@ -64,6 +71,10 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
+static struct sleep_save exynos5420_pmu_reg_save[] = {
+	SAVE_ITEM((void __iomem *)S5P_PMU_SPARE3),
+};
+
 /*
  * GIC wake-up support
  */
@@ -86,7 +97,7 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		wkup_irq = exynos5250_wkup_irq;
 	else
 		wkup_irq = exynos4_wkup_irq;
@@ -187,7 +198,16 @@ static int exynos_cpu_suspend(unsigned long arg)
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
+			exynos5420_sysram_base + EXYNOS5420_CPU_STATE);
+
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -215,6 +235,24 @@ static void exynos_pm_prepare(void)
 		regmap_read(pmu_regmap, EXYNOS5_JPEG_MEM_OPTION, &tmp);
 		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
 		regmap_write(pmu_regmap, EXYNOS5_JPEG_MEM_OPTION, tmp);
+	} else if (soc_is_exynos5420()) {
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(exynos5420_pmu_reg_save); i++)
+			regmap_read(pmu_regmap,
+			(unsigned int)exynos5420_pmu_reg_save[i].reg,
+			(unsigned int *)&exynos5420_pmu_reg_save[i].val);
+		/*
+		 * The cpu state needs to be saved and restored so that the
+		 * secondary CPUs will enter low power start. Though the U-Boot
+		 * is setting the cpu state with low power flag, the kernel
+		 * needs to restore it back in case, the primary cpu fails to
+		 * suspend for any reason.
+		 */
+		exynos5420_cpu_state[0] =
+		__raw_readl(exynos5420_sysram_base + EXYNOS5420_CPU_STATE);
+		exynos5420_cpu_state[1] =
+		__raw_readl(exynos5420_ns_sysram_base + EXYNOS5420_CPU_ADDR);
 	}
 
 	/* Set value of power down register for sleep mode */
@@ -225,6 +263,26 @@ static void exynos_pm_prepare(void)
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
@@ -241,12 +299,22 @@ static int exynos_pm_suspend(void)
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
+			regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION,
+					EXYNOS5420_ARM_USE_STANDBY_WFI0);
+		else
+			regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION,
+					EXYNOS5420_KFC_USE_STANDBY_WFI0);
+	} else {
+		tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+		regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, tmp);
+	}
 
 	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		exynos_cpu_save_register();
@@ -279,6 +347,19 @@ static int exynos_pm_central_resume(void)
 
 static void exynos_pm_resume(void)
 {
+	unsigned int tmp;
+
+	if (soc_is_exynos5420()) {
+		/* Restore the sysram cpu state register */
+		__raw_writel(exynos5420_cpu_state[0],
+		exynos5420_sysram_base + EXYNOS5420_CPU_STATE);
+		__raw_writel(exynos5420_cpu_state[1],
+		exynos5420_ns_sysram_base + EXYNOS5420_CPU_ADDR);
+
+		regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION,
+				EXYNOS5420_USE_STANDBY_WFI_ALL);
+	}
+
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
@@ -287,17 +368,54 @@ static void exynos_pm_resume(void)
 
 	/* For release retention */
 
-	regmap_write(pmu_regmap, S5P_PAD_RET_MAUDIO_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_GPIO_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_UART_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_MMCA_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_MMCB_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
-	regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
+	if (soc_is_exynos5420()) {
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_DRAM_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_MAUDIO_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_JTAG_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_GPIO_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_UART_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_MMCA_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_MMCB_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_MMCC_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_HSI_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_EBIA_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS_PAD_RET_EBIB_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_SPI_OPTION,
+								(1 << 28));
+		regmap_write(pmu_regmap, EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
+								(1 << 28));
+	} else {
+		regmap_write(pmu_regmap, S5P_PAD_RET_MAUDIO_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_GPIO_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_UART_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_MMCA_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_MMCB_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
+		regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
+	}
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250()) {
 		s3c_pm_do_restore(exynos5_sys_save,
 			ARRAY_SIZE(exynos5_sys_save));
+	} else if (soc_is_exynos5420()) {
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(exynos5420_pmu_reg_save); i++)
+			regmap_write(pmu_regmap,
+			(unsigned int)exynos5420_pmu_reg_save[i].reg,
+			(unsigned int)exynos5420_pmu_reg_save[i].val);
+	}
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
@@ -306,6 +424,18 @@ static void exynos_pm_resume(void)
 
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
 
@@ -414,8 +544,41 @@ static struct notifier_block exynos_cpu_pm_notifier_block = {
 
 void __init exynos_pm_init(void)
 {
+	struct device_node *node;
 	u32 tmp;
 
+	if (soc_is_exynos5420()) {
+		node = of_find_compatible_node(NULL, NULL,
+			"samsung,exynos4210-sysram");
+		if (!node) {
+			pr_err("failed to find secure sysram node\n");
+			return;
+		}
+
+		exynos5420_sysram_base = of_iomap(node, 0);
+		of_node_put(node);
+		if (!exynos5420_sysram_base) {
+			pr_err("failed to map secure sysram base address\n");
+			return;
+		}
+
+		node = of_find_compatible_node(NULL, NULL,
+			"samsung,exynos4210-sysram-ns");
+		if (!node) {
+			pr_err("failed to find non-secure sysram node\n");
+			iounmap(exynos5420_sysram_base);
+			return;
+		}
+
+		exynos5420_ns_sysram_base = of_iomap(node, 0);
+		of_node_put(node);
+		if (!exynos5420_ns_sysram_base) {
+			pr_err("failed to map non-secure sysram base address\n");
+			iounmap(exynos5420_sysram_base);
+			return;
+		}
+	}
+
 	pmu_regmap = get_exynos_pmuregmap();
 	cpu_pm_register_notifier(&exynos_cpu_pm_notifier_block);
 
@@ -423,9 +586,15 @@ void __init exynos_pm_init(void)
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
index 8925ab0..08a3c00 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -33,6 +33,7 @@
 #define S5P_INFORM5				0x0814
 #define S5P_INFORM6				0x0818
 #define S5P_INFORM7				0x081C
+#define S5P_PMU_SPARE3				0x090c
 
 #define EXYNOS_IROM_DATA2			0x0988
 #define S5P_ARM_CORE0_LOWPWR			0x1000
-- 
1.7.9.5

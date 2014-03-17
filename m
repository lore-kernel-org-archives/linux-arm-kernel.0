From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 17 Mar 2014 18:39:54 +0530
Subject: [PATCH v2 2/3] ARM: EXYNOS: Add initial support of PMU for Exynos5260
In-Reply-To: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
References: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1395061795-17777-3-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds PMU support of PMU for Exynos5260. Suspend-to-RAM can be built on
top this.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/common.h            |   26 ++++
 arch/arm/mach-exynos/pm.c                |   34 +++--
 arch/arm/mach-exynos/pmu.c               |  238 ++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h          |  232 +++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/cpu.h |    8 +
 5 files changed, 529 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index aba6a2a..a17f701 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -56,6 +56,32 @@ enum sys_powerdown {
 	NUM_SYS_POWERDOWN,
 };
 
+enum running_cpu {
+	EXYNOS5_KFC,
+	EXYNOS5_ARM,
+};
+
+enum reg_op {
+	REG_INIT,	/* write new value */
+	REG_RESET,	/* clear with zero */
+	REG_SET,	/* bit set */
+	REG_CLEAR,	/* bit clear */
+};
+
+/* reg/value set */
+#define EXYNOS_PMU_REG(REG, VAL, OP)		\
+{						\
+	.reg	=	(void __iomem *)REG,	\
+	.val	=	VAL,			\
+	.op	=	OP,			\
+}
+
+struct exynos_pmu_init_reg {
+	void __iomem *reg;
+	unsigned int val;
+	enum reg_op op;
+};
+
 extern unsigned long l2x0_regs_phys;
 struct exynos_pmu_conf {
 	void __iomem *reg;
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 15af0ce..dbe9670 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -109,7 +109,7 @@ static int exynos_cpu_suspend(unsigned long arg)
 	outer_flush_all();
 #endif
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5260())
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -150,6 +150,7 @@ static void exynos_pm_prepare(void)
 static int exynos_pm_suspend(void)
 {
 	unsigned long tmp;
+	unsigned int cluster_id;
 
 	/* Setting Central Sequence Register for power down mode */
 
@@ -158,11 +159,21 @@ static int exynos_pm_suspend(void)
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
 	/* Setting SEQ_OPTION register */
+	if (soc_is_exynos5250()) {
+		tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+		__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	} else if (soc_is_exynos5260()) {
+		cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
+		if (!cluster_id)
+			__raw_writel(EXYNOS5260_ARM_USE_STANDBY_WFI0,
+				     S5P_CENTRAL_SEQ_OPTION);
+		else
+			__raw_writel(EXYNOS5260_KFC_USE_STANDBY_WFI0,
+				     S5P_CENTRAL_SEQ_OPTION);
 
-	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	}
 
-	if (!soc_is_exynos5250()) {
+	if (!soc_is_exynos5250() && !soc_is_exynos5260()) {
 		/* Save Power control register */
 		asm ("mrc p15, 0, %0, c15, c0, 0"
 		     : "=r" (tmp) : : "cc");
@@ -196,7 +207,7 @@ static void exynos_pm_resume(void)
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
-	if (!soc_is_exynos5250()) {
+	if (!soc_is_exynos5250() && !soc_is_exynos5260()) {
 		/* Restore Power control register */
 		tmp = save_arm_register[0];
 		asm volatile ("mcr p15, 0, %0, c15, c0, 0"
@@ -312,10 +323,15 @@ void __init exynos_pm_init(void)
 	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
 
 	/* All wakeup disable */
-	tmp = __raw_readl(S5P_WAKEUP_MASK);
-	tmp |= ((0xFF << 8) | (0x1F << 1));
-	__raw_writel(tmp, S5P_WAKEUP_MASK);
-
+	if (soc_is_exynos5260()) {
+		tmp = __raw_readl(EXYNOS5260_WAKEUP_MASK);
+		tmp |= ((0xE << 12) | (0xE << 8) | (0x3 << 1));
+		__raw_writel(tmp, EXYNOS5260_WAKEUP_MASK);
+	} else {
+		tmp = __raw_readl(S5P_WAKEUP_MASK);
+		tmp |= ((0xFF << 8) | (0x1F << 1));
+		__raw_writel(tmp, S5P_WAKEUP_MASK);
+	}
 	register_syscore_ops(&exynos_pm_syscore_ops);
 	suspend_set_ops(&exynos_suspend_ops);
 }
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 05c7ce1..7a3412d 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -18,6 +18,13 @@
 #include "common.h"
 #include "regs-pmu.h"
 
+#define EXYNOS5260_USE_STANDBY_WFI_ALL	(EXYNOS5260_ARM_USE_STANDBY_WFI0  \
+					| EXYNOS5260_ARM_USE_STANDBY_WFI1  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI0  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI1  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI2  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI3)
+
 static const struct exynos_pmu_conf *exynos_pmu_config;
 
 static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
@@ -318,6 +325,99 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static struct exynos_pmu_conf exynos5260_pmu_config[] = {
+	/* { .reg = address, .val = { AFTR, LPA, SLEEP } */
+	{ EXYNOS5260_A15_EGL0_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL0_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL0_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A15_EGL1_SYS_PWR_REG,		 { 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL1_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL1_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC0_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC0_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC1_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC1_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC2_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC2_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC2_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC3_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC3_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC3_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_CORTEXA15_NONEAGLE_SYS_PWR_REG,	{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_CORTEXA7_NONEAGLE_SYS_PWR_REG,	{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_A5IS_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A5IS_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A5IS_CNTRL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_CORTEXA15_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x7} },
+	{ EXYNOS5260_CORTEXA7_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x7} },
+	{ EXYNOS5260_CLKSTOP_CMU_TOP_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_CLKRUN_CMU_TOP_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_TOP_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_RESET_EAGLECLKSTOP_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_CLKSTOP_CMU_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_CLKRUN_CMU_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_MIF_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_DISABLE_PLL_CMU_TOP_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_DISABLE_PLL_AUD_PLL_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_DISABLE_PLL_CMU_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5260_TOP_BUS_MIF_SYS_PWR_REG,		{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5260_TOP_RET_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_TOP_PWR_MIF_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5260_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_SLEEP_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_LOGIC_RESET_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_OSCCLK_GATE_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_SLEEP_RESET_MIF_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_MEMORY_TOP_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5260_MEMORY_MIF_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_LPDDR3_SYS_PWR_REG,	{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_AUD_SYS_PWR_REG,		{ 0x0, 0x1, 0x0} },
+	{ EXYNOS5260_PAD_RET_JTAG_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MMC2_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_TOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_UART_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MMC0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MMC1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_SPI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_BOOTLDO_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_ISOLATION_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_GPIO_MODE_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_GPIO_MODE_AUD_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_GSCL_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_DISP_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_AUD_SYS_PWR_REG,			{ 0xF, 0xF, 0x0} },
+	{ EXYNOS5260_G2D_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_ISP_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_MFC_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_MEMORY_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0xF} },
+	{ EXYNOS5260_RESET_CMU_GSCL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_CAM0_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_MSCL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_DISP_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_CAM1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_AUD_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ PMU_TABLE_END,},
+};
+
 static void __iomem * const exynos5_list_both_cnt_feed[] = {
 	EXYNOS5_ARM_CORE0_OPTION,
 	EXYNOS5_ARM_CORE1_OPTION,
@@ -338,6 +438,94 @@ static void __iomem * const exynos5_list_diable_wfi_wfe[] = {
 	EXYNOS5_ISP_ARM_OPTION,
 };
 
+void __iomem *exynos5260_list_feed[] = {
+	EXYNOS_ARM_CORE_OPTION(0),
+	EXYNOS_ARM_CORE_OPTION(1),
+	EXYNOS_ARM_CORE_OPTION(4),
+	EXYNOS_ARM_CORE_OPTION(5),
+	EXYNOS_ARM_CORE_OPTION(6),
+	EXYNOS_ARM_CORE_OPTION(7),
+	EXYNOS5260_EAGLE_NONCPU_OPTION,
+	EXYNOS5260_KFC_NONCPU_OPTION,
+	EXYNOS5_TOP_PWR_OPTION,
+	EXYNOS5_TOP_PWR_SYSMEM_OPTION,
+	EXYNOS5_GSCL_OPTION,
+	EXYNOS5_G3D_OPTION,
+	EXYNOS5260_DISP_OPTION,
+	EXYNOS5_MAU_OPTION,
+	EXYNOS5260_G2D_OPTION,
+	EXYNOS5260_ISP_OPTION,
+	EXYNOS5260_MFC_OPTION,
+};
+
+struct exynos_pmu_init_reg exynos5260_pmu_reg[] = {
+	/* Enable USE_STANDBY_WFI for all CORE */
+	EXYNOS_PMU_REG(S5P_CENTRAL_SEQ_OPTION,
+				EXYNOS5260_USE_STANDBY_WFI_ALL, REG_INIT),
+	/* Set PSHOLD port for output high */
+	EXYNOS_PMU_REG(EXYNOS_PS_HOLD_CONTROL,
+				EXYNOS_PS_HOLD_OUTPUT_HIGH, REG_SET),
+	/* Enable signal for PSHOLD port */
+	EXYNOS_PMU_REG(EXYNOS_PS_HOLD_CONTROL, EXYNOS_PS_HOLD_EN, REG_SET),
+	/* Init core interface reg */
+	EXYNOS_PMU_REG(EXYNOS5260_EAGLE_NONCPU_OPTION, (0xF << 16), REG_CLEAR),
+	EXYNOS_PMU_REG(EXYNOS5260_KFC_NONCPU_OPTION, (0xF << 16), REG_CLEAR),
+	/* Init L2 option */
+	EXYNOS_PMU_REG(EXYNOS5260_EAGLE_L2_OPTION, 0x0, REG_INIT),
+	EXYNOS_PMU_REG(EXYNOS5260_KFC_L2_OPTION, 0x0, REG_INIT),
+	/* Procedure of central sequencer needs to be changed */
+	EXYNOS_PMU_REG(EXYNOS5260_SEQ_TRANSITION0,
+			((1 << 31) | (0x3a << 16) | 0x3e), REG_INIT),
+	EXYNOS_PMU_REG(EXYNOS5260_SEQ_TRANSITION1,
+			((1 << 31) | (0x3e << 16) | 0x3b), REG_INIT),
+	EXYNOS_PMU_REG(EXYNOS5260_SEQ_TRANSITION2,
+			((1 << 31) | (0x3d << 16) | 0x3f), REG_INIT),
+	EXYNOS_PMU_REG(NULL, 0, 0)
+};
+
+static int exynos_pmu_reg_set(struct exynos_pmu_init_reg *init_reg)
+{
+	unsigned int tmp;
+
+	for (; init_reg->reg; init_reg++) {
+		switch (init_reg->op) {
+		case REG_CLEAR:
+			tmp = __raw_readl(init_reg->reg);
+			tmp &= ~init_reg->val;
+			__raw_writel(tmp, init_reg->reg);
+			pr_debug("CLR: %08x - %08x\n",
+				virt_to_phys(init_reg->reg), tmp);
+			break;
+
+		case REG_SET:
+			tmp = __raw_readl(init_reg->reg);
+			tmp |= init_reg->val;
+			__raw_writel(tmp, init_reg->reg);
+			pr_debug("SET: %08x - %08x\n",
+				virt_to_phys(init_reg->reg), tmp);
+			break;
+
+		case REG_INIT:
+			__raw_writel(init_reg->val, init_reg->reg);
+			pr_debug("INI: %08x - %08x\n",
+				virt_to_phys(init_reg->reg), init_reg->val);
+			break;
+
+		case REG_RESET:
+			__raw_writel(0x0, init_reg->reg);
+			pr_debug("RES: %08x - %08x\n",
+				virt_to_phys(init_reg->reg), 0x0);
+			break;
+
+		default:
+			pr_err("PMU_REG_SET: undefined operation.\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void exynos5_init_pmu(void)
 {
 	unsigned int i;
@@ -389,6 +577,48 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	}
 }
 
+static void exynos5260_reset_assert_ctrl(bool on, enum running_cpu cluster)
+{
+	unsigned int i;
+	unsigned int option;
+	unsigned int cpu_start_idx, cpu_last_idx;
+
+	if (cluster == EXYNOS5_KFC) {
+		cpu_start_idx = EXYNOS5260_CPUS_PER_CLUSTER;
+		cpu_last_idx = cpu_start_idx + EXYNOS5260_CPUS_PER_CLUSTER;
+	} else {
+		cpu_start_idx = 0;
+		cpu_last_idx = EXYNOS5260_EGL_CORE_NUMBERS;
+	}
+
+	for (i = cpu_start_idx; i < cpu_last_idx; i++) {
+		option = __raw_readl(EXYNOS_ARM_CORE_OPTION(i));
+		if (on)
+			option = (option |
+				EXYNOS5260_USE_DELAYED_RESET_ASSERTION);
+		else
+			option = (option &
+				~EXYNOS5260_USE_DELAYED_RESET_ASSERTION);
+
+		__raw_writel(option, EXYNOS_ARM_CORE_OPTION(i));
+	}
+}
+
+static void exynos5260_init_pmu(void)
+{
+	unsigned int i, tmp;
+
+	/*
+	 * Enable only SC_FEEDBACK
+	 */
+	for (i = 0; i < ARRAY_SIZE(exynos5260_list_feed); i++) {
+		tmp = __raw_readl(exynos5260_list_feed[i]);
+		tmp &= ~EXYNOS5_USE_SC_COUNTER;
+		tmp |= EXYNOS5_USE_SC_FEEDBACK;
+		__raw_writel(tmp, exynos5260_list_feed[i]);
+	}
+}
+
 static int __init exynos_pmu_init(void)
 {
 	unsigned int value;
@@ -416,6 +646,14 @@ static int __init exynos_pmu_init(void)
 
 		exynos_pmu_config = exynos5250_pmu_config;
 		pr_info("EXYNOS5250 PMU Initialize\n");
+	} else if (soc_is_exynos5260()) {
+		exynos_pmu_reg_set(exynos5260_pmu_reg);
+		exynos5260_reset_assert_ctrl(true, EXYNOS5_ARM);
+
+		exynos5260_init_pmu();
+		exynos_pmu_config = exynos5260_pmu_config;
+
+		pr_info("EXYNOS5260 PMU Initialized\n");
 	} else {
 		pr_info("EXYNOS: PMU not supported\n");
 	}
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 2c15a8f..a81926b 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -179,8 +179,20 @@
 #define S5P_DIS_IRQ_CORE3			S5P_PMUREG(0x1034)
 #define S5P_DIS_IRQ_CENTRAL3			S5P_PMUREG(0x1038)
 
+#define S5P_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
+#define S5P_ARM_CORE0_STATUS			S5P_PMUREG(0x2004)
+#define S5P_ARM_CORE0_OPTION			S5P_PMUREG(0x2008)
+
+
 /* For EXYNOS5 */
 
+/* PS_HOLD_CONTROL */
+
+#define EXYNOS_PS_HOLD_CONTROL			S5P_PMUREG(0x330c)
+
+#define EXYNOS_PS_HOLD_EN			(1 << 31)
+#define EXYNOS_PS_HOLD_OUTPUT_HIGH		(3 << 8)
+
 #define EXYNOS5_SYS_I2C_CFG					S5P_SYSREG(0x0234)
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
@@ -313,5 +325,225 @@
 #define EXYNOS5_OPTION_USE_STANDBYWFI				(1 << 16)
 
 #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
+#define EXYNOS_ARM_CORE_OPTION(_nr)             (S5P_ARM_CORE0_OPTION \
+						+ ((_nr) * 0x80))
+#define EXYNOS_ARM_CORE_STATUS(_nr)             (S5P_ARM_CORE0_STATUS \
+						+ ((_nr) * 0x80))
+#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)      \
+		(S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_CORE_LOCAL_PWR_EN                0xf
+
+#define EXYNOS_ARM_COMMON_CONFIGURATION         S5P_PMUREG(0x2500)
+#define EXYNOS_ARM_COMMON_STATUS                S5P_PMUREG(0x2504)
+#define EXYNOS_COMMON_CONFIGURATION(_nr)        \
+		(EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_COMMON_STATUS(_nr)               \
+		(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
+#define EXYNOS_COMMON_OPTION(_nr)               \
+		(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x8)
+
+#define EXYNOS_PS_HOLD_CONTROL			S5P_PMUREG(0x330c)
+
+/* Exynos5260 specific Sys Regs */
+#define EXYNOS5260_SYSREG_PERI(x)	(EXYNOS5260_VA_SYS_PERI + (x))
+#define EXYNOS5260_SYSREG_EGL(x)	(EXYNOS5260_VA_SYS_EGL + (x))
+#define EXYNOS5260_SYSREG_KFC(x)	(EXYNOS5260_VA_SYS_KFC + (x))
+#define EXYNOS5260_SYSREG_G2D(x)	(EXYNOS5260_VA_SYS_G2D + (x))
+#define EXYNOS5260_SYSREG_MIF(x)	(EXYNOS5260_VA_SYS_MIF + (x))
+#define EXYNOS5260_SYSREG_MFC(x)	(EXYNOS5260_VA_SYS_MFC + (x))
+#define EXYNOS5260_SYSREG_G3D(x)	(EXYNOS5260_VA_SYS_G3D + (x))
+#define EXYNOS5260_SYSREG_FSYS(x)	(EXYNOS5260_VA_SYS_FSYS + (x))
+#define EXYNOS5260_SYSREG_AUD(x)	(EXYNOS5260_VA_SYS_AUD + (x))
+#define EXYNOS5260_SYSREG_ISP(x)	(EXYNOS5260_VA_SYS_ISP + (x))
+#define EXYNOS5260_SYSREG_GSCL(x)	(EXYNOS5260_VA_SYS_GSCL + (x))
+#define EXYNOS5260_SYSREG_DISP(x)	(EXYNOS5260_VA_SYS_DISP + (x))
+
+#define EXYNOS5260_SYS_DISP1_BLK_CFG	EXYNOS5260_SYSREG_DISP(0x0)
+
+#define EXYNOS5260_CORE_LOCAL_PWR_EN				0xf
+#define EXYNOS5260_CPUS_PER_CLUSTER				4
+#define EXYNOS5260_EGL_CORE_NUMBERS				2
+
+#define EXYNOS5260_USE_DELAYED_RESET_ASSERTION			(1 << 12)
+
+#define EXYNOS5260_WAKEUP_STAT2			S5P_PMUREG(0x0604)
+#define EXYNOS5260_WAKEUP_STAT3			S5P_PMUREG(0x0608)
+#define EXYNOS5260_EINT_WAKEUP_MASK		S5P_PMUREG(0x060C)
+#define EXYNOS5260_WAKEUP_MASK			S5P_PMUREG(0x0610)
+#define EXYNOS5260_WAKEUP_MASK2			S5P_PMUREG(0x0614)
+#define EXYNOS5260_WAKEUP_MASK3			S5P_PMUREG(0x0618)
+
+
+/* Exynos5260 specific PMU SYS_PWR_REGs */
+#define EXYNOS5260_A15_EGL0_SYS_PWR_REG			S5P_PMUREG(0x1000)
+#define EXYNOS5260_DIS_IRQ_A15_EGL0_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1004)
+#define EXYNOS5260_DIS_IRQ_A15_EGL0_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1008)
+#define EXYNOS5260_DIS_IRQ_A15_EGL0_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x100C)
+#define EXYNOS5260_A15_EGL1_SYS_PWR_REG			S5P_PMUREG(0x1010)
+#define EXYNOS5260_DIS_IRQ_A15_EGL1_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1014)
+#define EXYNOS5260_DIS_IRQ_A15_EGL1_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1018)
+#define EXYNOS5260_DIS_IRQ_A15_EGL1_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x101C)
+#define EXYNOS5260_A7_KFC0_SYS_PWR_REG			S5P_PMUREG(0x1040)
+#define EXYNOS5260_DIS_IRQ_A7_KFC0_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1044)
+#define EXYNOS5260_DIS_IRQ_A7_KFC0_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1048)
+#define EXYNOS5260_DIS_IRQ_A7_KFC0_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x104C)
+#define EXYNOS5260_A7_KFC1_SYS_PWR_REG			S5P_PMUREG(0x1050)
+#define EXYNOS5260_DIS_IRQ_A7_KFC1_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1054)
+#define EXYNOS5260_DIS_IRQ_A7_KFC1_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1058)
+#define EXYNOS5260_DIS_IRQ_A7_KFC1_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x105C)
+#define EXYNOS5260_A7_KFC2_SYS_PWR_REG			S5P_PMUREG(0x1060)
+#define EXYNOS5260_DIS_IRQ_A7_KFC2_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1064)
+#define EXYNOS5260_DIS_IRQ_A7_KFC2_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1068)
+#define EXYNOS5260_DIS_IRQ_A7_KFC2_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x106C)
+#define EXYNOS5260_A7_KFC3_SYS_PWR_REG			S5P_PMUREG(0x1070)
+#define EXYNOS5260_DIS_IRQ_A7_KFC3_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1074)
+#define EXYNOS5260_DIS_IRQ_A7_KFC3_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1078)
+#define EXYNOS5260_DIS_IRQ_A7_KFC3_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x107C)
+#define EXYNOS5260_CORTEXA15_NONEAGLE_SYS_PWR_REG	S5P_PMUREG(0x1080)
+#define EXYNOS5260_CORTEXA7_NONEAGLE_SYS_PWR_REG	S5P_PMUREG(0x1084)
+#define EXYNOS5260_A5IS_SYS_PWR_REG			S5P_PMUREG(0x10B0)
+#define EXYNOS5260_DIS_IRQ_A5IS_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x10B4)
+#define EXYNOS5260_DIS_IRQ_A5IS_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x10B8)
+#define EXYNOS5260_CORTEXA15_L2_SYS_PWR_REG		S5P_PMUREG(0x10C0)
+#define EXYNOS5260_CORTEXA7_L2_SYS_PWR_REG		S5P_PMUREG(0x10C4)
+#define EXYNOS5260_CLKSTOP_CMU_TOP_SYS_PWR_REG		S5P_PMUREG(0x1100)
+#define EXYNOS5260_CLKRUN_CMU_TOP_SYS_PWR_REG		S5P_PMUREG(0x1104)
+#define EXYNOS5260_RESET_CMU_TOP_SYS_PWR_REG		S5P_PMUREG(0x110C)
+#define EXYNOS5260_RESET_EAGLECLKSTOP_SYS_PWR_REG	S5P_PMUREG(0x111C)
+#define EXYNOS5260_CLKSTOP_CMU_MIF_SYS_PWR_REG		S5P_PMUREG(0x1120)
+#define EXYNOS5260_CLKRUN_CMU_MIF_SYS_PWR_REG		S5P_PMUREG(0x1124)
+#define EXYNOS5260_RESET_CMU_MIF_SYS_PWR_REG		S5P_PMUREG(0x112C)
+#define EXYNOS5260_DISABLE_PLL_CMU_TOP_SYS_PWR_REG	S5P_PMUREG(0x1140)
+#define EXYNOS5260_DISABLE_PLL_AUD_PLL_SYS_PWR_REG	S5P_PMUREG(0x1144)
+#define EXYNOS5260_DISABLE_PLL_CMU_MIF_SYS_PWR_REG	S5P_PMUREG(0x1160)
+#define EXYNOS5260_TOP_BUS_MIF_SYS_PWR_REG		S5P_PMUREG(0x1190)
+#define EXYNOS5260_TOP_RET_MIF_SYS_PWR_REG		S5P_PMUREG(0x1194)
+#define EXYNOS5260_TOP_PWR_MIF_SYS_PWR_REG		S5P_PMUREG(0x1198)
+#define EXYNOS5260_LOGIC_RESET_SYS_PWR_REG		S5P_PMUREG(0x11A0)
+#define EXYNOS5260_OSCCLK_GATE_SYS_PWR_REG		S5P_PMUREG(0x11A4)
+#define EXYNOS5260_SLEEP_RESET_SYS_PWR_REG		S5P_PMUREG(0x11A8)
+#define EXYNOS5260_LOGIC_RESET_MIF_SYS_PWR_REG		S5P_PMUREG(0x11B0)
+#define EXYNOS5260_OSCCLK_GATE_MIF_SYS_PWR_REG		S5P_PMUREG(0x11B4)
+#define EXYNOS5260_SLEEP_RESET_MIF_SYS_PWR_REG		S5P_PMUREG(0x11B8)
+#define EXYNOS5260_MEMORY_TOP_SYS_PWR_REG		S5P_PMUREG(0x11C0)
+#define EXYNOS5260_MEMORY_MIF_SYS_PWR_REG		S5P_PMUREG(0x11E0)
+#define EXYNOS5260_PAD_RET_LPDDR3_SYS_PWR_REG		S5P_PMUREG(0x1200)
+#define EXYNOS5260_PAD_RET_AUD_SYS_PWR_REG		S5P_PMUREG(0x1204)
+#define EXYNOS5260_PAD_RET_JTAG_SYS_PWR_REG		S5P_PMUREG(0x1208)
+#define EXYNOS5260_PAD_RET_MMC2_SYS_PWR_REG		S5P_PMUREG(0x1218)
+#define EXYNOS5260_PAD_RET_JTAG_APM_SYS_PWR_REG		S5P_PMUREG(0x121C)
+#define EXYNOS5260_PAD_RET_TOP_SYS_PWR_REG		S5P_PMUREG(0x1220)
+#define EXYNOS5260_PAD_RET_UART_SYS_PWR_REG		S5P_PMUREG(0x1224)
+#define EXYNOS5260_PAD_RET_MMC0_SYS_PWR_REG		S5P_PMUREG(0x1228)
+#define EXYNOS5260_PAD_RET_MMC1_SYS_PWR_REG		S5P_PMUREG(0x122C)
+#define EXYNOS5260_PAD_RET_EBIA_SYS_PWR_REG		S5P_PMUREG(0x1230)
+#define EXYNOS5260_PAD_RET_EBIB_SYS_PWR_REG		S5P_PMUREG(0x1234)
+#define EXYNOS5260_PAD_RET_SPI_SYS_PWR_REG		S5P_PMUREG(0x1238)
+#define EXYNOS5260_PAD_RET_MIF_SYS_PWR_REG		S5P_PMUREG(0x123C)
+#define EXYNOS5260_PAD_ISOLATION_SYS_PWR_REG		S5P_PMUREG(0x1240)
+#define EXYNOS5260_PAD_RET_USBXTI_SYS_PWR_REG		S5P_PMUREG(0x1244)
+#define EXYNOS5260_PAD_RET_BOOTLDO_SYS_PWR_REG		S5P_PMUREG(0x1248)
+#define EXYNOS5260_PAD_RET_UFS_SYS_PWR_REG		S5P_PMUREG(0x124C)
+#define EXYNOS5260_PAD_ISOLATION_MIF_SYS_PWR_REG	S5P_PMUREG(0x1250)
+#define EXYNOS5260_PAD_ALV_SEL_SYS_PWR_REG		S5P_PMUREG(0x1260)
+#define EXYNOS5260_XXTI_SYS_PWR_REG			S5P_PMUREG(0x1284)
+#define EXYNOS5260_XXTI26_SYS_PWR_REG			S5P_PMUREG(0x1288)
+#define EXYNOS5260_EXT_REGULATOR_SYS_PWR_REG		S5P_PMUREG(0x12C0)
+#define EXYNOS5260_GPIO_MODE_SYS_PWR_REG		S5P_PMUREG(0x1300)
+#define EXYNOS5260_GPIO_MODE_MIF_SYS_PWR_REG		S5P_PMUREG(0x1320)
+#define EXYNOS5260_GPIO_MODE_AUD_SYS_PWR_REG		S5P_PMUREG(0x1340)
+#define EXYNOS5260_GSCL_SYS_PWR_REG			S5P_PMUREG(0x1400)
+#define EXYNOS5260_CAM0_SYS_PWR_REG			S5P_PMUREG(0x1404)
+#define EXYNOS5260_MSCL_SYS_PWR_REG			S5P_PMUREG(0x1408)
+#define EXYNOS5260_DISP_SYS_PWR_REG			S5P_PMUREG(0x1410)
+#define EXYNOS5260_CAM1_SYS_PWR_REG			S5P_PMUREG(0x1414)
+#define EXYNOS5260_AUD_SYS_PWR_REG			S5P_PMUREG(0x1418)
+#define EXYNOS5260_FSYS_SYS_PWR_REG			S5P_PMUREG(0x141C)
+#define EXYNOS5260_G2D_SYS_PWR_REG			S5P_PMUREG(0x1424)
+#define EXYNOS5260_ISP_SYS_PWR_REG			S5P_PMUREG(0x1428)
+#define EXYNOS5260_MFC_SYS_PWR_REG			S5P_PMUREG(0x1430)
+#define EXYNOS5260_CLKRUN_CMU_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1440)
+#define EXYNOS5260_CLKRUN_CMU_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1444)
+#define EXYNOS5260_CLKRUN_CMU_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1448)
+#define EXYNOS5260_CLKRUN_CMU_G3D_SYS_PWR_REG		S5P_PMUREG(0x144C)
+#define EXYNOS5260_CLKRUN_CMU_DISP_SYS_PWR_REG		S5P_PMUREG(0x1450)
+#define EXYNOS5260_CLKRUN_CMU_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1454)
+#define EXYNOS5260_CLKRUN_CMU_AUD_SYS_PWR_REG		S5P_PMUREG(0x1458)
+#define EXYNOS5260_CLKRUN_CMU_FSYS_SYS_PWR_REG		S5P_PMUREG(0x145C)
+#define EXYNOS5260_CLKRUN_CMU_G2D_SYS_PWR_REG		S5P_PMUREG(0x1464)
+#define EXYNOS5260_CLKRUN_CMU_ISP_SYS_PWR_REG		S5P_PMUREG(0x1468)
+#define EXYNOS5260_CLKRUN_CMU_MFC_SYS_PWR_REG		S5P_PMUREG(0x1470)
+#define EXYNOS5260_CLKSTOP_CMU_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1480)
+#define EXYNOS5260_CLKSTOP_CMU_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1484)
+#define EXYNOS5260_CLKSTOP_CMU_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1488)
+#define EXYNOS5260_CLKSTOP_CMU_G3D_SYS_PWR_REG		S5P_PMUREG(0x148C)
+#define EXYNOS5260_CLKSTOP_CMU_DISP_SYS_PWR_REG		S5P_PMUREG(0x1490)
+#define EXYNOS5260_CLKSTOP_CMU_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1494)
+#define EXYNOS5260_CLKSTOP_CMU_AUD_SYS_PWR_REG		S5P_PMUREG(0x1498)
+#define EXYNOS5260_CLKSTOP_CMU_FSYS_SYS_PWR_REG		S5P_PMUREG(0x149C)
+#define EXYNOS5260_CLKSTOP_CMU_G2D_SYS_PWR_REG		S5P_PMUREG(0x14A4)
+#define EXYNOS5260_CLKSTOP_CMU_ISP_SYS_PWR_REG		S5P_PMUREG(0x14A8)
+#define EXYNOS5260_CLKSTOP_CMU_MFC_SYS_PWR_REG		S5P_PMUREG(0x14B0)
+#define EXYNOS5260_DISABLE_PLL_CMU_GSCL_SYS_PWR_REG	S5P_PMUREG(0x14C0)
+#define EXYNOS5260_DISABLE_PLL_CMU_CAM0_SYS_PWR_REG	S5P_PMUREG(0x14C4)
+#define EXYNOS5260_DISABLE_PLL_CMU_MSCL_SYS_PWR_REG	S5P_PMUREG(0x14C8)
+#define EXYNOS5260_DISABLE_PLL_CMU_G3D_SYS_PWR_REG	S5P_PMUREG(0x14CC)
+#define EXYNOS5260_DISABLE_PLL_CMU_DISP_SYS_PWR_REG	S5P_PMUREG(0x14D0)
+#define EXYNOS5260_DISABLE_PLL_CMU_CAM1_SYS_PWR_REG	S5P_PMUREG(0x14D4)
+#define EXYNOS5260_DISABLE_PLL_CMU_AUD_SYS_PWR_REG	S5P_PMUREG(0x14D8)
+#define EXYNOS5260_DISABLE_PLL_CMU_FSYS_SYS_PWR_REG	S5P_PMUREG(0x14DC)
+#define EXYNOS5260_DISABLE_PLL_CMU_G2D_SYS_PWR_REG	S5P_PMUREG(0x14E4)
+#define EXYNOS5260_DISABLE_PLL_CMU_ISP_SYS_PWR_REG	S5P_PMUREG(0x14E8)
+#define EXYNOS5260_DISABLE_PLL_CMU_MFC_SYS_PWR_REG	S5P_PMUREG(0x14F0)
+#define EXYNOS5260_RESET_LOGIC_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1500)
+#define EXYNOS5260_RESET_LOGIC_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1504)
+#define EXYNOS5260_RESET_LOGIC_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1508)
+#define EXYNOS5260_RESET_LOGIC_G3D_SYS_PWR_REG		S5P_PMUREG(0x150C)
+#define EXYNOS5260_RESET_LOGIC_DISP_SYS_PWR_REG		S5P_PMUREG(0x1510)
+#define EXYNOS5260_RESET_LOGIC_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1514)
+#define EXYNOS5260_RESET_LOGIC_AUD_SYS_PWR_REG		S5P_PMUREG(0x1518)
+#define EXYNOS5260_RESET_LOGIC_FSYS_SYS_PWR_REG		S5P_PMUREG(0x151C)
+#define EXYNOS5260_RESET_LOGIC_G2D_SYS_PWR_REG		S5P_PMUREG(0x1524)
+#define EXYNOS5260_RESET_LOGIC_ISP_SYS_PWR_REG		S5P_PMUREG(0x1528)
+#define EXYNOS5260_RESET_LOGIC_MFC_SYS_PWR_REG		S5P_PMUREG(0x1530)
+#define EXYNOS5260_MEMORY_G2D_SYS_PWR_REG		S5P_PMUREG(0x1564)
+#define EXYNOS5260_RESET_CMU_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1580)
+#define EXYNOS5260_RESET_CMU_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1584)
+#define EXYNOS5260_RESET_CMU_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1588)
+#define EXYNOS5260_RESET_CMU_G3D_SYS_PWR_REG		S5P_PMUREG(0x158C)
+#define EXYNOS5260_RESET_CMU_DISP_SYS_PWR_REG		S5P_PMUREG(0x1590)
+#define EXYNOS5260_RESET_CMU_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1594)
+#define EXYNOS5260_RESET_CMU_AUD_SYS_PWR_REG		S5P_PMUREG(0x1598)
+#define EXYNOS5260_RESET_CMU_FSYS_SYS_PWR_REG		S5P_PMUREG(0x159C)
+#define EXYNOS5260_RESET_CMU_G2D_SYS_PWR_REG		S5P_PMUREG(0x15A4)
+#define EXYNOS5260_RESET_CMU_ISP_SYS_PWR_REG		S5P_PMUREG(0x15A8)
+#define EXYNOS5260_RESET_CMU_MFC_SYS_PWR_REG		S5P_PMUREG(0x15B0)
+#define EXYNOS5260_SEQ_TRANSITION0			S5P_PMUREG(0x0220)
+#define EXYNOS5260_SEQ_TRANSITION1			S5P_PMUREG(0x0224)
+#define EXYNOS5260_SEQ_TRANSITION2			S5P_PMUREG(0x0228)
+#define EXYNOS5260_EAGLE_NONCPU_OPTION			S5P_PMUREG(0x2408)
+#define EXYNOS5260_KFC_NONCPU_OPTION			S5P_PMUREG(0x2428)
+#define EXYNOS5260_DISP_OPTION				S5P_PMUREG(0x4088)
+#define EXYNOS5260_G2D_OPTION				S5P_PMUREG(0x4128)
+#define EXYNOS5260_ISP_OPTION				S5P_PMUREG(0x4148)
+#define EXYNOS5260_MFC_OPTION				S5P_PMUREG(0x4188)
+#define EXYNOS5260_EAGLE_L2_OPTION			S5P_PMUREG(0x2608)
+#define EXYNOS5260_KFC_L2_OPTION			S5P_PMUREG(0x2628)
+#define EXYNOS5260_EAGLE_L2_STATUS			S5P_PMUREG(0x2604)
+#define EXYNOS5260_KFC_L2_STATUS			S5P_PMUREG(0x2624)
+
+/* CENTRAL_SEQ_OPTION */
+#define EXYNOS5260_ARM_USE_STANDBY_WFI0			(1 << 16)
+#define EXYNOS5260_ARM_USE_STANDBY_WFI1			(1 << 17)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI0			(1 << 20)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI1			(1 << 21)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI2			(1 << 22)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI3			(1 << 23)
+#define EXYNOS5260_ARM_USE_STANDBY_WFE0			(1 << 24)
+#define EXYNOS5260_ARM_USE_STANDBY_WFE1			(1 << 25)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE0			(1 << 28)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE1			(1 << 29)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE2			(1 << 30)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE3			(1 << 31)
 
 #endif /* __ASM_ARCH_REGS_PMU_H */
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index d762533..d8fd9ed 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -49,6 +49,7 @@ extern unsigned long samsung_cpu_id;
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5260_SOC_ID	0xE5260000
 #define EXYNOS5420_SOC_ID	0xE5420000
 #define EXYNOS5440_SOC_ID	0xE5440000
 #define EXYNOS5_SOC_MASK	0xFFFFF000
@@ -72,6 +73,7 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5260, EXYNOS5260_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
@@ -154,6 +156,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5250()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5260)
+# define soc_is_exynos5260()	is_samsung_exynos5260()
+#else
+# define soc_is_exynos5260()	0
+#endif
+
 #if defined(CONFIG_SOC_EXYNOS5420)
 # define soc_is_exynos5420()	is_samsung_exynos5420()
 #else
-- 
1.7.9.5

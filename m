From: boyko.lee@samsung.com (Jongpill Lee)
Date: Mon, 19 Sep 2011 10:23:30 +0900
Subject: [PATCH 3/3] ARM: EXYNOS4: Support suspend/resume for EXYNOS4212
In-Reply-To: <1316395410-12023-1-git-send-email-boyko.lee@samsung.com>
References: <1316395410-12023-1-git-send-email-boyko.lee@samsung.com>
Message-ID: <1316395410-12023-3-git-send-email-boyko.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds suspend and resume function for EXYNOS4212.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
---
 arch/arm/mach-exynos4/pm.c  |    7 +++
 arch/arm/mach-exynos4/pmu.c |  118 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 62e4f43..509a435 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -339,6 +339,13 @@ static int exynos4_pm_suspend(void)
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
+	if (soc_is_exynos4212()) {
+		tmp = __raw_readl(S5P_CENTRAL_SEQ_OPTION);
+		tmp &= ~(S5P_USE_STANDBYWFI_ISP_ARM |
+			 S5P_USE_STANDBYWFE_ISP_ARM);
+		__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	}
+
 	/* Save Power control register */
 	asm ("mrc p15, 0, %0, c15, c0, 0"
 	     : "=r" (tmp) : : "cc");
diff --git a/arch/arm/mach-exynos4/pmu.c b/arch/arm/mach-exynos4/pmu.c
index 02bfa0d..bba48f5 100644
--- a/arch/arm/mach-exynos4/pmu.c
+++ b/arch/arm/mach-exynos4/pmu.c
@@ -94,6 +94,114 @@ static struct exynos4_pmu_conf exynos4210_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static struct exynos4_pmu_conf exynos4212_pmu_config[] = {
+	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ISP_ARM_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_ISP_ARM_LOCAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_ISP_ARM_CENTRAL_LOWPWR,	{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
+	{ S5P_L2_0_LOWPWR,			{ 0x0, 0x0, 0x3 } },
+	/* XXX_OPTION register should be set other field */
+	{ S5P_ARM_L2_0_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_L2_1_LOWPWR,			{ 0x0, 0x0, 0x3 } },
+	{ S5P_ARM_L2_1_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_DRAM_FREQ_DOWN_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_DDRPHY_DLLOFF_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_LPDDR_PHY_DLL_LOCK_LOWPWR,	{ 0x1, 0x1, 0x1 } },
+	{ S5P_CMU_ACLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_COREBLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_MPLLUSER_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
+	{ S5P_TOP_BUS_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_COREBLK_LOWPWR,		{ 0x3, 0x0, 0x3 } },
+	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_OSCCLK_GATE_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_LOGIC_RESET_COREBLK_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_OSCCLK_GATE_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x1 } },
+	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_ONENAND_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_HSI_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSI_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_G2D_ACP_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_USBOTG_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSMMC_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_CSSYS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SECSS_MEM_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ S5P_ROTATOR_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_ROTATOR_MEM_OPTION,		{ 0x10, 0x10, 0x0 } },
+	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_COREBLK_LOWPWR,{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_ISOLATION_COREBLK_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_COREBLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_TOP_ASB_RESET_LOWPWR,		{ 0x1, 0x1, 0x1 } },
+	{ S5P_TOP_ASB_ISOLATION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_ISP_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
+	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_CMU_SYSCLK_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SYSCLK_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
 void exynos4_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
@@ -107,7 +215,15 @@ static int __init exynos4_pmu_init(void)
 {
 	exynos4_pmu_config = exynos4210_pmu_config;
 
-	pr_info("EXYNOS4210 PMU Initialize\n");
+	if (soc_is_exynos4210()) {
+		exynos4_pmu_config = exynos4210_pmu_config;
+		pr_info("EXYNOS4210 PMU Initialize\n");
+	} else if (soc_is_exynos4212()) {
+		exynos4_pmu_config = exynos4212_pmu_config;
+		pr_info("EXYNOS4212 PMU Initialize\n");
+	} else {
+		pr_info("EXYNOS4: PMU not supported\n");
+	}
 
 	return 0;
 }
-- 
1.7.1

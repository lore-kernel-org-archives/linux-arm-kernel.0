From: boyko.lee@samsung.com (Jongpill Lee)
Date: Mon, 19 Sep 2011 10:25:40 +0900
Subject: [PATCH V2 1/3] ARM: EXYNOS4: Modify PMU register setting function
In-Reply-To: <1316395542-27578-1-git-send-email-boyko.lee@samsung.com>
References: <1316395542-27578-1-git-send-email-boyko.lee@samsung.com>
Message-ID: <1316395542-27578-2-git-send-email-boyko.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies PMU register setting function to support the other Exynos4 series.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/pmu.h      |    7 +
 arch/arm/mach-exynos4/include/mach/regs-pmu.h |    1 -
 arch/arm/mach-exynos4/pmu.c                   |  239 +++++++++----------------
 3 files changed, 96 insertions(+), 151 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/pmu.h b/arch/arm/mach-exynos4/include/mach/pmu.h
index a952904..632dd56 100644
--- a/arch/arm/mach-exynos4/include/mach/pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/pmu.h
@@ -13,6 +13,8 @@
 #ifndef __ASM_ARCH_PMU_H
 #define __ASM_ARCH_PMU_H __FILE__
 
+#define PMU_TABLE_END	NULL
+
 enum sys_powerdown {
 	SYS_AFTR,
 	SYS_LPA,
@@ -20,6 +22,11 @@ enum sys_powerdown {
 	NUM_SYS_POWERDOWN,
 };
 
+struct exynos4_pmu_conf {
+	void __iomem *reg;
+	unsigned int val[NUM_SYS_POWERDOWN];
+};
+
 extern void exynos4_sys_powerdown_conf(enum sys_powerdown mode);
 
 #endif /* __ASM_ARCH_PMU_H */
diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
index cdf9b47..7fa44b9 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
@@ -27,7 +27,6 @@
 #define S5P_USE_STANDBY_WFI1			(1 << 17)
 #define S5P_USE_STANDBY_WFE0			(1 << 24)
 #define S5P_USE_STANDBY_WFE1			(1 << 25)
-#define S5P_USE_MASK				((0x3 << 16) | (0x3 << 24))
 
 #define S5P_SWRESET				S5P_PMUREG(0x0400)
 
diff --git a/arch/arm/mach-exynos4/pmu.c b/arch/arm/mach-exynos4/pmu.c
index 7ea9eb2..02bfa0d 100644
--- a/arch/arm/mach-exynos4/pmu.c
+++ b/arch/arm/mach-exynos4/pmu.c
@@ -16,160 +16,99 @@
 #include <mach/regs-clock.h>
 #include <mach/pmu.h>
 
-static void __iomem *sys_powerdown_reg[] = {
-	S5P_ARM_CORE0_LOWPWR,
-	S5P_DIS_IRQ_CORE0,
-	S5P_DIS_IRQ_CENTRAL0,
-	S5P_ARM_CORE1_LOWPWR,
-	S5P_DIS_IRQ_CORE1,
-	S5P_DIS_IRQ_CENTRAL1,
-	S5P_ARM_COMMON_LOWPWR,
-	S5P_L2_0_LOWPWR,
-	S5P_L2_1_LOWPWR,
-	S5P_CMU_ACLKSTOP_LOWPWR,
-	S5P_CMU_SCLKSTOP_LOWPWR,
-	S5P_CMU_RESET_LOWPWR,
-	S5P_APLL_SYSCLK_LOWPWR,
-	S5P_MPLL_SYSCLK_LOWPWR,
-	S5P_VPLL_SYSCLK_LOWPWR,
-	S5P_EPLL_SYSCLK_LOWPWR,
-	S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,
-	S5P_CMU_RESET_GPSALIVE_LOWPWR,
-	S5P_CMU_CLKSTOP_CAM_LOWPWR,
-	S5P_CMU_CLKSTOP_TV_LOWPWR,
-	S5P_CMU_CLKSTOP_MFC_LOWPWR,
-	S5P_CMU_CLKSTOP_G3D_LOWPWR,
-	S5P_CMU_CLKSTOP_LCD0_LOWPWR,
-	S5P_CMU_CLKSTOP_LCD1_LOWPWR,
-	S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,
-	S5P_CMU_CLKSTOP_GPS_LOWPWR,
-	S5P_CMU_RESET_CAM_LOWPWR,
-	S5P_CMU_RESET_TV_LOWPWR,
-	S5P_CMU_RESET_MFC_LOWPWR,
-	S5P_CMU_RESET_G3D_LOWPWR,
-	S5P_CMU_RESET_LCD0_LOWPWR,
-	S5P_CMU_RESET_LCD1_LOWPWR,
-	S5P_CMU_RESET_MAUDIO_LOWPWR,
-	S5P_CMU_RESET_GPS_LOWPWR,
-	S5P_TOP_BUS_LOWPWR,
-	S5P_TOP_RETENTION_LOWPWR,
-	S5P_TOP_PWR_LOWPWR,
-	S5P_LOGIC_RESET_LOWPWR,
-	S5P_ONENAND_MEM_LOWPWR,
-	S5P_MODIMIF_MEM_LOWPWR,
-	S5P_G2D_ACP_MEM_LOWPWR,
-	S5P_USBOTG_MEM_LOWPWR,
-	S5P_HSMMC_MEM_LOWPWR,
-	S5P_CSSYS_MEM_LOWPWR,
-	S5P_SECSS_MEM_LOWPWR,
-	S5P_PCIE_MEM_LOWPWR,
-	S5P_SATA_MEM_LOWPWR,
-	S5P_PAD_RETENTION_DRAM_LOWPWR,
-	S5P_PAD_RETENTION_MAUDIO_LOWPWR,
-	S5P_PAD_RETENTION_GPIO_LOWPWR,
-	S5P_PAD_RETENTION_UART_LOWPWR,
-	S5P_PAD_RETENTION_MMCA_LOWPWR,
-	S5P_PAD_RETENTION_MMCB_LOWPWR,
-	S5P_PAD_RETENTION_EBIA_LOWPWR,
-	S5P_PAD_RETENTION_EBIB_LOWPWR,
-	S5P_PAD_RETENTION_ISOLATION_LOWPWR,
-	S5P_PAD_RETENTION_ALV_SEL_LOWPWR,
-	S5P_XUSBXTI_LOWPWR,
-	S5P_XXTI_LOWPWR,
-	S5P_EXT_REGULATOR_LOWPWR,
-	S5P_GPIO_MODE_LOWPWR,
-	S5P_GPIO_MODE_MAUDIO_LOWPWR,
-	S5P_CAM_LOWPWR,
-	S5P_TV_LOWPWR,
-	S5P_MFC_LOWPWR,
-	S5P_G3D_LOWPWR,
-	S5P_LCD0_LOWPWR,
-	S5P_LCD1_LOWPWR,
-	S5P_MAUDIO_LOWPWR,
-	S5P_GPS_LOWPWR,
-	S5P_GPS_ALIVE_LOWPWR,
-};
+static struct exynos4_pmu_conf *exynos4_pmu_config;
 
-static const unsigned int sys_powerdown_val[][NUM_SYS_POWERDOWN] = {
-	/* { AFTR, LPA, SLEEP }*/
-	{ 0, 0, 2 },	/* ARM_CORE0 */
-	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CORE0 */
-	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CENTRAL0 */
-	{ 0, 0, 2 },	/* ARM_CORE1 */
-	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CORE1 */
-	{ 0, 0, 0 },	/* ARM_DIS_IRQ_CENTRAL1 */
-	{ 0, 0, 2 },	/* ARM_COMMON */
-	{ 2, 2, 3 },	/* ARM_CPU_L2_0 */
-	{ 2, 2, 3 },	/* ARM_CPU_L2_1 */
-	{ 1, 0, 0 },	/* CMU_ACLKSTOP */
-	{ 1, 0, 0 },	/* CMU_SCLKSTOP */
-	{ 1, 1, 0 },	/* CMU_RESET */
-	{ 1, 0, 0 },	/* APLL_SYSCLK */
-	{ 1, 0, 0 },	/* MPLL_SYSCLK */
-	{ 1, 0, 0 },	/* VPLL_SYSCLK */
-	{ 1, 1, 0 },	/* EPLL_SYSCLK */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_GPS_ALIVE */
-	{ 1, 1, 0 },	/* CMU_RESET_GPS_ALIVE */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_CAM */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_TV */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_MFC */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_G3D */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_LCD0 */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_LCD1 */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_MAUDIO */
-	{ 1, 1, 0 },	/* CMU_CLKSTOP_GPS */
-	{ 1, 1, 0 },	/* CMU_RESET_CAM */
-	{ 1, 1, 0 },	/* CMU_RESET_TV */
-	{ 1, 1, 0 },	/* CMU_RESET_MFC */
-	{ 1, 1, 0 },	/* CMU_RESET_G3D */
-	{ 1, 1, 0 },	/* CMU_RESET_LCD0 */
-	{ 1, 1, 0 },	/* CMU_RESET_LCD1 */
-	{ 1, 1, 0 },	/* CMU_RESET_MAUDIO */
-	{ 1, 1, 0 },	/* CMU_RESET_GPS */
-	{ 3, 0, 0 },	/* TOP_BUS */
-	{ 1, 0, 1 },	/* TOP_RETENTION */
-	{ 3, 0, 3 },	/* TOP_PWR */
-	{ 1, 1, 0 },	/* LOGIC_RESET */
-	{ 3, 0, 0 },	/* ONENAND_MEM */
-	{ 3, 0, 0 },	/* MODIMIF_MEM */
-	{ 3, 0, 0 },	/* G2D_ACP_MEM */
-	{ 3, 0, 0 },	/* USBOTG_MEM */
-	{ 3, 0, 0 },	/* HSMMC_MEM */
-	{ 3, 0, 0 },	/* CSSYS_MEM */
-	{ 3, 0, 0 },	/* SECSS_MEM */
-	{ 3, 0, 0 },	/* PCIE_MEM */
-	{ 3, 0, 0 },	/* SATA_MEM */
-	{ 1, 0, 0 },	/* PAD_RETENTION_DRAM */
-	{ 1, 1, 0 },	/* PAD_RETENTION_MAUDIO */
-	{ 1, 0, 0 },	/* PAD_RETENTION_GPIO */
-	{ 1, 0, 0 },	/* PAD_RETENTION_UART */
-	{ 1, 0, 0 },	/* PAD_RETENTION_MMCA */
-	{ 1, 0, 0 },	/* PAD_RETENTION_MMCB */
-	{ 1, 0, 0 },	/* PAD_RETENTION_EBIA */
-	{ 1, 0, 0 },	/* PAD_RETENTION_EBIB */
-	{ 1, 0, 0 },	/* PAD_RETENTION_ISOLATION */
-	{ 1, 0, 0 },	/* PAD_RETENTION_ALV_SEL */
-	{ 1, 1, 0 },	/* XUSBXTI */
-	{ 1, 1, 0 },	/* XXTI */
-	{ 1, 1, 0 },	/* EXT_REGULATOR */
-	{ 1, 0, 0 },	/* GPIO_MODE */
-	{ 1, 1, 0 },	/* GPIO_MODE_MAUDIO */
-	{ 7, 0, 0 },	/* CAM */
-	{ 7, 0, 0 },	/* TV */
-	{ 7, 0, 0 },	/* MFC */
-	{ 7, 0, 0 },	/* G3D */
-	{ 7, 0, 0 },	/* LCD0 */
-	{ 7, 0, 0 },	/* LCD1 */
-	{ 7, 7, 0 },	/* MAUDIO */
-	{ 7, 0, 0 },	/* GPS */
-	{ 7, 0, 0 },	/* GPS_ALIVE */
+static struct exynos4_pmu_conf exynos4210_pmu_config[] = {
+	/* { .reg = address, .val = { AFTR, LPA, SLEEP } */
+	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_CORE1_LOWPWR,			{ 0x0, 0x0, 0x2 } },
+	{ S5P_DIS_IRQ_CORE1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_DIS_IRQ_CENTRAL1,			{ 0x0, 0x0, 0x0 } },
+	{ S5P_ARM_COMMON_LOWPWR,		{ 0x0, 0x0, 0x2 } },
+	{ S5P_L2_0_LOWPWR,			{ 0x2, 0x2, 0x3 } },
+	{ S5P_L2_1_LOWPWR,			{ 0x2, 0x2, 0x3 } },
+	{ S5P_CMU_ACLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_SCLKSTOP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_CMU_RESET_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_APLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_MPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_VPLL_SYSCLK_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ S5P_EPLL_SYSCLK_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPSALIVE_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_CLKSTOP_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_CAM_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_TV_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_MFC_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_G3D_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_LCD0_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_LCD1_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CMU_RESET_GPS_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_TOP_BUS_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_TOP_RETENTION_LOWPWR,		{ 0x1, 0x0, 0x1 } },
+	{ S5P_TOP_PWR_LOWPWR,			{ 0x3, 0x0, 0x3 } },
+	{ S5P_LOGIC_RESET_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_ONENAND_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_MODIMIF_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_G2D_ACP_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_USBOTG_MEM_LOWPWR,		{ 0x3, 0x0, 0x0 } },
+	{ S5P_HSMMC_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_CSSYS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SECSS_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_PCIE_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_SATA_MEM_LOWPWR,			{ 0x3, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_DRAM_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MAUDIO_LOWPWR,	{ 0x1, 0x1, 0x0 } },
+	{ S5P_PAD_RETENTION_GPIO_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_UART_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_MMCB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIA_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_EBIB_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ISOLATION_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_PAD_RETENTION_ALV_SEL_LOWPWR,	{ 0x1, 0x0, 0x0 } },
+	{ S5P_XUSBXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_XXTI_LOWPWR,			{ 0x1, 0x1, 0x0 } },
+	{ S5P_EXT_REGULATOR_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_GPIO_MODE_LOWPWR,			{ 0x1, 0x0, 0x0 } },
+	{ S5P_GPIO_MODE_MAUDIO_LOWPWR,		{ 0x1, 0x1, 0x0 } },
+	{ S5P_CAM_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_TV_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MFC_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_G3D_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD0_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_LCD1_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_MAUDIO_LOWPWR,			{ 0x7, 0x7, 0x0 } },
+	{ S5P_GPS_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
 };
 
 void exynos4_sys_powerdown_conf(enum sys_powerdown mode)
 {
-	unsigned int count = ARRAY_SIZE(sys_powerdown_reg);
+	unsigned int i;
+
+	for (i = 0; (exynos4_pmu_config[i].reg != PMU_TABLE_END) ; i++)
+		__raw_writel(exynos4_pmu_config[i].val[mode],
+				exynos4_pmu_config[i].reg);
+}
+
+static int __init exynos4_pmu_init(void)
+{
+	exynos4_pmu_config = exynos4210_pmu_config;
+
+	pr_info("EXYNOS4210 PMU Initialize\n");
 
-	for (; count > 0; count--)
-		__raw_writel(sys_powerdown_val[count - 1][mode],
-				sys_powerdown_reg[count - 1]);
+	return 0;
 }
+arch_initcall(exynos4_pmu_init);
-- 
1.7.1

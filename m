From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 16 Dec 2013 17:31:10 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
Message-ID: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMU configuration table for various low power modes - AFTR/LPA/SLEEP.
Also, add core s2r support for Exynos5420.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
This patch depends on "ARM: EXYNOS5: Add PMU settings for exynos5420"
http://www.spinics.net/lists/linux-samsung-soc/msg24902.html

 arch/arm/mach-exynos/include/mach/regs-clock.h |   15 +++
 arch/arm/mach-exynos/include/mach/regs-pmu.h   |   84 ++++++++++++
 arch/arm/mach-exynos/pm.c                      |  151 +++++++++++++++++++---
 arch/arm/mach-exynos/pmu.c                     |  165 ++++++++++++++++++++++++
 4 files changed, 396 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index d36ad76..20008f6 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -363,6 +363,21 @@
 #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
+/* For EXYNOS5420 */
+#define EXYNOS5420_CLKSRC_MASK_CPERI		EXYNOS_CLKREG(0x04300)
+#define EXYNOS5420_CLKSRC_MASK_TOP0		EXYNOS_CLKREG(0x10300)
+#define EXYNOS5420_CLKSRC_MASK_TOP1		EXYNOS_CLKREG(0x10304)
+#define EXYNOS5420_CLKSRC_MASK_TOP2		EXYNOS_CLKREG(0x10308)
+#define EXYNOS5420_CLKSRC_MASK_TOP7		EXYNOS_CLKREG(0x1031C)
+#define EXYNOS5420_CLKSRC_MASK_DISP10		EXYNOS_CLKREG(0x1032C)
+#define EXYNOS5420_CLKSRC_MASK_MAU		EXYNOS_CLKREG(0x10334)
+#define EXYNOS5420_CLKSRC_MASK_FSYS		EXYNOS_CLKREG(0x10340)
+#define EXYNOS5420_CLKSRC_MASK_PERIC0		EXYNOS_CLKREG(0x10350)
+#define EXYNOS5420_CLKSRC_MASK_PERIC1		EXYNOS_CLKREG(0x10354)
+#define EXYNOS5420_CLKSRC_MASK_ISP		EXYNOS_CLKREG(0x10370)
+#define EXYNOS5420_CLKGATE_BUS_DISP1		EXYNOS_CLKREG(0x10728)
+#define EXYNOS5420_CLKGATE_IP_PERIC		EXYNOS_CLKREG(0x10950)
+
 /* Compatibility defines and inclusion */
 
 #include <mach/regs-pmu.h>
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index d5d5386..ad316f3 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -229,6 +229,7 @@
 
 /* For EXYNOS5 */
 
+#define EXYNOS5_SYS_DISP1_BLK_CFG				S5P_SYSREG(0x0214)
 #define EXYNOS5_SYS_I2C_CFG					S5P_SYSREG(0x0234)
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
@@ -360,6 +361,7 @@
 #define EXYNOS5_USE_SC_COUNTER					(1 << 0)
 
 #define EXYNOS5_MANUAL_L2RSTDISABLE_CONTROL			(1 << 2)
+#define EXYNOS5_L2RSTDISABLE_VALUE				(1 << 3)
 #define EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN			(1 << 7)
 
 #define EXYNOS5_OPTION_USE_STANDBYWFE				(1 << 24)
@@ -373,6 +375,67 @@
 #define EXYNOS5420_ARM_INTR_SPREAD_ENABLE			S5P_PMUREG(0x0100)
 #define EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI		S5P_PMUREG(0x0104)
 #define EXYNOS5420_UP_SCHEDULER					S5P_PMUREG(0x0120)
+#define EXYNOS5420_IROM_DATA2					S5P_PMUREG(0x0988)
+#define EXYNOS5420_ARM_CORE2_SYS_PWR_REG			S5P_PMUREG(0x1020)
+#define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1024)
+#define EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG	S5P_PMUREG(0x1028)
+#define EXYNOS5420_ARM_CORE3_SYS_PWR_REG			S5P_PMUREG(0x1030)
+#define EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1034)
+#define EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG	S5P_PMUREG(0x1038)
+#define EXYNOS5420_KFC_CORE0_SYS_PWR_REG			S5P_PMUREG(0x1040)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1044)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG	S5P_PMUREG(0x1048)
+#define EXYNOS5420_KFC_CORE1_SYS_PWR_REG			S5P_PMUREG(0x1050)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1054)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG	S5P_PMUREG(0x1058)
+#define EXYNOS5420_KFC_CORE2_SYS_PWR_REG			S5P_PMUREG(0x1060)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1064)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG	S5P_PMUREG(0x1068)
+#define EXYNOS5420_KFC_CORE3_SYS_PWR_REG			S5P_PMUREG(0x1070)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1074)
+#define EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG	S5P_PMUREG(0x1078)
+#define EXYNOS5420_ISP_ARM_SYS_PWR_REG				S5P_PMUREG(0x1090)
+#define EXYNOS5420_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG		S5P_PMUREG(0x1094)
+#define EXYNOS5420_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG		S5P_PMUREG(0x1098)
+#define EXYNOS5420_ARM_COMMON_SYS_PWR_REG			S5P_PMUREG(0x10A0)
+#define EXYNOS5420_KFC_COMMON_SYS_PWR_REG			S5P_PMUREG(0x10B0)
+#define EXYNOS5420_KFC_L2_SYS_PWR_REG				S5P_PMUREG(0x10D0)
+#define EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG			S5P_PMUREG(0x1158)
+#define EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG			S5P_PMUREG(0x115C)
+#define EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG			S5P_PMUREG(0x1160)
+#define EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG			S5P_PMUREG(0x1174)
+#define EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG			S5P_PMUREG(0x1178)
+#define EXYNOS5420_INTRAM_MEM_SYS_PWR_REG			S5P_PMUREG(0x11B8)
+#define EXYNOS5420_INTROM_MEM_SYS_PWR_REG			S5P_PMUREG(0x11BC)
+#define EXYNOS5420_ONENANDXL_MEM_SYS_PWR			S5P_PMUREG(0x11C0)
+#define EXYNOS5420_USBDEV_MEM_SYS_PWR				S5P_PMUREG(0x11CC)
+#define EXYNOS5420_USBDEV1_MEM_SYS_PWR				S5P_PMUREG(0x11D0)
+#define EXYNOS5420_SDMMC_MEM_SYS_PWR				S5P_PMUREG(0x11D4)
+#define EXYNOS5420_CSSYS_MEM_SYS_PWR				S5P_PMUREG(0x11D8)
+#define EXYNOS5420_SECSS_MEM_SYS_PWR				S5P_PMUREG(0x11DC)
+#define EXYNOS5420_ROTATOR_MEM_SYS_PWR				S5P_PMUREG(0x11E0)
+#define EXYNOS5420_INTRAM_MEM_SYS_PWR				S5P_PMUREG(0x11E4)
+#define EXYNOS5420_INTROM_MEM_SYS_PWR				S5P_PMUREG(0x11E8)
+#define EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG		S5P_PMUREG(0x1208)
+#define EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG		S5P_PMUREG(0x1210)
+#define EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG		S5P_PMUREG(0x1214)
+#define EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG		S5P_PMUREG(0x1218)
+#define EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG		S5P_PMUREG(0x121C)
+#define EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG		S5P_PMUREG(0x1220)
+#define EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG		S5P_PMUREG(0x1224)
+#define EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG		S5P_PMUREG(0x1228)
+#define EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG		S5P_PMUREG(0x122C)
+#define EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG		S5P_PMUREG(0x1230)
+#define EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG	S5P_PMUREG(0x1234)
+#define EXYNOS5420_DISP1_SYS_PWR_REG				S5P_PMUREG(0x1410)
+#define EXYNOS5420_MAU_SYS_PWR_REG				S5P_PMUREG(0x1414)
+#define EXYNOS5420_G2D_SYS_PWR_REG				S5P_PMUREG(0x1418)
+#define EXYNOS5420_MSC_SYS_PWR_REG				S5P_PMUREG(0x141C)
+#define EXYNOS5420_FSYS_SYS_PWR_REG				S5P_PMUREG(0x1420)
+#define EXYNOS5420_FSYS2_SYS_PWR_REG				S5P_PMUREG(0x1424)
+#define EXYNOS5420_PSGEN_SYS_PWR_REG				S5P_PMUREG(0x1428)
+#define EXYNOS5420_PERIC_SYS_PWR_REG				S5P_PMUREG(0x142C)
+#define EXYNOS5420_WCORE_SYS_PWR_REG				S5P_PMUREG(0x1430)
 #define EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG		S5P_PMUREG(0x1490)
 #define EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG			S5P_PMUREG(0x1494)
 #define EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG			S5P_PMUREG(0x1498)
@@ -402,6 +465,7 @@
 #define EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG			S5P_PMUREG(0x1598)
 #define EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG			S5P_PMUREG(0x159C)
 #define EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG			S5P_PMUREG(0x15A0)
+#define EXYNOS5420_SFR_AXI_CGDIS1				S5P_PMUREG(0x15E4)
 #define EXYNOS5420_ARM_COMMON_STATUS				S5P_PMUREG(0x2504)
 #define EXYNOS5420_ARM_COMMON_OPTION				S5P_PMUREG(0x2508)
 #define EXYNOS5420_KFC_COMMON_STATUS				S5P_PMUREG(0x2584)
@@ -410,7 +474,24 @@
 #define EXYNOS5420_KFC_L2_OPTION				S5P_PMUREG(0x2688)
 #define EXYNOS5420_LOGIC_RESET_DURATION3			S5P_PMUREG(0x2D1C)
 
+#define EXYNOS5420_PAD_RET_DRAM_OPTION				S5P_PMUREG(0x3008)
+#define EXYNOS5420_PAD_RET_MAUDIO_OPTION			S5P_PMUREG(0x3028)
+#define EXYNOS5420_PAD_RET_JTAG_OPTION				S5P_PMUREG(0x3048)
+#define EXYNOS5420_PAD_RET_GPIO_OPTION				S5P_PMUREG(0x30C8)
+#define EXYNOS5420_PAD_RET_UART_OPTION				S5P_PMUREG(0x30E8)
+#define EXYNOS5420_PAD_RET_MMCA_OPTION				S5P_PMUREG(0x3108)
+#define EXYNOS5420_PAD_RET_MMCB_OPTION				S5P_PMUREG(0x3128)
+#define EXYNOS5420_PAD_RET_MMCC_OPTION				S5P_PMUREG(0x3148)
+#define EXYNOS5420_PAD_RET_HSI_OPTION				S5P_PMUREG(0x3168)
+#define EXYNOS5420_PAD_RET_EBIA_OPTION				S5P_PMUREG(0x3188)
+#define EXYNOS5420_PAD_RET_EBIB_OPTION				S5P_PMUREG(0x31A8)
+#define EXYNOS5420_PAD_RET_SPI_OPTION				S5P_PMUREG(0x31C8)
+#define EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION			S5P_PMUREG(0x31E8)
+
+
 #define EXYNOS5_XXTI_DURATION3					S5P_PMUREG(0x343C)
+#define EXYNOS5420_FSYS2_OPTION					S5P_PMUREG(0x4168)
+#define EXYNOS5420_PSGEN_OPTION					S5P_PMUREG(0x4188)
 
 /* For EXYNOS_CENTRAL_SEQ_OPTION */
 #define EXYNOS5420_ARM_USE_STANDBY_WFI0				(1 << 4)
@@ -447,4 +528,7 @@
 #define SPREAD_USE_STANDWFI					0xF
 #define EXYNOS5420_SWRESET_KFC_SEL				0x3
 
+#define EXYNOS5420_UFS						(1 << 8)
+#define EXYNOS5420_EMULATION					(1 << 31)
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 7fb0f13..3ad103f 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -52,6 +52,22 @@ static const struct sleep_save exynos4210_set_clksrc[] = {
 	{ .reg = EXYNOS4210_CLKSRC_MASK_LCD1		, .val = 0x00001111, },
 };
 
+static struct sleep_save exynos5420_set_clksrc[] = {
+	{ .reg = EXYNOS5420_CLKSRC_MASK_CPERI,		.val = 0xffffffff, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_TOP0,		.val = 0x11111111, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_TOP1,		.val = 0x11101111, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_TOP2,		.val = 0x11111110, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_TOP7,		.val = 0x00111100, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_DISP10,		.val = 0x11111110, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_MAU,		.val = 0x10000000, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_FSYS,		.val = 0x11111110, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_PERIC0,		.val = 0x11111110, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_PERIC1,		.val = 0x11111100, },
+	{ .reg = EXYNOS5420_CLKSRC_MASK_ISP,		.val = 0x11111000, },
+	{ .reg = EXYNOS5420_CLKGATE_BUS_DISP1,		.val = 0xffffffff, },
+	{ .reg = EXYNOS5420_CLKGATE_IP_PERIC,		.val = 0xffffffff, },
+};
+
 static struct sleep_save exynos4_epll_save[] = {
 	SAVE_ITEM(EXYNOS4_EPLL_CON0),
 	SAVE_ITEM(EXYNOS4_EPLL_CON1),
@@ -66,6 +82,14 @@ static struct sleep_save exynos5_sys_save[] = {
 	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
 };
 
+static struct sleep_save exynos5420_sys_save[] = {
+	SAVE_ITEM(EXYNOS5_SYS_DISP1_BLK_CFG),
+};
+
+static struct sleep_save exynos5420_cpustate_save[] = {
+	SAVE_ITEM(S5P_VA_SYSRAM + 0x28),
+};
+
 static struct sleep_save exynos_core_save[] = {
 	/* SROM side */
 	SAVE_ITEM(S5P_SROM_BW),
@@ -84,8 +108,15 @@ static int exynos_cpu_suspend(unsigned long arg)
 #ifdef CONFIG_CACHE_L2X0
 	outer_flush_all();
 #endif
+	/*
+	 * Clear the IRAM register that holds a low power flag. The presence
+	 * of this flag decides if the primary cpu starts executing the low
+	 * power function@wake-up or not.
+	 */
+	if (soc_is_exynos5420())
+		__raw_writel(0x0, S5P_VA_SYSRAM + 0x28);
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5420())
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -101,9 +132,14 @@ static void exynos_pm_prepare(void)
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250()) {
+	if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
 		s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
 		s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
+	} else if (soc_is_exynos5420()) {
+		s3c_pm_do_save(exynos5420_sys_save,
+					ARRAY_SIZE(exynos5420_sys_save));
+		s3c_pm_do_save(exynos5420_cpustate_save,
+			ARRAY_SIZE(exynos5420_cpustate_save));
 	} else {
 		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
 		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
@@ -123,12 +159,32 @@ static void exynos_pm_prepare(void)
 
 	/* Before enter central sequence mode, clock src register have to set */
 
-	if (!soc_is_exynos5250())
+	if (!(soc_is_exynos5250() || soc_is_exynos5420()))
 		s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
 
 	if (soc_is_exynos4210())
 		s3c_pm_do_restore_core(exynos4210_set_clksrc, ARRAY_SIZE(exynos4210_set_clksrc));
 
+	if (soc_is_exynos5420()) {
+		s3c_pm_do_restore_core(exynos5420_set_clksrc,
+				ARRAY_SIZE(exynos5420_set_clksrc));
+
+		tmp = __raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
+		tmp |= EXYNOS5420_UFS;
+		__raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
+
+		tmp = __raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
+		tmp &= ~EXYNOS5_L2RSTDISABLE_VALUE;
+		__raw_writel(tmp, EXYNOS5420_ARM_COMMON_OPTION);
+
+		tmp = __raw_readl(EXYNOS5420_FSYS2_OPTION);
+		tmp |= EXYNOS5420_EMULATION;
+		__raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
+
+		tmp = __raw_readl(EXYNOS5420_PSGEN_OPTION);
+		tmp |= EXYNOS5420_EMULATION;
+		__raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
+	}
 }
 
 static int exynos_pm_add(struct device *dev, struct subsys_interface *sif)
@@ -224,11 +280,17 @@ static __init int exynos_pm_drvinit(void)
 
 	/* All wakeup disable */
 
-	tmp = __raw_readl(S5P_WAKEUP_MASK);
-	tmp |= ((0xFF << 8) | (0x1F << 1));
-	__raw_writel(tmp, S5P_WAKEUP_MASK);
+	if (soc_is_exynos5420()) {
+		tmp = __raw_readl(S5P_WAKEUP_MASK);
+		tmp |= ((0x7F << 7) | (0x1F << 1));
+		__raw_writel(tmp, S5P_WAKEUP_MASK);
+	} else {
+		tmp = __raw_readl(S5P_WAKEUP_MASK);
+		tmp |= ((0xFF << 8) | (0x1F << 1));
+		__raw_writel(tmp, S5P_WAKEUP_MASK);
+	}
 
-	if (!soc_is_exynos5250()) {
+	if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
 		pll_base = clk_get(NULL, "xtal");
 
 		if (!IS_ERR(pll_base)) {
@@ -244,6 +306,7 @@ arch_initcall(exynos_pm_drvinit);
 static int exynos_pm_suspend(void)
 {
 	unsigned long tmp;
+	unsigned int cluster_id;
 
 	/* Setting Central Sequence Register for power down mode */
 
@@ -253,10 +316,20 @@ static int exynos_pm_suspend(void)
 
 	/* Setting SEQ_OPTION register */
 
-	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	if (soc_is_exynos5420()) {
+		cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
+		if (!cluster_id)
+			__raw_writel(EXYNOS5420_ARM_USE_STANDBY_WFI0,
+				     S5P_CENTRAL_SEQ_OPTION);
+		else
+			__raw_writel(EXYNOS5420_KFC_USE_STANDBY_WFI0,
+				     S5P_CENTRAL_SEQ_OPTION);
+	} else if (soc_is_exynos5250()) {
+		tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+		__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	}
 
-	if (!soc_is_exynos5250()) {
+	if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
 		/* Save Power control register */
 		asm ("mrc p15, 0, %0, c15, c0, 0"
 		     : "=r" (tmp) : : "cc");
@@ -275,6 +348,15 @@ static void exynos_pm_resume(void)
 {
 	unsigned long tmp;
 
+	if (soc_is_exynos5420()) {
+		/* Restore the low power flag */
+		s3c_pm_do_restore(exynos5420_cpustate_save,
+			ARRAY_SIZE(exynos5420_cpustate_save));
+
+		__raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
+			S5P_CENTRAL_SEQ_OPTION);
+	}
+
 	/*
 	 * If PMU failed while entering sleep mode, WFI will be
 	 * ignored by PMU and then exiting cpu_do_idle().
@@ -290,7 +372,7 @@ static void exynos_pm_resume(void)
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
-	if (!soc_is_exynos5250()) {
+	if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
 		/* Restore Power control register */
 		tmp = save_arm_register[0];
 		asm volatile ("mcr p15, 0, %0, c15, c0, 0"
@@ -306,21 +388,40 @@ static void exynos_pm_resume(void)
 
 	/* For release retention */
 
-	__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
-	__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
+	 if (soc_is_exynos5420()) {
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_DRAM_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_MAUDIO_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_JTAG_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_GPIO_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_UART_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCA_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCB_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_MMCC_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_HSI_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_EBIA_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_EBIB_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_SPI_OPTION);
+		__raw_writel((1 << 28), EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION);
+	} else {
+		__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
+		__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
+	}
 
 	if (soc_is_exynos5250())
 		s3c_pm_do_restore(exynos5_sys_save,
 			ARRAY_SIZE(exynos5_sys_save));
+	else if (soc_is_exynos5420())
+		s3c_pm_do_restore(exynos5420_sys_save,
+			ARRAY_SIZE(exynos5420_sys_save));
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250()) {
+	if (!(soc_is_exynos5250() || soc_is_exynos5420())) {
 		exynos4_restore_pll();
 
 #ifdef CONFIG_SMP
@@ -330,6 +431,18 @@ static void exynos_pm_resume(void)
 
 early_wakeup:
 
+	if (soc_is_exynos5420()) {
+		tmp = __raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
+		tmp &= ~EXYNOS5420_UFS;
+		__raw_writel(tmp, EXYNOS5420_SFR_AXI_CGDIS1);
+		tmp = __raw_readl(EXYNOS5420_FSYS2_OPTION);
+		tmp &= ~EXYNOS5420_EMULATION;
+		__raw_writel(tmp, EXYNOS5420_FSYS2_OPTION);
+		tmp = __raw_readl(EXYNOS5420_PSGEN_OPTION);
+		tmp &= ~EXYNOS5420_EMULATION;
+		__raw_writel(tmp, EXYNOS5420_PSGEN_OPTION);
+	}
+
 	/* Clear SLEEP mode set in INFORM1 */
 	__raw_writel(0x0, S5P_INFORM1);
 
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index e39cc75..1449404 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -16,6 +16,8 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
 
+#include <asm/cputype.h>
+
 #include "common.h"
 
 static const struct exynos_pmu_conf *exynos_pmu_config;
@@ -318,6 +320,151 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static struct exynos_pmu_conf exynos5420_pmu_config[] = {
+	/* { .reg = address, .val = { AFTR, LPA, SLEEP } */
+	{ EXYNOS5_ARM_CORE0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ARM_CORE1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_ARM_CORE2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_ARM_CORE3_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE0_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE1_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_CORE3_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ISP_ARM_SYS_PWR_REG,				{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_ARM_COMMON_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_COMMON_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_ARM_L2_SYS_PWR_REG,				{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_KFC_L2_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,			{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,				{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,			{ 0x1, 0x1, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,				{ 0x3, 0x3, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_LOGIC_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,			{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5420_INTROM_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_XUSBXTI_SYS_PWR_REG,				{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_XXTI_SYS_PWR_REG,				{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_GPIO_MODE_SYS_PWR_REG,			{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_GSCL_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_ISP_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_MFC_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_G3D_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_DISP1_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_MAU_SYS_PWR_REG,				{ 0x7, 0x7, 0x0} },
+	{ EXYNOS5420_G2D_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_MSC_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_FSYS_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_FSYS2_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_PSGEN_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_PERIC_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5420_WCORE_SYS_PWR_REG,				{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ PMU_TABLE_END,},
+};
+
 static void __iomem * const exynos5_list_both_cnt_feed[] = {
 	EXYNOS5_ARM_CORE0_OPTION,
 	EXYNOS5_ARM_CORE1_OPTION,
@@ -410,6 +557,20 @@ static void exynos5_init_pmu(void)
 		__raw_writel(tmp, exynos5_list_diable_wfi_wfe[i]);
 	}
 }
+/*
+ * exynos_set_core_flag - set the cluster id to IROM register
+ *			  to ensure that we wake up with the
+ *			  current cluster.
+ */
+static void exynos_set_core_flag(void)
+{
+	int cluster_id = (read_cpuid_mpidr() >> 8) & 0xf;
+
+	if (cluster_id)
+		__raw_writel(1, EXYNOS5420_IROM_DATA2);
+	else
+		__raw_writel(0, EXYNOS5420_IROM_DATA2);
+}
 
 void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
@@ -418,6 +579,9 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	if (soc_is_exynos5250())
 		exynos5_init_pmu();
 
+	if (soc_is_exynos5420())
+		exynos_set_core_flag();
+
 	for (i = 0; (exynos_pmu_config[i].reg != PMU_TABLE_END) ; i++)
 		__raw_writel(exynos_pmu_config[i].val[mode],
 				exynos_pmu_config[i].reg);
@@ -520,6 +684,7 @@ static int __init exynos_pmu_init(void)
 			EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
 		__raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
 
+		exynos_pmu_config = exynos5420_pmu_config;
 		pr_info("EXYNOS5420 PMU Initialized\n");
 	} else {
 		pr_info("EXYNOS: PMU not supported\n");
-- 
1.7.9.5

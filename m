From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 17:46:40 +0900
Subject: [PATCH 2/7] ARM: EXYNOS4: Remove PMU configuration for S2RAM
In-Reply-To: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1308732405-16664-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

PMU(Power Management Unit) configuraion for S2RAM(SLEEP) is removed
and using function which provided by PMU support code to configure
PMU register.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   77 +------------------------------------------
 1 files changed, 2 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 8755ca8..a073a01 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -30,80 +30,7 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
 #include <mach/pm-core.h>
-
-static struct sleep_save exynos4_sleep[] = {
-	{ .reg = S5P_ARM_CORE0_LOWPWR			, .val = 0x2, },
-	{ .reg = S5P_DIS_IRQ_CORE0			, .val = 0x0, },
-	{ .reg = S5P_DIS_IRQ_CENTRAL0			, .val = 0x0, },
-	{ .reg = S5P_ARM_CORE1_LOWPWR			, .val = 0x2, },
-	{ .reg = S5P_DIS_IRQ_CORE1			, .val = 0x0, },
-	{ .reg = S5P_DIS_IRQ_CENTRAL1			, .val = 0x0, },
-	{ .reg = S5P_ARM_COMMON_LOWPWR			, .val = 0x2, },
-	{ .reg = S5P_L2_0_LOWPWR			, .val = 0x3, },
-	{ .reg = S5P_L2_1_LOWPWR			, .val = 0x3, },
-	{ .reg = S5P_CMU_ACLKSTOP_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_SCLKSTOP_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_APLL_SYSCLK_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_MPLL_SYSCLK_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_VPLL_SYSCLK_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_EPLL_SYSCLK_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_GPS_ALIVE_LOWPWR	, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_GPSALIVE_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_CAM_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_TV_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_MFC_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_G3D_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_LCD0_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_LCD1_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_MAUDIO_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_CLKSTOP_GPS_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_CAM_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_TV_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_MFC_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_G3D_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_LCD0_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_LCD1_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_MAUDIO_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CMU_RESET_GPS_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_TOP_BUS_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_TOP_RETENTION_LOWPWR		, .val = 0x1, },
-	{ .reg = S5P_TOP_PWR_LOWPWR			, .val = 0x3, },
-	{ .reg = S5P_LOGIC_RESET_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_ONENAND_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_MODIMIF_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_G2D_ACP_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_USBOTG_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_HSMMC_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_CSSYS_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_SECSS_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_PCIE_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_SATA_MEM_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_DRAM_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_MAUDIO_LOWPWR	, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_GPIO_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_UART_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_MMCA_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_MMCB_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_EBIA_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_EBIB_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_ISOLATION_LOWPWR	, .val = 0x0, },
-	{ .reg = S5P_PAD_RETENTION_ALV_SEL_LOWPWR	, .val = 0x0, },
-	{ .reg = S5P_XUSBXTI_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_XXTI_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_EXT_REGULATOR_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_GPIO_MODE_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_GPIO_MODE_MAUDIO_LOWPWR		, .val = 0x0, },
-	{ .reg = S5P_CAM_LOWPWR				, .val = 0x0, },
-	{ .reg = S5P_TV_LOWPWR				, .val = 0x0, },
-	{ .reg = S5P_MFC_LOWPWR				, .val = 0x0, },
-	{ .reg = S5P_G3D_LOWPWR				, .val = 0x0, },
-	{ .reg = S5P_LCD0_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_LCD1_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_MAUDIO_LOWPWR			, .val = 0x0, },
-	{ .reg = S5P_GPS_LOWPWR				, .val = 0x0, },
-	{ .reg = S5P_GPS_ALIVE_LOWPWR			, .val = 0x0, },
-};
+#include <mach/pmu.h>
 
 static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = S5P_CLKSRC_MASK_TOP			, .val = 0x00000001, },
@@ -331,7 +258,7 @@ static void exynos4_pm_prepare(void)
 
 	/* Set value of power down register for sleep mode */
 
-	s3c_pm_do_restore_core(exynos4_sleep, ARRAY_SIZE(exynos4_sleep));
+	exynos4_sys_powerdown_conf(SYS_SLEEP);
 	__raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
 
 	/* ensure at least INFORM0 has the resume address */
-- 
1.7.1

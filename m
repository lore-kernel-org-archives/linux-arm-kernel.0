From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jan 2017 21:34:52 +0200
Subject: [PATCH 2/2] soc: samsung: pmu: Remove duplicated define for
 ARM_L2_OPTION register
In-Reply-To: <20170125193452.31768-1-krzk@kernel.org>
References: <20170125193452.31768-1-krzk@kernel.org>
Message-ID: <20170125193452.31768-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register ARM_L2_OPTION (0x2608 in Exynos4 and Exynos5 PMU) was
defined twice.  Both names were used in the Exynos542x code.  Simplify
this.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/suspend.c              | 6 +++---
 drivers/soc/samsung/exynos5250-pmu.c        | 2 +-
 drivers/soc/samsung/exynos5420-pmu.c        | 4 ++--
 include/linux/soc/samsung/exynos-regs-pmu.h | 3 +--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 94df5d5c024e..29fc95f19bb5 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -387,9 +387,9 @@ static void exynos5420_pm_prepare(void)
 	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM))
 		pmu_raw_writel(__pa_symbol(mcpm_entry_point), S5P_INFORM0);
 
-	tmp = pmu_raw_readl(EXYNOS5_ARM_L2_OPTION);
-	tmp &= ~EXYNOS5_USE_RETENTION;
-	pmu_raw_writel(tmp, EXYNOS5_ARM_L2_OPTION);
+	tmp = pmu_raw_readl(EXYNOS_L2_OPTION(0));
+	tmp &= ~EXYNOS_L2_USE_RETENTION;
+	pmu_raw_writel(tmp, EXYNOS_L2_OPTION(0));
 
 	tmp = pmu_raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
 	tmp |= EXYNOS5420_UFS;
diff --git a/drivers/soc/samsung/exynos5250-pmu.c b/drivers/soc/samsung/exynos5250-pmu.c
index 3fac42561964..8d94f0819f32 100644
--- a/drivers/soc/samsung/exynos5250-pmu.c
+++ b/drivers/soc/samsung/exynos5250-pmu.c
@@ -29,7 +29,7 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	{ EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
 	{ EXYNOS5_ARM_COMMON_SYS_PWR_REG,		{ 0x0, 0x0, 0x2} },
 	{ EXYNOS5_ARM_L2_SYS_PWR_REG,			{ 0x3, 0x3, 0x3} },
-	{ EXYNOS5_ARM_L2_OPTION,			{ 0x10, 0x10, 0x0 } },
+	{ EXYNOS_L2_OPTION(0),				{ 0x10, 0x10, 0x0 } },
 	{ EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
 	{ EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
 	{ EXYNOS5_CMU_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
diff --git a/drivers/soc/samsung/exynos5420-pmu.c b/drivers/soc/samsung/exynos5420-pmu.c
index 3f2c64180ef8..0a89fa79c678 100644
--- a/drivers/soc/samsung/exynos5420-pmu.c
+++ b/drivers/soc/samsung/exynos5420-pmu.c
@@ -230,11 +230,11 @@ static void exynos5420_pmu_init(void)
 	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
 
 	value  = pmu_raw_readl(EXYNOS_L2_OPTION(0));
-	value &= ~EXYNOS5_USE_RETENTION;
+	value &= ~EXYNOS_L2_USE_RETENTION;
 	pmu_raw_writel(value, EXYNOS_L2_OPTION(0));
 
 	value = pmu_raw_readl(EXYNOS_L2_OPTION(1));
-	value &= ~EXYNOS5_USE_RETENTION;
+	value &= ~EXYNOS_L2_USE_RETENTION;
 	pmu_raw_writel(value, EXYNOS_L2_OPTION(1));
 
 	/*
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 9793502a6a57..9786c62d7159 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -149,8 +149,7 @@
 #define EXYNOS_L2_OPTION(_nr)			\
 			(EXYNOS_L2_CONFIGURATION(_nr) + 0x8)
 
-#define EXYNOS5_ARM_L2_OPTION			0x2608
-#define EXYNOS5_USE_RETENTION			BIT(4)
+#define EXYNOS_L2_USE_RETENTION			BIT(4)
 
 #define S5P_PAD_RET_MAUDIO_OPTION		0x3028
 #define S5P_PAD_RET_MMC2_OPTION			0x30c8
-- 
2.9.3

From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Tue, 19 Aug 2014 12:37:46 +0545
Subject: [RESEND PATCH v4 1/2] ARM: EXYNOS: Move Disabling of JPEG
 USE_RETENTION for exynos5250 to pmu.c
In-Reply-To: <1408431167-14134-1-git-send-email-vikas.sajjan@samsung.com>
References: <1408431167-14134-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1408431167-14134-2-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the Disabling of JPEG USE_RETENTION for exynos5250 to pmu.c to make way for
refactoring of pm.c and to create common functions across exynos4 and
exynos5250.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/pm.c  |    7 +------
 arch/arm/mach-exynos/pmu.c |    1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index abefacb..31e209b 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -255,13 +255,8 @@ static void exynos_pm_prepare(void)
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (soc_is_exynos5250()) {
+	if (soc_is_exynos5250())
 		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
-		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
-		tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
-		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
-		pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
-	}
 
 	/* Set value of power down register for sleep mode */
 
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index ff9d23f..cfc62e8 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -264,6 +264,7 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	{ EXYNOS5_INTRAM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
 	{ EXYNOS5_INTROM_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
 	{ EXYNOS5_JPEG_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5_JPEG_MEM_OPTION,			{ 0x10, 0x10, 0x0} },
 	{ EXYNOS5_HSI_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
 	{ EXYNOS5_MCUIOP_MEM_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
 	{ EXYNOS5_SATA_MEM_SYS_PWR_REG,			{ 0x3, 0x0, 0x0} },
-- 
1.7.9.5

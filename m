From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 07 Nov 2012 16:17:00 +0530
Subject: [PATCH 3/3] ARM: EXYNOS5: Fix i2c suspend/resume for legacy controller
In-Reply-To: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
References: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352285220-31544-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On resuming from suspend the i2c configuration register that is part
of system controller resets to 0xf. This sets the interrupt source to
the new high speed i2c rather than the legacy one that we are using.
Save and restore the I2C_CFG register for exynos5 to fix this.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index fd55cee..43e0b04 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -62,6 +62,10 @@ static struct sleep_save exynos4_vpll_save[] = {
 	SAVE_ITEM(EXYNOS4_VPLL_CON1),
 };
 
+static struct sleep_save exynos5_sys_save[] = {
+	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
+};
+
 static struct sleep_save exynos_core_save[] = {
 	/* SROM side */
 	SAVE_ITEM(S5P_SROM_BW),
@@ -104,6 +108,7 @@ static void exynos_pm_prepare(void)
 		s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
 		s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
 	} else {
+		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
 		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
 		tmp = __raw_readl(EXYNOS5_JPEG_MEM_OPTION);
 		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
@@ -307,6 +312,10 @@ static void exynos_pm_resume(void)
 	__raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
 	__raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
 
+	if (soc_is_exynos5250())
+		s3c_pm_do_restore(exynos5_sys_save,
+			ARRAY_SIZE(exynos5_sys_save));
+
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	if (!soc_is_exynos5250()) {
-- 
1.6.6.1

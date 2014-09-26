From: jonghwa3.lee@samsung.com (Jonghwa Lee)
Date: Fri, 26 Sep 2014 16:23:21 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: suspend: Make restoring registers into
 selectable option.
In-Reply-To: <1411716202-31644-1-git-send-email-jonghwa3.lee@samsung.com>
References: <1411716202-31644-1-git-send-email-jonghwa3.lee@samsung.com>
Message-ID: <1411716202-31644-2-git-send-email-jonghwa3.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some EXYNOS series may not requried to save ROM registers as it's default
for now. This patch makes restoring registers into machine-specific option.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 arch/arm/mach-exynos/suspend.c |   39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f5d9773..b41d146 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -48,23 +48,28 @@ struct exynos_wkup_irq {
 	u32 mask;
 };
 
-static struct sleep_save exynos5_sys_save[] = {
-	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
+static struct sleep_save exynos_save_regs[] = {
+	/* SROM side */
+	SAVE_ITEM(S5P_SROM_BW),
+	SAVE_ITEM(S5P_SROM_BC0),
+	SAVE_ITEM(S5P_SROM_BC1),
+	SAVE_ITEM(S5P_SROM_BC2),
+	SAVE_ITEM(S5P_SROM_BC3),
 };
 
-static struct sleep_save exynos_core_save[] = {
-	/* SROM side */
+static struct sleep_save exynos5_save_regs[] = {
 	SAVE_ITEM(S5P_SROM_BW),
 	SAVE_ITEM(S5P_SROM_BC0),
 	SAVE_ITEM(S5P_SROM_BC1),
 	SAVE_ITEM(S5P_SROM_BC2),
 	SAVE_ITEM(S5P_SROM_BC3),
+	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
 };
 
 struct exynos_pm_data {
 	const struct exynos_wkup_irq *wkup_irq;
-	struct sleep_save *extra_save;
-	int num_extra_save;
+	struct sleep_save *save_regs;
+	int num_save_regs;
 	unsigned int wake_disable_mask;
 	unsigned int *release_ret_regs;
 
@@ -165,11 +170,9 @@ static void exynos_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
-	 if (pm_data->extra_save)
-		s3c_pm_do_save(pm_data->extra_save,
-				pm_data->num_extra_save);
+	 if (pm_data->save_regs)
+		s3c_pm_do_save(pm_data->save_regs,
+				pm_data->num_save_regs);
 
 	exynos_pm_enter_sleep_mode();
 }
@@ -203,11 +206,9 @@ static void exynos_pm_resume(void)
 	/* For release retention */
 	exynos_pm_release_retention();
 
-	if (pm_data->extra_save)
-		s3c_pm_do_restore_core(pm_data->extra_save,
-					pm_data->num_extra_save);
-
-	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
+	if (pm_data->save_regs)
+		s3c_pm_do_restore_core(pm_data->save_regs,
+					pm_data->num_save_regs);
 
 	if (cpuid == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
@@ -291,6 +292,8 @@ static const struct exynos_pm_data exynos4_pm_data = {
 	.wkup_irq	= exynos4_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
 	.release_ret_regs = exynos_release_ret_regs,
+	.save_regs	= exynos_save_regs,
+	.num_save_regs	= ARRAY_SIZE(exynos_save_regs),
 	.pm_suspend	= exynos_pm_suspend,
 	.pm_resume	= exynos_pm_resume,
 	.pm_prepare	= exynos_pm_prepare,
@@ -301,8 +304,8 @@ static const struct exynos_pm_data exynos5250_pm_data = {
 	.wkup_irq	= exynos5250_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
 	.release_ret_regs = exynos_release_ret_regs,
-	.extra_save	= exynos5_sys_save,
-	.num_extra_save	= ARRAY_SIZE(exynos5_sys_save),
+	.save_regs	= exynos5_save_regs,
+	.num_save_regs	= ARRAY_SIZE(exynos5_save_regs),
 	.pm_suspend	= exynos_pm_suspend,
 	.pm_resume	= exynos_pm_resume,
 	.pm_prepare	= exynos_pm_prepare,
-- 
1.7.9.5

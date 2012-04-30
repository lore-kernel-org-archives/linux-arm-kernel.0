From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 30 Apr 2012 12:14:19 -0700
Subject: [PATCH 09/20] ARM: Exynos: Remove a new bus_type instance for Exynos5
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335813270-13083-10-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A seperate bus_type instance is not required for Exynos5. The existing bus_type
instance used with Exynos4 is sufficient for both Exynos4 and Exynos5. This
also solves issue of uninitialized usage of exynos4_subsys in Exynos4 power
management code that is reused for Exynos5 also. In addition to that, the
existing exynos4_subsys bus_type is renamed to exynos_subsys to indicate that
it is reused on both Exynos4 and Exynos5 platforms.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c            |   27 ++++++---------------------
 arch/arm/mach-exynos/pm.c                |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h |    2 +-
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index eff4446..3302a8d 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -565,30 +565,18 @@ void __init exynos5_init_irq(void)
 	s5p_init_irq(NULL, 0);
 }
 
-struct bus_type exynos4_subsys = {
-	.name		= "exynos4-core",
-	.dev_name	= "exynos4-core",
-};
-
-struct bus_type exynos5_subsys = {
-	.name		= "exynos5-core",
-	.dev_name	= "exynos5-core",
+struct bus_type exynos_subsys = {
+	.name		= "exynos-core",
+	.dev_name	= "exynos-core",
 };
 
 static struct device exynos4_dev = {
-	.bus	= &exynos4_subsys,
-};
-
-static struct device exynos5_dev = {
-	.bus	= &exynos5_subsys,
+	.bus	= &exynos_subsys,
 };
 
 static int __init exynos_core_init(void)
 {
-	if (soc_is_exynos5250())
-		return subsys_system_register(&exynos5_subsys, NULL);
-	else
-		return subsys_system_register(&exynos4_subsys, NULL);
+	return subsys_system_register(&exynos_subsys, NULL);
 }
 core_initcall(exynos_core_init);
 
@@ -675,10 +663,7 @@ static int __init exynos_init(void)
 {
 	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
 
-	if (soc_is_exynos5250())
-		return device_register(&exynos5_dev);
-	else
-		return device_register(&exynos4_dev);
+	return device_register(&exynos4_dev);
 }
 
 /* uart registration process */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 428cfeb..7164aa9 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -275,7 +275,7 @@ static void exynos4_restore_pll(void)
 
 static struct subsys_interface exynos4_pm_interface = {
 	.name		= "exynos4_pm",
-	.subsys		= &exynos4_subsys,
+	.subsys		= &exynos_subsys,
 	.add_dev	= exynos4_pm_add,
 };
 
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 787ceac..0721293 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -202,7 +202,7 @@ extern struct bus_type s3c2443_subsys;
 extern struct bus_type s3c6410_subsys;
 extern struct bus_type s5p64x0_subsys;
 extern struct bus_type s5pv210_subsys;
-extern struct bus_type exynos4_subsys;
+extern struct bus_type exynos_subsys;
 
 extern void (*s5pc1xx_idle)(void);
 
-- 
1.7.5.4

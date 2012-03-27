From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Mar 2012 14:56:03 +0530
Subject: [PATCH 2/4] ARM: Exynos: Remove a new bus_type instance for Exynos5
In-Reply-To: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
References: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1332840365-24827-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A seperate bus_type instance is not required for Exynos5. The existing bus_type
instance used with Exynos4 is sufficient for both Exynos4 and Exynos5. This
also solves issue of uninitialized usage of exynos4_subsys in Exynos4 power
management code that is reused for Exynos5 also.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/common.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index a750a5d..f265dc4 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -563,25 +563,13 @@ struct bus_type exynos4_subsys = {
 	.dev_name	= "exynos4-core",
 };
 
-struct bus_type exynos5_subsys = {
-	.name		= "exynos5-core",
-	.dev_name	= "exynos5-core",
-};
-
 static struct device exynos4_dev = {
 	.bus	= &exynos4_subsys,
 };
 
-static struct device exynos5_dev = {
-	.bus	= &exynos5_subsys,
-};
-
 static int __init exynos_core_init(void)
 {
-	if (soc_is_exynos5250())
-		return subsys_system_register(&exynos5_subsys, NULL);
-	else
-		return subsys_system_register(&exynos4_subsys, NULL);
+	return subsys_system_register(&exynos4_subsys, NULL);
 }
 core_initcall(exynos_core_init);
 
@@ -667,10 +655,7 @@ static int __init exynos_init(void)
 {
 	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
 
-	if (soc_is_exynos5250())
-		return device_register(&exynos5_dev);
-	else
-		return device_register(&exynos4_dev);
+	return device_register(&exynos4_dev);
 }
 
 /* uart registration process */
-- 
1.6.6.rc2

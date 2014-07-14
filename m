From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Jul 2014 09:28:43 +0530
Subject: [RESPIN PATCH v6] ARM: EXYNOS: Move cpufreq and cpuidle device
 registration to init_machine
Message-ID: <1405310323-3195-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As exynos_cpuidle_init and exynos_cpufreq_init function have just one lines
of code for registering platform devices. We can move these lines to
exynos_dt_machine_init and delete exynos_cpuidle_init and exynos_cpufreq_init
function. This will help in reducing lines of code in exynos.c, making it
more cleaner.

Suggested-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---

This patch is part of exynos-cleanup series v6 [1]. Just respinning after
resolving merge conflicts on latest kgene/for-next.

[1]: https://lkml.org/lkml/2014/7/10/338


 arch/arm/mach-exynos/exynos.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2a43a17..99dc5aa 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -175,17 +175,6 @@ static struct platform_device exynos_cpuidle = {
 	.id                = -1,
 };
 
-void __init exynos_cpuidle_init(void)
-{
-	if (soc_is_exynos4210() || soc_is_exynos5250())
-		platform_device_register(&exynos_cpuidle);
-}
-
-void __init exynos_cpufreq_init(void)
-{
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-}
-
 void __iomem *sysram_base_addr;
 void __iomem *sysram_ns_base_addr;
 
@@ -335,10 +324,11 @@ static void __init exynos_dt_machine_init(void)
 	if (!IS_ENABLED(CONFIG_SMP))
 		exynos_sysram_init();
 
-	if (!of_machine_is_compatible("samsung,exynos5420"))
-		exynos_cpuidle_init();
+	if (of_machine_is_compatible("samsung,exynos4210") ||
+			of_machine_is_compatible("samsung,exynos5250"))
+		platform_device_register(&exynos_cpuidle);
 
-	exynos_cpufreq_init();
+	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.7.9.5

From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 25 Jun 2014 18:15:38 +0530
Subject: [PATCH v5 2/6] ARM: EXYNOS: Move cpufreq and cpuidle device
 registration to init_machine
In-Reply-To: <1403700342-9678-1-git-send-email-pankaj.dubey@samsung.com>
References: <1403700342-9678-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1403700342-9678-3-git-send-email-pankaj.dubey@samsung.com>
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
 arch/arm/mach-exynos/exynos.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6affcd9..e54d885 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -171,19 +171,6 @@ static struct platform_device exynos_cpuidle = {
 	.id                = -1,
 };
 
-void __init exynos_cpuidle_init(void)
-{
-	if (soc_is_exynos5440())
-		return;
-
-	platform_device_register(&exynos_cpuidle);
-}
-
-void __init exynos_cpufreq_init(void)
-{
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-}
-
 static void __init exynos_init_late(void)
 {
 	if (of_machine_is_compatible("samsung,exynos5440"))
@@ -271,8 +258,10 @@ static void __init exynos_dt_machine_init(void)
 		}
 	}
 
-	exynos_cpuidle_init();
-	exynos_cpufreq_init();
+	if (!soc_is_exynos5440())
+		platform_device_register(&exynos_cpuidle);
+
+	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.7.9.5

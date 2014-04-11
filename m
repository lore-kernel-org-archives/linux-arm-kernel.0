From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:08 +0200
Subject: [PATCH V5 13/20] ARM: exynos: cpuidle: Disable cpuidle for 5440
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point to register the cpuidle driver for the 5440 as it has only
one WFI state which is the default idle function when the cpuidle driver is
disabled.

By disabling cpuidle we prevent to enter to the governor computation for
nothing, thus saving a lot of processing time.

The only drawback is the statistic via sysfs on this state which is lost but
it is meaningless and it could be retrieved from the ftrace easily.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    3 ---
 arch/arm/mach-exynos/exynos.c  |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index f66ee4d..95313ea 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -133,9 +133,6 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (soc_is_exynos5440())
-		exynos_idle_driver.state_count = 1;
-
 	ret = cpuidle_register(&exynos_idle_driver, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index b567361..fe8dac8 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -227,6 +227,9 @@ static struct platform_device exynos_cpuidle = {
 
 void __init exynos_cpuidle_init(void)
 {
+	if (soc_is_exynos5440())
+		return;
+
 	platform_device_register(&exynos_cpuidle);
 }
 
-- 
1.7.9.5

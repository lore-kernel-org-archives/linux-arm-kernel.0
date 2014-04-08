From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  8 Apr 2014 14:19:37 +0200
Subject: [PATCH V3 15/17] ARM: exynos: cpuidle: Disable cpuidle for 5440
In-Reply-To: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396959579-18268-16-git-send-email-daniel.lezcano@linaro.org>
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
---
 arch/arm/mach-exynos/cpuidle.c |    5 -----
 arch/arm/mach-exynos/exynos.c  |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 4b94181..a1f111e 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -16,8 +16,6 @@
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 
 static int idle_finisher(unsigned long flags)
@@ -77,9 +75,6 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
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

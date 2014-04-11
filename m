From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:13 +0200
Subject: [PATCH V5 18/20] ARM: exynos: cpuidle: Pass the AFTR callback to the
 platform_data
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more dependency on the arch code. The platform_data field is used to set the
PM callback as the other cpuidle drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |    4 +++-
 arch/arm/mach-exynos/exynos.c  |    5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 02609ac..1d1222e 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -27,7 +27,7 @@
 
 #include <mach/map.h>
 
-#include "common.h"
+static void (*exynos_enter_aftr)(void);
 
 static int idle_finisher(unsigned long flags)
 {
@@ -86,6 +86,8 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
 
+	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
+
 	ret = cpuidle_register(&exynos_idle_driver, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index fe8dac8..d22f0e4 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -221,8 +221,9 @@ void exynos_restart(enum reboot_mode mode, const char *cmd)
 }
 
 static struct platform_device exynos_cpuidle = {
-	.name		= "exynos_cpuidle",
-	.id		= -1,
+	.name              = "exynos_cpuidle",
+	.dev.platform_data = exynos_enter_aftr,
+	.id                = -1,
 };
 
 void __init exynos_cpuidle_init(void)
-- 
1.7.9.5

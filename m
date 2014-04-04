From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:48:01 +0200
Subject: [PATCH 15/17] ARM: exynos: cpuidle: Pass the AFTR callback to the
 platform_data
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-16-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more dependency on the arch code. The platform_data field is used to set the
PM callback as the other cpuidle driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/common.c  |    5 +++--
 arch/arm/mach-exynos/common.h  |    1 +
 arch/arm/mach-exynos/cpuidle.c |    8 ++++----
 arch/arm/mach-exynos/pmu.c     |    6 ++++++
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f18be40..d5fa21e 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -294,8 +294,9 @@ void exynos5_restart(enum reboot_mode mode, const char *cmd)
 }
 
 static struct platform_device exynos_cpuidle = {
-	.name		= "exynos_cpuidle",
-	.id		= -1,
+	.name              = "exynos_cpuidle",
+	.dev.platform_data = exynos_sys_powerdown_aftr,
+	.id                = -1,
 };
 
 void __init exynos_cpuidle_init(void)
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index f76967b..3678a28 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -49,5 +49,6 @@ struct exynos_pmu_conf {
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+extern void exynos_sys_powerdown_aftr(void);
 
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 1916dc6..f6b7aac0 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -18,13 +18,11 @@
 
 #include <plat/cpu.h>
 
-#include "common.h"
+static void (*exynos_aftr)(void);
 
 static int idle_finisher(unsigned long flags)
 {
-	/* Set value of power down register for aftr mode */
-	exynos_sys_powerdown_conf(SYS_AFTR);
-
+	exynos_aftr();
 	cpu_do_idle();
 
 	return 1;
@@ -82,6 +80,8 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 	if (soc_is_exynos5440())
 		exynos_idle_driver.state_count = 1;
 
+	exynos_aftr = (void *)(pdev->dev.platform_data);
+
 	ret = cpuidle_register(&exynos_idle_driver, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 05c7ce1..fd1ae22 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -389,6 +389,12 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	}
 }
 
+/* Set value of power down register for aftr mode */
+void exynos_sys_powerdown_aftr(void)
+{
+	exynos_sys_powerdown_conf(SYS_AFTR);
+}
+
 static int __init exynos_pmu_init(void)
 {
 	unsigned int value;
-- 
1.7.9.5

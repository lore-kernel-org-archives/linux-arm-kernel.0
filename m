From: sbkim73@samsung.com (Sangbeom Kim)
Date: Tue,  5 Apr 2011 09:28:44 +0900
Subject: [PATCH 3/4] ARM: EXYNOS4: Change each platform kernel timer using
	s5p_timer
In-Reply-To: <1301963325-22349-1-git-send-email-sbkim73@samsung.com>
References: <1301963325-22349-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1301963325-22349-4-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace exynos4 dedicated timer with s5p_timer.
Defualt clocksource is pwm4 and clockevent is pwm2.
It can be deleted time.c by using s5p_timer.

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c           |    4 +++-
 arch/arm/mach-exynos4/mach-smdkc210.c       |    4 +++-
 arch/arm/mach-exynos4/mach-smdkv310.c       |    5 ++++-
 arch/arm/mach-exynos4/mach-universal_c210.c |    4 +++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index b79ad01..cc50414 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -30,6 +30,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
+#include <plat/s5p-time.h>
 
 #include <mach/map.h>
 
@@ -282,6 +283,7 @@ static void __init nuri_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(nuri_uartcfgs, ARRAY_SIZE(nuri_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init nuri_machine_init(void)
@@ -301,5 +303,5 @@ MACHINE_START(NURI, "NURI")
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
 	.init_machine	= nuri_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index e645f7a..c3a34c9 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -27,6 +27,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
+#include <plat/s5p-time.h>
 
 #include <mach/map.h>
 
@@ -196,6 +197,7 @@ static void __init smdkc210_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkc210_uartcfgs, ARRAY_SIZE(smdkc210_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init smdkc210_machine_init(void)
@@ -219,5 +221,5 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkc210_map_io,
 	.init_machine	= smdkc210_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 1526764..03e3a61 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -29,6 +29,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
+#include <plat/s5p-time.h>
 
 #include <mach/map.h>
 
@@ -218,6 +219,8 @@ static void __init smdkv310_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
+
 }
 
 static void __init smdkv310_machine_init(void)
@@ -244,5 +247,5 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
 	.init_machine	= smdkv310_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 97d329f..57c17bc 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -28,6 +28,7 @@
 #include <plat/devs.h>
 #include <plat/iic.h>
 #include <plat/sdhci.h>
+#include <plat/s5p-time.h>
 
 #include <mach/map.h>
 
@@ -624,6 +625,7 @@ static void __init universal_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init universal_machine_init(void)
@@ -646,5 +648,5 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
 	.init_machine	= universal_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
-- 
1.7.1

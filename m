From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:17 +0530
Subject: [PATCH v6 07/16] ARM: Exynos: Initialize the clocks prior to timer
 initialization
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-8-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the clock initialization should be completed prior to the mct timer
initialization, create a new function 'exynos_init_time' that first sets up
the clock and then invokes the timer initialization function. The 'init_time'
callback in the board files are updated to invoke this new wrapper function.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c              |   16 ++++++++++++++++
 arch/arm/mach-exynos/mach-armlex4210.c     |    2 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c     |    2 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c     |    2 +-
 arch/arm/mach-exynos/mach-nuri.c           |    2 +-
 arch/arm/mach-exynos/mach-origen.c         |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c       |    4 ++--
 arch/arm/mach-exynos/mach-smdkv310.c       |    4 ++--
 arch/arm/mach-exynos/mach-universal_c210.c |    8 +++++++-
 9 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 8e4a25c..64585af 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -23,6 +23,8 @@
 #include <linux/export.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
 
 #include <asm/proc-fns.h>
 #include <asm/exception.h>
@@ -436,6 +438,20 @@ static void __init exynos5440_map_io(void)
 	iotable_init(exynos5440_iodesc0, ARRAY_SIZE(exynos5440_iodesc0));
 }
 
+void __init exynos_init_time(void)
+{
+	if (of_have_populated_dt()) {
+#ifdef CONFIG_OF
+		of_clk_init(NULL);
+		clocksource_of_init();
+#endif
+	} else {
+		/* todo: remove after migrating legacy E4 platforms to dt */
+		exynos4_clk_init(NULL);
+		mct_init();
+	}
+}
+
 #define COMBINER_ENABLE_SET	0x0
 #define COMBINER_ENABLE_CLEAR	0x4
 #define COMBINER_INT_STATUS	0xC
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index e45b4b4..3518ac8 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -203,6 +203,6 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 2c25f2c..6c5e068 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -127,7 +127,7 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.init_early	= exynos_firmware_init,
 	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= clocksource_of_init,
+	.init_time	= exynos_init_time,
 	.dt_compat	= exynos4_dt_compat,
 	.restart        = exynos4_restart,
 	.reserve	= exynos4_reserve,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index b5f9549..dfe51ee 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -179,7 +179,7 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= clocksource_of_init,
+	.init_time	= exynos_init_time,
 	.dt_compat	= exynos5_dt_compat,
 	.restart        = exynos5_restart,
 	.reserve	= exynos5_reserve,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index c49ec9d..cdae74b 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1381,7 +1381,7 @@ MACHINE_START(NURI, "NURI")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.reserve        = &nuri_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 656967d..e9ab921 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -816,7 +816,7 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.reserve	= &origen_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index c56cc21..71422ad 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -377,7 +377,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.restart	= exynos4_restart,
 	.reserve	= &smdk4x12_reserve,
 MACHINE_END
@@ -392,7 +392,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.restart	= exynos4_restart,
 	.reserve	= &smdk4x12_reserve,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 9d511f5..eb51c06 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -424,7 +424,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.reserve	= &smdkv310_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
@@ -438,7 +438,7 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= mct_init,
+	.init_time	= exynos_init_time,
 	.reserve	= &smdkv310_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 3998c81..53de074 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1144,6 +1144,12 @@ static void __init universal_machine_init(void)
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
 }
 
+static void __init universal_init_time(void)
+{
+	exynos4_clk_init(NULL);
+	mct_init();
+}
+
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
@@ -1153,7 +1159,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= samsung_timer_init,
+	.init_time	= universal_init_time,
 	.reserve        = &universal_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
-- 
1.7.5.4

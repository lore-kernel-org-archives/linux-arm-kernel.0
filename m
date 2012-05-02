From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:29 +0800
Subject: [PATCH 04/15] ARM: exynos: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-exynos/common.c              |    5 +++++
 arch/arm/mach-exynos/common.h              |    7 +++++++
 arch/arm/mach-exynos/mach-armlex4210.c     |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c     |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c     |    1 +
 arch/arm/mach-exynos/mach-nuri.c           |    1 +
 arch/arm/mach-exynos/mach-origen.c         |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c       |    1 +
 arch/arm/mach-exynos/mach-smdkv310.c       |    1 +
 arch/arm/mach-exynos/mach-universal_c210.c |    1 +
 arch/arm/mach-exynos/pm_domains.c          |    3 +--
 11 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 8614aab..16da001 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -285,6 +285,11 @@ void exynos5_restart(char mode, const char *cmd)
 	__raw_writel(0x1, EXYNOS_SWRESET);
 }
 
+void __init exynos_init_late(void)
+{
+	exynos_pm_late_initcall();
+}
+
 /*
  * exynos_map_io
  *
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 677b546..aed2eeb 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -19,6 +19,13 @@ void exynos4_init_irq(void);
 void exynos5_init_irq(void);
 void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
+void exynos_init_late(void);
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+int exynos_pm_late_initcall(void);
+#else
+static int exynos_pm_late_initcall(void) { return 0; }
+#endif
 
 #ifdef CONFIG_ARCH_EXYNOS4
 void exynos4_register_clocks(void);
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index d726fcd..40eaa8c5 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -214,6 +214,7 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.map_io		= armlex4210_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 8245f1c..e7e9743 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -83,6 +83,7 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.map_io		= exynos4210_dt_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos4210_dt_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.dt_compat	= exynos4210_dt_compat,
 	.restart        = exynos4_restart,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 4711c89..5b1ab97 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -72,6 +72,7 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	.map_io		= exynos5250_dt_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5250_dt_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.dt_compat	= exynos5250_dt_compat,
 	.restart        = exynos5_restart,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index b4f1f90..5d68532 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1350,6 +1350,7 @@ MACHINE_START(NURI, "NURI")
 	.map_io		= nuri_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.reserve        = &nuri_reserve,
 	.restart	= exynos4_restart,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 878d4c9..263ba44 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -735,6 +735,7 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.map_io		= origen_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.reserve	= &origen_reserve,
 	.restart	= exynos4_restart,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index d00e4f0..763967d 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -303,6 +303,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 83b91fa..f9d2b31 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -393,6 +393,7 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 7ebf79c..7c34886 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1112,6 +1112,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.map_io		= universal_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
+	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
 	.reserve        = &universal_reserve,
 	.restart	= exynos4_restart,
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 13b3068..e9fafcf 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -193,9 +193,8 @@ static __init int exynos4_pm_init_power_domain(void)
 }
 arch_initcall(exynos4_pm_init_power_domain);
 
-static __init int exynos_pm_late_initcall(void)
+int __init exynos_pm_late_initcall(void)
 {
 	pm_genpd_poweroff_unused();
 	return 0;
 }
-late_initcall(exynos_pm_late_initcall);
-- 
1.7.5.4

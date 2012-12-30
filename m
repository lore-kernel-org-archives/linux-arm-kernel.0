From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:33 -0800
Subject: [PATCH v5 04/12] ARM: Exynos: Rework timer initialization sequence
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A seperate timer initialization function for all exynos based platforms is
created. This new initialization function will help to identify the type of
timer used and call their corresponding initialization function. Since the
clock initialization should be completed prior to the mct timer initialization,
the clock initialization can be initiated from this new timer initialization
function.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c          |   27 +++++++++++++++++++++++++++
 arch/arm/mach-exynos/common.h          |    3 ++-
 arch/arm/mach-exynos/mach-armlex4210.c |    2 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c |    2 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c |    2 +-
 arch/arm/mach-exynos/mach-nuri.c       |    2 +-
 arch/arm/mach-exynos/mach-origen.c     |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c   |    4 ++--
 arch/arm/mach-exynos/mach-smdkv310.c   |    4 ++--
 arch/arm/mach-exynos/mct.c             |   13 +------------
 10 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 30592f0..535a7ed 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -24,6 +24,8 @@
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 
+#include <asm/mach/time.h>
+#include <asm/arch_timer.h>
 #include <asm/proc-fns.h>
 #include <asm/exception.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -462,6 +464,31 @@ static void __init exynos5_init_clocks(int xtal)
 	exynos5_setup_clocks();
 }
 
+void __init exynos_timer_init(void)
+{
+	/*
+	 * Temporary support for Exynos4 based non-dt platforms. This should
+	 * go away soon.
+	 */
+	if (!of_have_populated_dt() && (soc_is_exynos4210() ||
+		soc_is_exynos4212() || soc_is_exynos4412())) {
+		exynos_mct_init();
+		return;
+	}
+
+	/* quick check to see if this machine uses arch timer */
+	if (of_machine_is_compatible("samsung,exynos5440")) {
+		if (arch_timer_of_register())
+			panic("%s: could not initialize timer\n", __func__);
+	} else {
+		exynos_mct_init();
+	}
+}
+
+struct sys_timer exynos_timer = {
+	.init		= exynos_timer_init,
+};
+
 #define COMBINER_ENABLE_SET	0x0
 #define COMBINER_ENABLE_CLEAR	0x4
 #define COMBINER_INT_STATUS	0xC
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 7733b61..687b6f0 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -12,7 +12,7 @@
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
-extern struct sys_timer exynos4_timer;
+extern struct sys_timer exynos_timer;
 
 struct map_desc;
 void exynos_init_io(struct map_desc *mach_desc, int size);
@@ -21,6 +21,7 @@ void exynos5_init_irq(void);
 void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
+extern void exynos_mct_init(void);
 
 void exynos_firmware_init(void);
 
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index b938f9f..4d0ea70 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -204,6 +204,6 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index ab1dacc..86d914c 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -111,7 +111,7 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.init_early	= exynos_firmware_init,
 	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.dt_compat	= exynos4_dt_compat,
 	.restart        = exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index e99d3d8..4ea3543 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -182,7 +182,7 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.dt_compat	= exynos5_dt_compat,
 	.restart        = exynos5_restart,
 	.reserve	= exynos5_reserve,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 27d4ed8..03d5ddf 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1382,7 +1382,7 @@ MACHINE_START(NURI, "NURI")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.reserve        = &nuri_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5e34b9c..97dcf6f 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -817,7 +817,7 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.reserve	= &origen_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index ae6da40..08409b0 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -378,7 +378,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.restart	= exynos4_restart,
 	.reserve	= &smdk4x12_reserve,
 MACHINE_END
@@ -393,7 +393,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.restart	= exynos4_restart,
 	.reserve	= &smdk4x12_reserve,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 35548e3..d791e5d 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -425,7 +425,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.reserve	= &smdkv310_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
@@ -439,7 +439,7 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.init_late	= exynos_init_late,
-	.timer		= &exynos4_timer,
+	.timer		= &exynos_timer,
 	.reserve	= &smdkv310_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index bf359f6..448ce86 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -23,7 +23,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 
-#include <asm/arch_timer.h>
 #include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 
@@ -31,7 +30,6 @@
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-#include <asm/mach/time.h>
 
 #define EXYNOS4_MCTREG(x)		(x)
 #define EXYNOS4_MCT_G_CNT_L		EXYNOS4_MCTREG(0x100)
@@ -513,16 +511,11 @@ static void __init exynos4_timer_resources(struct device_node *np)
 #endif /* CONFIG_LOCAL_TIMERS */
 }
 
-static void __init exynos_timer_init(void)
+void __init exynos_mct_init(void)
 {
 	struct device_node *np;
 	u32 nr_irqs, i;
 
-	if (soc_is_exynos5440()) {
-		arch_timer_of_register();
-		return;
-	}
-
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-mct");
 	if (np) {
 		if (of_machine_is_compatible("samsung,exynos4210") ||
@@ -551,7 +544,3 @@ static void __init exynos_timer_init(void)
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
 }
-
-struct sys_timer exynos4_timer = {
-	.init		= exynos_timer_init,
-};
-- 
1.7.5.4

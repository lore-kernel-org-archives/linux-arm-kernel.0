From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Sep 2014 13:22:01 +0900
Subject: [PATCH 1/6] ARM: shmobile: r8a7740: Multiplatform support
In-Reply-To: <cover.1410235700.git.horms+renesas@verge.net.au>
References: <cover.1410235700.git.horms+renesas@verge.net.au>
Message-ID: <c41215b781efbfa22ffc9dc474c2981c130c153d.1410235700.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable r8a7740 Multiplatform support for the generic r8a7740
machine vector. No board support is enabled, and the board
code for Armadillo 800 EVA DT Reference is left by itself.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig         | 5 +++++
 arch/arm/mach-shmobile/pm-r8a7740.c    | 5 ++---
 arch/arm/mach-shmobile/r8a7740.h       | 4 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 +++++++-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index e15dff7..498162f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -26,6 +26,11 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select SYS_SUPPORTS_SH_MTU2
 
+config ARCH_R8A7740
+	bool "R-Mobile A1 (R8A77400)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select RENESAS_INTC_IRQPIN
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index a0d44d5..4d327de 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -13,7 +13,7 @@
 #include "common.h"
 #include "pm-rmobile.h"
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static int r8a7740_pd_a4s_suspend(void)
 {
 	/*
@@ -58,8 +58,7 @@ void __init r8a7740_init_pm_domains(void)
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 }
-
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
 #ifdef CONFIG_SUSPEND
 static int r8a7740_enter_suspend(suspend_state_t suspend_state)
diff --git a/arch/arm/mach-shmobile/r8a7740.h b/arch/arm/mach-shmobile/r8a7740.h
index 3352fb8..f369b4b 100644
--- a/arch/arm/mach-shmobile/r8a7740.h
+++ b/arch/arm/mach-shmobile/r8a7740.h
@@ -53,10 +53,10 @@ extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 extern void __init r8a7740_init_pm_domains(void);
 #else
 static inline void r8a7740_init_pm_domains(void) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
 #endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8fe270d..1e55c50 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -36,6 +36,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
 #include "dma-register.h"
@@ -813,7 +814,12 @@ void __init r8a7740_init_irq_of(void)
 
 static void __init r8a7740_generic_init(void)
 {
-	r8a7740_clock_init(0);
+	r8a7740_meram_workaround();
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Shared attribute override enable, 32K*8way */
+	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
+#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
2.0.1

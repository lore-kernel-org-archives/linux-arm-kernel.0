From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:49 +0200
Subject: [PATCH v2 24/30] ARM: shmobile: r8a7740: Remove unnecessary
 r8a7740_add_standard_devices_dt()
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-25-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a7740_add_standard_devices_dt() now only calls
of_platform_populate() so call it directly and remove
r8a7740_add_standard_devices_dt().

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 3 ++-
 arch/arm/mach-shmobile/r8a7740.h                         | 1 -
 arch/arm/mach-shmobile/setup-r8a7740.c                   | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 84bc6cb..f06e1f3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -170,7 +171,7 @@ static void __init eva_init(void)
 	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
 #endif
 
-	r8a7740_add_standard_devices_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	r8a7740_pm_init();
 }
diff --git a/arch/arm/mach-shmobile/r8a7740.h b/arch/arm/mach-shmobile/r8a7740.h
index 1d1a5fd..3352fb8 100644
--- a/arch/arm/mach-shmobile/r8a7740.h
+++ b/arch/arm/mach-shmobile/r8a7740.h
@@ -49,7 +49,6 @@ extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
-extern void r8a7740_add_standard_devices_dt(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 3dcdc8d..fbfc49a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -781,11 +781,6 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init r8a7740_add_standard_devices_dt(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 void __init r8a7740_init_irq_of(void)
 {
 	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
@@ -819,7 +814,7 @@ void __init r8a7740_init_irq_of(void)
 static void __init r8a7740_generic_init(void)
 {
 	r8a7740_clock_init(0);
-	r8a7740_add_standard_devices_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *r8a7740_boards_compat_dt[] __initdata = {
-- 
2.0.0.rc2

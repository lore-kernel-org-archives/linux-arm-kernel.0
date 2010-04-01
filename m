From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 1 Apr 2010 10:15:24 +0530
Subject: [PATCH] ux500: enable l2x0 support
Message-ID: <1ade6b346ede3962391f7bd3ba9d117198062941.1270096673.git.srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the l2x0 support and ensures that the secondary
CPU can see the page table and secondary data at this point.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/cpu-u8500.c |   17 +++++++++++++++++
 arch/arm/mach-ux500/platsmp.c   |    3 ++-
 arch/arm/mm/Kconfig             |    2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 5fb4466..979f1c3 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -20,6 +20,7 @@
 #include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <plat/mtu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -127,6 +128,7 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO5_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
 };
 
 static struct map_desc u8500ed_io_desc[] __initdata = {
@@ -183,3 +185,18 @@ static void __init u8500_timer_init(void)
 struct sys_timer u8500_timer = {
 	.init	= u8500_timer_init,
 };
+
+#ifdef CONFIG_CACHE_L2X0
+static int u8500_l2x0_init(void)
+{
+	void __iomem *l2x0_base;
+
+	l2x0_base = __io_address(U8500_L2CC_BASE);
+
+	/* 64KB way size, 8 way associativity, force WA */
+	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
+
+	return 0;
+}
+early_initcall(u8500_l2x0_init);
+#endif
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 8dfe7ca..76dd935 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -75,7 +75,8 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * that it has been released by resetting pen_release.
 	 */
 	pen_release = cpu;
-	flush_cache_all();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release) + 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 270c8e2..dfc94be 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -755,7 +755,7 @@ config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
-		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_VEXPRESS_CA9X4
+		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_VEXPRESS_CA9X4 || ARCH_U8500
 	default y
 	select OUTER_CACHE
 	help
-- 
1.6.3.3

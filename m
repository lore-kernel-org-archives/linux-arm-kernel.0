From: will.deacon@arm.com (Will Deacon)
Date: Mon,  7 Jun 2010 10:53:50 +0100
Subject: [PATCH] Versatile Express: add support for local timers on CA9X4
	daughterboard
Message-ID: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Cortex-A9 local timers available when
using the CA9X4 daughterboard with the Versatile Express.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                               |    5 +++--
 arch/arm/mach-vexpress/ct-ca9x4.c              |   14 ++++++++------
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h |    1 +
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..7b117b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,9 +1172,10 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
+		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
+		ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || ARCH_U8500)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index e6f7303..3762fc8 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -14,6 +14,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/smp_twd.h>
 
 #include <mach/clkdev.h>
 #include <mach/ct-ca9x4.h>
@@ -63,20 +64,25 @@ static void __init ct_ca9x4_init_irq(void)
 	gic_cpu_init(0, gic_cpu_base_addr);
 }
 
-#if 0
 static void ct_ca9x4_timer_init(void)
 {
+#if 0
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
 	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
 	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
+#endif
+
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = MMIO_P2V(A9_MPCORE_TWD);
+#endif
+	v2m_timer.init();
 }
 
 static struct sys_timer ct_ca9x4_timer = {
 	.init	= ct_ca9x4_timer_init,
 };
-#endif
 
 static struct clcd_panel xvga_panel = {
 	.mode		= {
@@ -240,10 +246,6 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
-#if 0
 	.timer		= &ct_ca9x4_timer,
-#else
-	.timer		= &v2m_timer,
-#endif
 	.init_machine	= ct_ca9x4_init,
 MACHINE_END
diff --git a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
index 8650f04..f9e2f8d 100644
--- a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
+++ b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
@@ -28,6 +28,7 @@
 #define A9_MPCORE_SCU		(CT_CA9X4_MPIC + 0x0000)
 #define A9_MPCORE_GIC_CPU	(CT_CA9X4_MPIC + 0x0100)
 #define A9_MPCORE_GIT		(CT_CA9X4_MPIC + 0x0200)
+#define A9_MPCORE_TWD		(CT_CA9X4_MPIC + 0x0600)
 #define A9_MPCORE_GIC_DIST	(CT_CA9X4_MPIC + 0x1000)
 
 /*
-- 
1.6.3.3

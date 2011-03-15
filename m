From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:55 +0000
Subject: [RFC PATCHv2 12/20] ARM: versatile/vexpress: rework timer support
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dynamically register the TWD setup function.

For vexpress, give preference to architected timers over SP804 timers
and versatile sched_clock implementation, if available.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/realview_eb.c              |    4 ++-
 arch/arm/mach-realview/realview_pb11mp.c          |    4 ++-
 arch/arm/mach-realview/realview_pbx.c             |    5 ++-
 arch/arm/mach-vexpress/v2m.c                      |   29 ++++++++++++++++++++-
 arch/arm/plat-versatile/include/plat/localtimer.h |    9 ++++++
 arch/arm/plat-versatile/localtimer.c              |   10 ++++++-
 6 files changed, 55 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/localtimer.h

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 2ecc1d9..3a0900f 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -45,6 +45,8 @@
 #include <mach/board-eb.h>
 #include <mach/irqs.h>
 
+#include <plat/localtimer.h>
+
 #include "core.h"
 
 static struct map_desc realview_eb_io_desc[] __initdata = {
@@ -402,7 +404,7 @@ static void __init realview_eb_timer_init(void)
 
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
 #ifdef CONFIG_LOCAL_TIMERS
-		twd_base = __io_address(REALVIEW_EB11MP_TWD_BASE);
+		versatile_local_timer_init(__io_address(REALVIEW_EB11MP_TWD_BASE));
 #endif
 		timer_irq = IRQ_EB11MP_TIMER0_1;
 	} else
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index b2985fc..76da67d 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -46,6 +46,8 @@
 #include <mach/board-pb11mp.h>
 #include <mach/irqs.h>
 
+#include <plat/localtimer.h>
+
 #include "core.h"
 
 static struct map_desc realview_pb11mp_io_desc[] __initdata = {
@@ -306,7 +308,7 @@ static void __init realview_pb11mp_timer_init(void)
 	timer3_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE) + 0x20;
 
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = __io_address(REALVIEW_TC11MP_TWD_BASE);
+	versatile_local_timer_init(__io_address(REALVIEW_TC11MP_TWD_BASE));
 #endif
 	realview_timer_init(IRQ_TC11MP_TIMER0_1);
 }
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 92ace2c..280befd 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -31,7 +31,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
-#include <asm/smp_twd.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -44,6 +43,8 @@
 #include <mach/board-pbx.h>
 #include <mach/irqs.h>
 
+#include <plat/localtimer.h>
+
 #include "core.h"
 
 static struct map_desc realview_pbx_io_desc[] __initdata = {
@@ -310,7 +311,7 @@ static void __init realview_pbx_timer_init(void)
 
 #ifdef CONFIG_LOCAL_TIMERS
 	if (core_tile_pbx11mp() || core_tile_pbxa9mp())
-		twd_base = __io_address(REALVIEW_PBX_TILE_TWD_BASE);
+		versatile_local_timer_init(__io_address(REALVIEW_PBX_TILE_TWD_BASE));
 #endif
 	realview_timer_init(IRQ_PBX_TIMER0_1);
 }
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index ba46e8e..9fa5ad6 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -16,6 +16,8 @@
 
 #include <asm/mach-types.h>
 #include <asm/sizes.h>
+#include <asm/localtimer.h>
+#include <asm/arch_timer.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
@@ -28,6 +30,7 @@
 #include <mach/motherboard.h>
 
 #include <plat/sched_clock.h>
+#include <plat/localtimer.h>
 
 #include "core.h"
 
@@ -49,13 +52,37 @@ static struct map_desc v2m_io_desc[] __initdata = {
 static void __init v2m_init_early(void)
 {
 	ct_desc->init_early();
-	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
+}
+
+static int __cpuinit v2m_arch_timer_setup(struct clock_event_device *evt)
+{
+	versatile_local_timer_setup(evt);
+
+	/*
+	 * Enable PPI 30 in case we're running in normal mode instead
+	 * of secure mode. The timer has been stopped in the pre_setup()
+	 * phase, so it is safe to enable the interrupt here.
+	 */
+	gic_enable_ppi(30);
+
+	return 0;
 }
 
 static void __init v2m_timer_init(void)
 {
 	u32 scctrl;
 
+	/*
+	 * Try architected timers first. If they are not available,
+	 * fallback to TWD and versatile sched_clock.
+	 */
+	if (!arch_timer_register_setup(v2m_arch_timer_setup))
+		return;
+
+	versatile_local_timer_init(NULL);
+
+	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
+
 	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
 	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
 	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
diff --git a/arch/arm/plat-versatile/include/plat/localtimer.h b/arch/arm/plat-versatile/include/plat/localtimer.h
new file mode 100644
index 0000000..c6cdf72
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/localtimer.h
@@ -0,0 +1,9 @@
+#ifndef ARM_PLAT_LOCALTIMER_H
+#define ARM_PLAT_LOCALTIMER_H
+
+#include <linux/clockchips.h>
+
+void versatile_local_timer_setup(struct clock_event_device *evt);
+void versatile_local_timer_init(void __iomem *base);
+
+#endif
diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
index 93ea3e3..01025ea 100644
--- a/arch/arm/plat-versatile/localtimer.c
+++ b/arch/arm/plat-versatile/localtimer.c
@@ -11,14 +11,22 @@
 #include <linux/init.h>
 #include <linux/clockchips.h>
 
+#include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 #include <mach/irqs.h>
 
 /*
  * Setup the local clock events for a CPU.
  */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit versatile_local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
 	return 0;
 }
+
+void __init versatile_local_timer_init(void __iomem *base)
+{
+	if (base)
+		twd_base = base;
+	twd_timer_register_setup(versatile_local_timer_setup);
+}
-- 
1.7.0.4

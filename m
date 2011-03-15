From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:54 +0000
Subject: [RFC PATCHv2 11/20] ARM: architected timers: Add A15 specific
	sched_clock implementation
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide an A15 sched_clock implementation using the virtual counter,
which is thought to be more useful than the physical one in a
virtualised environment, as it can offset the time spent in another
VM or the hypervisor.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_timer.h |    4 ++--
 arch/arm/kernel/arch_timer.c      |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index f98263c..9fa0556 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -2,9 +2,9 @@
 #define __ASMARM_ARCH_TIMER_H
 
 #ifdef CONFIG_HAVE_ARCH_TIMERS
-int arch_timer_register_setup(void (*setup)(struct clock_event_device *));
+int arch_timer_register_setup(int (*setup)(struct clock_event_device *));
 #else
-static inline int arch_timer_register_setup(void (*setup)(struct clock_event_device *))
+static inline int arch_timer_register_setup(int (*setup)(struct clock_event_device *))
 {
 	return -ENODEV;
 }
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index bc05604..fe55919 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -20,10 +20,13 @@
 
 #include <asm/cputype.h>
 #include <asm/localtimer.h>
+#include <asm/sched_clock.h>
 #include <asm/hardware/gic.h>
 
 static unsigned long arch_timer_rate;
 
+static DEFINE_CLOCK_DATA(cd);
+
 /*
  * Architected system timer support.
  */
@@ -201,6 +204,30 @@ static struct clocksource clocksource_counter = {
 	.flags	= (CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES),
 };
 
+static u32 arch_counter_get_cntvct32(void)
+{
+	cycle_t cntvct;
+
+	cntvct = arch_counter_get_cntvct();
+
+	/*
+	 * The sched_clock infrastructure only knows about counters
+	 * with at most 32bits. Forget about the upper 24 bits for the
+	 * time being...
+	 */
+	return (u32)(cntvct & (u32)~0);
+}
+
+DEFINE_SCHED_CLOCK_FUNC(arch_timer_sched_clock)
+{
+	return cyc_to_sched_clock(&cd, arch_counter_get_cntvct32(), (u32)~0);
+}
+
+static void notrace arch_timer_update_sched_clock(void)
+{
+	update_sched_clock(&cd, arch_counter_get_cntvct32(), (u32)~0);
+}
+
 static int __init arch_timer_clocksource_init(void)
 {
 	struct clocksource *cs = &clocksource_counter;
@@ -209,10 +236,13 @@ static int __init arch_timer_clocksource_init(void)
 
 	clocksource_register_hz(cs, arch_timer_rate);
 
+	init_arch_sched_clock(&cd, arch_timer_update_sched_clock,
+			      arch_timer_sched_clock, 32, arch_timer_rate);
+
 	return 0;
 }
 
-int __init arch_timer_register_setup(void (*setup)(struct clock_event_device *))
+int __init arch_timer_register_setup(int (*setup)(struct clock_event_device *))
 {
 	if (!arch_timer_available())
 		return -ENODEV;
-- 
1.7.0.4

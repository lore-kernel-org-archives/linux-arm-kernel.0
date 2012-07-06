From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Jul 2012 10:20:20 +0100
Subject: [RFC PATCH 2/4] ARM: arch_timers: register a time/cycle counter
In-Reply-To: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1341566422-20368-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some subsystems (KVM for example) need access to a cycle counter.
In the KVM case, this is used to measure the time delta between
host and guest in order to accurately generate timer events for
the guest.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_timer.h |    8 ++++++++
 arch/arm/kernel/arch_timer.c      |   25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index ed2e95d..72c6822 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -1,9 +1,12 @@
 #ifndef __ASMARM_ARCH_TIMER_H
 #define __ASMARM_ARCH_TIMER_H
 
+#include <linux/clocksource.h>
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 int arch_timer_of_register(void);
 int arch_timer_sched_clock_init(void);
+struct timecounter *arch_timer_get_timecounter(void);
 #else
 static inline int arch_timer_of_register(void)
 {
@@ -14,6 +17,11 @@ static inline int arch_timer_sched_clock_init(void)
 {
 	return -ENXIO;
 }
+
+static inline struct timecounter *arch_timer_get_timecounter(void)
+{
+	return NULL;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 54599e9..2b5da66 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -318,6 +318,15 @@ static cycle_t arch_counter_read(struct clocksource *cs)
 	return arch_counter_get_cntpct();
 }
 
+static cycle_t arch_counter_read_cc(const struct cyclecounter *cc)
+{
+	/*
+	 * Always use the physical counter for the clocksource.
+	 * CNTHCTL.PL1PCTEN must be set to 1.
+	 */
+	return arch_counter_get_cntpct();
+}
+
 static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
 	.rating	= 400,
@@ -326,6 +335,18 @@ static struct clocksource clocksource_counter = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static struct cyclecounter cyclecounter = {
+	.read	= arch_counter_read_cc,
+	.mask	= CLOCKSOURCE_MASK(56),
+};
+
+static struct timecounter timecounter;
+
+struct timecounter *arch_timer_get_timecounter(void)
+{
+	return &timecounter;
+}
+
 static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
 {
 	int i;
@@ -376,6 +397,10 @@ static int __init arch_timer_register(void)
 	}
 
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
+	cyclecounter.mult = clocksource_counter.mult;
+	cyclecounter.shift = clocksource_counter.shift;
+	timecounter_init(&timecounter, &cyclecounter,
+			 arch_counter_get_cntpct());
 
 	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++) {
 		irq_handler_t handler = arch_timer_handler;
-- 
1.7.10.3

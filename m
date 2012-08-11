From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Aug 2012 11:31:31 +0100
Subject: [PATCH v2 2/2] ARM: arch_timers: register a time/cycle counter
In-Reply-To: <1344681091-12652-1-git-send-email-marc.zyngier@arm.com>
References: <1344681091-12652-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1344681091-12652-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some subsystems (KVM for example) need access to a cycle counter.
In the KVM case, this is used to measure the time delta between
host and guest in order to accurately generate timer events for
the guest.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_timer.h |    7 +++++++
 arch/arm/kernel/arch_timer.c      |   25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 62e7547..ad9b155 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -2,11 +2,13 @@
 #define __ASMARM_ARCH_TIMER_H
 
 #include <asm/errno.h>
+#include <linux/clocksource.h>
 
 #ifdef CONFIG_ARM_ARCH_TIMER
 #define ARCH_HAS_READ_CURRENT_TIMER
 int arch_timer_of_register(void);
 int arch_timer_sched_clock_init(void);
+struct timecounter *arch_timer_get_timecounter(void);
 #else
 static inline int arch_timer_of_register(void)
 {
@@ -17,6 +19,11 @@ static inline int arch_timer_sched_clock_init(void)
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
index 4a64733..f57e4b7 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -330,6 +330,15 @@ int read_current_timer(unsigned long *timer_val)
 	return 0;
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
@@ -338,6 +347,18 @@ static struct clocksource clocksource_counter = {
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
 	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
@@ -381,6 +402,10 @@ static int __init arch_timer_register(void)
 	}
 
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
+	cyclecounter.mult = clocksource_counter.mult;
+	cyclecounter.shift = clocksource_counter.shift;
+	timecounter_init(&timecounter, &cyclecounter,
+			 arch_counter_get_cntpct());
 
 	if (arch_timer_use_virtual) {
 		ppi = arch_timer_ppi[VIRT_PPI];
-- 
1.7.8.6

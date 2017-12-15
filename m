From: sagar.a.kamble@intel.com (Sagar Arun Kamble)
Date: Fri, 15 Dec 2017 13:08:19 +0530
Subject: [PATCH 04/27] clocksource/arm_arch_timer: Use timecounter_initialize
 interface
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1513323522-15021-5-git-send-email-sagar.a.kamble@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With new interface timecounter_initialize we can initialize timecounter
fields and underlying cyclecounter together. Update arch_timer_kvm_info
timecounter init with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clocksource/arm_arch_timer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 31543e5..d96393f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -910,10 +910,7 @@ static u64 arch_counter_get_cntvct_mem(void)
 	return ((u64) vct_hi << 32) | vct_lo;
 }
 
-static struct arch_timer_kvm_info arch_timer_kvm_info = {
-	.timecounter.cc.read = arch_counter_read_cc,
-	.timecounter.cc.mask = CLOCKSOURCE_MASK(56),
-};
+static struct arch_timer_kvm_info arch_timer_kvm_info;
 
 struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 {
@@ -923,7 +920,6 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
-	struct cyclecounter *cc = &arch_timer_kvm_info.timecounter.cc;
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
@@ -943,9 +939,12 @@ static void __init arch_counter_register(unsigned type)
 	start_count = arch_timer_read_counter();
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 
-	cc->mult = clocksource_counter.mult;
-	cc->shift = clocksource_counter.shift;
-	timecounter_init(&arch_timer_kvm_info.timecounter, start_count);
+	timecounter_initialize(&arch_timer_kvm_info.timecounter,
+			       arch_counter_read_cc,
+			       CLOCKSOURCE_MASK(56),
+			       clocksource_counter.mult,
+			       clocksource_counter.shift,
+			       start_count);
 
 	/* 56 bits minimum, so we assume worst case rollover */
 	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
-- 
1.9.1

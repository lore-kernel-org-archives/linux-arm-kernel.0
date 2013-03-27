From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Mar 2013 17:11:50 +0000
Subject: [PATCH 3/5] clocksource: arch_timer: use virtual counters
In-Reply-To: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
References: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1364404312-4427-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switching between reading the virtual or physical counters is
problematic, as some core code wants a view of time before we're fully
set up. Using a function pointer and switching the source after the
first read can make time appear to go backwards, and having a check in
the read function is an unfortunate block on what we want to be a fast
path.

Instead, this patch makes us always use the virtual counters. If we're a
guest, or don't have hyp mode, we'll use the virtual timers, and as such
don't care about CNTVOFF as long as it doesn't change in such a way as
to make time travel backwards. If we do have hyp mode, and might be a
KVM host, we have to use the physical timers, and require CNTVOFF to be
zero so as to have a consistent view of time between the physical timers
and virtual counters.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/arch_timer.h    |  9 ---------
 arch/arm64/include/asm/arch_timer.h  | 10 ----------
 drivers/clocksource/arm_arch_timer.c | 23 +++++------------------
 include/clocksource/arm_arch_timer.h |  2 +-
 4 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 7ade91d..35fea17 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -81,15 +81,6 @@ static inline u32 arch_timer_get_cntfrq(void)
 	return val;
 }
 
-static inline u64 arch_counter_get_cntpct(void)
-{
-	u64 cval;
-
-	isb();
-	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
-	return cval;
-}
-
 static inline u64 arch_counter_get_cntvct(void)
 {
 	u64 cval;
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 91e2a6a..5307737 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -110,16 +110,6 @@ static inline void __cpuinit arch_counter_set_user_access(void)
 	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
 }
 
-static inline u64 arch_counter_get_cntpct(void)
-{
-	u64 cval;
-
-	isb();
-	asm volatile("mrs %0, cntpct_el0" : "=r" (cval));
-
-	return cval;
-}
-
 static inline u64 arch_counter_get_cntvct(void)
 {
 	u64 cval;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d7ad425..2abb861 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -186,27 +186,19 @@ u32 arch_timer_get_rate(void)
 	return arch_timer_rate;
 }
 
-/*
- * Some external users of arch_timer_read_counter (e.g. sched_clock) may try to
- * call it before it has been initialised. Rather than incur a performance
- * penalty checking for initialisation, provide a default implementation that
- * won't lead to time appearing to jump backwards.
- */
-static u64 arch_timer_read_zero(void)
+u64 arch_timer_read_counter(void)
 {
-	return 0;
+	return arch_counter_get_cntvct();
 }
 
-u64 (*arch_timer_read_counter)(void) = arch_timer_read_zero;
-
 static cycle_t arch_counter_read(struct clocksource *cs)
 {
-	return arch_timer_read_counter();
+	return arch_counter_get_cntvct();
 }
 
 static cycle_t arch_counter_read_cc(const struct cyclecounter *cc)
 {
-	return arch_timer_read_counter();
+	return arch_counter_get_cntvct();
 }
 
 static struct clocksource clocksource_counter = {
@@ -285,7 +277,7 @@ static int __init arch_timer_register(void)
 	cyclecounter.mult = clocksource_counter.mult;
 	cyclecounter.shift = clocksource_counter.shift;
 	timecounter_init(&timecounter, &cyclecounter,
-			 arch_counter_get_cntpct());
+			 arch_counter_get_cntvct());
 
 	if (arch_timer_use_virtual) {
 		ppi = arch_timer_ppi[VIRT_PPI];
@@ -382,10 +374,5 @@ int __init arch_timer_init(void)
 		}
 	}
 
-	if (arch_timer_use_virtual)
-		arch_timer_read_counter = arch_counter_get_cntvct;
-	else
-		arch_timer_read_counter = arch_counter_get_cntpct;
-
 	return arch_timer_register();
 }
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 2603267..3883812 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -33,7 +33,7 @@
 
 extern int arch_timer_init(void);
 extern u32 arch_timer_get_rate(void);
-extern u64 (*arch_timer_read_counter)(void);
+extern u64 arch_timer_read_counter(void);
 extern struct timecounter *arch_timer_get_timecounter(void);
 
 #else
-- 
1.8.1.1

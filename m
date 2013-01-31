From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:39 +0000
Subject: [PATCHv5 16/16] clocksource: arch_timer: use virtual counters
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-17-git-send-email-mark.rutland@arm.com>
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

Any code which may want to alter CNTVOFF (e.g. KVM) will need to ensure
that it is zeroed when entering the host.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 21 ++++-----------------
 include/clocksource/arm_arch_timer.h |  2 +-
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d7ad425..f0705fb 100644
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
index b61f996..34dccbe 100644
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

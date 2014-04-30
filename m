From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 30 Apr 2014 14:23:34 +0200
Subject: [RFC PATCH] sched_clock: also call register_current_timer_delay() if
 possible
Message-ID: <1398860614-29469-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM one has to call register_current_timer_delay() in order to use
the (quick) timer based calibrarion instead of the a little slower loop
based delay.
The timer function specified in register_current_timer_delay() is also
used by read_current_timer() which would otherwise return -ENXIO.
And read_current_timer() timer is used by get_cycles() which in turn is
used by random_get_entropy(). That means each sub-architecture returned
here 0 if register_current_timer_delay() was no performed.

The parameters for for sched_clock_register() and
register_current_timer_delay() are mostly the same. Instead of calling
register_current_timer_delay() each time just after (or before)
sched_clock_register() I thought it might easier by doing it once at
sched_clock time since the parameter are the same. That means each ARM sub
arch that working sched-clock would also have a working random_get_entropy()
implementation.

Any comments?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/include/asm/delay.h |  1 +
 kernel/time/sched_clock.c    | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index dff714d..0ae3ff9 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -64,6 +64,7 @@ extern void __loop_const_udelay(unsigned long);
 
 /* Delay-loop timer registration. */
 #define ARCH_HAS_READ_CURRENT_TIMER
+#define ARCH_HAS_CURRENT_TIMER_DELAY
 extern void register_current_timer_delay(const struct delay_timer *timer);
 
 #endif /* __ASSEMBLY__ */
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0abb364..dc09496 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -17,6 +17,7 @@
 #include <linux/sched_clock.h>
 #include <linux/seqlock.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 struct clock_data {
 	ktime_t wrap_kt;
@@ -112,6 +113,24 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
 	hrtimer_forward_now(hrt, cd.wrap_kt);
 	return HRTIMER_RESTART;
 }
+#ifdef ARCH_HAS_CURRENT_TIMER_DELAY
+static struct delay_timer generic_timer;
+
+static void __init do_register_current_timer_delay(u64 (*read)(void),
+		unsigned long rate)
+{
+	if (generic_timer.read_current_timer)
+		return;
+	generic_timer.read_current_timer = (unsigned long (*)(void))read;
+	generic_timer.freq = rate;
+	register_current_timer_delay(&generic_timer);
+}
+
+#else
+
+static inline void do_register_current_timer_delay(u64 (*read)(void),
+		unsigned long rate) {}
+#endif
 
 void __init sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate)
@@ -162,6 +181,7 @@ void __init sched_clock_register(u64 (*read)(void), int bits,
 		enable_sched_clock_irqtime();
 
 	pr_debug("Registered %pF as sched_clock source\n", read);
+	do_register_current_timer_delay(read, rate);
 }
 
 void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
-- 
1.9.2

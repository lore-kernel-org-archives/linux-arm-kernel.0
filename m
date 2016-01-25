From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:41:49 +0100
Subject: [PATCH] tick: sched: hide unused oneshot timer code
Message-ID: <1453736525-1959191-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of functions in kernel/time/tick-sched.c are only
relevant for oneshot timer mode, i.e. when hires-timers or
nohz mode are enabled. If both are disabled, we get gcc warnings
about them:

kernel/time/tick-sched.c:98:16: warning: 'tick_init_jiffy_update' defined but not used [-Wunused-function]
 static ktime_t tick_init_jiffy_update(void)
                ^
kernel/time/tick-sched.c:112:13: warning: 'tick_sched_do_timer' defined but not used [-Wunused-function]
 static void tick_sched_do_timer(ktime_t now)
             ^
kernel/time/tick-sched.c:134:13: warning: 'tick_sched_handle' defined but not used [-Wunused-function]
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
             ^

This encloses the whole set of functions in an appropriate ifdef
to avoid the warning and to make it clearer when they are used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/tick-sched.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9d7a053545f5..1b02ab516373 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -36,16 +36,17 @@
  */
 static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched);
 
-/*
- * The time, when the last jiffy update happened. Protected by jiffies_lock.
- */
-static ktime_t last_jiffies_update;
-
 struct tick_sched *tick_get_tick_sched(int cpu)
 {
 	return &per_cpu(tick_cpu_sched, cpu);
 }
 
+#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
+/*
+ * The time, when the last jiffy update happened. Protected by jiffies_lock.
+ */
+static ktime_t last_jiffies_update;
+
 /*
  * Must be called with interrupts disabled !
  */
@@ -151,6 +152,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
+#endif
 
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
-- 
2.7.0

From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 22 Apr 2014 14:16:50 -0400
Subject: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
In-Reply-To: <20140422134802.73fc1fa4@gandalf.local.home>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org>
 <20140422115439.GA20669@linutronix.de>
 <20140422094657.5b6ca1e2@gandalf.local.home>
 <53569E05.8010600@linutronix.de>
 <20140422134802.73fc1fa4@gandalf.local.home>
Message-ID: <20140422141650.7f43d5ba@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014 13:48:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I need to take a deeper look into the actual code. But as trylocks on
> UP are nops (always succeed), and if it expects to be able to do
> something in a critical section that is protected by spinlocks (again
> nops on UP), this would be broken for UP.

Reading the code, I see it's broken. We should add something like this:

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/kernel/timer.c b/kernel/timer.c
index cc34e42..a03164a 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1447,6 +1447,12 @@ static void run_timer_softirq(struct softirq_action *h)
 		__run_timers(base);
 }
 
+#ifdef CONFIG_SMP
+#define timer_should_raise_softirq(lock)	!spin_do_trylock(lock)
+#else
+#define timer_should_raise_softirq(lock)	1
+#endif
+
 /*
  * Called by the local, per-CPU timer interrupt on SMP.
  */
@@ -1467,7 +1473,7 @@ void run_local_timers(void)
 		return;
 	}
 
-	if (!spin_do_trylock(&base->lock)) {
+	if (timer_should_raise_softirq(&base->lock)) {
 		raise_softirq(TIMER_SOFTIRQ);
 		return;
 	}

From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 8 Feb 2012 05:41:57 +0400
Subject: [PATCH 1/4] sched: Introduce idle notifiers API
In-Reply-To: <20120208013959.GA24535@panacea>
References: <20120208013959.GA24535@panacea>
Message-ID: <20120208014157.GA459@panacea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Idle notifiers may be used as a hint to the code that needs to know when
there are no tasks to execute, and the scheduler is idling, or when the
idling period ends. This patch implements a simple notifiers API.

Notes:

- Unlike x86 "CPU idle" notifiers API, these notifiers do not run on
  every invocation or exit from cpuidle. Instead it is only used
  to notify about scheduler state changes, not HW states.

  In other words, CPU idle notifiers work inside while(!need_resched())
  loop, and scheduler idle notifiers will work outside of this loop.

- rcu_idle_{enter,exit} are wired as built-ins, bypassing
  sched_idle_notifier chain.

  We might change it later to get rid of sched_idle_enter_condrcu()
  stuff on powerpc and x86. But that's just an implementation detail,
  so let's keep things simple for now.

- tick_nohz_idle_enter() is also wired as built-in, there is no much
  gain in moving to to sched_idle_notifier chain.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 include/linux/sched.h |   10 ++++++++++
 kernel/sched/core.c   |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4032ec1..e82f721 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1960,6 +1960,16 @@ extern void sched_clock_idle_sleep_event(void);
 extern void sched_clock_idle_wakeup_event(u64 delta_ns);
 #endif
 
+#define SCHED_IDLE_START	1
+#define SCHED_IDLE_END		2
+extern void sched_idle_notifier_register(struct notifier_block *nb);
+extern void sched_idle_notifier_unregister(struct notifier_block *nb);
+extern void sched_idle_notifier_call_chain(unsigned long val);
+extern void sched_idle_enter_condrcu(bool idle_uses_rcu);
+extern void sched_idle_exit_condrcu(bool idle_uses_rcu);
+static inline void sched_idle_enter(void) { sched_idle_enter_condrcu(0); }
+static inline void sched_idle_exit(void) { sched_idle_exit_condrcu(0); }
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 /*
  * An i/f to runtime opt-in for irq time accounting based off of sched_clock.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd7b25e..62798ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1810,6 +1810,44 @@ void wake_up_new_task(struct task_struct *p)
 	task_rq_unlock(rq, p, &flags);
 }
 
+static ATOMIC_NOTIFIER_HEAD(sched_idle_notifier);
+
+void sched_idle_notifier_register(struct notifier_block *nb)
+{
+	atomic_notifier_chain_register(&sched_idle_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(sched_idle_notifier_register);
+
+void sched_idle_notifier_unregister(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&sched_idle_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(sched_idle_notifier_unregister);
+
+void sched_idle_notifier_call_chain(unsigned long val)
+{
+	atomic_notifier_call_chain(&sched_idle_notifier, val, NULL);
+}
+EXPORT_SYMBOL_GPL(sched_idle_notifier_call_chain);
+
+void sched_idle_enter_condrcu(bool idle_uses_rcu)
+{
+	tick_nohz_idle_enter();
+	if (!idle_uses_rcu)
+		rcu_idle_enter();
+	sched_idle_notifier_call_chain(SCHED_IDLE_START);
+}
+EXPORT_SYMBOL_GPL(sched_idle_enter_condrcu);
+
+void sched_idle_exit_condrcu(bool idle_uses_rcu)
+{
+	sched_idle_notifier_call_chain(SCHED_IDLE_END);
+	if (!idle_uses_rcu)
+		rcu_idle_exit();
+	tick_nohz_idle_exit();
+}
+EXPORT_SYMBOL_GPL(sched_idle_exit_condrcu);
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 /**
-- 
1.7.7.6

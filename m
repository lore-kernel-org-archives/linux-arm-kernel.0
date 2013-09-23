From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:46 -0400
Subject: [PATCH 03/13] ARM: bL_switcher: Add switch completion callback for
 bL_switch_request()
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

There is no explicit way to know when a switch started via
bL_switch_request() is complete.  This can lead to unpredictable
behaviour when the switcher is controlled by a subsystem which
makes dynamic decisions (such as cpufreq).

The CPU PM notifier is not really suitable for signalling
completion, because the CPU could get suspended and resumed for
other, independent reasons while a switch request is in flight.
Adding a whole new notifier for this seems excessive, and may tempt
people to put heavyweight code on this path.

This patch implements a new bL_switch_request_cb() function that
allows for a per-request lightweight callback, private between the
switcher and the caller of bL_switch_request_cb().

Overlapping switches on a single CPU are considered incorrect if
they are requested via bL_switch_request_cb() with a callback (they
will lead to an unpredictable final state without explicit external
synchronisation to force the requests into a particular order).
Queuing requests robustly would be overkill because only one
subsystem should be attempting to control the switcher at any time.

Overlapping requests of this kind will be failed with -EBUSY to
indicate that the second request won't take effect and the
completer will never be called for it.

bL_switch_request() is retained as a wrapper round the new function,
with the old, fire-and-forget semantics.  In this case the last request
will always win. The request may still be denied if a previous request
with a completer is still pending.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/common/bL_switcher.c      | 53 ++++++++++++++++++++++++++++++++++----
 arch/arm/include/asm/bL_switcher.h | 10 ++++++-
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 016488730c..34316be404 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -25,6 +26,7 @@
 #include <linux/notifier.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/irqchip/arm-gic.h>
@@ -224,10 +226,13 @@ static int bL_switch_to(unsigned int new_cluster_id)
 }
 
 struct bL_thread {
+	spinlock_t lock;
 	struct task_struct *task;
 	wait_queue_head_t wq;
 	int wanted_cluster;
 	struct completion started;
+	bL_switch_completion_handler completer;
+	void *completer_cookie;
 };
 
 static struct bL_thread bL_threads[NR_CPUS];
@@ -237,6 +242,8 @@ static int bL_switcher_thread(void *arg)
 	struct bL_thread *t = arg;
 	struct sched_param param = { .sched_priority = 1 };
 	int cluster;
+	bL_switch_completion_handler completer;
+	void *completer_cookie;
 
 	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
 	complete(&t->started);
@@ -247,9 +254,21 @@ static int bL_switcher_thread(void *arg)
 		wait_event_interruptible(t->wq,
 				t->wanted_cluster != -1 ||
 				kthread_should_stop());
-		cluster = xchg(&t->wanted_cluster, -1);
-		if (cluster != -1)
+
+		spin_lock(&t->lock);
+		cluster = t->wanted_cluster;
+		completer = t->completer;
+		completer_cookie = t->completer_cookie;
+		t->wanted_cluster = -1;
+		t->completer = NULL;
+		spin_unlock(&t->lock);
+
+		if (cluster != -1) {
 			bL_switch_to(cluster);
+
+			if (completer)
+				completer(completer_cookie);
+		}
 	} while (!kthread_should_stop());
 
 	return 0;
@@ -270,16 +289,30 @@ static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
 }
 
 /*
- * bL_switch_request - Switch to a specific cluster for the given CPU
+ * bL_switch_request_cb - Switch to a specific cluster for the given CPU,
+ *      with completion notification via a callback
  *
  * @cpu: the CPU to switch
  * @new_cluster_id: the ID of the cluster to switch to.
+ * @completer: switch completion callback.  if non-NULL,
+ *	@completer(@completer_cookie) will be called on completion of
+ *	the switch, in non-atomic context.
+ * @completer_cookie: opaque context argument for @completer.
  *
  * This function causes a cluster switch on the given CPU by waking up
  * the appropriate switcher thread.  This function may or may not return
  * before the switch has occurred.
+ *
+ * If a @completer callback function is supplied, it will be called when
+ * the switch is complete.  This can be used to determine asynchronously
+ * when the switch is complete, regardless of when bL_switch_request()
+ * returns.  When @completer is supplied, no new switch request is permitted
+ * for the affected CPU until after the switch is complete, and @completer
+ * has returned.
  */
-int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
+int bL_switch_request_cb(unsigned int cpu, unsigned int new_cluster_id,
+			 bL_switch_completion_handler completer,
+			 void *completer_cookie)
 {
 	struct bL_thread *t;
 
@@ -289,16 +322,25 @@ int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
 	}
 
 	t = &bL_threads[cpu];
+
 	if (IS_ERR(t->task))
 		return PTR_ERR(t->task);
 	if (!t->task)
 		return -ESRCH;
 
+	spin_lock(&t->lock);
+	if (t->completer) {
+		spin_unlock(&t->lock);
+		return -EBUSY;
+	}
+	t->completer = completer;
+	t->completer_cookie = completer_cookie;
 	t->wanted_cluster = new_cluster_id;
+	spin_unlock(&t->lock);
 	wake_up(&t->wq);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bL_switch_request);
+EXPORT_SYMBOL_GPL(bL_switch_request_cb);
 
 /*
  * Activation and configuration code.
@@ -460,6 +502,7 @@ static int bL_switcher_enable(void)
 
 	for_each_online_cpu(cpu) {
 		struct bL_thread *t = &bL_threads[cpu];
+		spin_lock_init(&t->lock);
 		init_waitqueue_head(&t->wq);
 		init_completion(&t->started);
 		t->wanted_cluster = -1;
diff --git a/arch/arm/include/asm/bL_switcher.h b/arch/arm/include/asm/bL_switcher.h
index b243ca93e8..7d1cce8b8a 100644
--- a/arch/arm/include/asm/bL_switcher.h
+++ b/arch/arm/include/asm/bL_switcher.h
@@ -15,7 +15,15 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
-int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id);
+typedef void (*bL_switch_completion_handler)(void *cookie);
+
+int bL_switch_request_cb(unsigned int cpu, unsigned int new_cluster_id,
+			 bL_switch_completion_handler completer,
+			 void *completer_cookie);
+static inline int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
+{
+	return bL_switch_request_cb(cpu, new_cluster_id, NULL, NULL);
+}
 
 /*
  * Register here to be notified about runtime enabling/disabling of
-- 
1.8.4.98.gb022869

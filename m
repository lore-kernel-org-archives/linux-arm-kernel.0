From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:53 +0800
Subject: [RFC PATCH v4 15/34] early kprobes: use stop_machine() based
 optimization method for early kprobes.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-16-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

schedule_delayed_work() doesn't work until scheduler and timer are
ready. For early kprobes, directly call do_optimize_kprobes() should
make things simpler. Arch code should ensure there's no conflict between
code modification and execution using stop_machine().

To avoid lock order problem, call do_optimize_kprobes() before leaving
register_kprobe() instead of kick_kprobe_optimizer().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab3640b..2d178fc 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -546,7 +546,16 @@ static void do_free_cleaned_kprobes(void)
 /* Start optimizer after OPTIMIZE_DELAY passed */
 static void kick_kprobe_optimizer(void)
 {
-	schedule_delayed_work(&optimizing_work, OPTIMIZE_DELAY);
+	/*
+	 * For early kprobes, scheduler and timer may not ready.  Use
+	 * do_optimize_kprobes() and let it choose stop_machine() based
+	 * optimizer. Instead of directly calling do_optimize_kprobes(),
+	 * let optimization be done in register_kprobe because we can
+	 * held many (and different) locks here in different situations
+	 * which makes things relativly complex.
+	 */
+	if (likely(!kprobes_is_early()))
+		schedule_delayed_work(&optimizing_work, OPTIMIZE_DELAY);
 }
 
 /* Kprobe jump optimizer */
@@ -1595,6 +1604,16 @@ int register_kprobe(struct kprobe *p)
 	/* Try to optimize kprobe */
 	try_to_optimize_kprobe(p);
 
+	/*
+	 * Optimize early kprobes here because of locking order.
+	 * See comments in kick_kprobe_optimizer().
+	 */
+	if (unlikely(kprobes_is_early())) {
+		mutex_lock(&module_mutex);
+		do_optimize_kprobes();
+		mutex_unlock(&module_mutex);
+	}
+
 out:
 	mutex_unlock(&kprobe_mutex);
 
-- 
1.8.4

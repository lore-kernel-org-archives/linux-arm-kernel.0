From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:54 -0400
Subject: [PATCH 11/13] ARM: bL_switcher/trace: Add trace trigger for trace
 bootstrapping
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-12-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

When tracing switching, an external tracer needs a way to bootstrap
its knowledge of the logical<->physical CPU mapping.

This patch adds a sysfs attribute trace_trigger.  A write to this
attribute will generate a power:cpu_migrate_current event for each
online CPU, indicating the current physical CPU for each logical
CPU.

Activating or deactivating the switcher also generates these
events, so that the tracer knows about the resulting remapping of
affected CPUs.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/common/bL_switcher.c            | 36 ++++++++++++++++++++++++++++++++
 include/trace/events/power_cpu_migrate.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 7002de360d..f0dc025077 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -27,6 +27,7 @@
 #include <linux/notifier.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
@@ -531,6 +532,25 @@ static int bL_switcher_halve_cpus(void)
 	return 0;
 }
 
+static void bL_switcher_trace_trigger_cpu(void *__always_unused info)
+{
+	trace_cpu_migrate_current(get_ns(), read_mpidr());
+}
+
+static int bL_switcher_trace_trigger(void)
+{
+	int ret;
+
+	preempt_disable();
+
+	bL_switcher_trace_trigger_cpu(NULL);
+	ret = smp_call_function(bL_switcher_trace_trigger_cpu, NULL, true);
+
+	preempt_enable();
+
+	return ret;
+}
+
 static int bL_switcher_enable(void)
 {
 	int cpu, ret;
@@ -553,6 +573,8 @@ static int bL_switcher_enable(void)
 	if (ret)
 		goto error;
 
+	bL_switcher_trace_trigger();
+
 	for_each_online_cpu(cpu) {
 		struct bL_thread *t = &bL_threads[cpu];
 		spin_lock_init(&t->lock);
@@ -637,6 +659,8 @@ static void bL_switcher_disable(void)
 	}
 
 	bL_switcher_restore_cpus();
+	bL_switcher_trace_trigger();
+
 	bL_activation_notify(BL_NOTIFY_POST_DISABLE);
 
 out:
@@ -670,11 +694,23 @@ static ssize_t bL_switcher_active_store(struct kobject *kobj,
 	return (ret >= 0) ? count : ret;
 }
 
+static ssize_t bL_switcher_trace_trigger_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int ret = bL_switcher_trace_trigger();
+
+	return ret ? ret : count;
+}
+
 static struct kobj_attribute bL_switcher_active_attr =
 	__ATTR(active, 0644, bL_switcher_active_show, bL_switcher_active_store);
 
+static struct kobj_attribute bL_switcher_trace_trigger_attr =
+	__ATTR(trace_trigger, 0200, NULL, bL_switcher_trace_trigger_store);
+
 static struct attribute *bL_switcher_attrs[] = {
 	&bL_switcher_active_attr.attr,
+	&bL_switcher_trace_trigger_attr.attr,
 	NULL,
 };
 
diff --git a/include/trace/events/power_cpu_migrate.h b/include/trace/events/power_cpu_migrate.h
index 3694af0f5b..f76dd4de62 100644
--- a/include/trace/events/power_cpu_migrate.h
+++ b/include/trace/events/power_cpu_migrate.h
@@ -42,6 +42,7 @@ DECLARE_EVENT_CLASS(cpu_migrate,
 
 __define_cpu_migrate_event(begin);
 __define_cpu_migrate_event(finish);
+__define_cpu_migrate_event(current);
 
 #undef __define_cpu_migrate
 #undef __cpu_migrate_proto
-- 
1.8.4.98.gb022869

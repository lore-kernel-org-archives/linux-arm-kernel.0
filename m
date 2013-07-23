From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:25 -0400
Subject: [PATCH 09/13] ARM: bL_switcher: ability to enable and disable the
 switcher via sysfs
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The /sys/kernel/bL_switcher/enable file allows to enable or disable
the switcher by writing 1 or 0 to it respectively.  It is still enabled
by default on boot.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 171 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 160 insertions(+), 11 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 34eff3bc25..abeeff5520 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -24,6 +24,7 @@
 #include <linux/tick.h>
 #include <linux/mm.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/irqchip/arm-gic.h>
 
 #include <asm/smp_plat.h>
@@ -226,6 +227,7 @@ struct bL_thread {
 	struct task_struct *task;
 	wait_queue_head_t wq;
 	int wanted_cluster;
+	struct completion started;
 };
 
 static struct bL_thread bL_threads[MAX_CPUS_PER_CLUSTER];
@@ -237,6 +239,7 @@ static int bL_switcher_thread(void *arg)
 	int cluster;
 
 	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
+	complete(&t->started);
 
 	do {
 		if (signal_pending(current))
@@ -252,7 +255,7 @@ static int bL_switcher_thread(void *arg)
 	return 0;
 }
 
-static struct task_struct * __init bL_switcher_thread_create(int cpu, void *arg)
+static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
 {
 	struct task_struct *task;
 
@@ -301,9 +304,11 @@ EXPORT_SYMBOL_GPL(bL_switch_request);
  * Activation and configuration code.
  */
 
+static unsigned int bL_switcher_active;
+static unsigned int bL_switcher_cpu_original_cluster[MAX_CPUS_PER_CLUSTER];
 static cpumask_t bL_switcher_removed_logical_cpus;
 
-static void __init bL_switcher_restore_cpus(void)
+static void bL_switcher_restore_cpus(void)
 {
 	int i;
 
@@ -311,7 +316,7 @@ static void __init bL_switcher_restore_cpus(void)
 		cpu_up(i);
 }
 
-static int __init bL_switcher_halve_cpus(void)
+static int bL_switcher_halve_cpus(void)
 {
 	int cpu, cluster, i, ret;
 	cpumask_t cluster_mask[2], common_mask;
@@ -355,8 +360,10 @@ static int __init bL_switcher_halve_cpus(void)
 			 * is equal to their physical CPU number. This is
 			 * not perfect but good enough for now.
 			 */
-			if (cpu == i)
+			if (cpu == i) {
+				bL_switcher_cpu_original_cluster[cpu] = cluster;
 				continue;
+			}
 		}
 
 		ret = cpu_down(i);
@@ -370,18 +377,18 @@ static int __init bL_switcher_halve_cpus(void)
 	return 0;
 }
 
-static int __init bL_switcher_init(void)
+static int bL_switcher_enable(void)
 {
 	int cpu, ret;
 
-	pr_info("big.LITTLE switcher initializing\n");
-
-	if (MAX_NR_CLUSTERS != 2) {
-		pr_err("%s: only dual cluster systems are supported\n", __func__);
-		return -EINVAL;
+	cpu_hotplug_driver_lock();
+	if (bL_switcher_active) {
+		cpu_hotplug_driver_unlock();
+		return 0;
 	}
 
-	cpu_hotplug_driver_lock();
+	pr_info("big.LITTLE switcher initializing\n");
+
 	ret = bL_switcher_halve_cpus();
 	if (ret) {
 		cpu_hotplug_driver_unlock();
@@ -391,13 +398,155 @@ static int __init bL_switcher_init(void)
 	for_each_online_cpu(cpu) {
 		struct bL_thread *t = &bL_threads[cpu];
 		init_waitqueue_head(&t->wq);
+		init_completion(&t->started);
 		t->wanted_cluster = -1;
 		t->task = bL_switcher_thread_create(cpu, t);
 	}
+
+	bL_switcher_active = 1;
 	cpu_hotplug_driver_unlock();
 
 	pr_info("big.LITTLE switcher initialized\n");
 	return 0;
 }
 
+#ifdef CONFIG_SYSFS
+
+static void bL_switcher_disable(void)
+{
+	unsigned int cpu, cluster, i;
+	struct bL_thread *t;
+	struct task_struct *task;
+
+	cpu_hotplug_driver_lock();
+	if (!bL_switcher_active) {
+		cpu_hotplug_driver_unlock();
+		return;
+	}
+	bL_switcher_active = 0;
+
+	/*
+	 * To deactivate the switcher, we must shut down the switcher
+	 * threads to prevent any other requests from being accepted.
+	 * Then, if the final cluster for given logical CPU is not the
+	 * same as the original one, we'll recreate a switcher thread
+	 * just for the purpose of switching the CPU back without any
+	 * possibility for interference from external requests.
+	 */
+	for_each_online_cpu(cpu) {
+		BUG_ON(cpu != (cpu_logical_map(cpu) & 0xff));
+		t = &bL_threads[cpu];
+		task = t->task;
+		t->task = NULL;
+		if (!task || IS_ERR(task))
+			continue;
+		kthread_stop(task);
+		/* no more switch may happen on this CPU at this point */
+		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
+		if (cluster == bL_switcher_cpu_original_cluster[cpu])
+			continue;
+		init_completion(&t->started);
+		t->wanted_cluster = bL_switcher_cpu_original_cluster[cpu];
+		task = bL_switcher_thread_create(cpu, t);
+		if (!IS_ERR(task)) {
+			wait_for_completion(&t->started);
+			kthread_stop(task);
+			cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
+			if (cluster == bL_switcher_cpu_original_cluster[cpu])
+				continue;
+		}
+		/* If execution gets here, we're in trouble. */
+		pr_crit("%s: unable to restore original cluster for CPU %d\n",
+			__func__, cpu);
+		for_each_cpu(i, &bL_switcher_removed_logical_cpus) {
+			if ((cpu_logical_map(i) & 0xff) != cpu)
+				continue;
+			pr_crit("%s: CPU %d can't be restored\n",
+				__func__, i);
+			cpumask_clear_cpu(i, &bL_switcher_removed_logical_cpus);
+			break;
+		}
+	}
+
+	bL_switcher_restore_cpus();
+	cpu_hotplug_driver_unlock();
+}
+
+static ssize_t bL_switcher_active_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", bL_switcher_active);
+}
+
+static ssize_t bL_switcher_active_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+
+	switch (buf[0]) {
+	case '0':
+		bL_switcher_disable();
+		ret = 0;
+		break;
+	case '1':
+		ret = bL_switcher_enable();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return (ret >= 0) ? count : ret;
+}
+
+static struct kobj_attribute bL_switcher_active_attr =
+	__ATTR(active, 0644, bL_switcher_active_show, bL_switcher_active_store);
+
+static struct attribute *bL_switcher_attrs[] = {
+	&bL_switcher_active_attr.attr,
+	NULL,
+};
+
+static struct attribute_group bL_switcher_attr_group = {
+	.attrs = bL_switcher_attrs,
+};
+
+static struct kobject *bL_switcher_kobj;
+
+static int __init bL_switcher_sysfs_init(void)
+{
+	int ret;
+
+	bL_switcher_kobj = kobject_create_and_add("bL_switcher", kernel_kobj);
+	if (!bL_switcher_kobj)
+		return -ENOMEM;
+	ret = sysfs_create_group(bL_switcher_kobj, &bL_switcher_attr_group);
+	if (ret)
+		kobject_put(bL_switcher_kobj);
+	return ret;
+}
+
+#endif  /* CONFIG_SYSFS */
+
+static int __init bL_switcher_init(void)
+{
+	int ret;
+
+	if (MAX_NR_CLUSTERS != 2) {
+		pr_err("%s: only dual cluster systems are supported\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = bL_switcher_enable();
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_SYSFS
+	ret = bL_switcher_sysfs_init();
+	if (ret)
+		pr_err("%s: unable to create sysfs entry\n", __func__);
+#endif
+
+	return 0;
+}
+
 late_initcall(bL_switcher_init);
-- 
1.8.1.2

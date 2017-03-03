From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri,  3 Mar 2017 12:41:29 -0800
Subject: [PATCH V5 3/9] kernel/cpu_pm: Add runtime PM support for CPUs
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1488573695-106680-4-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its PM domain.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/cpuhotplug.h |  1 +
 kernel/cpu_pm.c            | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 921acaa..448226a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -79,6 +79,7 @@ enum cpuhp_state {
 	CPUHP_AP_OFFLINE,
 	CPUHP_AP_SCHED_STARTING,
 	CPUHP_AP_RCUTREE_DYING,
+	CPUHP_AP_CPU_PM_STARTING,
 	CPUHP_AP_IRQ_GIC_STARTING,
 	CPUHP_AP_IRQ_HIP04_STARTING,
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 009cc9a..db95ef3 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -16,9 +16,12 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -99,6 +102,7 @@ int cpu_pm_enter(void)
 {
 	int nr_calls;
 	int ret = 0;
+	struct device *dev = get_cpu_device(smp_processor_id());
 
 	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
@@ -110,6 +114,10 @@ int cpu_pm_enter(void)
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
 	read_unlock(&cpu_pm_notifier_lock);
 
+	/* Notify Runtime PM that we are suspending the CPU */
+	if (!ret && dev)
+		RCU_NONIDLE(pm_runtime_put_sync_suspend(dev));
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
@@ -129,6 +137,11 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
 int cpu_pm_exit(void)
 {
 	int ret;
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	/* Notify Runtime PM that we are resuming the CPU */
+	if (dev)
+		RCU_NONIDLE(pm_runtime_get_sync(dev));
 
 	read_lock(&cpu_pm_notifier_lock);
 	ret = cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
@@ -200,6 +213,40 @@ int cpu_cluster_pm_exit(void)
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int cpu_pm_cpu_dying(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (dev)
+		pm_runtime_put_sync_suspend(dev);
+
+	return 0;
+}
+
+static int cpu_pm_cpu_starting(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (dev)
+		pm_runtime_get_sync(dev);
+
+	return 0;
+}
+
+static int __init cpu_pm_hotplug_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_CPU_PM_STARTING,
+				"AP_CPU_PM_STARTING",
+				cpu_pm_cpu_starting, cpu_pm_cpu_dying);
+
+	return ret;
+}
+device_initcall(cpu_pm_hotplug_init);
+#endif
+
 #ifdef CONFIG_PM
 static int cpu_pm_suspend(void)
 {
-- 
2.7.4

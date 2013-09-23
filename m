From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:44 -0400
Subject: [PATCH 01/13] ARM: bL_switcher: Add synchronous enable/disable
 interface
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Some subsystems will need to know for sure whether the switcher is
enabled or disabled during certain critical regions.

This patch provides a simple mutex-based mechanism to discover
whether the switcher is enabled and temporarily lock out further
enable/disable:

  * bL_switcher_get_enabled() returns true iff the switcher is
    enabled and temporarily inhibits enable/disable.

  * bL_switcher_put_enabled() permits enable/disable of the switcher
    again after a previous call to bL_switcher_get_enabled().

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c      | 27 +++++++++++++++++++++++++--
 arch/arm/include/asm/bL_switcher.h |  3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 335ff76d4c..7d98629aa4 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -23,6 +23,7 @@
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/irqchip/arm-gic.h>
@@ -302,6 +303,7 @@ EXPORT_SYMBOL_GPL(bL_switch_request);
  * Activation and configuration code.
  */
 
+static DEFINE_MUTEX(bL_switcher_activation_lock);
 static unsigned int bL_switcher_active;
 static unsigned int bL_switcher_cpu_original_cluster[NR_CPUS];
 static cpumask_t bL_switcher_removed_logical_cpus;
@@ -413,9 +415,11 @@ static int bL_switcher_enable(void)
 {
 	int cpu, ret;
 
+	mutex_lock(&bL_switcher_activation_lock);
 	cpu_hotplug_driver_lock();
 	if (bL_switcher_active) {
 		cpu_hotplug_driver_unlock();
+		mutex_unlock(&bL_switcher_activation_lock);
 		return 0;
 	}
 
@@ -424,6 +428,7 @@ static int bL_switcher_enable(void)
 	ret = bL_switcher_halve_cpus();
 	if (ret) {
 		cpu_hotplug_driver_unlock();
+		mutex_unlock(&bL_switcher_activation_lock);
 		return ret;
 	}
 
@@ -436,9 +441,10 @@ static int bL_switcher_enable(void)
 	}
 
 	bL_switcher_active = 1;
-	cpu_hotplug_driver_unlock();
-
 	pr_info("big.LITTLE switcher initialized\n");
+
+	cpu_hotplug_driver_unlock();
+	mutex_unlock(&bL_switcher_activation_lock);
 	return 0;
 }
 
@@ -450,9 +456,11 @@ static void bL_switcher_disable(void)
 	struct bL_thread *t;
 	struct task_struct *task;
 
+	mutex_lock(&bL_switcher_activation_lock);
 	cpu_hotplug_driver_lock();
 	if (!bL_switcher_active) {
 		cpu_hotplug_driver_unlock();
+		mutex_unlock(&bL_switcher_activation_lock);
 		return;
 	}
 	bL_switcher_active = 0;
@@ -497,6 +505,7 @@ static void bL_switcher_disable(void)
 
 	bL_switcher_restore_cpus();
 	cpu_hotplug_driver_unlock();
+	mutex_unlock(&bL_switcher_activation_lock);
 }
 
 static ssize_t bL_switcher_active_show(struct kobject *kobj,
@@ -554,6 +563,20 @@ static int __init bL_switcher_sysfs_init(void)
 
 #endif  /* CONFIG_SYSFS */
 
+bool bL_switcher_get_enabled(void)
+{
+	mutex_lock(&bL_switcher_activation_lock);
+
+	return bL_switcher_active;
+}
+EXPORT_SYMBOL_GPL(bL_switcher_get_enabled);
+
+void bL_switcher_put_enabled(void)
+{
+	mutex_unlock(&bL_switcher_activation_lock);
+}
+EXPORT_SYMBOL_GPL(bL_switcher_put_enabled);
+
 /*
  * Veto any CPU hotplug operation on those CPUs we've removed
  * while the switcher is active.
diff --git a/arch/arm/include/asm/bL_switcher.h b/arch/arm/include/asm/bL_switcher.h
index e0c0bba70b..05d7c4cb94 100644
--- a/arch/arm/include/asm/bL_switcher.h
+++ b/arch/arm/include/asm/bL_switcher.h
@@ -14,4 +14,7 @@
 
 int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id);
 
+bool bL_switcher_get_enabled(void);
+void bL_switcher_put_enabled(void);
+
 #endif
-- 
1.8.4.98.gb022869

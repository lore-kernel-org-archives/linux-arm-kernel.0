From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:45 -0400
Subject: [PATCH 02/13] ARM: bL_switcher: Add runtime control notifier
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Some subsystems will need to respond synchronously to runtime
enabling and disabling of the switcher.

This patch adds a dedicated notifier interface to support such
subsystems.  Pre- and post- enable/disable notifications are sent
to registered callbacks, allowing safe transition of non-b.L-
transparent subsystems across these control transitions.

Notifier callbacks may veto switcher (de)activation on pre notifications
only.  Post notifications won't revert the action.

If enabling or disabling of the switcher fails after the pre-change
notification has been sent, subsystems which have registered
notifiers can be left in an inappropriate state.

This patch sends a suitable post-change notification on failure,
indicating that the old state has been reestablished.

For example, a failed initialisation will result in the following
sequence:

    BL_NOTIFY_PRE_ENABLE
    /* switcher initialisation fails */
    BL_NOTIFY_POST_DISABLE

It is the responsibility of notified subsystems to respond in an
appropriate way.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c      | 60 +++++++++++++++++++++++++++++++-------
 arch/arm/include/asm/bL_switcher.h | 44 ++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 7d98629aa4..016488730c 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -22,6 +22,7 @@
 #include <linux/clockchips.h>
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
+#include <linux/notifier.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/string.h>
@@ -304,10 +305,34 @@ EXPORT_SYMBOL_GPL(bL_switch_request);
  */
 
 static DEFINE_MUTEX(bL_switcher_activation_lock);
+static BLOCKING_NOTIFIER_HEAD(bL_activation_notifier);
 static unsigned int bL_switcher_active;
 static unsigned int bL_switcher_cpu_original_cluster[NR_CPUS];
 static cpumask_t bL_switcher_removed_logical_cpus;
 
+int bL_switcher_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&bL_activation_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(bL_switcher_register_notifier);
+
+int bL_switcher_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&bL_activation_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(bL_switcher_unregister_notifier);
+
+static int bL_activation_notify(unsigned long val)
+{
+	int ret;
+
+	ret = blocking_notifier_call_chain(&bL_activation_notifier, val, NULL);
+	if (ret & NOTIFY_STOP_MASK)
+		pr_err("%s: notifier chain failed with status 0x%x\n",
+			__func__, ret);
+	return notifier_to_errno(ret);
+}
+
 static void bL_switcher_restore_cpus(void)
 {
 	int i;
@@ -425,12 +450,13 @@ static int bL_switcher_enable(void)
 
 	pr_info("big.LITTLE switcher initializing\n");
 
+	ret = bL_activation_notify(BL_NOTIFY_PRE_ENABLE);
+	if (ret)
+		goto error;
+
 	ret = bL_switcher_halve_cpus();
-	if (ret) {
-		cpu_hotplug_driver_unlock();
-		mutex_unlock(&bL_switcher_activation_lock);
-		return ret;
-	}
+	if (ret)
+		goto error;
 
 	for_each_online_cpu(cpu) {
 		struct bL_thread *t = &bL_threads[cpu];
@@ -441,11 +467,18 @@ static int bL_switcher_enable(void)
 	}
 
 	bL_switcher_active = 1;
+	bL_activation_notify(BL_NOTIFY_POST_ENABLE);
 	pr_info("big.LITTLE switcher initialized\n");
+	goto out;
+
+error:
+	pr_warn("big.LITTLE switcher initialization failed\n");
+	bL_activation_notify(BL_NOTIFY_POST_DISABLE);
 
+out:
 	cpu_hotplug_driver_unlock();
 	mutex_unlock(&bL_switcher_activation_lock);
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_SYSFS
@@ -458,11 +491,15 @@ static void bL_switcher_disable(void)
 
 	mutex_lock(&bL_switcher_activation_lock);
 	cpu_hotplug_driver_lock();
-	if (!bL_switcher_active) {
-		cpu_hotplug_driver_unlock();
-		mutex_unlock(&bL_switcher_activation_lock);
-		return;
+
+	if (!bL_switcher_active)
+		goto out;
+
+	if (bL_activation_notify(BL_NOTIFY_PRE_DISABLE) != 0) {
+		bL_activation_notify(BL_NOTIFY_POST_ENABLE);
+		goto out;
 	}
+
 	bL_switcher_active = 0;
 
 	/*
@@ -504,6 +541,9 @@ static void bL_switcher_disable(void)
 	}
 
 	bL_switcher_restore_cpus();
+	bL_activation_notify(BL_NOTIFY_POST_DISABLE);
+
+out:
 	cpu_hotplug_driver_unlock();
 	mutex_unlock(&bL_switcher_activation_lock);
 }
diff --git a/arch/arm/include/asm/bL_switcher.h b/arch/arm/include/asm/bL_switcher.h
index 05d7c4cb94..b243ca93e8 100644
--- a/arch/arm/include/asm/bL_switcher.h
+++ b/arch/arm/include/asm/bL_switcher.h
@@ -12,9 +12,53 @@
 #ifndef ASM_BL_SWITCHER_H
 #define ASM_BL_SWITCHER_H
 
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id);
 
+/*
+ * Register here to be notified about runtime enabling/disabling of
+ * the switcher.
+ *
+ * The notifier chain is called with the switcher activation lock held:
+ * the switcher will not be enabled or disabled during callbacks.
+ * Callbacks must not call bL_switcher_{get,put}_enabled().
+ */
+#define BL_NOTIFY_PRE_ENABLE	0
+#define BL_NOTIFY_POST_ENABLE	1
+#define BL_NOTIFY_PRE_DISABLE	2
+#define BL_NOTIFY_POST_DISABLE	3
+
+#ifdef CONFIG_BL_SWITCHER
+
+int bL_switcher_register_notifier(struct notifier_block *nb);
+int bL_switcher_unregister_notifier(struct notifier_block *nb);
+
+/*
+ * Use these functions to temporarily prevent enabling/disabling of
+ * the switcher.
+ * bL_switcher_get_enabled() returns true if the switcher is currently
+ * enabled.  Each call to bL_switcher_get_enabled() must be followed
+ * by a call to bL_switcher_put_enabled().  These functions are not
+ * recursive.
+ */
 bool bL_switcher_get_enabled(void);
 void bL_switcher_put_enabled(void);
 
+#else
+static inline int bL_switcher_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int bL_switcher_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline bool bL_switcher_get_enabled(void) { return false; }
+static inline void bL_switcher_put_enabled(void) { }
+#endif /* CONFIG_BL_SWITCHER */
+
 #endif
-- 
1.8.4.98.gb022869

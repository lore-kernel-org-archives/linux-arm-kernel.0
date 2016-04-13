From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Apr 2016 11:35:59 +0200
Subject: [PATCH v7 1/2] drivers: base: add support for registering notifier
 about deferred probe
In-Reply-To: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds code which allow other subsystems get a notification
when deferred probe has been triggered. This way one can retry some
actions, which earlier failed with -EPROBE_DEFER error code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dd.c      | 31 +++++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 16688f50729c..208466eb83fb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -19,6 +19,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/notifier.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
@@ -53,6 +54,7 @@ static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
 static struct workqueue_struct *deferred_wq;
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
+static BLOCKING_NOTIFIER_HEAD(deferred_notifier_head);
 
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -113,6 +115,9 @@ static void deferred_probe_work_func(struct work_struct *work)
 		put_device(dev);
 	}
 	mutex_unlock(&deferred_probe_mutex);
+
+	/* Notify any listeners about triggering deferred probe */
+	blocking_notifier_call_chain(&deferred_notifier_head, 0, NULL);
 }
 static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
 
@@ -224,6 +229,32 @@ static int deferred_probe_initcall(void)
 late_initcall(deferred_probe_initcall);
 
 /**
+ * deferred_probe_register_notifier - Register a notifier for deferred probe
+ * @nb: notifier block to signal
+ *
+ * This function allows caller to get a notification when deferred probe has
+ * been triggered. This lets it to retry some actions, which earlier failed
+ * with -EPROBE_DEFER error code.
+ */
+int deferred_probe_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&deferred_notifier_head, nb);
+}
+EXPORT_SYMBOL_GPL(deferred_probe_register_notifier);
+
+/**
+ * deferred_probe_unregister_notifier - Unregister a notifier
+ * @nb: notifier block to signal
+ *
+ * Unregister a previously registered deferred probe notifier.
+ */
+int deferred_probe_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&deferred_notifier_head, nb);
+}
+EXPORT_SYMBOL_GPL(deferred_probe_unregister_notifier);
+
+/**
  * device_is_bound() - Check if device is bound to a driver
  * @dev: device to check
  *
diff --git a/include/linux/device.h b/include/linux/device.h
index 002c59728dbe..c6496d1db5de 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1066,6 +1066,9 @@ extern int __must_check device_reprobe(struct device *dev);
 
 extern bool device_is_bound(struct device *dev);
 
+extern int deferred_probe_register_notifier(struct notifier_block *nb);
+extern int deferred_probe_unregister_notifier(struct notifier_block *nb);
+
 /*
  * Easy functions for dynamically creating devices on the fly
  */
-- 
1.9.2

From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri,  7 Sep 2018 12:07:44 +0200
Subject: [PATCH v2 10/16] nvmem: add a notifier chain
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Message-ID: <20180907100750.14564-11-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a blocking notifier chain with two events (add and remove) so that
users can get notified about the addition of nvmem devices they're
waiting for.

We'll use this instead of the at24 setup callback in the mityomapl138
board file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 36 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h | 19 ++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e456aaa6184a..17307015905a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -58,6 +58,8 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -339,6 +341,32 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+/**
+ * nvmem_register_notifier() - Register a notifier block for nvmem events.
+ *
+ * @nb: notifier block to be called on nvmem events.
+ *
+ * Return: 0 on success, negative error number on failure.
+ */
+int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_register_notifier);
+
+/**
+ * nvmem_unregister_notifier() - Unregister a notifier block for nvmem events.
+ *
+ * @nb: notifier block to be unregistered.
+ *
+ * Return: 0 on success, negative error number on failure.
+ */
+int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -420,8 +448,15 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	INIT_LIST_HEAD(&nvmem->cells);
 
+	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
+	if (rval)
+		goto err_teardown_compat;
+
 	return nvmem;
 
+err_teardown_compat:
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
@@ -436,6 +471,7 @@ static void nvmem_device_release(struct kref *kref)
 	struct nvmem_device *nvmem;
 
 	nvmem = container_of(kref, struct nvmem_device, refcnt);
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);
 
 	if (nvmem->flags & FLAG_COMPAT)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 1313da6731ff..be583c4eb2d0 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -14,6 +14,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 struct device;
 struct device_node;
@@ -21,6 +22,11 @@ struct device_node;
 struct nvmem_cell;
 struct nvmem_device;
 
+enum {
+	NVMEM_ADD = 1,
+	NVMEM_REMOVE,
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -45,6 +51,9 @@ int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
+int nvmem_register_notifier(struct notifier_block *nb);
+int nvmem_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -125,6 +134,16 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 	return NULL;
 }
 
+static inline int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
+static inline int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 10 Aug 2018 10:05:01 +0200
Subject: [PATCH v2 04/29] nvmem: provide nvmem_dev_name()
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Message-ID: <20180810080526.27207-5-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kernel users don't have any means of checking the names of nvmem
devices. Add a routine that returns the name of the nvmem provider.

This will be useful for nvmem notifier subscribers - otherwise they
can't check what device is being added/removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 6 ++++++
 include/linux/nvmem-consumer.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 128c8e51bff2..31df2e6d6f72 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1440,6 +1440,12 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return dev_name(&nvmem->dev);
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_name);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index ae4d30347602..14bb86a7a78d 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -69,6 +69,8 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 
 int nvmem_register_notifier(struct notifier_block *nb);
 int nvmem_unregister_notifier(struct notifier_block *nb);
+
+const char *nvmem_dev_name(struct nvmem_device *nvmem);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -167,6 +169,11 @@ static inline int int nvmem_unregister_notifier(struct notifier_block *nb)
 {
 	return -ENOSYS;
 }
+
+static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

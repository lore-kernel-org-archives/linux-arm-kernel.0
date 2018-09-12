From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 12 Sep 2018 09:51:09 +0200
Subject: [PATCH v3 01/21] nvmem: provide nvmem_dev_name()
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Message-ID: <20180912075129.25185-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kernel users don't have any means of checking the names of nvmem
devices. Add a routine that returns the name of the nvmem provider.

This will be useful for future nvmem notifier subscribers - otherwise
they can't check what device is being added/removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa1657831b70..d96348ae0f37 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1343,6 +1343,19 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_dev_name() - Get the name of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: name of the nvmem device.
+ */
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
index 4e85447f7860..0389fe00b177 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -55,6 +55,8 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+const char *nvmem_dev_name(struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -143,6 +145,12 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 {
 	return -ENOSYS;
 }
+
+static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

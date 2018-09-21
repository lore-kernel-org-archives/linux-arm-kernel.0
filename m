From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 21 Sep 2018 09:29:19 +0200
Subject: [PATCH v5 20/22] nvmem: use EOPNOTSUPP instead of ENOSYS
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Message-ID: <20180921072921.19387-21-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch emits warnings when using ENOSYS. Some of the frameworks
started using EOPNOTSUPP as return values for API functions when given
subsystem is disabled in Kconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/nvmem-consumer.h | 30 +++++++++++++++---------------
 include/linux/nvmem-provider.h |  5 ++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index e17617fa034f..312bfa5efd80 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -93,13 +93,13 @@ int nvmem_unregister_notifier(struct notifier_block *nb);
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
 						const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
 						     const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void devm_nvmem_cell_put(struct device *dev,
@@ -113,31 +113,31 @@ static inline void nvmem_cell_put(struct nvmem_cell *cell)
 
 static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline int nvmem_cell_write(struct nvmem_cell *cell,
 				    const char *buf, size_t len)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_cell_read_u32(struct device *dev,
 				      const char *cell_id, u32 *val)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 							 const char *name)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void nvmem_device_put(struct nvmem_device *nvmem)
@@ -153,28 +153,28 @@ static inline ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *info,
 					 void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_device_cell_write(struct nvmem_device *nvmem,
 					  struct nvmem_cell_info *info,
 					  void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_device_read(struct nvmem_device *nvmem,
 				    unsigned int offset, size_t bytes,
 				    void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_device_write(struct nvmem_device *nvmem,
 				     unsigned int offset, size_t bytes,
 				     void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
@@ -189,12 +189,12 @@ nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
 
 static inline int nvmem_register_notifier(struct notifier_block *nb)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_unregister_notifier(struct notifier_block *nb)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 #endif /* CONFIG_NVMEM */
@@ -208,13 +208,13 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 						   const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 						       const char *name)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 8ae012f6545a..1e3283c2af77 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -100,7 +100,7 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
@@ -114,8 +114,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return -ENOSYS;
-
+	return -EOPNOTSUPP;
 }
 
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
-- 
2.18.0

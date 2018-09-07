From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri,  7 Sep 2018 12:07:35 +0200
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Message-ID: <20180907100750.14564-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove all APIs dealing with nvmem_cell_info. There are no users and
this part of the subsystem will be reworked.

This patch temprarily disables support for non-DT users.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 212 ++-------------------------------
 include/linux/nvmem-consumer.h |  26 ----
 include/linux/nvmem-provider.h |  13 --
 3 files changed, 12 insertions(+), 239 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa1657831b70..bb475c2688f9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -282,23 +282,6 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	return to_nvmem_device(d);
 }
 
-static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
-{
-	struct nvmem_cell *p;
-
-	mutex_lock(&nvmem_cells_mutex);
-
-	list_for_each_entry(p, &nvmem_cells, node)
-		if (!strcmp(p->name, cell_id)) {
-			mutex_unlock(&nvmem_cells_mutex);
-			return p;
-		}
-
-	mutex_unlock(&nvmem_cells_mutex);
-
-	return NULL;
-}
-
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
 	mutex_lock(&nvmem_cells_mutex);
@@ -326,82 +309,6 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 	mutex_unlock(&nvmem_cells_mutex);
 }
 
-static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
-				   const struct nvmem_cell_info *info,
-				   struct nvmem_cell *cell)
-{
-	cell->nvmem = nvmem;
-	cell->offset = info->offset;
-	cell->bytes = info->bytes;
-	cell->name = info->name;
-
-	cell->bit_offset = info->bit_offset;
-	cell->nbits = info->nbits;
-
-	if (cell->nbits)
-		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
-					   BITS_PER_BYTE);
-
-	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-		dev_err(&nvmem->dev,
-			"cell %s unaligned to nvmem stride %d\n",
-			cell->name, nvmem->stride);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * nvmem_add_cells() - Add cell information to an nvmem device
- *
- * @nvmem: nvmem device to add cells to.
- * @info: nvmem cell info to add to the device
- * @ncells: number of cells in info
- *
- * Return: 0 or negative error code on failure.
- */
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells)
-{
-	struct nvmem_cell **cells;
-	int i, rval;
-
-	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
-	if (!cells)
-		return -ENOMEM;
-
-	for (i = 0; i < ncells; i++) {
-		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
-		if (!cells[i]) {
-			rval = -ENOMEM;
-			goto err;
-		}
-
-		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
-		if (rval) {
-			kfree(cells[i]);
-			goto err;
-		}
-
-		nvmem_cell_add(cells[i]);
-	}
-
-	/* remove tmp array */
-	kfree(cells);
-
-	return 0;
-err:
-	while (i--)
-		nvmem_cell_drop(cells[i]);
-
-	kfree(cells);
-
-	return rval;
-}
-EXPORT_SYMBOL_GPL(nvmem_add_cells);
-
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
  * drivers sys directory, to be backwards compatible with the older
@@ -516,9 +423,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
-	if (config->cells)
-		nvmem_add_cells(nvmem, config->cells, config->ncells);
-
 	return nvmem;
 
 err_device_del:
@@ -618,32 +522,19 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
 
-static struct nvmem_device *__nvmem_device_get(struct device_node *np,
-					       struct nvmem_cell **cellp,
-					       const char *cell_id)
+static struct nvmem_device *__nvmem_device_get(struct device_node *np)
 {
 	struct nvmem_device *nvmem = NULL;
 
-	mutex_lock(&nvmem_mutex);
-
-	if (np) {
-		nvmem = of_nvmem_find(np);
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-	} else {
-		struct nvmem_cell *cell = nvmem_find_cell(cell_id);
+	if (!np)
+		return ERR_PTR(-EINVAL);
 
-		if (cell) {
-			nvmem = cell->nvmem;
-			*cellp = cell;
-		}
+	mutex_lock(&nvmem_mutex);
 
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-ENOENT);
-		}
+	nvmem = of_nvmem_find(np);
+	if (!nvmem) {
+		mutex_unlock(&nvmem_mutex);
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	nvmem->users++;
@@ -706,7 +597,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	return __nvmem_device_get(nvmem_np, NULL, NULL);
+	return __nvmem_device_get(nvmem_np);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
@@ -810,18 +701,6 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
-static struct nvmem_cell *nvmem_cell_get_from_list(const char *cell_id)
-{
-	struct nvmem_cell *cell = NULL;
-	struct nvmem_device *nvmem;
-
-	nvmem = __nvmem_device_get(NULL, &cell, cell_id);
-	if (IS_ERR(nvmem))
-		return ERR_CAST(nvmem);
-
-	return cell;
-}
-
 #if IS_ENABLED(CONFIG_OF)
 /**
  * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
@@ -857,7 +736,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	nvmem = __nvmem_device_get(nvmem_np, NULL, NULL);
+	nvmem = __nvmem_device_get(nvmem_np);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
@@ -926,19 +805,10 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
  */
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 {
-	struct nvmem_cell *cell;
-
-	if (dev->of_node) { /* try dt first */
-		cell = of_nvmem_cell_get(dev->of_node, cell_id);
-		if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
-			return cell;
-	}
-
-	/* NULL cell_id only allowed for device tree; invalid otherwise */
-	if (!cell_id)
+	if (!dev->of_node)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_list(cell_id);
+	return of_nvmem_cell_get(dev->of_node, cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
@@ -1227,64 +1097,6 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
-/**
- * nvmem_device_cell_read() - Read a given nvmem device and cell
- *
- * @nvmem: nvmem device to read from.
- * @info: nvmem cell info to be read.
- * @buf: buffer pointer which will be populated on successful read.
- *
- * Return: length of successful bytes read on success and negative
- * error code on error.
- */
-ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf)
-{
-	struct nvmem_cell cell;
-	int rc;
-	ssize_t len;
-
-	if (!nvmem)
-		return -EINVAL;
-
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
-	if (rc)
-		return rc;
-
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len);
-	if (rc)
-		return rc;
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
-
-/**
- * nvmem_device_cell_write() - Write cell to a given nvmem device
- *
- * @nvmem: nvmem device to be written to.
- * @info: nvmem cell info to be written.
- * @buf: buffer to be written to cell.
- *
- * Return: length of bytes written or negative error code on failure.
- * */
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf)
-{
-	struct nvmem_cell cell;
-	int rc;
-
-	if (!nvmem)
-		return -EINVAL;
-
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
-	if (rc)
-		return rc;
-
-	return nvmem_cell_write(&cell, buf, cell.bytes);
-}
-EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
-
 /**
  * nvmem_device_read() - Read from a given nvmem device
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..7e9fb5a19d91 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -21,14 +21,6 @@ struct device_node;
 struct nvmem_cell;
 struct nvmem_device;
 
-struct nvmem_cell_info {
-	const char		*name;
-	unsigned int		offset;
-	unsigned int		bytes;
-	unsigned int		bit_offset;
-	unsigned int		nbits;
-};
-
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -50,10 +42,6 @@ int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 		      size_t bytes, void *buf);
 int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
-ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf);
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf);
 
 #else
 
@@ -116,20 +104,6 @@ static inline void devm_nvmem_device_put(struct device *dev,
 {
 }
 
-static inline ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-					 struct nvmem_cell_info *info,
-					 void *buf)
-{
-	return -ENOSYS;
-}
-
-static inline int nvmem_device_cell_write(struct nvmem_device *nvmem,
-					  struct nvmem_cell_info *info,
-					  void *buf)
-{
-	return -ENOSYS;
-}
-
 static inline int nvmem_device_read(struct nvmem_device *nvmem,
 				    unsigned int offset, size_t bytes,
 				    void *buf)
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..cc8556e3c825 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 
 struct nvmem_device;
-struct nvmem_cell_info;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -52,8 +51,6 @@ struct nvmem_config {
 	const char		*name;
 	int			id;
 	struct module		*owner;
-	const struct nvmem_cell_info	*cells;
-	int			ncells;
 	bool			read_only;
 	bool			root_only;
 	nvmem_reg_read_t	reg_read;
@@ -77,9 +74,6 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells);
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -105,12 +99,5 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 
 }
 
-static inline int nvmem_add_cells(struct nvmem_device *nvmem,
-				  const struct nvmem_cell_info *info,
-				  int ncells)
-{
-	return -ENOSYS;
-}
-
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.18.0

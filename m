From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 14 Sep 2018 16:40:08 +0200
Subject: [PATCH v4 19/22] nvmem: make the naming of arguments in
 nvmem_cell_get() consistent
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Message-ID: <20180914144011.27614-20-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The argument representing the cell name in the nvmem_cell_get() family
of functions is not consistend between function prototypes and
definitions. Name it 'id' in all those routines. This is in line with
other frameworks and can represent both the DT cell name from the
nvmem-cell-names property as well as the con_id field from cell
lookup entries.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 27 ++++++++++++++-------------
 include/linux/nvmem-consumer.h | 12 ++++++------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ea05219e60b4..ff21402fbd7d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -977,16 +977,15 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
  * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
  *
  * @np: Device tree node that uses the nvmem cell.
- * @name: nvmem cell name from nvmem-cell-names property, or NULL
- *	  for the cell at index 0 (the lone cell with no accompanying
- *	  nvmem-cell-names property).
+ * @id: nvmem cell name from nvmem-cell-names property, or NULL
+ *      for the cell at index 0 (the lone cell with no accompanying
+ *      nvmem-cell-names property).
  *
  * Return: Will be an ERR_PTR() on error or a valid pointer
  * to a struct nvmem_cell.  The nvmem_cell will be freed by the
  * nvmem_cell_put().
  */
-struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-					    const char *name)
+struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 {
 	struct device_node *cell_np, *nvmem_np;
 	struct nvmem_device *nvmem;
@@ -994,8 +993,8 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	int index = 0;
 
 	/* if cell name exists, find index to the name */
-	if (name)
-		index = of_property_match_string(np, "nvmem-cell-names", name);
+	if (id)
+		index = of_property_match_string(np, "nvmem-cell-names", id);
 
 	cell_np = of_parse_phandle(np, "nvmem-cells", index);
 	if (!cell_np)
@@ -1025,27 +1024,29 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
  *
  * @dev: Device that requests the nvmem cell.
- * @cell_id: nvmem cell name to get.
+ * @id: nvmem cell name to get (this corresponds with the name from the
+ *      nvmem-cell-names property for DT systems and with the con_id from
+ *      the lookup entry for non-DT systems).
  *
  * Return: Will be an ERR_PTR() on error or a valid pointer
  * to a struct nvmem_cell.  The nvmem_cell will be freed by the
  * nvmem_cell_put().
  */
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
+struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id)
 {
 	struct nvmem_cell *cell;
 
 	if (dev->of_node) { /* try dt first */
-		cell = of_nvmem_cell_get(dev->of_node, cell_id);
+		cell = of_nvmem_cell_get(dev->of_node, id);
 		if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
 			return cell;
 	}
 
-	/* NULL cell_id only allowed for device tree; invalid otherwise */
-	if (!cell_id)
+	/* NULL cell id only allowed for device tree; invalid otherwise */
+	if (!id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_lookup(dev, cell_id);
+	return nvmem_cell_get_from_lookup(dev, id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index d18caae2f7ac..e17617fa034f 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -55,8 +55,8 @@ enum {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
-struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
+struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
@@ -91,13 +91,13 @@ int nvmem_unregister_notifier(struct notifier_block *nb);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
-						const char *name)
+						const char *id)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
 static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
-				       const char *name)
+						     const char *id)
 {
 	return ERR_PTR(-ENOSYS);
 }
@@ -201,12 +201,12 @@ static inline int nvmem_unregister_notifier(struct notifier_block *nb)
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
 struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-				     const char *name);
+				     const char *id);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-				     const char *name)
+						   const char *id)
 {
 	return ERR_PTR(-ENOSYS);
 }
-- 
2.18.0

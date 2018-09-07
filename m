From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri,  7 Sep 2018 12:07:46 +0200
Subject: [PATCH v2 12/16] nvmem: resolve cells from DT at registration time
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Message-ID: <20180907100750.14564-13-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently we're creating a new cell structure everytime a DT users
calls nvmem_cell_get().

Change this behavior by resolving the cells during nvmem provider
registration and adding all cells to the provider's list. Make
of_nvmem_cell_get() just parse the phandle and look the cell up
in the relevant provider's list.

Don't drop the cell in nvmem_cell_put().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 122 ++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 48 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 854baa0559a1..da7a9d5beb33 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -405,6 +405,73 @@ static int nvmem_add_cells_from_list(struct nvmem_device *nvmem)
 	return rval;
 }
 
+static struct nvmem_cell *
+nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
+{
+	struct nvmem_cell *cell = NULL;
+	int i = 0;
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(cell, &nvmem->cells, node) {
+		if (index == i++)
+			break;
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	return cell;
+}
+
+static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+{
+	struct device_node *parent, *child;
+	struct device *dev = &nvmem->dev;
+	struct nvmem_cell *cell;
+	const __be32 *addr;
+	int len;
+
+	parent = dev->of_node;
+
+	for_each_child_of_node(parent, child) {
+		addr = of_get_property(child, "reg", &len);
+		if (!addr || (len < 2 * sizeof(u32))) {
+			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
+			return -EINVAL;
+		}
+
+		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+		if (!cell)
+			return -ENOMEM;
+
+		cell->nvmem = nvmem;
+		cell->offset = be32_to_cpup(addr++);
+		cell->bytes = be32_to_cpup(addr);
+		cell->name = child->name;
+
+		addr = of_get_property(child, "bits", &len);
+		if (addr && len == (2 * sizeof(u32))) {
+			cell->bit_offset = be32_to_cpup(addr++);
+			cell->nbits = be32_to_cpup(addr);
+		}
+
+		if (cell->nbits)
+			cell->bytes = DIV_ROUND_UP(
+					cell->nbits + cell->bit_offset,
+					BITS_PER_BYTE);
+
+		if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
+			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
+				cell->name, nvmem->stride);
+			/* Cells already added will be freed later. */
+			kfree(cell);
+			return -EINVAL;
+		}
+
+		nvmem_cell_add(cell);
+	}
+
+	return 0;
+}
+
 /**
  * nvmem_register_notifier() - Register a notifier block for nvmem events.
  *
@@ -514,6 +581,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	rval = nvmem_add_cells_from_list(nvmem);
 	if (rval)
 		goto err_teardown_compat;
+	rval = nvmem_add_cells_from_of(nvmem);
+	if (rval)
+		goto err_remove_cells;
 
 	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 	if (rval)
@@ -811,10 +881,8 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 					    const char *name)
 {
 	struct device_node *cell_np, *nvmem_np;
-	struct nvmem_cell *cell;
 	struct nvmem_device *nvmem;
-	const __be32 *addr;
-	int rval, len;
+	struct nvmem_cell *cell;
 	int index = 0;
 
 	/* if cell name exists, find index to the name */
@@ -834,54 +902,13 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
 
-	addr = of_get_property(cell_np, "reg", &len);
-	if (!addr || (len < 2 * sizeof(u32))) {
-		dev_err(&nvmem->dev, "nvmem: invalid reg on %pOF\n",
-			cell_np);
-		rval  = -EINVAL;
-		goto err_mem;
-	}
-
-	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	cell = nvmem_find_cell_by_index(nvmem, index);
 	if (!cell) {
-		rval = -ENOMEM;
-		goto err_mem;
-	}
-
-	cell->nvmem = nvmem;
-	cell->offset = be32_to_cpup(addr++);
-	cell->bytes = be32_to_cpup(addr);
-	cell->name = cell_np->name;
-
-	addr = of_get_property(cell_np, "bits", &len);
-	if (addr && len == (2 * sizeof(u32))) {
-		cell->bit_offset = be32_to_cpup(addr++);
-		cell->nbits = be32_to_cpup(addr);
-	}
-
-	if (cell->nbits)
-		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
-					   BITS_PER_BYTE);
-
-	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-			dev_err(&nvmem->dev,
-				"cell %s unaligned to nvmem stride %d\n",
-				cell->name, nvmem->stride);
-		rval  = -EINVAL;
-		goto err_sanity;
+		__nvmem_device_put(nvmem);
+		return ERR_PTR(-ENOENT);
 	}
 
-	nvmem_cell_add(cell);
-
 	return cell;
-
-err_sanity:
-	kfree(cell);
-
-err_mem:
-	__nvmem_device_put(nvmem);
-
-	return ERR_PTR(rval);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
@@ -978,7 +1005,6 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 	struct nvmem_device *nvmem = cell->nvmem;
 
 	__nvmem_device_put(nvmem);
-	nvmem_cell_drop(cell);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-- 
2.18.0

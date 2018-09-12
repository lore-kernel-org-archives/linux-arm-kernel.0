From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 12 Sep 2018 09:51:19 +0200
Subject: [PATCH v3 11/21] nvmem: remove the global cell list
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Message-ID: <20180912075129.25185-12-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Nvmem subsystem keeps a global list of cells that, for non-DT systems,
can only be referenced by cell name, which makes it impossible to have
more than one nvmem device with cells named the same.

This patch makes every nvmem device the owner of the list of its cells.
This effectively removes the support for non-DT systems, but it will
be reintroduced following a different approach in subsequent patches.

This isn't a problem as support for board files in nvmem is currently
broken anyway: any user that would try to get an nvmem cell from the
global cell list would remove the cell after the calling
nvmem_cell_put(). This can cause anything from a subsequent user not
being able to get the cell to double free errors if more users hold
reference to the same cell at the same time.

Fortunately there are no such users which allows us to rework this part.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 64 +++++++++++---------------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c950d54bb69d..585688ea2152 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	int			flags;
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
+	struct list_head	cells;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	void *priv;
@@ -58,9 +59,6 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
-static LIST_HEAD(nvmem_cells);
-static DEFINE_MUTEX(nvmem_cells_mutex);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -282,28 +280,11 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
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
-	mutex_lock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_unlock(&nvmem_mutex);
 	kfree(cell);
 }
 
@@ -311,16 +292,15 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
 	struct nvmem_cell *cell, *p;
 
-	list_for_each_entry_safe(cell, p, &nvmem_cells, node)
-		if (cell->nvmem == nvmem)
-			nvmem_cell_drop(cell);
+	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
+		nvmem_cell_drop(cell);
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
-	list_add_tail(&cell->node, &nvmem_cells);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
+	list_add_tail(&cell->node, &cell->nvmem->cells);
+	mutex_unlock(&nvmem_mutex);
 }
 
 static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
@@ -465,6 +445,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	kref_init(&nvmem->refcnt);
+	INIT_LIST_HEAD(&nvmem->cells);
 
 	nvmem->id = rval;
 	nvmem->owner = config->owner;
@@ -626,29 +607,14 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
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
-
-		if (cell) {
-			nvmem = cell->nvmem;
-			*cellp = cell;
-		}
-
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-ENOENT);
-		}
-	}
+	if (!np)
+		return ERR_PTR(-ENOENT);
 
+	mutex_lock(&nvmem_mutex);
+	nvmem = of_nvmem_find(np);
 	mutex_unlock(&nvmem_mutex);
+	if (!nvmem)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
-- 
2.18.0

From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  5 Sep 2018 11:57:27 +0200
Subject: [PATCH 02/13] nvmem: remove the global cell list
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Message-ID: <20180905095738.26406-3-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make each nvmem device the owner of its nvmem cells.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bb475c2688f9..86af62e2df47 100644
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
@@ -284,29 +282,25 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_unlock(&nvmem_mutex);
 	kfree(cell);
 }
 
-static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
+static void nvmem_device_remove_all_cells(struct nvmem_device *nvmem)
 {
-	struct nvmem_cell *cell;
-	struct list_head *p, *n;
+	struct nvmem_cell *cell, *p;
 
-	list_for_each_safe(p, n, &nvmem_cells) {
-		cell = list_entry(p, struct nvmem_cell, node);
-		if (cell->nvmem == nvmem)
-			nvmem_cell_drop(cell);
-	}
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
 
 /*
@@ -423,6 +417,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
+	INIT_LIST_HEAD(&nvmem->cells);
+
 	return nvmem;
 
 err_device_del:
-- 
2.18.0

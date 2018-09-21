From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 21 Sep 2018 09:29:12 +0200
Subject: [PATCH v5 13/22] nvmem: add support for cell info
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Message-ID: <20180921072921.19387-14-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add new structs and routines allowing users to define nvmem cells from
machine code. This global list of entries is parsed when a provider
is registered and cells are associated with the relevant nvmem_device
struct.

A possible improvement for the future is to allow users to register
cell tables after the nvmem provider has been registered by updating
the cell list at each call to nvmem_(add|del)_cell_table().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 72 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 33 +++++++++++-----
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ee794613024c..8e0108806e65 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -59,6 +59,9 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static DEFINE_MUTEX(nvmem_cell_mutex);
+static LIST_HEAD(nvmem_cell_tables);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -416,6 +419,43 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
+{
+	const struct nvmem_cell_info *info;
+	struct nvmem_cell_table *table;
+	struct nvmem_cell *cell;
+	int rval = 0, i;
+
+	mutex_lock(&nvmem_cell_mutex);
+	list_for_each_entry(table, &nvmem_cell_tables, node) {
+		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
+			for (i = 0; i < table->ncells; i++) {
+				info = &table->cells[i];
+
+				cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+				if (!cell) {
+					rval = -ENOMEM;
+					goto out;
+				}
+
+				rval = nvmem_cell_info_to_nvmem_cell(nvmem,
+								     info,
+								     cell);
+				if (rval) {
+					kfree(cell);
+					goto out;
+				}
+
+				nvmem_cell_add(cell);
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&nvmem_cell_mutex);
+	return rval;
+}
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -502,8 +542,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_teardown_compat;
 	}
 
+	rval = nvmem_add_cells_from_table(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	return nvmem;
 
+err_remove_cells:
+	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
@@ -1306,6 +1352,32 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_add_cell_table() - register a table of cell info entries
+ *
+ * @table: table of cell info entries
+ */
+void nvmem_add_cell_table(struct nvmem_cell_table *table)
+{
+	mutex_lock(&nvmem_cell_mutex);
+	list_add_tail(&table->node, &nvmem_cell_tables);
+	mutex_unlock(&nvmem_cell_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_cell_table);
+
+/**
+ * nvmem_del_cell_table() - remove a previously registered cell info table
+ *
+ * @table: table of cell info entries
+ */
+void nvmem_del_cell_table(struct nvmem_cell_table *table)
+{
+	mutex_lock(&nvmem_cell_mutex);
+	list_del(&table->node);
+	mutex_unlock(&nvmem_cell_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_cell_table);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0f357d0c1e75..5c9f205cac8f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -67,6 +67,25 @@ struct nvmem_config {
 	struct device		*base_dev;
 };
 
+/**
+ * struct nvmem_cell_table - NVMEM cell definitions for given provider
+ *
+ * @nvmem_name:		Provider name.
+ * @cells:		Array of cell definitions.
+ * @ncells:		Number of cell definitions in the array.
+ * @node:		List node.
+ *
+ * This structure together with related helper functions is provided for users
+ * that don't can't access the nvmem provided structure but wish to register
+ * cell definitions for it e.g. board files registering an EEPROM device.
+ */
+struct nvmem_cell_table {
+	const char		*nvmem_name;
+	const struct nvmem_cell_info	*cells;
+	size_t			ncells;
+	struct list_head	node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -77,9 +96,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells);
+void nvmem_add_cell_table(struct nvmem_cell_table *table);
+void nvmem_del_cell_table(struct nvmem_cell_table *table);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -102,12 +121,8 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 
 }
 
-static inline int nvmem_add_cells(struct nvmem_device *nvmem,
-				  const struct nvmem_cell_info *info,
-				  int ncells)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
+static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.18.0

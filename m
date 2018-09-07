From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri,  7 Sep 2018 12:07:45 +0200
Subject: [PATCH v2 11/16] nvmem: add support for cell info
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Message-ID: <20180907100750.14564-12-brgl@bgdev.pl>
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
 MAINTAINERS                   |  1 +
 drivers/nvmem/core.c          | 97 ++++++++++++++++++++++++++++++++++-
 include/linux/nvmem-machine.h | 41 +++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/nvmem-machine.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..a520924bf0a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,7 @@ F:	drivers/nvmem/
 F:	Documentation/devicetree/bindings/nvmem/
 F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
+F:	include/linux/nvmem-machine.h
 F:	include/linux/nvmem-provider.h
 
 NXP SGTL5000 DRIVER
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 17307015905a..854baa0559a1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/nvmem-machine.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -58,6 +59,9 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static DEFINE_MUTEX(nvmem_cell_mutex);
+static LIST_HEAD(nvmem_cell_tables);
+
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -341,6 +345,66 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+static struct nvmem_cell *
+nvmem_cell_from_cell_info(struct nvmem_device *nvmem,
+			  struct nvmem_cell_info *info)
+{
+	struct nvmem_cell *cell;
+
+	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return ERR_PTR(-ENOMEM);
+
+	cell->nvmem = nvmem;
+	cell->offset = info->offset;
+	cell->bytes = info->bytes;
+	cell->name = info->name;
+	cell->bit_offset = info->bit_offset;
+	cell->nbits = info->nbits;
+
+	if (cell->nbits)
+		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
+					   BITS_PER_BYTE);
+
+	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
+		dev_err(&nvmem->dev,
+			"cell %s unaligned to nvmem stride %d\n",
+			cell->name, nvmem->stride);
+		kfree(cell);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return cell;
+}
+
+static int nvmem_add_cells_from_list(struct nvmem_device *nvmem)
+{
+	struct nvmem_cell_table *table;
+	struct nvmem_cell_info *info;
+	struct nvmem_cell *cell;
+	int rval = 0, i;
+
+	mutex_lock(&nvmem_cell_mutex);
+	list_for_each_entry(table, &nvmem_cell_tables, node) {
+		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
+			for (i = 0; i < table->ncells; i++) {
+				info = &table->cells[i];
+				cell = nvmem_cell_from_cell_info(nvmem, info);
+				if (IS_ERR(cell)) {
+					rval = PTR_ERR(cell);
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
  * nvmem_register_notifier() - Register a notifier block for nvmem events.
  *
@@ -447,13 +511,18 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	INIT_LIST_HEAD(&nvmem->cells);
+	rval = nvmem_add_cells_from_list(nvmem);
+	if (rval)
+		goto err_teardown_compat;
 
 	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 	if (rval)
-		goto err_teardown_compat;
+		goto err_remove_cells;
 
 	return nvmem;
 
+err_remove_cells:
+	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
@@ -1179,6 +1248,32 @@ int nvmem_device_write(struct nvmem_device *nvmem,
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
diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
new file mode 100644
index 000000000000..1e199dfaacab
--- /dev/null
+++ b/include/linux/nvmem-machine.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * nvmem framework machine code bindings
+ *
+ * Copyright (C) 2018 Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#ifndef _LINUX_NVMEM_MACHINE_H
+#define _LINUX_NVMEM_MACHINE_H
+
+#include <linux/nvmem-provider.h>
+#include <linux/list.h>
+
+struct nvmem_cell_info {
+	const char		*name;
+	unsigned int		offset;
+	unsigned int		bytes;
+	unsigned int		bit_offset;
+	unsigned int		nbits;
+};
+
+struct nvmem_cell_table {
+	const char		*nvmem_name;
+	struct nvmem_cell_info	*cells;
+	size_t			ncells;
+	struct list_head	node;
+};
+
+#if IS_ENABLED(CONFIG_NVMEM)
+
+void nvmem_add_cell_table(struct nvmem_cell_table *table);
+void nvmem_del_cell_table(struct nvmem_cell_table *table);
+
+#else /* CONFIG_NVMEM */
+
+static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
+static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
+
+#endif /* CONFIG_NVMEM */
+
+#endif  /* ifndef _LINUX_NVMEM_MACHINE_H */
-- 
2.18.0

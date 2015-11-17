From: laura@labbott.name (Laura Abbott)
Date: Mon, 16 Nov 2015 16:57:34 -0800
Subject: [PATCHv2 2/3] staging: ion: Add files for parsing the devicetree
In-Reply-To: <1447721855-7574-1-git-send-email-laura@labbott.name>
References: <1447721855-7574-1-git-send-email-laura@labbott.name>
Message-ID: <1447721855-7574-3-git-send-email-laura@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Devicetree is the preferred mechanism for platform definition
these days. Add a set of files for supporting Ion with devicetree.
This is a set of functions for drivers to call to parse the Ion
devicetree along with definitons for defining heaps.

Signed-off-by: Laura Abbott <laura@labbott.name>
---
 drivers/staging/android/ion/Kconfig  |  10 +++
 drivers/staging/android/ion/Makefile |   1 +
 drivers/staging/android/ion/ion_of.c | 168 +++++++++++++++++++++++++++++++++++
 drivers/staging/android/ion/ion_of.h |  35 ++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/staging/android/ion/ion_of.c
 create mode 100644 drivers/staging/android/ion/ion_of.h

diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/ion/Kconfig
index 3452346..9b6d65d 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -33,3 +33,13 @@ config ION_TEGRA
 	help
 	  Choose this option if you wish to use ion on an nVidia Tegra.
 
+config ION_OF
+	bool "Devicetree support for Ion"
+	depends on ION && OF
+	help
+	  Provides base support for defining Ion heaps in devicetree
+	  and setting them up. Also includes functions for platforms
+	  to parse the devicetree and expand for their own custom
+	  extensions
+
+	  If using Ion and devicetree, you should say Y here
diff --git a/drivers/staging/android/ion/Makefile b/drivers/staging/android/ion/Makefile
index b56fd2b..a77417b 100644
--- a/drivers/staging/android/ion/Makefile
+++ b/drivers/staging/android/ion/Makefile
@@ -7,4 +7,5 @@ endif
 
 obj-$(CONFIG_ION_DUMMY) += ion_dummy_driver.o
 obj-$(CONFIG_ION_TEGRA) += tegra/
+obj-$(CONFIG_ION_OF) += ion_of.o ion_physmem.o
 
diff --git a/drivers/staging/android/ion/ion_of.c b/drivers/staging/android/ion/ion_of.c
new file mode 100644
index 0000000..9a56194
--- /dev/null
+++ b/drivers/staging/android/ion/ion_of.c
@@ -0,0 +1,168 @@
+/*
+ * Based on work from:
+ *   Andrew Andrianov <andrew@ncrmnt.org>
+ *   Google
+ *   The Linux Foundation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/cma.h>
+#include <linux/dma-contiguous.h>
+#include <linux/io.h>
+#include <linux/of_reserved_mem.h>
+#include "ion.h"
+#include "ion_priv.h"
+#include "ion_of.h"
+
+int ion_parse_dt_heap_common(struct device_node *heap_node,
+			struct ion_platform_heap *heap,
+			struct ion_of_heap *compatible)
+{
+	int i;
+
+	for (i = 0; compatible[i].name != NULL; i++) {
+		if (of_device_is_compatible(heap_node, compatible[i].compat))
+			break;
+	}
+
+	if (compatible[i].name == NULL)
+		return -ENODEV;
+
+	heap->id = compatible[i].heap_id;
+	heap->type = compatible[i].type;
+	heap->name = compatible[i].name;
+	heap->align = compatible[i].align;
+
+	/* Some kind of callback function pointer? */
+
+	pr_info("%s: id %d type %d name %s align %lx\n", __func__,
+			heap->id, heap->type, heap->name, heap->align);
+	return 0;
+}
+
+int ion_setup_heap_common(struct platform_device *parent,
+			struct device_node *heap_node,
+			struct ion_platform_heap *heap)
+{
+	int ret = 0;
+
+	switch (heap->type) {
+		case ION_HEAP_TYPE_CARVEOUT:
+		case ION_HEAP_TYPE_CHUNK:
+			if (heap->base && heap->size)
+				return 0;
+
+			ret = of_reserved_mem_device_init(heap->priv);
+			break;
+		default:
+			break;
+	}
+
+	return ret;
+}
+
+struct ion_platform_data *ion_parse_dt(struct platform_device *pdev,
+					struct ion_of_heap *compatible)
+{
+	int num_heaps, ret;
+	const struct device_node *dt_node = pdev->dev.of_node;
+	struct device_node *node;
+	struct ion_platform_heap *heaps;
+	struct ion_platform_data *data;
+	int i = 0;
+
+	num_heaps = of_get_available_child_count(dt_node);
+
+	if (!num_heaps)
+		return ERR_PTR(-EINVAL);
+
+	heaps = devm_kzalloc(&pdev->dev,
+				sizeof(struct ion_platform_heap)*num_heaps,
+				GFP_KERNEL);
+	if (!heaps)
+		return ERR_PTR(-ENOMEM);
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct ion_platform_data),
+				GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	for_each_available_child_of_node(dt_node, node) {
+		struct platform_device *heap_pdev;
+
+		ret = ion_parse_dt_heap_common(node, &heaps[i], compatible);
+		if (ret)
+			return ERR_PTR(ret);
+
+		heap_pdev = of_platform_device_create(node, heaps[i].name,
+							&pdev->dev);
+		if (!pdev)
+			return ERR_PTR(-ENOMEM);
+		heap_pdev->dev.platform_data = &heaps[i];
+
+		heaps[i].priv = &heap_pdev->dev;
+
+		ret = ion_setup_heap_common(pdev, node, &heaps[i]);
+		if (ret)
+			return ERR_PTR(ret);
+		i++;
+	}
+
+
+	data->heaps = heaps;
+	data->nr = num_heaps;
+	return data;
+}
+
+#ifdef CONFIG_OF_RESERVED_MEM
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
+static int rmem_ion_device_init(struct reserved_mem *rmem, struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ion_platform_heap *heap = pdev->dev.platform_data;
+
+	heap->base = rmem->base;
+	heap->base = rmem->size;
+	pr_debug("%s: heap %s base %pa size %pa dev %p\n", __func__,
+			heap->name, &rmem->base, &rmem->size, dev);
+	return 0;
+}
+
+static void rmem_ion_device_release(struct reserved_mem *rmem,
+					struct device *dev)
+{
+	return;
+}
+
+static const struct reserved_mem_ops rmem_dma_ops = {
+	.device_init	= rmem_ion_device_init,
+	.device_release	= rmem_ion_device_release,
+};
+
+static int __init rmem_ion_setup(struct reserved_mem *rmem)
+{
+	phys_addr_t size = rmem->size;
+
+	size = size / 1024;
+
+	pr_info("Ion memory setup at %pa size %pa MiB\n",
+		&rmem->base, &size);
+	rmem->ops = &rmem_dma_ops;
+	return 0;
+}
+RESERVEDMEM_OF_DECLARE(ion, "ion-region", rmem_ion_setup);
+#endif
diff --git a/drivers/staging/android/ion/ion_of.h b/drivers/staging/android/ion/ion_of.h
new file mode 100644
index 0000000..6b767e7
--- /dev/null
+++ b/drivers/staging/android/ion/ion_of.h
@@ -0,0 +1,35 @@
+/*
+ * Based on work from:
+ *   Andrew Andrianov <andrew@ncrmnt.org>
+ *   Google
+ *   The Linux Foundation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ION_OF_H
+#define _ION_OF_H
+
+struct ion_of_heap {
+	const char *compat;
+	int heap_id;
+	int type;
+	const char *name;
+	int align;
+};
+
+#define PLATFORM_HEAP(_compat, _id, _type, _name) \
+{ \
+	.compat = _compat, \
+	.heap_id = _id, \
+	.type = _type, \
+	.name = _name, \
+	.align = PAGE_SIZE, \
+}
+
+struct ion_platform_data *ion_parse_dt(struct platform_device *pdev,
+					struct ion_of_heap *compatible);
+
+#endif
-- 
2.5.0

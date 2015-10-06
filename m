From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue,  6 Oct 2015 13:47:13 -0700
Subject: [RFC][PATCH 2/2] staging: ion: Add files for parsing the devicetree
 (WIP)
In-Reply-To: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
References: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1444164433-9107-3-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <laura@labbott.name>


Devicetree is the preferred mechanism for platform definition
these days. Add a set of files for supporting Ion with devicetree.
This includes a set of bindings for heaps common across all
devices and parsing methods. Clients may use the standard
bindings or they can call the parsing functions along with
their own parsing for platform specific heaps.

Signed-off-by: Laura Abbott <laura@labbott.name>
Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 drivers/staging/android/ion/Kconfig  |  10 ++
 drivers/staging/android/ion/Makefile |   7 +-
 drivers/staging/android/ion/ion_of.c | 185 +++++++++++++++++++++++++++++++++++
 drivers/staging/android/ion/ion_of.h |   3 +
 4 files changed, 202 insertions(+), 3 deletions(-)
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
index b56fd2b..6602512 100644
--- a/drivers/staging/android/ion/Makefile
+++ b/drivers/staging/android/ion/Makefile
@@ -5,6 +5,7 @@ ifdef CONFIG_COMPAT
 obj-$(CONFIG_ION) += compat_ion.o
 endif
 
-obj-$(CONFIG_ION_DUMMY) += ion_dummy_driver.o
-obj-$(CONFIG_ION_TEGRA) += tegra/
-
+obj-$(CONFIG_ION_DUMMY)   += ion_dummy_driver.o
+obj-$(CONFIG_ION_PHYSMEM) += ion_physmem.o
+obj-$(CONFIG_ION_TEGRA)   += tegra/
+obj-$(CONFIG_ION_OF) +=	ion_of.o ion_physmem.o
diff --git a/drivers/staging/android/ion/ion_of.c b/drivers/staging/android/ion/ion_of.c
new file mode 100644
index 0000000..3c9b1e5
--- /dev/null
+++ b/drivers/staging/android/ion/ion_of.c
@@ -0,0 +1,185 @@
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
+
+/*
+ * Future work: allow callback function for each heap?
+ */
+
+int ion_parse_dt_heap_common(struct device_node *heap_node,
+			struct ion_platform_heap *heap)
+{
+	u32 ion_heap_id, ion_heap_align, ion_heap_type;
+	const char *ion_heap_name;
+	int ret;
+
+	ret =  of_property_read_string(heap_node, "linux,ion-heap-name",
+					&ion_heap_name);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(heap_node, "linux,ion-heap-id",
+					&ion_heap_id);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(heap_node, "linux,ion-heap-type",
+					&ion_heap_type);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(heap_node, "linux,ion-heap-align",
+					&ion_heap_align);
+	if (ret)
+		/* align is optional so make the alignemnt page size */
+		ion_heap_align = PAGE_SIZE;
+
+	heap->id = ion_heap_id;
+	heap->type = ion_heap_type;
+	heap->name = ion_heap_name;
+	heap->align = ion_heap_align;
+	pr_info("%s: id %d type %d name %s align %x\n",
+			__func__,
+			ion_heap_id, ion_heap_type,
+			ion_heap_name, ion_heap_align);
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
+struct ion_platform_data *ion_parse_dt(struct platform_device *pdev)
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
+		ret = ion_parse_dt_heap_common(node, &heaps[i]);
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
+
+		/* TODO custom callback */
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
index 0000000..b4d1b6d
--- /dev/null
+++ b/drivers/staging/android/ion/ion_of.h
@@ -0,0 +1,3 @@
+/* YES I NEED HEADER */
+
+struct ion_platform_data *ion_parse_dt(struct platform_device *pdev);
-- 
2.4.3

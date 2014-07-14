From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 14 Jul 2014 09:12:45 +0200
Subject: [PATCH v2 3/4] drivers: dma-coherent: add initialization from device
 tree
In-Reply-To: <1405321966-28184-1-git-send-email-m.szyprowski@samsung.com>
References: <1405321966-28184-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1405321966-28184-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for handling 'shared-dma-pool' reserved-memory device tree
nodes.

Based on previous code provided by Josh Cartwright <joshc@codeaurora.org>

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dma-coherent.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 7d6e84a51424..b20cbe095d86 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -218,3 +218,43 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 	return 0;
 }
 EXPORT_SYMBOL(dma_mmap_from_coherent);
+
+/*
+ * Support for reserved memory regions defined in device tree
+ */
+#ifdef CONFIG_OF_RESERVED_MEM
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
+static void rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
+{
+	dma_declare_coherent_memory(dev, rmem->base, rmem->base,
+		rmem->size, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+}
+
+static void rmem_dma_device_release(struct reserved_mem *rmem,
+				    struct device *dev)
+{
+	dma_release_declared_memory(dev);
+}
+
+static const struct reserved_mem_ops rmem_dma_ops = {
+	.device_init	= rmem_dma_device_init,
+	.device_release	= rmem_dma_device_release,
+};
+
+static int __init rmem_dma_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_dma_ops;
+	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
+#endif
-- 
1.9.2

From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 10 Jan 2017 14:18:42 +0000
Subject: [RFC PATCH v4 2/5] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <1484057925-23586-1-git-send-email-vladimir.murzin@arm.com>
References: <1484057925-23586-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1484057925-23586-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces default coherent DMA pool similar to default CMA
area concept. To keep other users safe code kept under CONFIG_ARM.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 .../bindings/reserved-memory/reserved-memory.txt   |  3 ++
 drivers/base/dma-coherent.c                        | 59 +++++++++++++++++++---
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 3da0ebd..16291f2 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -68,6 +68,9 @@ Linux implementation note:
 - If a "linux,cma-default" property is present, then Linux will use the
   region for the default pool of the contiguous memory allocator.
 
+- If a "linux,dma-default" property is present, then Linux will use the
+  region for the default pool of the consistent DMA allocator.
+
 Device node references to reserved memory
 -----------------------------------------
 Regions in the /reserved-memory node may be referenced by other device
diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 640a7e6..b52ba27 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -18,6 +18,15 @@ struct dma_coherent_mem {
 	spinlock_t	spinlock;
 };
 
+static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
+
+static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
+{
+	if (dev && dev->dma_mem)
+		return dev->dma_mem;
+	return dma_coherent_default_memory;
+}
+
 static bool dma_init_coherent_memory(
 	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
 	struct dma_coherent_mem **mem)
@@ -83,6 +92,9 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 static int dma_assign_coherent_memory(struct device *dev,
 				      struct dma_coherent_mem *mem)
 {
+	if (!dev)
+		return -ENODEV;
+
 	if (dev->dma_mem)
 		return -EBUSY;
 
@@ -161,15 +173,12 @@ EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
 int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 				       dma_addr_t *dma_handle, void **ret)
 {
-	struct dma_coherent_mem *mem;
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 	int order = get_order(size);
 	unsigned long flags;
 	int pageno;
 	int dma_memory_map;
 
-	if (!dev)
-		return 0;
-	mem = dev->dma_mem;
 	if (!mem)
 		return 0;
 
@@ -223,7 +232,7 @@ EXPORT_SYMBOL(dma_alloc_from_coherent);
  */
 int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
 {
-	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
 	if (mem && vaddr >= mem->virt_base && vaddr <
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
@@ -257,7 +266,7 @@ EXPORT_SYMBOL(dma_release_from_coherent);
 int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 			   void *vaddr, size_t size, int *ret)
 {
-	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
 	if (mem && vaddr >= mem->virt_base && vaddr + size <=
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
@@ -287,6 +296,8 @@ EXPORT_SYMBOL(dma_mmap_from_coherent);
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 
+static struct reserved_mem *dma_reserved_default_memory __initdata;
+
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
 	struct dma_coherent_mem *mem = rmem->priv;
@@ -307,7 +318,8 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	dev->dma_mem = NULL;
+	if (dev)
+		dev->dma_mem = NULL;
 }
 
 static const struct reserved_mem_ops rmem_dma_ops = {
@@ -327,6 +339,12 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
+
+	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
+		WARN(dma_reserved_default_memory,
+		     "Reserved memory: region for default DMA coherent area is redefined\n");
+		dma_reserved_default_memory = rmem;
+	}
 #endif
 
 	rmem->ops = &rmem_dma_ops;
@@ -334,5 +352,32 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
 	return 0;
 }
+
+static int __init dma_init_reserved_memory(void)
+{
+	const struct reserved_mem_ops *ops;
+	int ret;
+
+	if (!dma_reserved_default_memory)
+		return -ENOMEM;
+
+	ops = dma_reserved_default_memory->ops;
+
+	/*
+	 * We rely on rmem_dma_device_init() does not propagate error of
+	 * dma_assign_coherent_memory() for "NULL" device.
+	 */
+	ret = ops->device_init(dma_reserved_default_memory, NULL);
+
+	if (!ret) {
+		dma_coherent_default_memory = dma_reserved_default_memory->priv;
+		pr_info("DMA: default coherent area is set\n");
+	}
+
+	return ret;
+}
+
+core_initcall(dma_init_reserved_memory);
+
 RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
 #endif
-- 
2.0.0

From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu, 13 Apr 2017 15:47:56 -0600
Subject: [PATCH] ARM: dma-mapping: add check for coherent DMA memory without
 struct page
Message-ID: <20170413214756.21265-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When coherent DMA memory without struct page is shared, importer
fails to find the page and runs into kernel page fault when it
tries to dmabuf_ops_attach/map_sg/map_page the invalid page found
in the sg_table.

Add a new dma_check_dev_coherent() interface to check if memory is
from the device coherent area. There is no way to tell where the
memory returned by dma_alloc_attrs() came from.

arm_dma_get_sgtable() checks for invalid pages, however this check
could pass even for memory obtained the coherent allocator. Add an
additional check to call dma_check_dev_coherent() to confirm that it
is indeed the coherent DMA memory and fail the sgtable creation with
-EINVAL.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 arch/arm/mm/dma-mapping.c   | 11 ++++++++---
 drivers/base/dma-coherent.c | 25 +++++++++++++++++++++++++
 include/linux/dma-mapping.h |  2 ++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 475811f..27c7d9a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -954,9 +954,14 @@ int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
-	/* If the PFN is not valid, we do not have a struct page */
-	if (!pfn_valid(pfn))
-		return -ENXIO;
+	/*
+	 * If the PFN is not valid, we do not have a struct page
+	 * As this check can pass even for memory obtained through
+	 * the coherent allocator, do an additional check to determine
+	 * if this is coherent DMA memory.
+	 */
+	if (!pfn_valid(pfn) && dma_check_dev_coherent(dev, handle, cpu_addr))
+		return -EINVAL;
 
 	page = pfn_to_page(pfn);
 
diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 640a7e6..d08cf44 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -209,6 +209,31 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 EXPORT_SYMBOL(dma_alloc_from_coherent);
 
 /**
+ * dma_check_dev_coherent() - checks if memory is from the device coherent area
+ *
+ * @dev:	device whose coherent area is checked to validate memory
+ * @dma_handle:	dma handle associated with the allocated memory
+ * @vaddr:	the virtual address to the allocated area.
+ *
+ * Returns true if memory does belong to the per-device cohrent area.
+ * false otherwise.
+ */
+bool dma_check_dev_coherent(struct device *dev, dma_addr_t dma_handle,
+				void *vaddr)
+{
+	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+
+	if (mem && vaddr >= mem->virt_base &&
+	    vaddr < (mem->virt_base + (mem->size << PAGE_SHIFT)) &&
+	    dma_handle >= mem->device_base &&
+	    dma_handle < (mem->device_base + (mem->size << PAGE_SHIFT)))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(dma_check_dev_coherent);
+
+/**
  * dma_release_from_coherent() - try to free the memory allocated from per-device coherent memory pool
  * @dev:	device from which the memory was allocated
  * @order:	the order of pages allocated
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0977317..b10e70d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -160,6 +160,8 @@ static inline int is_device_dma_capable(struct device *dev)
  */
 int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 				       dma_addr_t *dma_handle, void **ret);
+bool dma_check_dev_coherent(struct device *dev, dma_addr_t dma_handle,
+				void *vaddr);
 int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
 
 int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
-- 
2.7.4

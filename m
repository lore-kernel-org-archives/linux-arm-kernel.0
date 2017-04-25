From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Apr 2017 18:57:39 +0100
Subject: [RFC PATCH] drivers: dma-mapping: Do not attempt to create a
 scatterlist for from_coherent buffers
Message-ID: <1493143059-2113-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory returned by dma_alloc_from_coherent() is not backed by struct
page and creating a scatterlist would use invalid page pointers. The
patch introduces the dma_vaddr_from_coherent() function and the
corresponding check in dma_get_sgtable_attrs().

Fixes: d2b7428eb0ca ("common: dma-mapping: introduce dma_get_sgtable() function")
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

In a recent discussion around the iommu DMA ops on arm64, Russell
pointed out that dma_get_sgtable is not safe since the coherent DMA
memory is not always backed by struct page. Russell has queued an
arm-specific patch checking for pfn_valid() but I thought I'd make a
more generic fix. This patch aims to bring the dma_get_sgtable() API in
line with the dma_alloc/mmap/free with respect to the from_coherent
memory.

 drivers/base/dma-coherent.c | 9 +++++++++
 include/linux/dma-mapping.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 640a7e63c453..1d2cdbefb850 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -279,6 +279,15 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(dma_mmap_from_coherent);
 
+int dma_vaddr_from_coherent(struct device *dev, void *vaddr, size_t size)
+{
+	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+
+	return mem && vaddr >= mem->virt_base &&
+		vaddr + size <= (mem->virt_base + (mem->size << PAGE_SHIFT));
+}
+EXPORT_SYMBOL(dma_vaddr_from_coherent);
+
 /*
  * Support for reserved memory regions defined in device tree
  */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0977317c6835..4dc99c6db184 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -164,10 +164,12 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
 
 int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
+int dma_vaddr_from_coherent(struct device *dev, void *vaddr, size_t size);
 #else
 #define dma_alloc_from_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
+#define dma_vaddr_from_coherent(dev, vaddr, size) (0)
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
 #ifdef CONFIG_HAS_DMA
@@ -461,6 +463,9 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	BUG_ON(!ops);
+	/* dma_alloc_from_coherent() memory is not backed by struct page */
+	if (dma_vaddr_from_coherent(dev, cpu_addr, size))
+		return -ENXIO;
 	if (ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);

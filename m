From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 17 Jul 2017 09:58:04 +0100
Subject: [RFC PATCH 1/2] drivers: dma-coherent: Introduce interface for
 default DMA pool
In-Reply-To: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
References: <1500281885-3034-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1500281885-3034-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph noticed [1] that default DMA pool in current form overload
the DMA coherent infrastructure. In reply, Robin suggested to split
the per-device vs. global pool interfaces, so allocation/release from
default DMA pool is driven by dma ops implementation.

This patch implements Robin's idea and provide interface to
allocate/release/mmap the default/global DMA pool.

[1] https://lkml.org/lkml/2017/7/7/370
[2] https://lkml.org/lkml/2017/7/7/431

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/base/dma-coherent.c | 159 +++++++++++++++++++++++++++++---------------
 include/linux/dma-mapping.h |  24 +++++++
 2 files changed, 130 insertions(+), 53 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 2ae24c2..6ab9039 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -25,7 +25,7 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
 {
 	if (dev && dev->dma_mem)
 		return dev->dma_mem;
-	return dma_coherent_default_memory;
+	return NULL;
 }
 
 static inline dma_addr_t dma_get_device_base(struct device *dev,
@@ -165,34 +165,15 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
 
-/**
- * dma_alloc_from_coherent() - try to allocate memory from the per-device coherent area
- *
- * @dev:	device from which we allocate memory
- * @size:	size of requested memory area
- * @dma_handle:	This will be filled with the correct dma handle
- * @ret:	This pointer will be filled with the virtual address
- *		to allocated area.
- *
- * This function should be only called from per-arch dma_alloc_coherent()
- * to support allocation from per-device coherent memory pools.
- *
- * Returns 0 if dma_alloc_coherent should continue with allocating from
- * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
- */
-int dma_alloc_from_coherent(struct device *dev, ssize_t size,
-				       dma_addr_t *dma_handle, void **ret)
+static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
+				       ssize_t size, dma_addr_t *dma_handle)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 	int order = get_order(size);
 	unsigned long flags;
 	int pageno;
 	int dma_memory_map;
+	void *ret;
 
-	if (!mem)
-		return 0;
-
-	*ret = NULL;
 	spin_lock_irqsave(&mem->spinlock, flags);
 
 	if (unlikely(size > (mem->size << PAGE_SHIFT)))
@@ -203,21 +184,51 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 		goto err;
 
 	/*
-	 * Memory was found in the per-device area.
+	 * Memory was found in the coherent area.
 	 */
-	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
-	*ret = mem->virt_base + (pageno << PAGE_SHIFT);
+	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
+	ret = mem->virt_base + (pageno << PAGE_SHIFT);
 	dma_memory_map = (mem->flags & DMA_MEMORY_MAP);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 	if (dma_memory_map)
-		memset(*ret, 0, size);
+		memset(ret, 0, size);
 	else
-		memset_io(*ret, 0, size);
+		memset_io(ret, 0, size);
 
-	return 1;
+	return ret;
 
 err:
 	spin_unlock_irqrestore(&mem->spinlock, flags);
+	return NULL;
+}
+
+/**
+ * dma_alloc_from_coherent() - try to allocate memory from the per-device coherent area
+ *
+ * @dev:	device from which we allocate memory
+ * @size:	size of requested memory area
+ * @dma_handle:	This will be filled with the correct dma handle
+ * @ret:	This pointer will be filled with the virtual address
+ *		to allocated area.
+ *
+ * This function should be only called from per-arch dma_alloc_coherent()
+ * to support allocation from per-device coherent memory pools.
+ *
+ * Returns 0 if dma_alloc_coherent should continue with allocating from
+ * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
+ */
+int dma_alloc_from_coherent(struct device *dev, ssize_t size,
+			    dma_addr_t *dma_handle, void **ret)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (!mem)
+		return 0;
+
+	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
+	if (*ret)
+		return 1;
+
 	/*
 	 * In the case where the allocation can not be satisfied from the
 	 * per-device area, try to fall back to generic memory if the
@@ -227,6 +238,31 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 }
 EXPORT_SYMBOL(dma_alloc_from_coherent);
 
+void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
+{
+	if (!dma_coherent_default_memory)
+		return NULL;
+
+	return __dma_alloc_from_coherent(dma_coherent_default_memory, size, dma_handle);
+}
+
+
+static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
+				       int order, void *vaddr)
+{
+	if (mem && vaddr >= mem->virt_base && vaddr <
+		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
+		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+		unsigned long flags;
+
+		spin_lock_irqsave(&mem->spinlock, flags);
+		bitmap_release_region(mem->bitmap, page, order);
+		spin_unlock_irqrestore(&mem->spinlock, flags);
+		return 1;
+	}
+	return 0;
+}
+
 /**
  * dma_release_from_coherent() - try to free the memory allocated from per-device coherent memory pool
  * @dev:	device from which the memory was allocated
@@ -244,19 +280,42 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
 {
 	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
-	if (mem && vaddr >= mem->virt_base && vaddr <
+	return __dma_release_from_coherent(mem, order, vaddr);
+}
+EXPORT_SYMBOL(dma_release_from_coherent);
+
+
+int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_release_from_coherent(dma_coherent_default_memory,
+					   order, vaddr);
+}
+
+static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
+				    struct vm_area_struct *vma, void *vaddr,
+				    size_t size, int *ret)
+{
+	if (mem && vaddr >= mem->virt_base && vaddr + size <=
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
-		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
-		unsigned long flags;
+		unsigned long off = vma->vm_pgoff;
+		int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+		int user_count = vma_pages(vma);
+		int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-		spin_lock_irqsave(&mem->spinlock, flags);
-		bitmap_release_region(mem->bitmap, page, order);
-		spin_unlock_irqrestore(&mem->spinlock, flags);
+		*ret = -ENXIO;
+		if (off < count && user_count <= count - off) {
+			unsigned long pfn = mem->pfn_base + start + off;
+			*ret = remap_pfn_range(vma, vma->vm_start, pfn,
+					       user_count << PAGE_SHIFT,
+					       vma->vm_page_prot);
+		}
 		return 1;
 	}
 	return 0;
 }
-EXPORT_SYMBOL(dma_release_from_coherent);
 
 /**
  * dma_mmap_from_coherent() - try to mmap the memory allocated from
@@ -278,26 +337,20 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 {
 	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
-	if (mem && vaddr >= mem->virt_base && vaddr + size <=
-		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
-		unsigned long off = vma->vm_pgoff;
-		int start = (vaddr - mem->virt_base) >> PAGE_SHIFT;
-		int user_count = vma_pages(vma);
-		int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		*ret = -ENXIO;
-		if (off < count && user_count <= count - off) {
-			unsigned long pfn = mem->pfn_base + start + off;
-			*ret = remap_pfn_range(vma, vma->vm_start, pfn,
-					       user_count << PAGE_SHIFT,
-					       vma->vm_page_prot);
-		}
-		return 1;
-	}
-	return 0;
+	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
 }
 EXPORT_SYMBOL(dma_mmap_from_coherent);
 
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
+				   size_t size, int *ret)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_mmap_from_coherent(dma_coherent_default_memory, vma,
+					vaddr, size, ret);
+}
+
 /*
  * Support for reserved memory regions defined in device tree
  */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 843ab86..8f2289f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -163,10 +163,34 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
 
 int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
+
+void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
+int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
+				  size_t size, int *ret);
+
 #else
 #define dma_alloc_from_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
+
+static inline void *dma_alloc_from_global_coherent(ssize_t size,
+						   dma_addr_t *dma_handle)
+{
+	return NULL;
+}
+
+static inline int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	return 0;
+}
+
+static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
+						void *cpu_addr, size_t size,
+						int *ret)
+{
+	return 0;
+}
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
 #ifdef CONFIG_HAS_DMA
-- 
2.0.0

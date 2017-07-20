From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 20 Jul 2017 11:19:58 +0100
Subject: [PATCH 1/2] drivers: dma-coherent: Introduce interface for default
 DMA pool
In-Reply-To: <1500545999-17177-1-git-send-email-vladimir.murzin@arm.com>
References: <1500545999-17177-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1500545999-17177-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph noticed [1] that default DMA pool in current form overload
the DMA coherent infrastructure. In reply, Robin suggested [2] to
split the per-device vs. global pool interfaces, so allocation/release
from default DMA pool is driven by dma ops implementation.

This patch implements Robin's idea and provide interface to
allocate/release/mmap the default (aka global) DMA pool.

To make it clear that existing *_from_coherent routines work on
per-device pool rename them to *_from_dev_coherent.

[1] https://lkml.org/lkml/2017/7/7/370
[2] https://lkml.org/lkml/2017/7/7/431

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Andras Szemzo <sza@esh.hu>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arc/mm/dma.c           |   2 +-
 arch/arm/mm/dma-mapping.c   |   2 +-
 arch/arm64/mm/dma-mapping.c |   4 +-
 arch/mips/mm/dma-default.c  |   2 +-
 drivers/base/dma-coherent.c | 169 +++++++++++++++++++++++++++++---------------
 drivers/base/dma-mapping.c  |   2 +-
 include/linux/dma-mapping.h |  40 ++++++++---
 7 files changed, 149 insertions(+), 72 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 2a07e6e..71d3eff 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -117,7 +117,7 @@ static int arc_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
 	if (off < count && user_count <= (count - off)) {
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e7380ba..fcf1473 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -851,7 +851,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
 
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
 	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index e90cd1d..f27d4dd 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -329,7 +329,7 @@ static int __swiotlb_mmap(struct device *dev,
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
 					     is_device_dma_coherent(dev));
 
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
 	return __swiotlb_mmap_pfn(vma, pfn, size);
@@ -706,7 +706,7 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
 					     is_device_dma_coherent(dev));
 
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e08598c..8e78251 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -232,7 +232,7 @@ static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
 	if (off < count && user_count <= (count - off)) {
diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 2ae24c2..d6f231c 100644
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
+static void *__dma_alloc_from_dev_coherent(struct dma_coherent_mem *mem,
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
+ * dma_alloc_from_dev_coherent() - try to allocate memory from the per-device coherent area
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
+int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
+			    dma_addr_t *dma_handle, void **ret)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (!mem)
+		return 0;
+
+	*ret = __dma_alloc_from_dev_coherent(mem, size, dma_handle);
+	if (*ret)
+		return 1;
+
 	/*
 	 * In the case where the allocation can not be satisfied from the
 	 * per-device area, try to fall back to generic memory if the
@@ -225,25 +236,20 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
 	 */
 	return mem->flags & DMA_MEMORY_EXCLUSIVE;
 }
-EXPORT_SYMBOL(dma_alloc_from_coherent);
+EXPORT_SYMBOL(dma_alloc_from_dev_coherent);
 
-/**
- * dma_release_from_coherent() - try to free the memory allocated from per-device coherent memory pool
- * @dev:	device from which the memory was allocated
- * @order:	the order of pages allocated
- * @vaddr:	virtual address of allocated pages
- *
- * This checks whether the memory was allocated from the per-device
- * coherent memory pool and if so, releases that memory.
- *
- * Returns 1 if we correctly released the memory, or 0 if
- * dma_release_coherent() should proceed with releasing memory from
- * generic pools.
- */
-int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
+void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	if (!dma_coherent_default_memory)
+		return NULL;
 
+	return __dma_alloc_from_dev_coherent(dma_coherent_default_memory, size, dma_handle);
+}
+
+
+static int __dma_release_from_dev_coherent(struct dma_coherent_mem *mem,
+				       int order, void *vaddr)
+{
 	if (mem && vaddr >= mem->virt_base && vaddr <
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
 		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
@@ -256,28 +262,42 @@ int dma_release_from_coherent(struct device *dev, int order, void *vaddr)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(dma_release_from_coherent);
 
 /**
- * dma_mmap_from_coherent() - try to mmap the memory allocated from
- * per-device coherent memory pool to userspace
+ * dma_release_from_dev_coherent() - try to free the memory allocated from per-device coherent memory pool
  * @dev:	device from which the memory was allocated
- * @vma:	vm_area for the userspace memory
- * @vaddr:	cpu address returned by dma_alloc_from_coherent
- * @size:	size of the memory buffer allocated by dma_alloc_from_coherent
- * @ret:	result from remap_pfn_range()
+ * @order:	the order of pages allocated
+ * @vaddr:	virtual address of allocated pages
  *
  * This checks whether the memory was allocated from the per-device
- * coherent memory pool and if so, maps that memory to the provided vma.
+ * coherent memory pool and if so, releases that memory.
  *
- * Returns 1 if we correctly mapped the memory, or 0 if the caller should
- * proceed with mapping memory from generic pools.
+ * Returns 1 if we correctly released the memory, or 0 if
+ * dma_release_coherent() should proceed with releasing memory from
+ * generic pools.
  */
-int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
-			   void *vaddr, size_t size, int *ret)
+int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 {
 	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
+	return __dma_release_from_dev_coherent(mem, order, vaddr);
+}
+EXPORT_SYMBOL(dma_release_from_dev_coherent);
+
+
+int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_release_from_dev_coherent(dma_coherent_default_memory,
+					   order, vaddr);
+}
+
+static int __dma_mmap_from_dev_coherent(struct dma_coherent_mem *mem,
+				    struct vm_area_struct *vma, void *vaddr,
+				    size_t size, int *ret)
+{
 	if (mem && vaddr >= mem->virt_base && vaddr + size <=
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
 		unsigned long off = vma->vm_pgoff;
@@ -296,7 +316,40 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 	}
 	return 0;
 }
-EXPORT_SYMBOL(dma_mmap_from_coherent);
+
+/**
+ * dma_mmap_from_dev_coherent() - try to mmap the memory allocated from
+ * per-device coherent memory pool to userspace
+ * @dev:	device from which the memory was allocated
+ * @vma:	vm_area for the userspace memory
+ * @vaddr:	cpu address returned by dma_alloc_from_dev_coherent
+ * @size:	size of the memory buffer allocated by dma_alloc_from_dev_coherent
+ * @ret:	result from remap_pfn_range()
+ *
+ * This checks whether the memory was allocated from the per-device
+ * coherent memory pool and if so, maps that memory to the provided vma.
+ *
+ * Returns 1 if we correctly mapped the memory, or 0 if the caller should
+ * proceed with mapping memory from generic pools.
+ */
+int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
+			   void *vaddr, size_t size, int *ret)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	return __dma_mmap_from_dev_coherent(mem, vma, vaddr, size, ret);
+}
+EXPORT_SYMBOL(dma_mmap_from_dev_coherent);
+
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
+				   size_t size, int *ret)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_mmap_from_dev_coherent(dma_coherent_default_memory, vma,
+					vaddr, size, ret);
+}
 
 /*
  * Support for reserved memory regions defined in device tree
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 5096755..b555ff9 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -235,7 +235,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
 	if (off < count && user_count <= (count - off)) {
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 843ab86..03c0196 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -157,16 +157,40 @@ static inline int is_device_dma_capable(struct device *dev)
  * These three functions are only for dma allocator.
  * Don't use them in device drivers.
  */
-int dma_alloc_from_coherent(struct device *dev, ssize_t size,
+int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 				       dma_addr_t *dma_handle, void **ret);
-int dma_release_from_coherent(struct device *dev, int order, void *vaddr);
+int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 
-int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
+int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
+
+void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
+int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
+				  size_t size, int *ret);
+
 #else
-#define dma_alloc_from_coherent(dev, size, handle, ret) (0)
-#define dma_release_from_coherent(dev, order, vaddr) (0)
-#define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
+#define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
+#define dma_release_from_dev_coherent(dev, order, vaddr) (0)
+#define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
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
@@ -481,7 +505,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 
 	BUG_ON(!ops);
 
-	if (dma_alloc_from_coherent(dev, size, dma_handle, &cpu_addr))
+	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
@@ -503,7 +527,7 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 	BUG_ON(!ops);
 	WARN_ON(irqs_disabled());
 
-	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
+	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
 		return;
 
 	if (!ops->free || !cpu_addr)
-- 
2.0.0

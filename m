From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 19 Feb 2016 09:22:44 +0100
Subject: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
 architecture
In-Reply-To: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces ARM-specific IOMMU-based DMA-mapping implementation
with generic IOMMU DMA-mapping code shared with ARM64 architecture. The
side-effect of this change is a switch from bitmap-based IO address space
management to tree-based code. There should be no functional changes
for drivers, which rely on initialization from generic arch_setup_dna_ops()
interface. Code, which used old arm_iommu_* functions must be updated to
new interface.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/Kconfig                   |   22 +-
 arch/arm/include/asm/device.h      |    9 -
 arch/arm/include/asm/dma-iommu.h   |   37 --
 arch/arm/include/asm/dma-mapping.h |   59 +-
 arch/arm/mm/dma-mapping.c          | 1158 +-----------------------------------
 drivers/gpu/drm/rockchip/Kconfig   |    1 +
 drivers/iommu/Kconfig              |    1 +
 drivers/media/platform/Kconfig     |    1 +
 8 files changed, 82 insertions(+), 1206 deletions(-)
 delete mode 100644 arch/arm/include/asm/dma-iommu.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f799e567fc8..ed45f0d63cee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -107,27 +107,7 @@ config ARM_DMA_USE_IOMMU
 	bool
 	select ARM_HAS_SG_CHAIN
 	select NEED_SG_DMA_LENGTH
-
-if ARM_DMA_USE_IOMMU
-
-config ARM_DMA_IOMMU_ALIGNMENT
-	int "Maximum PAGE_SIZE order of alignment for DMA IOMMU buffers"
-	range 4 9
-	default 8
-	help
-	  DMA mapping framework by default aligns all buffers to the smallest
-	  PAGE_SIZE order which is greater than or equal to the requested buffer
-	  size. This works well for buffers up to a few hundreds kilobytes, but
-	  for larger buffers it just a waste of address space. Drivers which has
-	  relatively small addressing window (like 64Mib) might run out of
-	  virtual space with just a few allocations.
-
-	  With this parameter you can specify the maximum PAGE_SIZE order for
-	  DMA IOMMU buffers. Larger buffers will be aligned only to this
-	  specified order. The order is expressed as a power of two multiplied
-	  by the PAGE_SIZE.
-
-endif
+	select IOMMU_DMA
 
 config MIGHT_HAVE_PCI
 	bool
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 4111592f0130..6ea939c39cd4 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -14,9 +14,6 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void *iommu; /* private IOMMU data */
 #endif
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-	struct dma_iommu_mapping	*mapping;
-#endif
 	bool dma_coherent;
 };
 
@@ -28,10 +25,4 @@ struct pdev_archdata {
 #endif
 };
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-#define to_dma_iommu_mapping(dev) ((dev)->archdata.mapping)
-#else
-#define to_dma_iommu_mapping(dev) NULL
-#endif
-
 #endif
diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
deleted file mode 100644
index 2ef282f96651..000000000000
--- a/arch/arm/include/asm/dma-iommu.h
+++ /dev/null
@@ -1,37 +0,0 @@
-#ifndef ASMARM_DMA_IOMMU_H
-#define ASMARM_DMA_IOMMU_H
-
-#ifdef __KERNEL__
-
-#include <linux/mm_types.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <linux/kmemcheck.h>
-#include <linux/kref.h>
-
-struct dma_iommu_mapping {
-	/* iommu specific data */
-	struct iommu_domain	*domain;
-
-	unsigned long		**bitmaps;	/* array of bitmaps */
-	unsigned int		nr_bitmaps;	/* nr of elements in array */
-	unsigned int		extensions;
-	size_t			bitmap_size;	/* size of a single bitmap */
-	size_t			bits;		/* per bitmap */
-	dma_addr_t		base;
-
-	spinlock_t		lock;
-	struct kref		kref;
-};
-
-struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size);
-
-void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
-
-int arm_iommu_attach_device(struct device *dev,
-					struct dma_iommu_mapping *mapping);
-void arm_iommu_detach_device(struct device *dev);
-
-#endif /* __KERNEL__ */
-#endif
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 6ad1ceda62a5..08bedb0c02c6 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -8,6 +8,7 @@
 #include <linux/dma-attrs.h>
 #include <linux/dma-debug.h>
 
+#include <asm/cacheflush.h>
 #include <asm/memory.h>
 
 #include <xen/xen.h>
@@ -32,7 +33,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
-static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
+static inline void arch_set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 {
 	BUG_ON(!dev);
 	dev->archdata.dma_ops = ops;
@@ -275,5 +276,61 @@ extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		struct dma_attrs *attrs);
 
+/*
+ * The DMA API is built upon the notion of "buffer ownership".  A buffer
+ * is either exclusively owned by the CPU (and therefore may be accessed
+ * by it) or exclusively owned by the DMA device.  These helper functions
+ * represent the transitions between these two ownership states.
+ *
+ * Note, however, that on later ARMs, this notion does not work due to
+ * speculative prefetches.  We model our approach on the assumption that
+ * the CPU does do speculative prefetches, which means we clean caches
+ * before transfers and delay cache invalidation until transfer completion.
+ *
+ */
+extern void __dma_page_cpu_to_dev(struct page *, unsigned long, size_t,
+				  enum dma_data_direction);
+extern void __dma_page_dev_to_cpu(struct page *, unsigned long, size_t,
+				  enum dma_data_direction);
+
+static inline void arch_flush_page(struct device *dev, const void *virt,
+			    phys_addr_t phys)
+{
+	dmac_flush_range(virt, virt + PAGE_SIZE);
+	outer_flush_range(phys, phys + PAGE_SIZE);
+}
+
+static inline void arch_dma_map_area(phys_addr_t phys, size_t size,
+				     enum dma_data_direction dir)
+{
+	unsigned int offset = phys & ~PAGE_MASK;
+	__dma_page_cpu_to_dev(phys_to_page(phys & PAGE_MASK), offset, size, dir);
+}
+
+static inline void arch_dma_unmap_area(phys_addr_t phys, size_t size,
+				       enum dma_data_direction dir)
+{
+	unsigned int offset = phys & ~PAGE_MASK;
+	__dma_page_dev_to_cpu(phys_to_page(phys & PAGE_MASK), offset, size, dir);
+}
+
+static inline pgprot_t arch_get_dma_pgprot(struct dma_attrs *attrs,
+					pgprot_t prot, bool coherent)
+{
+	if (coherent)
+		return prot;
+
+	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
+			    pgprot_writecombine(prot) :
+			    pgprot_dmacoherent(prot);
+	return prot;
+}
+
+extern void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page,
+					 gfp_t flags);
+extern bool arch_in_atomic_pool(void *start, size_t size);
+extern int arch_free_from_atomic_pool(void *start, size_t size);
+
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0eca3812527e..5d497f3c5924 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-iommu.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
@@ -34,7 +35,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/mach/arch.h>
-#include <asm/dma-iommu.h>
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
 #include <asm/dma-contiguous.h>
@@ -42,23 +42,6 @@
 #include "dma.h"
 #include "mm.h"
 
-/*
- * The DMA API is built upon the notion of "buffer ownership".  A buffer
- * is either exclusively owned by the CPU (and therefore may be accessed
- * by it) or exclusively owned by the DMA device.  These helper functions
- * represent the transitions between these two ownership states.
- *
- * Note, however, that on later ARMs, this notion does not work due to
- * speculative prefetches.  We model our approach on the assumption that
- * the CPU does do speculative prefetches, which means we clean caches
- * before transfers and delay cache invalidation until transfer completion.
- *
- */
-static void __dma_page_cpu_to_dev(struct page *, unsigned long,
-		size_t, enum dma_data_direction);
-static void __dma_page_dev_to_cpu(struct page *, unsigned long,
-		size_t, enum dma_data_direction);
-
 /**
  * arm_dma_map_page - map a portion of a page for streaming DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
@@ -492,7 +475,7 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 	return ptr;
 }
 
-static void *__alloc_from_pool(size_t size, struct page **ret_page)
+void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page, gfp_t gfp)
 {
 	unsigned long val;
 	void *ptr = NULL;
@@ -513,14 +496,14 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 	return ptr;
 }
 
-static bool __in_atomic_pool(void *start, size_t size)
+bool arch_in_atomic_pool(void *start, size_t size)
 {
 	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
 }
 
-static int __free_from_pool(void *start, size_t size)
+int arch_free_from_atomic_pool(void *start, size_t size)
 {
-	if (!__in_atomic_pool(start, size))
+	if (!arch_in_atomic_pool(start, size))
 		return 0;
 
 	gen_pool_free(atomic_pool, (unsigned long)start, size);
@@ -574,25 +557,21 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
-static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
-{
-	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
-			    pgprot_writecombine(prot) :
-			    pgprot_dmacoherent(prot);
-	return prot;
-}
-
 #define nommu() 0
 
+#define __alloc_from_pool(size, ret, gfp) arch_alloc_from_atomic_pool(size, ret, gfp)
+#define __free_from_pool(addr, size) arch_free_from_atomic_pool(addr, size)
+#define __get_dma_pgprot(attrs, prot, coherent) arch_get_dma_pgprot(attrs, prot, coherent)
+
 #else	/* !CONFIG_MMU */
 
 #define nommu() 1
 
-#define __get_dma_pgprot(attrs, prot)				__pgprot(0)
+#define __get_dma_pgprot(attrs, prot, coherent)				__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
-#define __alloc_from_pool(size, ret_page)			NULL
+#define __alloc_from_pool(size, ret_page, gfp)			NULL
 #define __alloc_from_contiguous(dev, size, prot, ret, c, wv)	NULL
-#define __free_from_pool(cpu_addr, size)			0
+#define __free_from_atomic_pool(cpu_addr, size)			0
 #define __free_from_contiguous(dev, page, cpu_addr, size, wv)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
@@ -657,7 +636,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	else if (is_coherent)
 		addr = __alloc_simple_buffer(dev, size, gfp, &page);
 	else if (!gfpflags_allow_blocking(gfp))
-		addr = __alloc_from_pool(size, &page);
+		addr = __alloc_from_pool(size, &page, gfp);
 	else
 		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page,
 					    caller, want_vaddr);
@@ -675,7 +654,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		    gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
 
 	return __dma_alloc(dev, size, handle, gfp, prot, false,
 			   attrs, __builtin_return_address(0));
@@ -728,7 +707,7 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 struct dma_attrs *attrs)
 {
 #ifdef CONFIG_MMU
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot, false);
 #endif	/* CONFIG_MMU */
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
@@ -842,7 +821,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
  * platforms with CONFIG_DMABOUNCE.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr;
@@ -858,7 +837,7 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	/* FIXME: non-speculating: flush on bidirectional mappings? */
 }
 
-static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
+void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = page_to_phys(page) + off;
@@ -1023,1098 +1002,6 @@ static int __init dma_debug_do_init(void)
 }
 fs_initcall(dma_debug_do_init);
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-
-/* IOMMU */
-
-static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
-
-static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
-				      size_t size)
-{
-	unsigned int order = get_order(size);
-	unsigned int align = 0;
-	unsigned int count, start;
-	size_t mapping_size = mapping->bits << PAGE_SHIFT;
-	unsigned long flags;
-	dma_addr_t iova;
-	int i;
-
-	if (order > CONFIG_ARM_DMA_IOMMU_ALIGNMENT)
-		order = CONFIG_ARM_DMA_IOMMU_ALIGNMENT;
-
-	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	align = (1 << order) - 1;
-
-	spin_lock_irqsave(&mapping->lock, flags);
-	for (i = 0; i < mapping->nr_bitmaps; i++) {
-		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
-				mapping->bits, 0, count, align);
-
-		if (start > mapping->bits)
-			continue;
-
-		bitmap_set(mapping->bitmaps[i], start, count);
-		break;
-	}
-
-	/*
-	 * No unused range found. Try to extend the existing mapping
-	 * and perform a second attempt to reserve an IO virtual
-	 * address range of size bytes.
-	 */
-	if (i == mapping->nr_bitmaps) {
-		if (extend_iommu_mapping(mapping)) {
-			spin_unlock_irqrestore(&mapping->lock, flags);
-			return DMA_ERROR_CODE;
-		}
-
-		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
-				mapping->bits, 0, count, align);
-
-		if (start > mapping->bits) {
-			spin_unlock_irqrestore(&mapping->lock, flags);
-			return DMA_ERROR_CODE;
-		}
-
-		bitmap_set(mapping->bitmaps[i], start, count);
-	}
-	spin_unlock_irqrestore(&mapping->lock, flags);
-
-	iova = mapping->base + (mapping_size * i);
-	iova += start << PAGE_SHIFT;
-
-	return iova;
-}
-
-static inline void __free_iova(struct dma_iommu_mapping *mapping,
-			       dma_addr_t addr, size_t size)
-{
-	unsigned int start, count;
-	size_t mapping_size = mapping->bits << PAGE_SHIFT;
-	unsigned long flags;
-	dma_addr_t bitmap_base;
-	u32 bitmap_index;
-
-	if (!size)
-		return;
-
-	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping_size;
-	BUG_ON(addr < mapping->base || bitmap_index > mapping->extensions);
-
-	bitmap_base = mapping->base + mapping_size * bitmap_index;
-
-	start = (addr - bitmap_base) >>	PAGE_SHIFT;
-
-	if (addr + size > bitmap_base + mapping_size) {
-		/*
-		 * The address range to be freed reaches into the iova
-		 * range of the next bitmap. This should not happen as
-		 * we don't allow this in __alloc_iova (at the
-		 * moment).
-		 */
-		BUG();
-	} else
-		count = size >> PAGE_SHIFT;
-
-	spin_lock_irqsave(&mapping->lock, flags);
-	bitmap_clear(mapping->bitmaps[bitmap_index], start, count);
-	spin_unlock_irqrestore(&mapping->lock, flags);
-}
-
-static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
-{
-	struct page **pages;
-	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
-	int i = 0;
-
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
-	if (!pages)
-		return NULL;
-
-	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs))
-	{
-		unsigned long order = get_order(size);
-		struct page *page;
-
-		page = dma_alloc_from_contiguous(dev, count, order);
-		if (!page)
-			goto error;
-
-		__dma_clear_buffer(page, size);
-
-		for (i = 0; i < count; i++)
-			pages[i] = page + i;
-
-		return pages;
-	}
-
-	/*
-	 * IOMMU can map any pages, so himem can also be used here
-	 */
-	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
-
-	while (count) {
-		int j, order;
-
-		for (order = __fls(count); order > 0; --order) {
-			/*
-			 * We do not want OOM killer to be invoked as long
-			 * as we can fall back to single pages, so we force
-			 * __GFP_NORETRY for orders higher than zero.
-			 */
-			pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
-			if (pages[i])
-				break;
-		}
-
-		if (!pages[i]) {
-			/*
-			 * Fall back to single page allocation.
-			 * Might invoke OOM killer as last resort.
-			 */
-			pages[i] = alloc_pages(gfp, 0);
-			if (!pages[i])
-				goto error;
-		}
-
-		if (order) {
-			split_page(pages[i], order);
-			j = 1 << order;
-			while (--j)
-				pages[i + j] = pages[i] + j;
-		}
-
-		__dma_clear_buffer(pages[i], PAGE_SIZE << order);
-		i += 1 << order;
-		count -= 1 << order;
-	}
-
-	return pages;
-error:
-	while (i--)
-		if (pages[i])
-			__free_pages(pages[i], 0);
-	kvfree(pages);
-	return NULL;
-}
-
-static int __iommu_free_buffer(struct device *dev, struct page **pages,
-			       size_t size, struct dma_attrs *attrs)
-{
-	int count = size >> PAGE_SHIFT;
-	int i;
-
-	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
-		dma_release_from_contiguous(dev, pages[0], count);
-	} else {
-		for (i = 0; i < count; i++)
-			if (pages[i])
-				__free_pages(pages[i], 0);
-	}
-
-	kvfree(pages);
-	return 0;
-}
-
-/*
- * Create a CPU mapping for a specified pages
- */
-static void *
-__iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
-		    const void *caller)
-{
-	return dma_common_pages_remap(pages, size,
-			VM_ARM_DMA_CONSISTENT | VM_USERMAP, prot, caller);
-}
-
-/*
- * Create a mapping in device IO address space for specified pages
- */
-static dma_addr_t
-__iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	dma_addr_t dma_addr, iova;
-	int i;
-
-	dma_addr = __alloc_iova(mapping, size);
-	if (dma_addr == DMA_ERROR_CODE)
-		return dma_addr;
-
-	iova = dma_addr;
-	for (i = 0; i < count; ) {
-		int ret;
-
-		unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
-		phys_addr_t phys = page_to_phys(pages[i]);
-		unsigned int len, j;
-
-		for (j = i + 1; j < count; j++, next_pfn++)
-			if (page_to_pfn(pages[j]) != next_pfn)
-				break;
-
-		len = (j - i) << PAGE_SHIFT;
-		ret = iommu_map(mapping->domain, iova, phys, len,
-				IOMMU_READ|IOMMU_WRITE);
-		if (ret < 0)
-			goto fail;
-		iova += len;
-		i = j;
-	}
-	return dma_addr;
-fail:
-	iommu_unmap(mapping->domain, dma_addr, iova-dma_addr);
-	__free_iova(mapping, dma_addr, size);
-	return DMA_ERROR_CODE;
-}
-
-static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t size)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-
-	/*
-	 * add optional in-page offset from iova to size and align
-	 * result to page size
-	 */
-	size = PAGE_ALIGN((iova & ~PAGE_MASK) + size);
-	iova &= PAGE_MASK;
-
-	iommu_unmap(mapping->domain, iova, size);
-	__free_iova(mapping, iova, size);
-	return 0;
-}
-
-static struct page **__atomic_get_pages(void *addr)
-{
-	struct page *page;
-	phys_addr_t phys;
-
-	phys = gen_pool_virt_to_phys(atomic_pool, (unsigned long)addr);
-	page = phys_to_page(phys);
-
-	return (struct page **)page;
-}
-
-static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
-{
-	struct vm_struct *area;
-
-	if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
-		return __atomic_get_pages(cpu_addr);
-
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
-		return cpu_addr;
-
-	area = find_vm_area(cpu_addr);
-	if (area && (area->flags & VM_ARM_DMA_CONSISTENT))
-		return area->pages;
-	return NULL;
-}
-
-static void *__iommu_alloc_atomic(struct device *dev, size_t size,
-				  dma_addr_t *handle)
-{
-	struct page *page;
-	void *addr;
-
-	addr = __alloc_from_pool(size, &page);
-	if (!addr)
-		return NULL;
-
-	*handle = __iommu_create_mapping(dev, &page, size);
-	if (*handle == DMA_ERROR_CODE)
-		goto err_mapping;
-
-	return addr;
-
-err_mapping:
-	__free_from_pool(addr, size);
-	return NULL;
-}
-
-static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
-				dma_addr_t handle, size_t size)
-{
-	__iommu_remove_mapping(dev, handle, size);
-	__free_from_pool(cpu_addr, size);
-}
-
-static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
-{
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
-	struct page **pages;
-	void *addr = NULL;
-
-	*handle = DMA_ERROR_CODE;
-	size = PAGE_ALIGN(size);
-
-	if (!gfpflags_allow_blocking(gfp))
-		return __iommu_alloc_atomic(dev, size, handle);
-
-	/*
-	 * Following is a work-around (a.k.a. hack) to prevent pages
-	 * with __GFP_COMP being passed to split_page() which cannot
-	 * handle them.  The real problem is that this flag probably
-	 * should be 0 on ARM as it is not supported on this
-	 * platform; see CONFIG_HUGETLBFS.
-	 */
-	gfp &= ~(__GFP_COMP);
-
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
-	if (!pages)
-		return NULL;
-
-	*handle = __iommu_create_mapping(dev, pages, size);
-	if (*handle == DMA_ERROR_CODE)
-		goto err_buffer;
-
-	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
-		return pages;
-
-	addr = __iommu_alloc_remap(pages, size, gfp, prot,
-				   __builtin_return_address(0));
-	if (!addr)
-		goto err_mapping;
-
-	return addr;
-
-err_mapping:
-	__iommu_remove_mapping(dev, *handle, size);
-err_buffer:
-	__iommu_free_buffer(dev, pages, size, attrs);
-	return NULL;
-}
-
-static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
-		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		    struct dma_attrs *attrs)
-{
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
-	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-
-	if (!pages)
-		return -ENXIO;
-
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
-		return -ENXIO;
-
-	pages += off;
-
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
-
-	return 0;
-}
-
-/*
- * free a page as defined by the above mapping.
- * Must not be called with IRQs disabled.
- */
-void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			  dma_addr_t handle, struct dma_attrs *attrs)
-{
-	struct page **pages;
-	size = PAGE_ALIGN(size);
-
-	if (__in_atomic_pool(cpu_addr, size)) {
-		__iommu_free_atomic(dev, cpu_addr, handle, size);
-		return;
-	}
-
-	pages = __iommu_get_pages(cpu_addr, attrs);
-	if (!pages) {
-		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
-		return;
-	}
-
-	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
-		dma_common_free_remap(cpu_addr, size,
-			VM_ARM_DMA_CONSISTENT | VM_USERMAP);
-	}
-
-	__iommu_remove_mapping(dev, handle, size);
-	__iommu_free_buffer(dev, pages, size, attrs);
-}
-
-static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
-				 void *cpu_addr, dma_addr_t dma_addr,
-				 size_t size, struct dma_attrs *attrs)
-{
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
-
-	if (!pages)
-		return -ENXIO;
-
-	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
-					 GFP_KERNEL);
-}
-
-static int __dma_direction_to_prot(enum dma_data_direction dir)
-{
-	int prot;
-
-	switch (dir) {
-	case DMA_BIDIRECTIONAL:
-		prot = IOMMU_READ | IOMMU_WRITE;
-		break;
-	case DMA_TO_DEVICE:
-		prot = IOMMU_READ;
-		break;
-	case DMA_FROM_DEVICE:
-		prot = IOMMU_WRITE;
-		break;
-	default:
-		prot = 0;
-	}
-
-	return prot;
-}
-
-/*
- * Map a part of the scatter-gather list into contiguous io address space
- */
-static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
-			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, struct dma_attrs *attrs,
-			  bool is_coherent)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova, iova_base;
-	int ret = 0;
-	unsigned int count;
-	struct scatterlist *s;
-	int prot;
-
-	size = PAGE_ALIGN(size);
-	*handle = DMA_ERROR_CODE;
-
-	iova_base = iova = __alloc_iova(mapping, size);
-	if (iova == DMA_ERROR_CODE)
-		return -ENOMEM;
-
-	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
-		phys_addr_t phys = page_to_phys(sg_page(s));
-		unsigned int len = PAGE_ALIGN(s->offset + s->length);
-
-		if (!is_coherent &&
-			!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
-
-		prot = __dma_direction_to_prot(dir);
-
-		ret = iommu_map(mapping->domain, iova, phys, len, prot);
-		if (ret < 0)
-			goto fail;
-		count += len >> PAGE_SHIFT;
-		iova += len;
-	}
-	*handle = iova_base;
-
-	return 0;
-fail:
-	iommu_unmap(mapping->domain, iova_base, count * PAGE_SIZE);
-	__free_iova(mapping, iova_base, size);
-	return ret;
-}
-
-static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, struct dma_attrs *attrs,
-		     bool is_coherent)
-{
-	struct scatterlist *s = sg, *dma = sg, *start = sg;
-	int i, count = 0;
-	unsigned int offset = s->offset;
-	unsigned int size = s->offset + s->length;
-	unsigned int max = dma_get_max_seg_size(dev);
-
-	for (i = 1; i < nents; i++) {
-		s = sg_next(s);
-
-		s->dma_address = DMA_ERROR_CODE;
-		s->dma_length = 0;
-
-		if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
-			if (__map_sg_chunk(dev, start, size, &dma->dma_address,
-			    dir, attrs, is_coherent) < 0)
-				goto bad_mapping;
-
-			dma->dma_address += offset;
-			dma->dma_length = size - offset;
-
-			size = offset = s->offset;
-			start = s;
-			dma = sg_next(dma);
-			count += 1;
-		}
-		size += s->length;
-	}
-	if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs,
-		is_coherent) < 0)
-		goto bad_mapping;
-
-	dma->dma_address += offset;
-	dma->dma_length = size - offset;
-
-	return count+1;
-
-bad_mapping:
-	for_each_sg(sg, s, count, i)
-		__iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
-	return 0;
-}
-
-/**
- * arm_coherent_iommu_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of i/o coherent buffers described by scatterlist in streaming
- * mode for DMA. The scatter gather list elements are merged together (if
- * possible) and tagged with the appropriate dma address and length. They are
- * obtained via sg_dma_{address,length}.
- */
-int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
-{
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
-}
-
-/**
- * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * The scatter gather list elements are merged together (if possible) and
- * tagged with the appropriate dma address and length. They are obtained via
- * sg_dma_{address,length}.
- */
-int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
-{
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
-}
-
-static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
-		bool is_coherent)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		if (sg_dma_len(s))
-			__iommu_remove_mapping(dev, sg_dma_address(s),
-					       sg_dma_len(s));
-		if (!is_coherent &&
-		    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-			__dma_page_dev_to_cpu(sg_page(s), s->offset,
-					      s->length, dir);
-	}
-}
-
-/**
- * arm_coherent_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
-{
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
-}
-
-/**
- * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
-{
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
-}
-
-/**
- * arm_iommu_sync_sg_for_cpu
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
-
-}
-
-/**
- * arm_iommu_sync_sg_for_device
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
-}
-
-
-/**
- * arm_coherent_iommu_map_page
- * @dev: valid struct device pointer
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * Coherent IOMMU aware version of arm_dma_map_page()
- */
-static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t dma_addr;
-	int ret, prot, len = PAGE_ALIGN(size + offset);
-
-	dma_addr = __alloc_iova(mapping, len);
-	if (dma_addr == DMA_ERROR_CODE)
-		return dma_addr;
-
-	prot = __dma_direction_to_prot(dir);
-
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
-	if (ret < 0)
-		goto fail;
-
-	return dma_addr + offset;
-fail:
-	__free_iova(mapping, dma_addr, len);
-	return DMA_ERROR_CODE;
-}
-
-/**
- * arm_iommu_map_page
- * @dev: valid struct device pointer
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * IOMMU aware version of arm_dma_map_page()
- */
-static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     struct dma_attrs *attrs)
-{
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__dma_page_cpu_to_dev(page, offset, size, dir);
-
-	return arm_coherent_iommu_map_page(dev, page, offset, size, dir, attrs);
-}
-
-/**
- * arm_coherent_iommu_unmap_page
- * @dev: valid struct device pointer
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_page)
- * @dir: DMA transfer direction (same as passed to dma_map_page)
- *
- * Coherent IOMMU aware version of arm_dma_unmap_page()
- */
-static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = handle & PAGE_MASK;
-	int offset = handle & ~PAGE_MASK;
-	int len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
-}
-
-/**
- * arm_iommu_unmap_page
- * @dev: valid struct device pointer
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_page)
- * @dir: DMA transfer direction (same as passed to dma_map_page)
- *
- * IOMMU aware version of arm_dma_unmap_page()
- */
-static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
-	int offset = handle & ~PAGE_MASK;
-	int len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__dma_page_dev_to_cpu(page, offset, size, dir);
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
-}
-
-static void arm_iommu_sync_single_for_cpu(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
-	unsigned int offset = handle & ~PAGE_MASK;
-
-	if (!iova)
-		return;
-
-	__dma_page_dev_to_cpu(page, offset, size, dir);
-}
-
-static void arm_iommu_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
-	unsigned int offset = handle & ~PAGE_MASK;
-
-	if (!iova)
-		return;
-
-	__dma_page_cpu_to_dev(page, offset, size, dir);
-}
-
-struct dma_map_ops iommu_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
-	.free		= arm_iommu_free_attrs,
-	.mmap		= arm_iommu_mmap_attrs,
-	.get_sgtable	= arm_iommu_get_sgtable,
-
-	.map_page		= arm_iommu_map_page,
-	.unmap_page		= arm_iommu_unmap_page,
-	.sync_single_for_cpu	= arm_iommu_sync_single_for_cpu,
-	.sync_single_for_device	= arm_iommu_sync_single_for_device,
-
-	.map_sg			= arm_iommu_map_sg,
-	.unmap_sg		= arm_iommu_unmap_sg,
-	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
-	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
-
-	.set_dma_mask		= arm_dma_set_mask,
-};
-
-struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
-	.free		= arm_iommu_free_attrs,
-	.mmap		= arm_iommu_mmap_attrs,
-	.get_sgtable	= arm_iommu_get_sgtable,
-
-	.map_page	= arm_coherent_iommu_map_page,
-	.unmap_page	= arm_coherent_iommu_unmap_page,
-
-	.map_sg		= arm_coherent_iommu_map_sg,
-	.unmap_sg	= arm_coherent_iommu_unmap_sg,
-
-	.set_dma_mask	= arm_dma_set_mask,
-};
-
-/**
- * arm_iommu_create_mapping
- * @bus: pointer to the bus holding the client device (for IOMMU calls)
- * @base: start address of the valid IO address space
- * @size: maximum size of the valid IO address space
- *
- * Creates a mapping structure which holds information about used/unused
- * IO address ranges, which is required to perform memory allocation and
- * mapping with IOMMU aware functions.
- *
- * The client device need to be attached to the mapping with
- * arm_iommu_attach_device function.
- */
-struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size)
-{
-	unsigned int bits = size >> PAGE_SHIFT;
-	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
-	struct dma_iommu_mapping *mapping;
-	int extensions = 1;
-	int err = -ENOMEM;
-
-	/* currently only 32-bit DMA address space is supported */
-	if (size > DMA_BIT_MASK(32) + 1)
-		return ERR_PTR(-ERANGE);
-
-	if (!bitmap_size)
-		return ERR_PTR(-EINVAL);
-
-	if (bitmap_size > PAGE_SIZE) {
-		extensions = bitmap_size / PAGE_SIZE;
-		bitmap_size = PAGE_SIZE;
-	}
-
-	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
-	if (!mapping)
-		goto err;
-
-	mapping->bitmap_size = bitmap_size;
-	mapping->bitmaps = kzalloc(extensions * sizeof(unsigned long *),
-				GFP_KERNEL);
-	if (!mapping->bitmaps)
-		goto err2;
-
-	mapping->bitmaps[0] = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!mapping->bitmaps[0])
-		goto err3;
-
-	mapping->nr_bitmaps = 1;
-	mapping->extensions = extensions;
-	mapping->base = base;
-	mapping->bits = BITS_PER_BYTE * bitmap_size;
-
-	spin_lock_init(&mapping->lock);
-
-	mapping->domain = iommu_domain_alloc(bus);
-	if (!mapping->domain)
-		goto err4;
-
-	kref_init(&mapping->kref);
-	return mapping;
-err4:
-	kfree(mapping->bitmaps[0]);
-err3:
-	kfree(mapping->bitmaps);
-err2:
-	kfree(mapping);
-err:
-	return ERR_PTR(err);
-}
-EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
-
-static void release_iommu_mapping(struct kref *kref)
-{
-	int i;
-	struct dma_iommu_mapping *mapping =
-		container_of(kref, struct dma_iommu_mapping, kref);
-
-	iommu_domain_free(mapping->domain);
-	for (i = 0; i < mapping->nr_bitmaps; i++)
-		kfree(mapping->bitmaps[i]);
-	kfree(mapping->bitmaps);
-	kfree(mapping);
-}
-
-static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
-{
-	int next_bitmap;
-
-	if (mapping->nr_bitmaps >= mapping->extensions)
-		return -EINVAL;
-
-	next_bitmap = mapping->nr_bitmaps;
-	mapping->bitmaps[next_bitmap] = kzalloc(mapping->bitmap_size,
-						GFP_ATOMIC);
-	if (!mapping->bitmaps[next_bitmap])
-		return -ENOMEM;
-
-	mapping->nr_bitmaps++;
-
-	return 0;
-}
-
-void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
-{
-	if (mapping)
-		kref_put(&mapping->kref, release_iommu_mapping);
-}
-EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
-
-static int __arm_iommu_attach_device(struct device *dev,
-				     struct dma_iommu_mapping *mapping)
-{
-	int err;
-
-	err = iommu_attach_device(mapping->domain, dev);
-	if (err)
-		return err;
-
-	kref_get(&mapping->kref);
-	to_dma_iommu_mapping(dev) = mapping;
-
-	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
-	return 0;
-}
-
-/**
- * arm_iommu_attach_device
- * @dev: valid struct device pointer
- * @mapping: io address space mapping structure (returned from
- *	arm_iommu_create_mapping)
- *
- * Attaches specified io address space mapping to the provided device.
- * This replaces the dma operations (dma_map_ops pointer) with the
- * IOMMU aware version.
- *
- * More than one client might be attached to the same io address space
- * mapping.
- */
-int arm_iommu_attach_device(struct device *dev,
-			    struct dma_iommu_mapping *mapping)
-{
-	int err;
-
-	err = __arm_iommu_attach_device(dev, mapping);
-	if (err)
-		return err;
-
-	set_dma_ops(dev, &iommu_ops);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
-
-static void __arm_iommu_detach_device(struct device *dev)
-{
-	struct dma_iommu_mapping *mapping;
-
-	mapping = to_dma_iommu_mapping(dev);
-	if (!mapping) {
-		dev_warn(dev, "Not attached\n");
-		return;
-	}
-
-	iommu_detach_device(mapping->domain, dev);
-	kref_put(&mapping->kref, release_iommu_mapping);
-	to_dma_iommu_mapping(dev) = NULL;
-
-	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
-}
-
-/**
- * arm_iommu_detach_device
- * @dev: valid struct device pointer
- *
- * Detaches the provided device from a previously attached map.
- * This voids the dma operations (dma_map_ops pointer)
- */
-void arm_iommu_detach_device(struct device *dev)
-{
-	__arm_iommu_detach_device(dev);
-	set_dma_ops(dev, NULL);
-}
-EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
-
-static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
-{
-	return coherent ? &iommu_coherent_ops : &iommu_ops;
-}
-
-static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    struct iommu_ops *iommu)
-{
-	struct dma_iommu_mapping *mapping;
-
-	if (!iommu)
-		return false;
-
-	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
-	if (IS_ERR(mapping)) {
-		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
-				size, dev_name(dev));
-		return false;
-	}
-
-	if (__arm_iommu_attach_device(dev, mapping)) {
-		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
-				dev_name(dev));
-		arm_iommu_release_mapping(mapping);
-		return false;
-	}
-
-	return true;
-}
-
-static void arm_teardown_iommu_dma_ops(struct device *dev)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-
-	if (!mapping)
-		return;
-
-	__arm_iommu_detach_device(dev);
-	arm_iommu_release_mapping(mapping);
-}
-
-#else
-
-static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    struct iommu_ops *iommu)
-{
-	return false;
-}
-
-static void arm_teardown_iommu_dma_ops(struct device *dev) { }
-
-#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
-
-#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
-
 static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
@@ -2123,18 +1010,13 @@ static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent)
 {
-	struct dma_map_ops *dma_ops;
-
 	dev->archdata.dma_coherent = coherent;
-	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
-		dma_ops = arm_get_iommu_dma_map_ops(coherent);
-	else
-		dma_ops = arm_get_dma_map_ops(coherent);
 
-	set_dma_ops(dev, dma_ops);
+	if (!common_iommu_setup_dma_ops(dev, dma_base, size, iommu))
+		arch_set_dma_ops(dev, arm_get_dma_map_ops(coherent));
 }
 
 void arch_teardown_dma_ops(struct device *dev)
 {
-	arm_teardown_iommu_dma_ops(dev);
+	common_iommu_teardown_dma_ops(dev);
 }
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 85739859dffc..7bdb5cf64ba3 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -1,5 +1,6 @@
 config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
+	depends on BROKEN
 	depends on DRM && ROCKCHIP_IOMMU
 	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1674de1cfed0..8a99210f1cbc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -265,6 +265,7 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
+	depends on BROKEN
 	depends on ARM_LPAE
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select IOMMU_API
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 8b89ebe16d94..fb8bb372e489 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -88,6 +88,7 @@ config VIDEO_OMAP3
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && ARCH_OMAP3
 	depends on HAS_DMA && OF
 	depends on OMAP_IOMMU
+	depends on BROKEN
 	select ARM_DMA_USE_IOMMU
 	select VIDEOBUF2_DMA_CONTIG
 	select MFD_SYSCON
-- 
1.9.2

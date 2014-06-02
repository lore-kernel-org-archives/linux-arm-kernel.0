From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Mon, 2 Jun 2014 15:49:23 +0530
Subject: [PATCH 4/4] arm:dma-iommu: Move out complete func defs
In-Reply-To: <1401704363-31052-4-git-send-email-ritesh.harjani@gmail.com>
References: <1401704363-31052-1-git-send-email-ritesh.harjani@gmail.com>
 <1401704363-31052-2-git-send-email-ritesh.harjani@gmail.com>
 <1401704363-31052-3-git-send-email-ritesh.harjani@gmail.com>
 <1401704363-31052-4-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1401704363-31052-5-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Move out complete function definations from
arch/arm/dma-mapping to lib/iommu-helper

1. Moved out iova alloc/free routine and make them
statically defined.

2. Moved out complete function definations calling
for alloc/free_iova routing to lib/iommu-helper.c

3. Seprated out cache maintainance from iommu_map/unmap
function routine, to be called from within arch/arm/dma-mapping.c

Change-Id: I6abfa820fe1450b7de70de1a1ace15263a29dfc4
Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm/Kconfig             |  42 ++---
 arch/arm/mm/dma-mapping.c    | 362 +++----------------------------------------
 include/linux/iommu-helper.h |  28 +++-
 lib/iommu-helper.c           | 329 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 399 insertions(+), 362 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 20717fb..977427d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -80,27 +80,6 @@ config ARM_DMA_USE_IOMMU
 	select NEED_SG_DMA_LENGTH
 	select DMA_USE_IOMMU_HELPER_MAPPING
 
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
-
 config HAVE_PWM
 	bool
 
@@ -1949,6 +1928,27 @@ config IOMMU_HELPER
 config DMA_USE_IOMMU_HELPER_MAPPING
 	def_bool n
 
+if DMA_USE_IOMMU_HELPER_MAPPING
+
+config DMA_IOMMU_ALIGNMENT
+	int "Maximum PAGE_SIZE order of alignment for DMA IOMMU buffers"
+	range 4 9
+	default 8
+	help
+	  DMA mapping framework by default aligns all buffers to the smallest
+	  PAGE_SIZE order which is greater than or equal to the requested buffer
+	  size. This works well for buffers up to a few hundreds kilobytes, but
+	  for larger buffers it just a waste of address space. Drivers which has
+	  relatively small addressing window (like 64Mib) might run out of
+	  virtual space with just a few allocations.
+
+	  With this parameter you can specify the maximum PAGE_SIZE order for
+	  DMA IOMMU buffers. Larger buffers will be aligned only to this
+	  specified order. The order is expressed as a power of two multiplied
+	  by the PAGE_SIZE.
+
+endif
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 268004c..6546fba 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1066,101 +1066,6 @@ fs_initcall(dma_debug_do_init);
 
 /* IOMMU */
 
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
 /*
  * Create a CPU mapping for a specified pages
  */
@@ -1194,62 +1099,6 @@ err:
 	return NULL;
 }
 
-/*
- * Create a mapping in device IO address space for specified pages
- */
-static dma_addr_t
-__iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
-{
-	struct dma_iommu_mapping *mapping = dev->mapping;
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	dma_addr_t dma_addr, iova;
-	int i, ret = DMA_ERROR_CODE;
-
-	dma_addr = __alloc_iova(mapping, size);
-	if (dma_addr == DMA_ERROR_CODE)
-		return dma_addr;
-
-	iova = dma_addr;
-	for (i = 0; i < count; ) {
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
-	struct dma_iommu_mapping *mapping = dev->mapping;
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
 static struct page **__atomic_get_pages(void *addr)
 {
 	struct dma_pool *pool = &atomic_pool;
@@ -1421,120 +1270,6 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 					 GFP_KERNEL);
 }
 
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
-	struct dma_iommu_mapping *mapping = dev->mapping;
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
 /**
  * arm_coherent_iommu_map_sg - map a set of SG buffers for streaming mode DMA
  * @dev: valid struct device pointer
@@ -1550,7 +1285,7 @@ bad_mapping:
 int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
+	return __iommu_map_sg(dev, sg, nents, dir, attrs);
 }
 
 /**
@@ -1568,25 +1303,15 @@ int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
-}
-
-static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
-		bool is_coherent)
-{
 	struct scatterlist *s;
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
+	int i, ret;
+	ret = __iommu_map_sg(dev, sg, nents, dir, attrs);
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs)) {
+		for_each_sg(sg, s, ret, i)
+			__dma_page_cpu_to_dev(sg_page(s), s->offset,
+					s->length, dir);
 	}
+	return ret;
 }
 
 /**
@@ -1602,7 +1327,7 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
 void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
+	__iommu_unmap_sg(dev, sg, nents, dir, attrs);
 }
 
 /**
@@ -1618,7 +1343,16 @@ void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
 void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 			enum dma_data_direction dir, struct dma_attrs *attrs)
 {
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
+	struct scatterlist *s;
+	int i;
+
+	__iommu_unmap_sg(dev, sg, nents, dir, attrs);
+
+	for_each_sg(sg, s, nents, i) {
+		if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+			__dma_page_dev_to_cpu(sg_page(s), s->offset,
+					      s->length, dir);
+	}
 }
 
 /**
@@ -1671,24 +1405,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->mapping;
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
+	return __iommu_map_page(dev, page, offset, size, dir);
 }
 
 /**
@@ -1708,7 +1425,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
 
-	return arm_coherent_iommu_map_page(dev, page, offset, size, dir, attrs);
+	return __iommu_map_page(dev, page, offset, size, dir);
 }
 
 /**
@@ -1724,16 +1441,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->mapping;
-	dma_addr_t iova = handle & PAGE_MASK;
-	int offset = handle & ~PAGE_MASK;
-	int len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
+	__iommu_unmap_page(dev, handle, size, dir);
 }
 
 /**
@@ -1753,16 +1461,12 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	int offset = handle & ~PAGE_MASK;
-	int len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
 
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(page, offset, size, dir);
 
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
+	__iommu_unmap_page(dev, handle, size, dir);
+
 }
 
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
@@ -1848,24 +1552,6 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
-static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
-{
-	int next_bitmap;
-
-	if (mapping->nr_bitmaps > mapping->extensions)
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
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
 	__iommu_release_mapping(mapping);
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index b27b7cb8..1e2e5f2 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -5,6 +5,12 @@
 #include <linux/dma-attrs.h>
 
 #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
+#include <linux/mm_types.h>
+#include <linux/dma-debug.h>
+#include <linux/kmemcheck.h>
+#include <linux/kref.h>
+#include <linux/dma-mapping.h>
+
 struct dma_iommu_mapping {
 	/* iommu specific data */
 	struct iommu_domain	*domain;
@@ -20,6 +26,25 @@ struct dma_iommu_mapping {
 	struct kref		kref;
 };
 
+extern dma_addr_t __iommu_create_mapping(struct device *dev, struct page **pages,
+					size_t size);
+
+extern int __iommu_remove_mapping(struct device *dev, dma_addr_t iova,
+				size_t size);
+
+extern dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir);
+
+extern void __iommu_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir);
+
+extern int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		     enum dma_data_direction dir, struct dma_attrs *attrs);
+
+extern void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir,
+		struct dma_attrs *attrs);
+
 extern struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 					  gfp_t gfp, struct dma_attrs *attrs,
 			void (*arch_clear_buffer_cb)(struct page*, size_t));
@@ -29,14 +54,13 @@ extern int __iommu_free_buffer(struct device *dev, struct page **pages,
 
 extern void __iommu_detach_device(struct device *dev);
 
-extern void __iommu_release_mapping(struct dma_iommu_mapping *mapping);
-
 extern int __iommu_attach_device(struct device *dev,
 			    struct dma_iommu_mapping *mapping);
 
 extern struct dma_iommu_mapping *
 __iommu_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
 
+extern void __iommu_release_mapping(struct dma_iommu_mapping *mapping);
 #define to_dma_iommu_mapping(dev) ((dev)->mapping)
 #else
 #define to_dma_iommu_mapping(dev) NULL
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index e0f643a..75d900e 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -8,13 +8,14 @@
 
 #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
 #include <linux/iommu.h>
-#include <linux/device.h>
 #include <linux/iommu-helper.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
 #include <linux/dma-contiguous.h>
 #include <linux/mm.h>
+
+#include <asm/dma-mapping.h>
 #endif
 
 int iommu_is_span_boundary(unsigned int index, unsigned int nr,
@@ -53,6 +54,195 @@ EXPORT_SYMBOL(iommu_area_alloc);
 
 #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
 
+/* IOMMU */
+static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
+{
+	int next_bitmap;
+
+	if (mapping->nr_bitmaps > mapping->extensions)
+		return -EINVAL;
+
+	next_bitmap = mapping->nr_bitmaps;
+	mapping->bitmaps[next_bitmap] = kzalloc(mapping->bitmap_size,
+						GFP_ATOMIC);
+	if (!mapping->bitmaps[next_bitmap])
+		return -ENOMEM;
+
+	mapping->nr_bitmaps++;
+
+	return 0;
+}
+
+static int __dma_direction_to_prot(enum dma_data_direction dir)
+{
+	int prot;
+
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		prot = IOMMU_READ | IOMMU_WRITE;
+		break;
+	case DMA_TO_DEVICE:
+		prot = IOMMU_READ;
+		break;
+	case DMA_FROM_DEVICE:
+		prot = IOMMU_WRITE;
+		break;
+	default:
+		prot = 0;
+	}
+
+	return prot;
+}
+
+static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
+				      size_t size)
+{
+	unsigned int order = get_order(size);
+	unsigned int align = 0;
+	unsigned int count, start;
+	size_t mapping_size = mapping->bits << PAGE_SHIFT;
+	unsigned long flags;
+	dma_addr_t iova;
+	int i;
+
+	if (order > CONFIG_DMA_IOMMU_ALIGNMENT)
+		order = CONFIG_DMA_IOMMU_ALIGNMENT;
+
+	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	align = (1 << order) - 1;
+
+	spin_lock_irqsave(&mapping->lock, flags);
+	for (i = 0; i < mapping->nr_bitmaps; i++) {
+		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
+				mapping->bits, 0, count, align);
+
+		if (start > mapping->bits)
+			continue;
+
+		bitmap_set(mapping->bitmaps[i], start, count);
+		break;
+	}
+
+	/*
+	 * No unused range found. Try to extend the existing mapping
+	 * and perform a second attempt to reserve an IO virtual
+	 * address range of size bytes.
+	 */
+	if (i == mapping->nr_bitmaps) {
+		if (extend_iommu_mapping(mapping)) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return DMA_ERROR_CODE;
+		}
+
+		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
+				mapping->bits, 0, count, align);
+
+		if (start > mapping->bits) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return DMA_ERROR_CODE;
+		}
+
+		bitmap_set(mapping->bitmaps[i], start, count);
+	}
+	spin_unlock_irqrestore(&mapping->lock, flags);
+
+	iova = mapping->base + (mapping_size * i);
+	iova += start << PAGE_SHIFT;
+
+	return iova;
+}
+
+static inline void __free_iova(struct dma_iommu_mapping *mapping,
+			       dma_addr_t addr, size_t size)
+{
+	unsigned int start, count;
+	size_t mapping_size = mapping->bits << PAGE_SHIFT;
+	unsigned long flags;
+	dma_addr_t bitmap_base;
+	u32 bitmap_index;
+
+	if (!size)
+		return;
+
+	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping_size;
+	BUG_ON(addr < mapping->base || bitmap_index > mapping->extensions);
+
+	bitmap_base = mapping->base + mapping_size * bitmap_index;
+
+	start = (addr - bitmap_base) >>	PAGE_SHIFT;
+
+	if (addr + size > bitmap_base + mapping_size) {
+		/*
+		 * The address range to be freed reaches into the iova
+		 * range of the next bitmap. This should not happen as
+		 * we don't allow this in __alloc_iova (at the
+		 * moment).
+		 */
+		BUG();
+	} else
+		count = size >> PAGE_SHIFT;
+
+	spin_lock_irqsave(&mapping->lock, flags);
+	bitmap_clear(mapping->bitmaps[bitmap_index], start, count);
+	spin_unlock_irqrestore(&mapping->lock, flags);
+}
+
+/*
+ * Create a mapping in device IO address space for specified pages
+ */
+dma_addr_t
+__iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
+{
+	struct dma_iommu_mapping *mapping = dev->mapping;
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	dma_addr_t dma_addr, iova;
+	int i, ret = DMA_ERROR_CODE;
+
+	dma_addr = __alloc_iova(mapping, size);
+	if (dma_addr == DMA_ERROR_CODE)
+		return dma_addr;
+
+	iova = dma_addr;
+	for (i = 0; i < count; ) {
+		unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
+		phys_addr_t phys = page_to_phys(pages[i]);
+		unsigned int len, j;
+
+		for (j = i + 1; j < count; j++, next_pfn++)
+			if (page_to_pfn(pages[j]) != next_pfn)
+				break;
+
+		len = (j - i) << PAGE_SHIFT;
+		ret = iommu_map(mapping->domain, iova, phys, len,
+				IOMMU_READ|IOMMU_WRITE);
+		if (ret < 0)
+			goto fail;
+		iova += len;
+		i = j;
+	}
+	return dma_addr;
+fail:
+	iommu_unmap(mapping->domain, dma_addr, iova-dma_addr);
+	__free_iova(mapping, dma_addr, size);
+	return DMA_ERROR_CODE;
+}
+
+int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t size)
+{
+	struct dma_iommu_mapping *mapping = dev->mapping;
+
+	/*
+	 * add optional in-page offset from iova to size and align
+	 * result to page size
+	 */
+	size = PAGE_ALIGN((iova & ~PAGE_MASK) + size);
+	iova &= PAGE_MASK;
+
+	iommu_unmap(mapping->domain, iova, size);
+	__free_iova(mapping, iova, size);
+	return 0;
+}
+
 struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 					  gfp_t gfp, struct dma_attrs *attrs,
 			void (*arch_clear_buffer_cb)(struct page*, size_t))
@@ -146,6 +336,143 @@ int __iommu_free_buffer(struct device *dev, struct page **pages,
 	return 0;
 }
 
+/*
+ * Map a part of the scatter-gather list into contiguous io address space
+ */
+static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
+			  size_t size, dma_addr_t *handle,
+			  enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping = dev->mapping;
+	dma_addr_t iova, iova_base;
+	int ret = 0;
+	unsigned int count;
+	struct scatterlist *s;
+	int prot;
+
+	size = PAGE_ALIGN(size);
+	*handle = DMA_ERROR_CODE;
+
+	iova_base = iova = __alloc_iova(mapping, size);
+	if (iova == DMA_ERROR_CODE)
+		return -ENOMEM;
+
+	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
+		phys_addr_t phys = page_to_phys(sg_page(s));
+		unsigned int len = PAGE_ALIGN(s->offset + s->length);
+
+		prot = __dma_direction_to_prot(dir);
+
+		ret = iommu_map(mapping->domain, iova, phys, len, prot);
+		if (ret < 0)
+			goto fail;
+		count += len >> PAGE_SHIFT;
+		iova += len;
+	}
+	*handle = iova_base;
+
+	return 0;
+fail:
+	iommu_unmap(mapping->domain, iova_base, count * PAGE_SIZE);
+	__free_iova(mapping, iova_base, size);
+	return ret;
+}
+
+int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		     enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *s = sg, *dma = sg, *start = sg;
+	int i, count = 0;
+	unsigned int offset = s->offset;
+	unsigned int size = s->offset + s->length;
+	unsigned int max = dma_get_max_seg_size(dev);
+
+	for (i = 1; i < nents; i++) {
+		s = sg_next(s);
+
+		s->dma_address = DMA_ERROR_CODE;
+		s->dma_length = 0;
+
+		if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
+			if (__map_sg_chunk(dev, start, size, &dma->dma_address,
+			    dir, attrs) < 0)
+				goto bad_mapping;
+
+			dma->dma_address += offset;
+			dma->dma_length = size - offset;
+
+			size = offset = s->offset;
+			start = s;
+			dma = sg_next(dma);
+			count += 1;
+		}
+		size += s->length;
+	}
+	if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs) < 0)
+		goto bad_mapping;
+
+	dma->dma_address += offset;
+	dma->dma_length = size - offset;
+
+	return count+1;
+
+bad_mapping:
+	for_each_sg(sg, s, count, i)
+		__iommu_remove_mapping(dev, sg_dma_address(s), sg_dma_len(s));
+	return 0;
+}
+
+void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		if (sg_dma_len(s))
+			__iommu_remove_mapping(dev, sg_dma_address(s),
+					       sg_dma_len(s));
+}
+}
+
+dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir)
+{
+	struct dma_iommu_mapping *mapping = dev->mapping;
+	dma_addr_t dma_addr;
+	int ret, prot, len = PAGE_ALIGN(size + offset);
+
+	dma_addr = __alloc_iova(mapping, len);
+	if (dma_addr == DMA_ERROR_CODE)
+		return dma_addr;
+
+	prot = __dma_direction_to_prot(dir);
+
+	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
+	if (ret < 0)
+		goto fail;
+
+	return dma_addr + offset;
+fail:
+	__free_iova(mapping, dma_addr, len);
+	return DMA_ERROR_CODE;
+}
+
+void __iommu_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir)
+{
+	struct dma_iommu_mapping *mapping = dev->mapping;
+	dma_addr_t iova = handle & PAGE_MASK;
+	int offset = handle & ~PAGE_MASK;
+	int len = PAGE_ALIGN(size + offset);
+
+	if (!iova)
+		return;
+
+	iommu_unmap(mapping->domain, iova, len);
+	__free_iova(mapping, iova, len);
+}
+
 /**
  * __iommu_init_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
-- 
1.8.1.3

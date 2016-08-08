From: labbott@redhat.com (Laura Abbott)
Date: Mon,  8 Aug 2016 10:49:34 -0700
Subject: [RFCv2][PATCH 2/5] arm: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <1470678577-14010-1-git-send-email-labbott@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
Message-ID: <1470678577-14010-3-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm may need the kernel_force_cache APIs to guarantee data consistency.
Implement versions of these APIs based on the DMA APIs.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm/include/asm/cacheflush.h |   4 ++
 arch/arm/mm/dma-mapping.c         | 119 --------------------------------------
 arch/arm/mm/flush.c               | 115 ++++++++++++++++++++++++++++++++++++
 arch/arm/mm/mm.h                  |   8 +++
 4 files changed, 127 insertions(+), 119 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 9156fc3..78eb011 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -518,4 +518,8 @@ static inline void secure_flush_area(const void *addr, size_t size)
 	outer_flush_range(phys, phys + size);
 }
 
+#define ARCH_HAS_FORCE_CACHE 1
+void kernel_force_cache_clean(struct page *page, size_t size);
+void kernel_force_cache_invalidate(struct page *page, size_t size);
+
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c6834c0..8c9296d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -95,23 +95,6 @@ static struct arm_dma_buffer *arm_dma_buffer_find(void *virt)
 	return found;
 }
 
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
@@ -945,108 +928,6 @@ int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return 0;
 }
 
-static void dma_cache_maint_page(struct page *page, unsigned long offset,
-	size_t size, enum dma_data_direction dir,
-	void (*op)(const void *, size_t, int))
-{
-	unsigned long pfn;
-	size_t left = size;
-
-	pfn = page_to_pfn(page) + offset / PAGE_SIZE;
-	offset %= PAGE_SIZE;
-
-	/*
-	 * A single sg entry may refer to multiple physically contiguous
-	 * pages.  But we still need to process highmem pages individually.
-	 * If highmem is not configured then the bulk of this loop gets
-	 * optimized out.
-	 */
-	do {
-		size_t len = left;
-		void *vaddr;
-
-		page = pfn_to_page(pfn);
-
-		if (PageHighMem(page)) {
-			if (len + offset > PAGE_SIZE)
-				len = PAGE_SIZE - offset;
-
-			if (cache_is_vipt_nonaliasing()) {
-				vaddr = kmap_atomic(page);
-				op(vaddr + offset, len, dir);
-				kunmap_atomic(vaddr);
-			} else {
-				vaddr = kmap_high_get(page);
-				if (vaddr) {
-					op(vaddr + offset, len, dir);
-					kunmap_high(page);
-				}
-			}
-		} else {
-			vaddr = page_address(page) + offset;
-			op(vaddr, len, dir);
-		}
-		offset = 0;
-		pfn++;
-		left -= len;
-	} while (left);
-}
-
-/*
- * Make an area consistent for devices.
- * Note: Drivers should NOT use this function directly, as it will break
- * platforms with CONFIG_DMABOUNCE.
- * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
- */
-static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
-	size_t size, enum dma_data_direction dir)
-{
-	phys_addr_t paddr;
-
-	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
-
-	paddr = page_to_phys(page) + off;
-	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
-	} else {
-		outer_clean_range(paddr, paddr + size);
-	}
-	/* FIXME: non-speculating: flush on bidirectional mappings? */
-}
-
-static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
-	size_t size, enum dma_data_direction dir)
-{
-	phys_addr_t paddr = page_to_phys(page) + off;
-
-	/* FIXME: non-speculating: not required */
-	/* in any case, don't bother invalidating if DMA to device */
-	if (dir != DMA_TO_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
-
-		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
-	}
-
-	/*
-	 * Mark the D-cache clean for these pages to avoid extra flushing.
-	 */
-	if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
-		unsigned long pfn;
-		size_t left = size;
-
-		pfn = page_to_pfn(page) + off / PAGE_SIZE;
-		off %= PAGE_SIZE;
-		if (off) {
-			pfn++;
-			left -= PAGE_SIZE - off;
-		}
-		while (left >= PAGE_SIZE) {
-			page = pfn_to_page(pfn++);
-			set_bit(PG_dcache_clean, &page->flags);
-			left -= PAGE_SIZE;
-		}
-	}
-}
 
 /**
  * arm_dma_map_sg - map a set of SG buffers for streaming mode DMA
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 3cced84..2b8b705 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
@@ -20,6 +21,7 @@
 #include <linux/hugetlb.h>
 
 #include "mm.h"
+#include "dma.h"
 
 #ifdef CONFIG_ARM_HEAVY_MB
 void (*soc_mb)(void);
@@ -415,3 +417,116 @@ void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned l
 	 */
 	__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
 }
+
+static void dma_cache_maint_page(struct page *page, unsigned long offset,
+	size_t size, enum dma_data_direction dir,
+	void (*op)(const void *, size_t, int))
+{
+	unsigned long pfn;
+	size_t left = size;
+
+	pfn = page_to_pfn(page) + offset / PAGE_SIZE;
+	offset %= PAGE_SIZE;
+
+	/*
+	 * A single sg entry may refer to multiple physically contiguous
+	 * pages.  But we still need to process highmem pages individually.
+	 * If highmem is not configured then the bulk of this loop gets
+	 * optimized out.
+	 */
+	do {
+		size_t len = left;
+		void *vaddr;
+
+		page = pfn_to_page(pfn);
+
+		if (PageHighMem(page)) {
+			if (len + offset > PAGE_SIZE)
+				len = PAGE_SIZE - offset;
+
+			if (cache_is_vipt_nonaliasing()) {
+				vaddr = kmap_atomic(page);
+				op(vaddr + offset, len, dir);
+				kunmap_atomic(vaddr);
+			} else {
+				vaddr = kmap_high_get(page);
+				if (vaddr) {
+					op(vaddr + offset, len, dir);
+					kunmap_high(page);
+				}
+			}
+		} else {
+			vaddr = page_address(page) + offset;
+			op(vaddr, len, dir);
+		}
+		offset = 0;
+		pfn++;
+		left -= len;
+	} while (left);
+}
+
+/*
+ * Make an area consistent for devices.
+ * Note: Drivers should NOT use this function directly, as it will break
+ * platforms with CONFIG_DMABOUNCE.
+ * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
+ */
+void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t paddr;
+
+	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
+
+	paddr = page_to_phys(page) + off;
+	if (dir == DMA_FROM_DEVICE) {
+		outer_inv_range(paddr, paddr + size);
+	} else {
+		outer_clean_range(paddr, paddr + size);
+	}
+	/* FIXME: non-speculating: flush on bidirectional mappings? */
+}
+
+void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t paddr = page_to_phys(page) + off;
+
+	/* FIXME: non-speculating: not required */
+	/* in any case, don't bother invalidating if DMA to device */
+	if (dir != DMA_TO_DEVICE) {
+		outer_inv_range(paddr, paddr + size);
+
+		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
+	}
+
+	/*
+	 * Mark the D-cache clean for these pages to avoid extra flushing.
+	 */
+	if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
+		unsigned long pfn;
+		size_t left = size;
+
+		pfn = page_to_pfn(page) + off / PAGE_SIZE;
+		off %= PAGE_SIZE;
+		if (off) {
+			pfn++;
+			left -= PAGE_SIZE - off;
+		}
+		while (left >= PAGE_SIZE) {
+			page = pfn_to_page(pfn++);
+			set_bit(PG_dcache_clean, &page->flags);
+			left -= PAGE_SIZE;
+		}
+	}
+}
+
+void kernel_force_cache_clean(struct page *page, size_t size)
+{
+	__dma_page_cpu_to_dev(page, 0, size, DMA_BIDIRECTIONAL);
+}
+
+void kernel_force_cache_invalidate(struct page *page, size_t size)
+{
+	__dma_page_dev_to_cpu(page, 0, size, DMA_BIDIRECTIONAL);
+}
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index ce727d4..9b853ac 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -1,9 +1,11 @@
 #ifdef CONFIG_MMU
 #include <linux/list.h>
 #include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/pgtable.h>
 
+
 /* the upper-most page table pointer */
 extern pmd_t *top_pmd;
 
@@ -97,3 +99,9 @@ void arm_mm_memblock_reserve(void);
 void dma_contiguous_remap(void);
 
 unsigned long __clear_cr(unsigned long mask);
+
+void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir);
+
+void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+	size_t size, enum dma_data_direction dir);
-- 
2.7.4

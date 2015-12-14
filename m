From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 14 Dec 2015 15:17:39 -0800
Subject: [for-4.4-rc6 PATCH] scatterlist: fix sg_phys() masking
Message-ID: <20151214231739.10377.11843.stgit@dwillia2-desk3.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit db0fa0cb0157 "scatterlist: use sg_phys()" did replacements of the
form:

    phys_addr_t phys = page_to_phys(sg_page(s));
    phys_addr_t phys = sg_phys(s) & PAGE_MASK;

However, this breaks platforms where sizeof(phys_addr_t) >
sizeof(unsigned long).  Since PAGE_MASK is an unsigned long this
inadvertently masks the high bits returned by sg_phys().  Convert to
PHYSICAL_PAGE_MASK in these cases which will do the proper sign
extension.

As caught by the kbuild robot, a generic fallback definition of
PHYSICAL_PAGE_MASK is needed for several archs.

Cc: <stable@vger.kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Vitaly Lavrov <vel21ripn@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm/mm/dma-mapping.c                    |    2 +-
 drivers/iommu/intel-iommu.c                  |    2 +-
 drivers/staging/android/ion/ion_chunk_heap.c |    4 ++--
 include/linux/mm.h                           |   12 ++++++++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e62400e5fb99..3eec6cbe9995 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1521,7 +1521,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		return -ENOMEM;
 
 	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
-		phys_addr_t phys = sg_phys(s) & PAGE_MASK;
+		phys_addr_t phys = sg_phys(s) & PHYSICAL_PAGE_MASK;
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
 		if (!is_coherent &&
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f1042daef9ad..f3bc16c5ac70 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2159,7 +2159,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			sg_res = aligned_nrpages(sg->offset, sg->length);
 			sg->dma_address = ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + sg->offset;
 			sg->dma_length = sg->length;
-			pteval = (sg_phys(sg) & PAGE_MASK) | prot;
+			pteval = (sg_phys(sg) & PHYSICAL_PAGE_MASK) | prot;
 			phys_pfn = pteval >> VTD_PAGE_SHIFT;
 		}
 
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 195c41d7bd53..b5bb0aa26a3f 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -81,7 +81,7 @@ static int ion_chunk_heap_allocate(struct ion_heap *heap,
 err:
 	sg = table->sgl;
 	for (i -= 1; i >= 0; i--) {
-		gen_pool_free(chunk_heap->pool, sg_phys(sg) & PAGE_MASK,
+		gen_pool_free(chunk_heap->pool, sg_phys(sg) & PHYSICAL_PAGE_MASK,
 			      sg->length);
 		sg = sg_next(sg);
 	}
@@ -109,7 +109,7 @@ static void ion_chunk_heap_free(struct ion_buffer *buffer)
 							DMA_BIDIRECTIONAL);
 
 	for_each_sg(table->sgl, sg, table->nents, i) {
-		gen_pool_free(chunk_heap->pool, sg_phys(sg) & PAGE_MASK,
+		gen_pool_free(chunk_heap->pool, sg_phys(sg) & PHYSICAL_PAGE_MASK,
 			      sg->length);
 	}
 	chunk_heap->allocated -= allocated_size;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 00bad7793788..877ca73946a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -90,6 +90,18 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)addr, PAGE_SIZE)
 
+#ifndef PHYSICAL_PAGE_MASK
+/*
+ * Cast *PAGE_MASK to a signed type so that it is sign-extended if
+ * virtual addresses are 32-bits but physical addresses are larger (ie,
+ * 32-bit PAE).
+ *
+ * An arch may redefine this to mask out values outside the max
+ * address-width of the cpu.
+ */
+#define PHYSICAL_PAGE_MASK ((signed long) PAGE_MASK)
+#endif
+
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way

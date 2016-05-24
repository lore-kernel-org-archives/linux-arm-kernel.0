From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 May 2016 08:28:08 +0200
Subject: [PATCH 2/4] ARM: dma-mapping: Constify attrs passed to internal
 functions
In-Reply-To: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464071290-15948-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the non-exported functions do not modify passed dma_attrs so the
pointer can point to const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ff7ed5697d3e..4abc50952451 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -621,7 +621,7 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
-static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
+static inline pgprot_t __get_dma_pgprot(const struct dma_attrs *attrs, pgprot_t prot)
 {
 	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
 			    pgprot_writecombine(prot) :
@@ -732,7 +732,7 @@ static struct arm_dma_allocator remap_allocator = {
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
-			 struct dma_attrs *attrs, const void *caller)
+			 const struct dma_attrs *attrs, const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
@@ -878,7 +878,7 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
  * Free a buffer as defined by the above mapping.
  */
 static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			   dma_addr_t handle, struct dma_attrs *attrs,
+			   dma_addr_t handle, const struct dma_attrs *attrs,
 			   bool is_coherent)
 {
 	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
@@ -1253,7 +1253,8 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 static const int iommu_order_array[] = { 9, 8, 4, 0 };
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
-					  gfp_t gfp, struct dma_attrs *attrs)
+					  gfp_t gfp,
+					  const struct dma_attrs *attrs)
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
@@ -1342,7 +1343,7 @@ error:
 }
 
 static int __iommu_free_buffer(struct device *dev, struct page **pages,
-			       size_t size, struct dma_attrs *attrs)
+			       size_t size, const struct dma_attrs *attrs)
 {
 	int count = size >> PAGE_SHIFT;
 	int i;
@@ -1439,7 +1440,8 @@ static struct page **__atomic_get_pages(void *addr)
 	return (struct page **)page;
 }
 
-static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
+static struct page **__iommu_get_pages(void *cpu_addr,
+				       const struct dma_attrs *attrs)
 {
 	struct vm_struct *area;
 
@@ -1633,8 +1635,8 @@ static int __dma_direction_to_prot(enum dma_data_direction dir)
  */
 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, struct dma_attrs *attrs,
-			  bool is_coherent)
+			  enum dma_data_direction dir,
+			  const struct dma_attrs *attrs, bool is_coherent)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova, iova_base;
@@ -1676,8 +1678,8 @@ fail:
 }
 
 static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, struct dma_attrs *attrs,
-		     bool is_coherent)
+		     enum dma_data_direction dir,
+		     const struct dma_attrs *attrs, bool is_coherent)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
 	int i, count = 0;
@@ -1758,8 +1760,8 @@ int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 }
 
 static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
-		bool is_coherent)
+		int nents, enum dma_data_direction dir,
+		const struct dma_attrs *attrs, bool is_coherent)
 {
 	struct scatterlist *s;
 	int i;
-- 
1.9.1

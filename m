From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 14 Aug 2018 14:04:17 +0100
Subject: [PATCH 2/3] iommu/dma: Use fast DMA domain lookup
In-Reply-To: <cover.1534250425.git.robin.murphy@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
Message-ID: <9223183f5ec32a0a88b9b70800ca7eef8819874a.1534250425.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most parts of iommu-dma already assume they are operating on a default
domain set up by iommu_dma_init_domain(), and can be converted straight
over to avoid the refcounting bottleneck. MSI page mappings may be in
an unmanaged domain with an explicit MSI-only cookie, so retain the
non-specific lookup, but that's OK since they're far from a contended
fast path either way.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8f549bdb866d..a27eedc16b32 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -510,7 +510,7 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count,
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle)
 {
-	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle, size);
+	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	*handle = IOMMU_MAPPING_ERROR;
 }
@@ -537,7 +537,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct page **pages;
@@ -625,9 +625,8 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot)
+		size_t size, int prot, struct iommu_domain *domain)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
 	dma_addr_t iova;
@@ -651,13 +650,14 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
-	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
+			iommu_get_dma_domain(dev));
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
+	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
 /*
@@ -745,7 +745,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
@@ -830,20 +830,21 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		sg = tmp;
 	}
 	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), start, end - start);
+	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
 }
 
 dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
+			iommu_get_dma_domain(dev));
 }
 
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
+	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -869,7 +870,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
 	if (iommu_dma_mapping_error(dev, iova))
 		goto out_free_page;
 
-- 
2.17.1.dirty

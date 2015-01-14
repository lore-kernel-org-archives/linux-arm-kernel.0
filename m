From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 19:13:23 +0000
Subject: [PATCH v2 3/3] ARM: dma-mapping: use to_dma_iommu_mapping instead of
 accessing archdata
In-Reply-To: <1421262803-21003-1-git-send-email-will.deacon@arm.com>
References: <1421262803-21003-1-git-send-email-will.deacon@arm.com>
Message-ID: <1421262803-21003-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the IOMMU-backed DMA ops for a device, we store a pointer to
the dma_iommu_mapping structure (used to keep track of the address
space) in the archdata.mapping field of the struct device.

Rather than access this field directly, use the to_dma_iommu_mapping
helper in dma-mapping, so that we don't really care where the mapping
information is held.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/dma-mapping.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f142ddd6c40a..4dab38fea608 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1206,7 +1206,7 @@ __iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
 static dma_addr_t
 __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	dma_addr_t dma_addr, iova;
 	int i, ret = DMA_ERROR_CODE;
@@ -1242,7 +1242,7 @@ fail:
 
 static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t size)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 
 	/*
 	 * add optional in-page offset from iova to size and align
@@ -1457,7 +1457,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  enum dma_data_direction dir, struct dma_attrs *attrs,
 			  bool is_coherent)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova, iova_base;
 	int ret = 0;
 	unsigned int count;
@@ -1678,7 +1678,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t dma_addr;
 	int ret, prot, len = PAGE_ALIGN(size + offset);
 
@@ -1731,7 +1731,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
 	int offset = handle & ~PAGE_MASK;
 	int len = PAGE_ALIGN(size + offset);
@@ -1756,7 +1756,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
 		struct dma_attrs *attrs)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	int offset = handle & ~PAGE_MASK;
@@ -1775,7 +1775,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	unsigned int offset = handle & ~PAGE_MASK;
@@ -1789,7 +1789,7 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 static void arm_iommu_sync_single_for_device(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
 	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	unsigned int offset = handle & ~PAGE_MASK;
@@ -1960,7 +1960,7 @@ int arm_iommu_attach_device(struct device *dev,
 		return err;
 
 	kref_get(&mapping->kref);
-	dev->archdata.mapping = mapping;
+	to_dma_iommu_mapping(dev) = mapping;
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
@@ -1985,7 +1985,7 @@ void arm_iommu_detach_device(struct device *dev)
 
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
-	dev->archdata.mapping = NULL;
+	to_dma_iommu_mapping(dev) = NULL;
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
@@ -2023,7 +2023,7 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
-	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 
 	if (!mapping)
 		return;
-- 
2.1.4

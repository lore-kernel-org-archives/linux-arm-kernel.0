From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 17:29:27 +0100
Subject: [PATCH] arm: dma-mapping: make unexported items static
Message-ID: <1465403367-32201-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of items in the dma-mapping code that are not
used outside of the file they are defined in. Fix the following
warnings by making them static:

arch/arm/mm/dma-mapping.c:1570:6: warning: symbol 'arm_iommu_free_attrs' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1736:5: warning: symbol 'arm_coherent_iommu_map_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1754:5: warning: symbol 'arm_iommu_map_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1788:6: warning: symbol 'arm_coherent_iommu_unmap_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1804:6: warning: symbol 'arm_iommu_unmap_sg' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1817:6: warning: symbol 'arm_iommu_sync_sg_for_cpu' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1835:6: warning: symbol 'arm_iommu_sync_sg_for_device' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1982:20: warning: symbol 'iommu_ops' was not declared. Should it be static?
arch/arm/mm/dma-mapping.c:1999:20: warning: symbol 'iommu_coherent_ops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mm/dma-mapping.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ff7ed56..703a878 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1567,7 +1567,8 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
  * free a page as defined by the above mapping.
  * Must not be called with IRQs disabled.
  */
-void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+static void arm_iommu_free_attrs(struct device *dev,
+				 size_t size, void *cpu_addr,
 			  dma_addr_t handle, struct dma_attrs *attrs)
 {
 	struct page **pages;
@@ -1733,7 +1734,8 @@ bad_mapping:
  * possible) and tagged with the appropriate dma address and length. They are
  * obtained via sg_dma_{address,length}.
  */
-int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+static int arm_coherent_iommu_map_sg(struct device *dev,
+				     struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
@@ -1751,7 +1753,7 @@ int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
  * tagged with the appropriate dma address and length. They are obtained via
  * sg_dma_{address,length}.
  */
-int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
@@ -1785,7 +1787,8 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
  */
-void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+static void arm_coherent_iommu_unmap_sg(struct device *dev,
+					struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
@@ -1801,7 +1804,8 @@ void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
  */
-void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+static void arm_iommu_unmap_sg(struct device *dev,
+			       struct scatterlist *sg, int nents,
 			enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
@@ -1814,7 +1818,8 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+static void arm_iommu_sync_sg_for_cpu(struct device *dev,
+				      struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *s;
@@ -1832,7 +1837,8 @@ void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+static void arm_iommu_sync_sg_for_device(struct device *dev,
+					 struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
 	struct scatterlist *s;
@@ -1979,7 +1985,7 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
-struct dma_map_ops iommu_ops = {
+static struct dma_map_ops iommu_ops = {
 	.alloc		= arm_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
@@ -1996,7 +2002,7 @@ struct dma_map_ops iommu_ops = {
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
 };
 
-struct dma_map_ops iommu_coherent_ops = {
+static struct dma_map_ops iommu_coherent_ops = {
 	.alloc		= arm_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
-- 
2.8.1

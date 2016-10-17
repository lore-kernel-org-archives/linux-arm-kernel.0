From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 17 Oct 2016 13:05:29 +0100
Subject: [PATCH 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
Message-ID: <b6c78e6c18d98069b0fdfa219da51d2aed129aed.1476705500.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new dma_{map,unmap}_resource() functions added to the DMA API
for the benefit of cases like slave DMA, add suitable implementations to
the arsenal of our generic layer. Since cache maintenance should not be
a concern, these can both be standalone versions without the need for
architecture-specific wrappers.

CC: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Since patch 2 has a build dependency on this one, they should probably
go together through either the arm64 tree or the iommu tree, but I can't
make up my mind which one seems more appropriate...

Robin.

 drivers/iommu/dma-iommu.c | 13 +++++++++++++
 include/linux/dma-iommu.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c5ab8667e6f2..50acd71915db 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -624,6 +624,19 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
 }
 
+dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return iommu_dma_map_page(dev, phys_to_page(phys), offset_in_page(phys),
+			size, dma_direction_to_prot(dir, false) | IOMMU_MMIO);
+}
+
+void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
+}
+
 int iommu_dma_supported(struct device *dev, u64 mask)
 {
 	/*
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 32c589062bd9..7f7e9a7e3839 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -61,6 +61,10 @@ void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
-- 
1.9.1

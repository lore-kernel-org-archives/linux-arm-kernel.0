From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Wed,  1 Jun 2016 17:22:27 +0200
Subject: [PATCHv7 4/6] arm: dma-mapping: add {map,
 unmap}_resource for iommu ops
In-Reply-To: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1464794549-6601-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add methods to map/unmap device resources addresses for dma_map_ops that
are IOMMU aware. This is needed to map a device MMIO register from a
physical address.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ff7ed56..8f12ec8 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1951,6 +1951,63 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	__free_iova(mapping, iova, len);
 }
 
+/**
+ * arm_iommu_map_resource - map a device resource for DMA
+ * @dev: valid struct device pointer
+ * @phys_addr: physical address of resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static dma_addr_t arm_iommu_map_resource(struct device *dev,
+		phys_addr_t phys_addr, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	dma_addr_t dma_addr;
+	int ret, prot;
+	phys_addr_t addr = phys_addr & PAGE_MASK;
+	int offset = phys_addr & ~PAGE_MASK;
+	int len = PAGE_ALIGN(size + offset);
+
+	dma_addr = __alloc_iova(mapping, size);
+	if (dma_addr == DMA_ERROR_CODE)
+		return dma_addr;
+
+	prot = __dma_direction_to_prot(dir) | IOMMU_MMIO;
+
+	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
+	if (ret < 0)
+		goto fail;
+
+	return dma_addr + offset;
+fail:
+	__free_iova(mapping, dma_addr, size);
+	return DMA_ERROR_CODE;
+}
+
+/**
+ * arm_iommu_unmap_resource - unmap a device DMA resource
+ * @dev: valid struct device pointer
+ * @dma_handle: DMA address to resource
+ * @size: size of resource to map
+ * @dir: DMA transfer direction
+ */
+static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	dma_addr_t iova = dma_handle & PAGE_MASK;
+	int offset = dma_handle & ~PAGE_MASK;
+	int len = PAGE_ALIGN(size + offset);
+
+	if (!iova)
+		return;
+
+	iommu_unmap(mapping->domain, iova, len);
+	__free_iova(mapping, iova, len);
+}
+
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -1994,6 +2051,9 @@ struct dma_map_ops iommu_ops = {
 	.unmap_sg		= arm_iommu_unmap_sg,
 	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
+
+	.map_resource		= arm_iommu_map_resource,
+	.unmap_resource		= arm_iommu_unmap_resource,
 };
 
 struct dma_map_ops iommu_coherent_ops = {
@@ -2007,6 +2067,9 @@ struct dma_map_ops iommu_coherent_ops = {
 
 	.map_sg		= arm_coherent_iommu_map_sg,
 	.unmap_sg	= arm_coherent_iommu_unmap_sg,
+
+	.map_resource	= arm_iommu_map_resource,
+	.unmap_resource	= arm_iommu_unmap_resource,
 };
 
 /**
-- 
2.8.2

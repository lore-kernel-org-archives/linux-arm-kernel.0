From: nishanth.p@gmail.com (Nishanth Peethambaran)
Date: Wed, 20 Feb 2013 12:13:50 +0530
Subject: [RFC] ARM: iommu: Adding new dma-mappin API to map sgtable
Message-ID: <CAMcxFTRBN7asUGmRHKfpfE-aLN16tfSWKTEWeOGDQ2vog1w_Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding APIs in arm dma mapping code to map a scatterlist in iommu domain
and get dma address. Allocators outside dma-mapping code like ION could
allocate pages and devices would need to map them for iommu and obtain a
linear dma address. Intention is to re-use the IOVA managment code and "mapping"
across allocators.

Can the above requirement be done without adding new APIs?
APIs available to map an sglist (arm_dma_map_sg) does not provide a linear
dma address.

Signed-off-by: Nishanth Peethambaran <nishanth@broadcom.com>
---
 arch/arm/include/asm/dma-mapping.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/include/asm/dma-mapping.h
b/arch/arm/include/asm/dma-mapping.h
index 5b579b9..f9e2f6c 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -268,6 +268,16 @@ extern void arm_dma_sync_sg_for_device(struct
device *, struct scatterlist *, in
 extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		struct dma_attrs *attrs);
+/*
+ * Map scatterlist pages for the device and return a dma address
+ */
+extern dma_addr_t arm_dma_map_sgtable(struct device *dev, struct sgtable *sgt,
+		enum dma_data_direction dir, struct dma_attrs *attrs);
+/*
+ * Unmap the dma address
+ */
+extern void arm_dma_unmap(struct device *, dma_addr_t iova, int size,
+		enum dma_data_direction dir, struct dma_attrs *attrs);

 #endif /* __KERNEL__ */
 #endif
-- 
1.7.9.5

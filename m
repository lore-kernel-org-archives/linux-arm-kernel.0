From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Aug 2012 22:49:05 -0500
Subject: [PATCH 2/4] ARM: add coherent iommu dma ops
In-Reply-To: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
References: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
Message-ID: <1344916147-13546-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove arch_is_coherent() from iommu dma ops and implement separate
coherent ops functions.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |  183 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 143 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c14e37e..29c3b3a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1254,7 +1254,8 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
  */
 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, struct dma_attrs *attrs)
+			  enum dma_data_direction dir, struct dma_attrs *attrs,
+			  bool is_coherent)
 {
 	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
 	dma_addr_t iova, iova_base;
@@ -1273,8 +1274,8 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		phys_addr_t phys = page_to_phys(sg_page(s));
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
-		if (!arch_is_coherent() &&
-		    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		if (!is_coherent &&
+			!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 
 		ret = iommu_map(mapping->domain, iova, phys, len, 0);
@@ -1292,20 +1293,9 @@ fail:
 	return ret;
 }
 
-/**
- * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * The scatter gather list elements are merged together (if possible) and
- * tagged with the appropriate dma address and length. They are obtained via
- * sg_dma_{address,length}.
- */
-int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, struct dma_attrs *attrs)
+static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		     enum dma_data_direction dir, struct dma_attrs *attrs,
+		     bool is_coherent)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
 	int i, count = 0;
@@ -1321,7 +1311,7 @@ int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 		if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
 			if (__map_sg_chunk(dev, start, size, &dma->dma_address,
-			    dir, attrs) < 0)
+			    dir, attrs, is_coherent) < 0)
 				goto bad_mapping;
 
 			dma->dma_address += offset;
@@ -1334,7 +1324,8 @@ int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		}
 		size += s->length;
 	}
-	if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs) < 0)
+	if (__map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs,
+		is_coherent) < 0)
 		goto bad_mapping;
 
 	dma->dma_address += offset;
@@ -1349,17 +1340,44 @@ bad_mapping:
 }
 
 /**
- * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
+ * arm_coherent_iommu_map_sg - map a set of SG buffers for streaming mode DMA
  * @dev: valid struct device pointer
  * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ * @nents: number of buffers to map
+ * @dir: DMA transfer direction
  *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
+ * Map a set of i/o coherent buffers described by scatterlist in streaming
+ * mode for DMA. The scatter gather list elements are merged together (if
+ * possible) and tagged with the appropriate dma address and length. They are
+ * obtained via sg_dma_{address,length}.
  */
-void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
+int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
+}
+
+/**
+ * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
+ * @dev: valid struct device pointer
+ * @sg: list of buffers
+ * @nents: number of buffers to map
+ * @dir: DMA transfer direction
+ *
+ * Map a set of buffers described by scatterlist in streaming mode for DMA.
+ * The scatter gather list elements are merged together (if possible) and
+ * tagged with the appropriate dma address and length. They are obtained via
+ * sg_dma_{address,length}.
+ */
+int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
+}
+
+static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
+		bool is_coherent)
 {
 	struct scatterlist *s;
 	int i;
@@ -1368,7 +1386,7 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		if (sg_dma_len(s))
 			__iommu_remove_mapping(dev, sg_dma_address(s),
 					       sg_dma_len(s));
-		if (!arch_is_coherent() &&
+		if (!is_coherent &&
 		    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 			__dma_page_dev_to_cpu(sg_page(s), s->offset,
 					      s->length, dir);
@@ -1376,6 +1394,38 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 }
 
 /**
+ * arm_coherent_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
+ * @dev: valid struct device pointer
+ * @sg: list of buffers
+ * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
+ * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ *
+ * Unmap a set of streaming mode DMA translations.  Again, CPU access
+ * rules concerning calls here are the same as for dma_unmap_single().
+ */
+void arm_coherent_iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
+}
+
+/**
+ * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
+ * @dev: valid struct device pointer
+ * @sg: list of buffers
+ * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
+ * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ *
+ * Unmap a set of streaming mode DMA translations.  Again, CPU access
+ * rules concerning calls here are the same as for dma_unmap_single().
+ */
+void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
+}
+
+/**
  * arm_iommu_sync_sg_for_cpu
  * @dev: valid struct device pointer
  * @sg: list of buffers
@@ -1389,8 +1439,7 @@ void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		if (!arch_is_coherent())
-			__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
+		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
 
 }
 
@@ -1408,22 +1457,21 @@ void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		if (!arch_is_coherent())
-			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
+		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 }
 
 
 /**
- * arm_iommu_map_page
+ * arm_coherent_iommu_map_page
  * @dev: valid struct device pointer
  * @page: page that buffer resides in
  * @offset: offset into page for start of buffer
  * @size: size of buffer to map
  * @dir: DMA transfer direction
  *
- * IOMMU aware version of arm_dma_map_page()
+ * Coherent IOMMU aware version of arm_dma_map_page()
  */
-static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
+static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
@@ -1431,9 +1479,6 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	dma_addr_t dma_addr;
 	int ret, len = PAGE_ALIGN(size + offset);
 
-	if (!arch_is_coherent() && !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
-		__dma_page_cpu_to_dev(page, offset, size, dir);
-
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_ERROR_CODE)
 		return dma_addr;
@@ -1449,6 +1494,52 @@ fail:
 }
 
 /**
+ * arm_iommu_map_page
+ * @dev: valid struct device pointer
+ * @page: page that buffer resides in
+ * @offset: offset into page for start of buffer
+ * @size: size of buffer to map
+ * @dir: DMA transfer direction
+ *
+ * IOMMU aware version of arm_dma_map_page()
+ */
+static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size, enum dma_data_direction dir,
+	     struct dma_attrs *attrs)
+{
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__dma_page_cpu_to_dev(page, offset, size, dir);
+
+	return arm_coherent_iommu_map_page(dev, page, offset, size, dir, attrs);
+}
+
+/**
+ * arm_coherent_iommu_unmap_page
+ * @dev: valid struct device pointer
+ * @handle: DMA address of buffer
+ * @size: size of buffer (same as passed to dma_map_page)
+ * @dir: DMA transfer direction (same as passed to dma_map_page)
+ *
+ * Coherent IOMMU aware version of arm_dma_unmap_page()
+ */
+static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+	dma_addr_t iova = handle & PAGE_MASK;
+	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
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
+/**
  * arm_iommu_unmap_page
  * @dev: valid struct device pointer
  * @handle: DMA address of buffer
@@ -1470,7 +1561,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
-	if (!arch_is_coherent() && !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_dev_to_cpu(page, offset, size, dir);
 
 	iommu_unmap(mapping->domain, iova, len);
@@ -1488,8 +1579,7 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 	if (!iova)
 		return;
 
-	if (!arch_is_coherent())
-		__dma_page_dev_to_cpu(page, offset, size, dir);
+	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
 static void arm_iommu_sync_single_for_device(struct device *dev,
@@ -1523,6 +1613,19 @@ struct dma_map_ops iommu_ops = {
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
 };
 
+struct dma_map_ops iommu_coherent_ops = {
+	.alloc		= arm_iommu_alloc_attrs,
+	.free		= arm_iommu_free_attrs,
+	.mmap		= arm_iommu_mmap_attrs,
+	.get_sgtable	= arm_iommu_get_sgtable,
+
+	.map_page	= arm_coherent_iommu_map_page,
+	.unmap_page	= arm_coherent_iommu_unmap_page,
+
+	.map_sg		= arm_coherent_iommu_map_sg,
+	.unmap_sg	= arm_coherent_iommu_unmap_sg,
+};
+
 /**
  * arm_iommu_create_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
-- 
1.7.9.5

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Jul 2016 10:40:57 +0200
Subject: [PATCH v6 06/46] arm64: dma-mapping: Use unsigned long for dma_attrs
In-Reply-To: <1468399300-5399-5-git-send-email-k.kozlowski@samsung.com>
References: <1468399167-28083-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-2-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-3-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-4-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1468399300-5399-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[for arm64]
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index f6c55afab3e2..a284fd0d0b00 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -32,7 +32,7 @@
 
 static int swiotlb __read_mostly;
 
-static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
+static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
 				 bool coherent)
 {
 	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
@@ -91,7 +91,7 @@ static int __free_from_pool(void *start, size_t size)
 
 static void *__dma_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	if (dev == NULL) {
 		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
@@ -121,7 +121,7 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 
 static void __dma_free_coherent(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	bool freed;
 	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
@@ -140,7 +140,7 @@ static void __dma_free_coherent(struct device *dev, size_t size,
 
 static void *__dma_alloc(struct device *dev, size_t size,
 			 dma_addr_t *dma_handle, gfp_t flags,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 	struct page *page;
 	void *ptr, *coherent_ptr;
@@ -188,7 +188,7 @@ no_mem:
 
 static void __dma_free(struct device *dev, size_t size,
 		       void *vaddr, dma_addr_t dma_handle,
-		       struct dma_attrs *attrs)
+		       unsigned long attrs)
 {
 	void *swiotlb_addr = phys_to_virt(dma_to_phys(dev, dma_handle));
 
@@ -205,7 +205,7 @@ static void __dma_free(struct device *dev, size_t size,
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	dma_addr_t dev_addr;
 
@@ -219,7 +219,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
 
 static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 				 size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	if (!is_device_dma_coherent(dev))
 		__dma_unmap_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
@@ -228,7 +228,7 @@ static void __swiotlb_unmap_page(struct device *dev, dma_addr_t dev_addr,
 
 static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				  int nelems, enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i, ret;
@@ -245,7 +245,7 @@ static int __swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 static void __swiotlb_unmap_sg_attrs(struct device *dev,
 				     struct scatterlist *sgl, int nelems,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -306,7 +306,7 @@ static void __swiotlb_sync_sg_for_device(struct device *dev,
 static int __swiotlb_mmap(struct device *dev,
 			  struct vm_area_struct *vma,
 			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
@@ -333,7 +333,7 @@ static int __swiotlb_mmap(struct device *dev,
 
 static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t handle, size_t size,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 
@@ -435,21 +435,21 @@ out:
 
 static void *__dummy_alloc(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flags,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	return NULL;
 }
 
 static void __dummy_free(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle,
-			 struct dma_attrs *attrs)
+			 unsigned long attrs)
 {
 }
 
 static int __dummy_mmap(struct device *dev,
 			struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	return -ENXIO;
 }
@@ -457,20 +457,20 @@ static int __dummy_mmap(struct device *dev,
 static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	return DMA_ERROR_CODE;
 }
 
 static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 }
 
 static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 			  int nelems, enum dma_data_direction dir,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	return 0;
 }
@@ -478,7 +478,7 @@ static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 static void __dummy_unmap_sg(struct device *dev,
 			     struct scatterlist *sgl, int nelems,
 			     enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 }
 
@@ -553,7 +553,7 @@ static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 
 static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 				 dma_addr_t *handle, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
@@ -613,7 +613,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 }
 
 static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			       dma_addr_t handle, struct dma_attrs *attrs)
+			       dma_addr_t handle, unsigned long attrs)
 {
 	size_t iosize = size;
 
@@ -629,7 +629,7 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (__in_atomic_pool(cpu_addr, size)) {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
+		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_from_pool(cpu_addr, size);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
@@ -639,14 +639,14 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		iommu_dma_free(dev, area->pages, iosize, &handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
-		iommu_dma_unmap_page(dev, handle, iosize, 0, NULL);
+		iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_pages(virt_to_page(cpu_addr), get_order(size));
 	}
 }
 
 static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      struct dma_attrs *attrs)
+			      unsigned long attrs)
 {
 	struct vm_struct *area;
 	int ret;
@@ -666,7 +666,7 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 
 static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 			       void *cpu_addr, dma_addr_t dma_addr,
-			       size_t size, struct dma_attrs *attrs)
+			       size_t size, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct vm_struct *area = find_vm_area(cpu_addr);
@@ -707,7 +707,7 @@ static void __iommu_sync_single_for_device(struct device *dev,
 static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 	int prot = dma_direction_to_prot(dir, coherent);
@@ -722,7 +722,7 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 
 static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
@@ -760,7 +760,7 @@ static void __iommu_sync_sg_for_device(struct device *dev,
 
 static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 				int nelems, enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	bool coherent = is_device_dma_coherent(dev);
 
@@ -774,7 +774,7 @@ static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
 static void __iommu_unmap_sg_attrs(struct device *dev,
 				   struct scatterlist *sgl, int nelems,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
-- 
1.9.1

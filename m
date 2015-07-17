From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 17 Jul 2015 16:58:22 +0100
Subject: [PATCH 2/2] arm64: dma-mapping: consolidate __swiotlb_mmap()
In-Reply-To: <65a75c2ea16d0fff8e8ec18a8f42e204c33249ed.1437148528.git.robin.murphy@arm.com>
References: <65a75c2ea16d0fff8e8ec18a8f42e204c33249ed.1437148528.git.robin.murphy@arm.com>
Message-ID: <114c1dcf89f3af794f69f85547127a33691b433f.1437148528.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 9d3bfbb4df58 ("arm64: Combine coherent and non-coherent
swiotlb dma_ops"), __dma_common_mmap() is no longer shared between two
callers, so roll it into the remaining one.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4b9b600..07c6976 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -303,9 +303,9 @@ static void __swiotlb_sync_sg_for_device(struct device *dev,
 				       sg->length, dir);
 }
 
-/* vma->vm_page_prot must be set appropriately before calling this function */
-static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
-			     void *cpu_addr, dma_addr_t dma_addr, size_t size)
+static int __swiotlb_mmap(struct device *dev, struct vm_area_struct *vma,
+			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			  struct dma_attrs *attrs)
 {
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
@@ -314,6 +314,9 @@ static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
 
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
+					     is_device_dma_coherent(dev));
+
 	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
@@ -327,16 +330,6 @@ static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
-static int __swiotlb_mmap(struct device *dev,
-			  struct vm_area_struct *vma,
-			  void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			  struct dma_attrs *attrs)
-{
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
-					     is_device_dma_coherent(dev));
-	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
-}
-
 int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 			  void *cpu_addr, dma_addr_t handle, size_t size,
 			  struct dma_attrs *attrs)
-- 
1.9.1

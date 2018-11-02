From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  2 Nov 2018 16:26:07 +0100
Subject: [PATCH] arm64: hide unused swiotlb functions
Message-ID: <20181102152624.1189250-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a good chunk of the swiotlb code has been replaced with the generic
version, two functions are only used from inside of an #ifdef:

arch/arm64/mm/dma-mapping.c:174:12: error: '__swiotlb_mmap_pfn' defined but not used [-Werror=unused-function]
 static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
            ^~~~~~~~~~~~~~~~~~
arch/arm64/mm/dma-mapping.c:163:12: error: '__swiotlb_get_sgtable_page' defined but not used [-Werror=unused-function]
 static int __swiotlb_get_sgtable_page(struct sg_table *sgt,

Move them into the same #ifdef section to avoid that warning.

Fixes: 886643b76632 ("arm64: use the generic swiotlb_dma_ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/mm/dma-mapping.c | 58 ++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3a703e5d4e32..62356c64e180 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -160,35 +160,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	__dma_unmap_area(phys_to_virt(paddr), size, dir);
 }
 
-static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
-				      struct page *page, size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-
-	return ret;
-}
-
-static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-
 static int __init atomic_pool_init(void)
 {
 	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
@@ -358,6 +329,35 @@ arch_initcall(arm64_dma_init);
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
+static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
+				      struct page *page, size_t size)
+{
+	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+
+	return ret;
+}
+
+static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
+			      unsigned long pfn, size_t size)
+{
+	int ret = -ENXIO;
+	unsigned long nr_vma_pages = vma_pages(vma);
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
+
+	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      pfn + off,
+				      vma->vm_end - vma->vm_start,
+				      vma->vm_page_prot);
+	}
+
+	return ret;
+}
+
 /* Thankfully, all cache ops are by VA so we can ignore phys here */
 static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
 {
-- 
2.18.0

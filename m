From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Jun 2012 13:50:14 +0200
Subject: [PATCHv2 2/6] ARM: dma-mapping: add support for
 DMA_ATTR_NO_KERNEL_MAPPING attribute
In-Reply-To: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1339588218-24398-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for DMA_ATTR_NO_KERNEL_MAPPING attribute for
IOMMU allocations, what let drivers to save precious kernel virtual
address space for large buffers that are intended to be accessed only
from userspace.

This patch is heavily based on initial work kindly provided by Abhinav
Kochhar <abhinav.k@samsung.com>.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b3ffcf9..5d8b8b2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1071,10 +1071,13 @@ static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t si
 	return 0;
 }
 
-static struct page **__iommu_get_pages(void *cpu_addr)
+static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
 {
 	struct vm_struct *area;
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		return cpu_addr;
+
 	area = find_vm_area(cpu_addr);
 	if (area && (area->flags & VM_DMA))
 		return area->pages;
@@ -1099,6 +1102,9 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (*handle == DMA_ERROR_CODE)
 		goto err_buffer;
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		return pages;
+
 	addr = __iommu_alloc_remap(pages, size, gfp, prot,
 				   __builtin_return_address(0));
 	if (!addr)
@@ -1119,7 +1125,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 {
 	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
-	struct page **pages = __iommu_get_pages(cpu_addr);
+	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 
@@ -1146,7 +1152,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 			  dma_addr_t handle, struct dma_attrs *attrs)
 {
-	struct page **pages = __iommu_get_pages(cpu_addr);
+	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	size = PAGE_ALIGN(size);
 
 	if (!pages) {
@@ -1156,8 +1162,10 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	unmap_kernel_range((unsigned long)cpu_addr, size);
-	vunmap(cpu_addr);
+	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+		unmap_kernel_range((unsigned long)cpu_addr, size);
+		vunmap(cpu_addr);
+	}
 
 	__iommu_remove_mapping(dev, handle, size);
 	__iommu_free_buffer(dev, pages, size);
-- 
1.7.1.569.g6f426

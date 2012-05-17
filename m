From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 May 2012 18:53:05 +0200
Subject: [PATCH 2/3] ARM: dma-mapping: add support for
 DMA_ATTR_NO_KERNEL_MAPPING attribute
In-Reply-To: <1337273586-11089-1-git-send-email-m.szyprowski@samsung.com>
References: <1337273586-11089-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1337273586-11089-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for DMA_ATTR_NO_KERNEL_MAPPING attribute for
IOMMU allocations, what let drivers to save precious kernel virtual
address space for large buffers that are intended to be accessed only
from userspace.

This patch is heavily based on initial work kindly provided by Abhinav
Kochhar <abhinav.k@samsung.com>.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 2e98403..23d0ace 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -940,9 +940,13 @@ static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t si
 	return 0;
 }
 
-static struct page **__iommu_get_pages(void *cpu_addr)
+static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
 {
 	struct vm_struct *area;
+
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		return cpu_addr;
+
 	read_lock(&vmlist_lock);
 	area = find_vm_area(cpu_addr);
 	read_unlock(&vmlist_lock);
@@ -969,6 +973,9 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (*handle == DMA_ERROR_CODE)
 		goto err_buffer;
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		return pages;
+
 	addr = __iommu_alloc_remap(pages, size, gfp, prot,
 				   __builtin_return_address(0));
 	if (!addr)
@@ -989,7 +996,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 {
 	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
-	struct page **pages = __iommu_get_pages(cpu_addr);
+	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 
 	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 
@@ -1016,7 +1023,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 			  dma_addr_t handle, struct dma_attrs *attrs)
 {
-	struct page **pages = __iommu_get_pages(cpu_addr);
+	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	size = PAGE_ALIGN(size);
 
 	if (!pages) {
@@ -1026,8 +1033,11 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	unmap_kernel_range((unsigned long)cpu_addr, size);
-	vunmap(cpu_addr);
+	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+		unmap_kernel_range((unsigned long)cpu_addr, size);
+		vunmap(cpu_addr);
+	}
+
 	__iommu_remove_mapping(dev, handle, size);
 	__iommu_free_buffer(dev, pages, size);
 }
-- 
1.7.10.1

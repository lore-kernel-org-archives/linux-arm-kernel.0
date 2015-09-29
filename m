From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Sep 2015 18:50:58 +0200
Subject: [PATCH v4 2/2] ARM: dma-mapping: Fix the coherent case when iommu is
 used
In-Reply-To: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
References: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1443545458-14807-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When doing dma allocation with IOMMU the __iommu_alloc_atomic() was
used even when the system was coherent. However, this function
allocates from a non-cacheable pool, which is fine when the device is
not cache coherent but won't work as expected in the device is cache
coherent. Indeed, the CPU and device must access the memory using the
same cacheability attributes.

Moreover when the devices are coherent, the mmap call must not change
the pg_prot flags in the vma struct. The arm_coherent_iommu_mmap_attrs
has been updated in the same way that it was done for the arm_dma_mmap
in commit 55af8a91640d ("ARM: 8387/1: arm/mm/dma-mapping.c: Add
arm_coherent_dma_mmap").

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/dma-mapping.c | 88 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c8ed0c16c5a8..de1b0f070353 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1340,13 +1340,16 @@ static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
 	return NULL;
 }
 
-static void *__iommu_alloc_atomic(struct device *dev, size_t size,
-				  dma_addr_t *handle)
+static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
+				  dma_addr_t *handle, bool is_coherent)
 {
 	struct page *page;
 	void *addr;
 
-	addr = __alloc_from_pool(size, &page);
+	if (is_coherent)
+		addr = __alloc_simple_buffer(dev, size, gfp, &page);
+	else
+		addr = __alloc_from_pool(size, &page);
 	if (!addr)
 		return NULL;
 
@@ -1361,15 +1364,19 @@ err_mapping:
 	return NULL;
 }
 
-static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
-				dma_addr_t handle, size_t size)
+static void __iommu_free_simple(struct device *dev, void *cpu_addr,
+	    dma_addr_t handle, size_t size, bool is_coherent)
 {
 	__iommu_remove_mapping(dev, handle, size);
-	__free_from_pool(cpu_addr, size);
+	if (is_coherent)
+		__dma_free_buffer(virt_to_page(cpu_addr), size);
+	else
+		__free_from_pool(cpu_addr, size);
 }
 
-static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs,
+	    bool is_coherent)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
@@ -1378,8 +1385,8 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
-	if (!(gfp & __GFP_WAIT))
-		return __iommu_alloc_atomic(dev, size, handle);
+	if (is_coherent || !(gfp & __GFP_WAIT))
+		return __iommu_alloc_simple(dev, size, gfp, handle, is_coherent);
 
 	/*
 	 * Following is a work-around (a.k.a. hack) to prevent pages
@@ -1390,8 +1397,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp &= ~(__GFP_COMP);
 
-	/* For now always consider we are in a non-coherent case */
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, false);
+	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, is_coherent);
 	if (!pages)
 		return NULL;
 
@@ -1416,7 +1422,19 @@ err_buffer:
 	return NULL;
 }
 
-static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	return __arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, false);
+}
+
+static void *arm_coherent_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	return __arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, true);
+}
+
+static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    struct dma_attrs *attrs)
 {
@@ -1424,8 +1442,6 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-
 	if (!pages)
 		return -ENXIO;
 
@@ -1442,18 +1458,34 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	return 0;
 }
 
+static int arm_iommu_mmap_attrs(struct device *dev,
+		    struct vm_area_struct *vma, void *cpu_addr,
+		    dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+
+	return __arm_iommu_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
+static int arm_coherent_iommu_mmap_attrs(struct device *dev,
+		    struct vm_area_struct *vma, void *cpu_addr,
+		    dma_addr_t dma_addr, size_t size, struct dma_attrs *attrs)
+{
+	return __arm_iommu_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
 /*
  * free a page as defined by the above mapping.
  * Must not be called with IRQs disabled.
  */
-void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-			  dma_addr_t handle, struct dma_attrs *attrs)
+void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+	dma_addr_t handle, struct dma_attrs *attrs, bool is_coherent)
 {
 	struct page **pages;
 	size = PAGE_ALIGN(size);
 
-	if (__in_atomic_pool(cpu_addr, size)) {
-		__iommu_free_atomic(dev, cpu_addr, handle, size);
+	if (is_coherent || __in_atomic_pool(cpu_addr, size)) {
+		__iommu_free_simple(dev, cpu_addr, handle, size, is_coherent);
 		return;
 	}
 
@@ -1472,6 +1504,18 @@ void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	__iommu_free_buffer(dev, pages, size, attrs);
 }
 
+void arm_iommu_free_attrs(struct device *dev, size_t size,
+	    void *cpu_addr, dma_addr_t handle, struct dma_attrs *attrs)
+{
+	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, false);
+}
+
+void arm_coherent_iommu_free_attrs(struct device *dev, size_t size,
+	    void *cpu_addr, dma_addr_t handle, struct dma_attrs *attrs)
+{
+	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, true);
+}
+
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t dma_addr,
 				 size_t size, struct dma_attrs *attrs)
@@ -1878,9 +1922,9 @@ struct dma_map_ops iommu_ops = {
 };
 
 struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
-	.free		= arm_iommu_free_attrs,
-	.mmap		= arm_iommu_mmap_attrs,
+	.alloc		= arm_coherent_iommu_alloc_attrs,
+	.free		= arm_coherent_iommu_free_attrs,
+	.mmap		= arm_coherent_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
 
 	.map_page	= arm_coherent_iommu_map_page,
-- 
2.1.0

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 14 Aug 2015 18:12:56 +0200
Subject: [PATCH v2 2/2] ARM: dma-mapping: Fix the coherent case when iommu is
 used
In-Reply-To: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
References: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1439568776-17864-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When doing dma allocation with IOMMU the __iommu_alloc_atomic() was
used even when the system was coherent. However, this function
allocates from a non-cacheable pool, which is fine when the device is
not cache coherent but won't work as expected in the device is cache
coherent. Indeed, the CPU and device must access the memory using the
same cacheability attributes.

Tested-by: We need someone here

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/dma-mapping.c | 52 +++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 96d1b0572602..9dcb290e9c8c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1347,13 +1347,16 @@ static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
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
 
@@ -1368,15 +1371,19 @@ err_mapping:
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
@@ -1385,8 +1392,8 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
-	if (!(gfp & __GFP_WAIT))
-		return __iommu_alloc_atomic(dev, size, handle);
+	if (is_coherent || !(gfp & __GFP_WAIT))
+		return __iommu_alloc_simple(dev, size, gfp, handle, is_coherent);
 
 	/*
 	 * Following is a work-around (a.k.a. hack) to prevent pages
@@ -1397,8 +1404,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	 */
 	gfp &= ~(__GFP_COMP);
 
-	/* For now always consider we are in a non-coherent case */
-	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, false);
+	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, is_coherent);
 	if (!pages)
 		return NULL;
 
@@ -1423,6 +1429,18 @@ err_buffer:
 	return NULL;
 }
 
+static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	__arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, false);
+}
+
+static void *arm_coherent_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
+{
+	__arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, true);
+}
+
 static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    struct dma_attrs *attrs)
@@ -1453,14 +1471,14 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
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
 
@@ -1885,7 +1903,7 @@ struct dma_map_ops iommu_ops = {
 };
 
 struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
+	.alloc		= arm_coherent_iommu_alloc_attrs,
 	.free		= arm_iommu_free_attrs,
 	.mmap		= arm_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
-- 
2.1.0

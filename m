From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Jun 2015 17:28:19 +0100
Subject: [RFC PATCH v2] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <1433351745-3646-1-git-send-email-lorenx4@gmail.com>
References: <1433351745-3646-1-git-send-email-lorenx4@gmail.com>
Message-ID: <20150610162819.GD22844@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 07:15:45PM +0200, Lorenzo Nava wrote:
> This patch allows the use of CMA for DMA coherent memory allocation.
> At the moment if the input parameter "is_coherent" is set to true 
> the allocation is not made using the CMA, which I think is not the 
> desired behaviour.
> 
> Signed-off-by: Lorenzo Nava <lorenx4@xxxxxxxx>
> ---
> Changes in v2:
>  correct __arm_dma_free() according to __dma_alloc() allocation
> ---
>  arch/arm/mm/dma-mapping.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 7e7583d..15643b9 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -645,9 +645,9 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	size = PAGE_ALIGN(size);
>  	want_vaddr = !dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
>  
> -	if (is_coherent || nommu())
> +	if (nommu())
>  		addr = __alloc_simple_buffer(dev, size, gfp, &page);
> -	else if (!(gfp & __GFP_WAIT))
> +	else if (!is_coherent && !(gfp & __GFP_WAIT))
>  		addr = __alloc_from_pool(size, &page);
>  	else if (!dev_get_cma_area(dev))
>  		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller, want_vaddr);

So while you allow __alloc_from_contiguous() to be called when
is_coherent, the memory returned is still non-cacheable. The reason is
that the "prot" argument passed to __dma_alloc() in
arm_coherent_dma_alloc() is pgprot_dmacoherent(PAGE_KERNEL) which means
Normal NonCacheable memory. The mmap seems to create a cacheable mapping
as vma->vm_page_prot is not passed through __get_dma_pgprot().

I think you need something like below, completely untested:

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1ced8a0f7a52..1ee3d8e8c313 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -573,11 +573,13 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
-static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
+static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
+					bool coherent)
 {
-	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
-			    pgprot_writecombine(prot) :
-			    pgprot_dmacoherent(prot);
+	if (dma_get_attr(DMA_ATTR_WRITE_COMBINE))
+		prot = pgprot_writecombine(prot);
+	else if (!coherent)
+		prot = pgprot_dmacoherent(prot);
 	return prot;
 }
 
@@ -587,7 +589,7 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 
 #define nommu() 1
 
-#define __get_dma_pgprot(attrs, prot)				__pgprot(0)
+#define __get_dma_pgprot(attrs, prot, coherent)			__pgprot(0)
 #define __alloc_remap_buffer(dev, size, gfp, prot, ret, c, wv)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
 #define __alloc_from_contiguous(dev, size, prot, ret, c, wv)	NULL
@@ -670,7 +672,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		    gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
@@ -683,7 +685,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, true);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
@@ -733,7 +735,7 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 struct dma_attrs *attrs)
 {
 #ifdef CONFIG_MMU
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot, false);
 #endif	/* CONFIG_MMU */
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
@@ -1362,7 +1364,7 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, is_device_dma_coherent(dev));
 	struct page **pages;
 	void *addr = NULL;
 
@@ -1414,7 +1416,7 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot, is_device_dma_coherent(dev));
 
 	if (!pages)
 		return -ENXIO;

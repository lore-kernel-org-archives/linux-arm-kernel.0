From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 21:42:12 +0200
Subject: [review] ARM: dma-mapping: Add support DMA allocate memory
 without mapping
In-Reply-To: <53746A80.8070900@gmail.com>
References: <53746A80.8070900@gmail.com>
Message-ID: <14325562.oAPLH1PRKP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 15:19:28 albuer wrote:
> Dear all:
> 
> ARM: dma-mapping: Add support DMA allocate memory without mapping
> 
> reserved DMA(CMA) regions may be large than 512MB for devices, placed it
> in the highmem zone is appropriate, but according to the existing
> mechanism, memory allocation with mapping will cause vmalloc area not
> enough.
> 
> Now we don't do mapping if the DMA_ATTR_NO_KERNEL_MAPPING is set.
>
> the DMA(CMA) region used for VPU/VOP/Camera/RGA etc, my screen
> resolution: 2560*1600, we need CMA memory large than 768MB.
> 

Please follow the normal submission procedure as documented in
Documentation/SubmittingPatches, and put the patch inline rather
than an attachment.

I've pasted the patch below for review.

 
> +static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t
> prot); +

Style: better move the inline function here to avoid the forward declaration.

>  static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t
>  gfp,
> 
> -				 pgprot_t prot, struct page **ret_page,
> +				 struct dma_attrs *attrs, struct page **ret_page,
> 
>  				 const void *caller)
>  
>  {
>  
>  	struct page *page;
>  	void *ptr;
> 
> +	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
> 
>  	page = __dma_alloc_buffer(dev, size, gfp);
>  	if (!page)
>  	
>  		return NULL;
> 
> +	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
> +		return (*ret_page=page);
> +
> 
>  	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
>  	if (!ptr) {
>  	
>  		__dma_free_buffer(page, size);
> 

Hmm, so if we don't want a mapping, the function returns a pointer
to the struct page rather than to the virtual address?

This sounds like it will do the right thing, but it's also a
very confusing interface. Maybe somebody can think of a better
return value.

We do have a similarly confusing case for the existing __iommu_get_pages
function:

static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
{
        struct vm_struct *area;

        if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
                return __atomic_get_pages(cpu_addr);

        if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
                return cpu_addr;

        area = find_vm_area(cpu_addr);
        if (area && (area->flags & VM_ARM_DMA_CONSISTENT))
                return area->pages;
        return NULL;
}

This either returns 'cpu_addr' directly, or a pointer to the pages. I have
no idea how this can work right, but I may be missing something subtle.

	Arnd

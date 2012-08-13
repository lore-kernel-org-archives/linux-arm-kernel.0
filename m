From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 13 Aug 2012 08:15:22 +0200
Subject: [RFC PATCH] ARM: add coherent dma ops
In-Reply-To: <1344490622-20029-1-git-send-email-robherring2@gmail.com>
References: <1344490622-20029-1-git-send-email-robherring2@gmail.com>
Message-ID: <007b01cd791b$07adc900$17095b00$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thursday, August 09, 2012 7:37 AM Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> arch_is_coherent is problematic as it is a global symbol. This
> doesn't work for multi-platform kernels or platforms which can support
> per device coherent DMA.
> 
> This adds arm_coherent_dma_ops to be used for devices which connected
> coherently (i.e. to the ACP port on Cortex-A9 or A15). The arm_dma_ops
> are modified at boot when arch_is_coherent is true.

Thanks for the patch. I had something similar on my TODO list, but had not enough time for
it. I like this patch but I have some comments.
 
> This does not address arch_is_coherent used in iommu dma ops.

In the initial version we might get rid of arch_is_coherent() usage in iommu dma ops and
implement it when a real coherent hw with iommu will be available.

> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Compile tested only.

>  arch/arm/mm/dma-mapping.c |   89 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c2cdf65..8875cd4 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -73,11 +73,18 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
>  	     unsigned long offset, size_t size, enum dma_data_direction dir,
>  	     struct dma_attrs *attrs)
>  {
> -	if (!arch_is_coherent() && !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
>  		__dma_page_cpu_to_dev(page, offset, size, dir);
>  	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
>  }
> 
> +static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
> +	     unsigned long offset, size_t size, enum dma_data_direction dir,
> +	     struct dma_attrs *attrs)
> +{
> +	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
> +}
> +
>  /**
>   * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> @@ -96,7 +103,7 @@ static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir,
>  		struct dma_attrs *attrs)
>  {
> -	if (!arch_is_coherent() && !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> +	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
>  		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
>  				      handle & ~PAGE_MASK, size, dir);
>  }
> @@ -106,8 +113,7 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
>  {
>  	unsigned int offset = handle & (PAGE_SIZE - 1);
>  	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
> -	if (!arch_is_coherent())
> -		__dma_page_dev_to_cpu(page, offset, size, dir);
> +	__dma_page_dev_to_cpu(page, offset, size, dir);
>  }
> 
>  static void arm_dma_sync_single_for_device(struct device *dev,
> @@ -115,8 +121,7 @@ static void arm_dma_sync_single_for_device(struct device *dev,
>  {
>  	unsigned int offset = handle & (PAGE_SIZE - 1);
>  	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
> -	if (!arch_is_coherent())
> -		__dma_page_cpu_to_dev(page, offset, size, dir);
> +	__dma_page_cpu_to_dev(page, offset, size, dir);
>  }
> 
>  static int arm_dma_set_mask(struct device *dev, u64 dma_mask);
> @@ -138,6 +143,40 @@ struct dma_map_ops arm_dma_ops = {
>  };
>  EXPORT_SYMBOL(arm_dma_ops);
> 
> +static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> +	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
> +static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +				  dma_addr_t handle, struct dma_attrs *attrs);
> +
> +struct dma_map_ops arm_coherent_dma_ops = {
> +	.alloc			= arm_coherent_dma_alloc,
> +	.free			= arm_coherent_dma_free,
> +	.mmap			= arm_dma_mmap,
> +	.get_sgtable		= arm_dma_get_sgtable,
> +	.map_page		= arm_coherent_dma_map_page,
> +	.map_sg			= arm_dma_map_sg,
> +	.set_dma_mask		= arm_dma_set_mask,
> +};
> +EXPORT_SYMBOL(arm_coherent_dma_ops);
> +
> +static int __init dma_map_init(void)
> +{
> +	if (!arch_is_coherent())
> +		return 0;
> +
> +	arm_dma_ops.map_page = arm_coherent_dma_map_page;
> +	arm_dma_ops.unmap_page = NULL;
> +	arm_dma_ops.map_sg = NULL;
> +	arm_dma_ops.unmap_sg = NULL;
> +	arm_dma_ops.sync_single_for_cpu = NULL;
> +	arm_dma_ops.sync_single_for_device = NULL;
> +	arm_dma_ops.sync_sg_for_cpu = NULL;
> +	arm_dma_ops.sync_sg_for_device = NULL;
> +	arm_dma_ops.alloc = arm_coherent_dma_alloc;
> +	arm_dma_ops.free = arm_coherent_dma_free;
> +}
> +core_initcall(dma_map_init);

I would implement it in a bit different way. Overwriting structure entries is not the 
cleanest approach and might lead to some misunderstandings. I would rather change 
get_dma_ops() function in arch/arm/include/asm/dma-mapping.h to something like this:

static inline struct dma_map_ops *get_dma_ops(struct device *dev)
{
        if (dev && dev->archdata.dma_ops)
                return dev->archdata.dma_ops;
        return !arch_is_coherent() ? &arm_dma_ops : &arm_coherent_dma_ops;
}

This way the code is easy to understand and compiler can easily optimize out the above 
check for 99% of architectures which are either coherent or not. In case of partially 
coherent architectures, arch_is_coherent() will probably return false and coherent 
devices will get their dma_map_ops initialized by platform code.

> +
>  static u64 get_coherent_dma_mask(struct device *dev)
>  {
>  	u64 mask = (u64)arm_dma_limit;
> @@ -538,7 +577,7 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t
> gfp,
> 
> 
>  static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> -			 gfp_t gfp, pgprot_t prot, const void *caller)
> +			 gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
>  {
>  	u64 mask = get_coherent_dma_mask(dev);
>  	struct page *page;
> @@ -571,7 +610,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t
> *handle,
>  	*handle = DMA_ERROR_CODE;
>  	size = PAGE_ALIGN(size);
> 
> -	if (arch_is_coherent() || nommu())
> +	if (is_coherent || nommu())
>  		addr = __alloc_simple_buffer(dev, size, gfp, &page);
>  	else if (gfp & GFP_ATOMIC)
>  		addr = __alloc_from_pool(size, &page);
> @@ -599,7 +638,20 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	if (dma_alloc_from_coherent(dev, size, handle, &memory))
>  		return memory;
> 
> -	return __dma_alloc(dev, size, handle, gfp, prot,
> +	return __dma_alloc(dev, size, handle, gfp, prot, false,
> +			   __builtin_return_address(0));
> +}
> +
> +static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> +	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> +{
> +	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
> +	void *memory;
> +
> +	if (dma_alloc_from_coherent(dev, size, handle, &memory))
> +		return memory;
> +
> +	return __dma_alloc(dev, size, handle, gfp, prot, true,
>  			   __builtin_return_address(0));
>  }
> 
> @@ -636,8 +688,9 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  /*
>   * Free a buffer as defined by the above mapping.
>   */
> -void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
> -		  dma_addr_t handle, struct dma_attrs *attrs)
> +static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +			   dma_addr_t handle, struct dma_attrs *attrs,
> +			   bool is_coherent)
>  {
>  	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
> 
> @@ -646,7 +699,7 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
> 
>  	size = PAGE_ALIGN(size);
> 
> -	if (arch_is_coherent() || nommu()) {
> +	if (is_coherent || nommu()) {
>  		__dma_free_buffer(page, size);
>  	} else if (!IS_ENABLED(CONFIG_CMA)) {
>  		__dma_free_remap(cpu_addr, size);
> @@ -662,6 +715,18 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  	}
>  }
> 
> +void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		  dma_addr_t handle, struct dma_attrs *attrs)
> +{
> +	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
> +}
> +
> +static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +				  dma_addr_t handle, struct dma_attrs *attrs)
> +{
> +	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
> +}
> +
>  int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>  		 void *cpu_addr, dma_addr_t handle, size_t size,
>  		 struct dma_attrs *attrs)
> --
> 1.7.9.5


Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center

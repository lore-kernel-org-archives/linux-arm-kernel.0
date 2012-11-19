From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 19 Nov 2012 11:00:34 +0100
Subject: [PATCH V2 1/3] arm: dma mapping: Export dma ops functions
In-Reply-To: <1353059100-24022-2-git-send-email-gregory.clement@free-electrons.com>
References: <1353059100-24022-1-git-send-email-gregory.clement@free-electrons.com>
 <1353059100-24022-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50AA0342.30304@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 10:44 AM, Gregory CLEMENT wrote:
> Expose the DMA operations functions. Until now only the dma_ops
> structs in a whole or some dma operation were exposed. This patch
> exposes all the dma coherents and non-coherents operations. They can
> be reused when an architecture or driver need to create its own set of
> dma_operation.

Hello Marek,

If I understood well, you are the one who take care of the ARM DMA-mapping
subsystem.
It would be good if we could have an acked-by from you, for this patch.

Thanks,
Greogry

> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/include/asm/dma-mapping.h |   62 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mm/dma-mapping.c          |   36 +++++----------------
>  2 files changed, 70 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 2300484..f940a10 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -112,6 +112,60 @@ static inline void dma_free_noncoherent(struct device *dev, size_t size,
>  extern int dma_supported(struct device *dev, u64 mask);
>  
>  /**
> + * arm_dma_map_page - map a portion of a page for streaming DMA
> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> + * @page: page that buffer resides in
> + * @offset: offset into page for start of buffer
> + * @size: size of buffer to map
> + * @dir: DMA transfer direction
> + *
> + * Ensure that any data held in the cache is appropriately discarded
> + * or written back.
> + *
> + * The device owns this memory once this call has completed.  The CPU
> + * can regain ownership by calling dma_unmap_page().
> + */
> +extern dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
> +				    unsigned long offset, size_t size,
> +				    enum dma_data_direction dir,
> +				    struct dma_attrs *attrs);
> +
> +extern dma_addr_t arm_coherent_dma_map_page(struct device *dev,
> +					    struct page *page,
> +					    unsigned long offset, size_t size,
> +					    enum dma_data_direction dir,
> +					    struct dma_attrs *attrs);
> +
> +/**
> + * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
> + * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> + * @handle: DMA address of buffer
> + * @size: size of buffer (same as passed to dma_map_page)
> + * @dir: DMA transfer direction (same as passed to dma_map_page)
> + *
> + * Unmap a page streaming mode DMA translation.  The handle and size
> + * must match what was provided in the previous dma_map_page() call.
> + * All other usages are undefined.
> + *
> + * After this call, reads by the CPU to the buffer are guaranteed to see
> + * whatever the device wrote there.
> + */
> +extern void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
> +				size_t size, enum dma_data_direction dir,
> +				struct dma_attrs *attrs);
> +
> +extern void arm_dma_sync_single_for_cpu(struct device *dev,
> +					dma_addr_t handle, size_t size,
> +					enum dma_data_direction dir);
> +
> +extern void arm_dma_sync_single_for_device(struct device *dev,
> +					dma_addr_t handle, size_t size,
> +					enum dma_data_direction dir);
> +
> +extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
> +
> +
> +/**
>   * arm_dma_alloc - allocate consistent memory for DMA
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>   * @size: required memory size
> @@ -125,6 +179,10 @@ extern int dma_supported(struct device *dev, u64 mask);
>  extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  			   gfp_t gfp, struct dma_attrs *attrs);
>  
> +extern void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> +				    dma_addr_t *handle, gfp_t gfp,
> +				    struct dma_attrs *attrs);
> +
>  #define dma_alloc_coherent(d, s, h, f) dma_alloc_attrs(d, s, h, f, NULL)
>  
>  static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> @@ -157,6 +215,10 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  			 dma_addr_t handle, struct dma_attrs *attrs);
>  
> +extern void arm_coherent_dma_free(struct device *dev, size_t size,
> +				    void *cpu_addr, dma_addr_t handle,
> +				    struct dma_attrs *attrs);
> +
>  #define dma_free_coherent(d, s, c, h) dma_free_attrs(d, s, c, h, NULL)
>  
>  static inline void dma_free_attrs(struct device *dev, size_t size,
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 58bc3e4..5b60ee6 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -56,20 +56,13 @@ static void __dma_page_dev_to_cpu(struct page *, unsigned long,
>  		size_t, enum dma_data_direction);
>  
>  /**
> - * arm_dma_map_page - map a portion of a page for streaming DMA
> - * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> - * @page: page that buffer resides in
> - * @offset: offset into page for start of buffer
> - * @size: size of buffer to map
> - * @dir: DMA transfer direction
> - *
>   * Ensure that any data held in the cache is appropriately discarded
>   * or written back.
>   *
>   * The device owns this memory once this call has completed.  The CPU
>   * can regain ownership by calling dma_unmap_page().
>   */
> -static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
> +dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
>  	     unsigned long offset, size_t size, enum dma_data_direction dir,
>  	     struct dma_attrs *attrs)
>  {
> @@ -78,7 +71,7 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
>  	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
>  }
>  
> -static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
> +dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
>  	     unsigned long offset, size_t size, enum dma_data_direction dir,
>  	     struct dma_attrs *attrs)
>  {
> @@ -86,12 +79,6 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
>  }
>  
>  /**
> - * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
> - * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> - * @handle: DMA address of buffer
> - * @size: size of buffer (same as passed to dma_map_page)
> - * @dir: DMA transfer direction (same as passed to dma_map_page)
> - *
>   * Unmap a page streaming mode DMA translation.  The handle and size
>   * must match what was provided in the previous dma_map_page() call.
>   * All other usages are undefined.
> @@ -99,7 +86,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
>   * After this call, reads by the CPU to the buffer are guaranteed to see
>   * whatever the device wrote there.
>   */
> -static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
> +void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir,
>  		struct dma_attrs *attrs)
>  {
> @@ -108,7 +95,7 @@ static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
>  				      handle & ~PAGE_MASK, size, dir);
>  }
>  
> -static void arm_dma_sync_single_for_cpu(struct device *dev,
> +void arm_dma_sync_single_for_cpu(struct device *dev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
>  	unsigned int offset = handle & (PAGE_SIZE - 1);
> @@ -116,7 +103,7 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
>  	__dma_page_dev_to_cpu(page, offset, size, dir);
>  }
>  
> -static void arm_dma_sync_single_for_device(struct device *dev,
> +void arm_dma_sync_single_for_device(struct device *dev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
>  	unsigned int offset = handle & (PAGE_SIZE - 1);
> @@ -124,8 +111,6 @@ static void arm_dma_sync_single_for_device(struct device *dev,
>  	__dma_page_cpu_to_dev(page, offset, size, dir);
>  }
>  
> -static int arm_dma_set_mask(struct device *dev, u64 dma_mask);
> -
>  struct dma_map_ops arm_dma_ops = {
>  	.alloc			= arm_dma_alloc,
>  	.free			= arm_dma_free,
> @@ -143,11 +128,6 @@ struct dma_map_ops arm_dma_ops = {
>  };
>  EXPORT_SYMBOL(arm_dma_ops);
>  
> -static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> -	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
> -static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
> -				  dma_addr_t handle, struct dma_attrs *attrs);
> -
>  struct dma_map_ops arm_coherent_dma_ops = {
>  	.alloc			= arm_coherent_dma_alloc,
>  	.free			= arm_coherent_dma_free,
> @@ -672,7 +652,7 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  			   __builtin_return_address(0));
>  }
>  
> -static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> +void *arm_coherent_dma_alloc(struct device *dev, size_t size,
>  	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
>  {
>  	pgprot_t prot = __get_dma_pgprot(attrs, pgprot_kernel);
> @@ -751,7 +731,7 @@ void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
>  }
>  
> -static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  				  dma_addr_t handle, struct dma_attrs *attrs)
>  {
>  	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
> @@ -971,7 +951,7 @@ int dma_supported(struct device *dev, u64 mask)
>  }
>  EXPORT_SYMBOL(dma_supported);
>  
> -static int arm_dma_set_mask(struct device *dev, u64 dma_mask)
> +int arm_dma_set_mask(struct device *dev, u64 dma_mask)
>  {
>  	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
>  		return -EIO;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

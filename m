From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 14 Jan 2014 10:15:19 +0100
Subject: [RFC] dma-mapping: Provide write-combine allocations
In-Reply-To: <1389621188-3094-1-git-send-email-treding@nvidia.com>
References: <1389621188-3094-1-git-send-email-treding@nvidia.com>
Message-ID: <52D50027.60207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-01-13 14:53, Thierry Reding wrote:
> Provide an implementation for dma_{alloc,free}_writecombine() when the
> architecture supports DMA attributes.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   arch/arm/include/asm/dma-mapping.h | 16 ----------------
>   include/linux/dma-mapping.h        | 16 ++++++++++++++++
>   2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index e701a4d9aa59..96b7634a7edc 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -242,22 +242,6 @@ extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   			void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   			struct dma_attrs *attrs);
>   
> -static inline void *dma_alloc_writecombine(struct device *dev, size_t size,
> -				       dma_addr_t *dma_handle, gfp_t flag)
> -{
> -	DEFINE_DMA_ATTRS(attrs);
> -	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
> -	return dma_alloc_attrs(dev, size, dma_handle, flag, &attrs);
> -}
> -
> -static inline void dma_free_writecombine(struct device *dev, size_t size,
> -				     void *cpu_addr, dma_addr_t dma_handle)
> -{
> -	DEFINE_DMA_ATTRS(attrs);
> -	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
> -	return dma_free_attrs(dev, size, cpu_addr, dma_handle, &attrs);
> -}
> -
>   /*
>    * This can be called during early boot to increase the size of the atomic
>    * coherent DMA pool above the default value of 256KiB. It must be called
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index fd4aee29ad10..8475e02b4bd1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -249,6 +249,22 @@ struct dma_attrs;
>   #define dma_unmap_sg_attrs(dev, sgl, nents, dir, attrs) \
>   	dma_unmap_sg(dev, sgl, nents, dir)
>   
> +#else
> +static inline void *dma_alloc_writecombine(struct device *dev, size_t size,
> +					   dma_addr_t *dma_addr, gfp_t gfp)
> +{
> +	DEFINE_DMA_ATTRS(attrs);
> +	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
> +	return dma_alloc_attrs(dev, size, dma_addr, gfp, &attrs);
> +}
> +
> +static inline void dma_free_writecombine(struct device *dev, size_t size,
> +					 void *cpu_addr, dma_addr_t dma_addr)
> +{
> +	DEFINE_DMA_ATTRS(attrs);
> +	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
> +	return dma_free_attrs(dev, size, cpu_addr, dma_addr, &attrs);
> +}
>   #endif /* CONFIG_HAVE_DMA_ATTRS */
>   
>   #ifdef CONFIG_NEED_DMA_MAP_STATE

I would also add dma_mmap_writecombine() to the above functions.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

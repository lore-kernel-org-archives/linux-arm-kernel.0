From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 13 Feb 2012 14:41:37 +0400
Subject: [PATCH 03/14 v2] MIPS: adapt for dma_map_ops changes
In-Reply-To: <1329129329-25205-1-git-send-email-m.szyprowski@samsung.com>
References: <1324643253-3024-4-git-send-email-m.szyprowski@samsung.com>
 <1329129329-25205-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F38E8E1.3070004@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-02-2012 14:35, Marek Szyprowski wrote:

> From: Andrzej Pietrasiewicz<andrzej.p@samsung.com>

> Adapt core MIPS architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.

> Signed-off-by: Andrzej Pietrasiewicz<andrzej.p@samsung.com>
> [added missing changes to arch/mips/cavium-octeon/dma-octeon.c]
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
[...]

> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> index 7aa37dd..cbd41f5 100644
> --- a/arch/mips/include/asm/dma-mapping.h
> +++ b/arch/mips/include/asm/dma-mapping.h
> @@ -57,25 +57,31 @@ dma_set_mask(struct device *dev, u64 mask)
>   extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>   	       enum dma_data_direction direction);
>
> -static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> -				       dma_addr_t *dma_handle, gfp_t gfp)
> +#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
> +
> +static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> +				    dma_addr_t *dma_handle, gfp_t gfp,
> +				    struct dma_attrs *attrs)
>   {
>   	void *ret;
>   	struct dma_map_ops *ops = get_dma_ops(dev);
>
> -	ret = ops->alloc_coherent(dev, size, dma_handle, gfp);
> +	ret = ops->alloc(dev, size, dma_handle, gfp, NULL);

    Not 'attrs' instead of NULL?

>
>   	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
>
>   	return ret;
>   }
>
> -static inline void dma_free_coherent(struct device *dev, size_t size,
> -				     void *vaddr, dma_addr_t dma_handle)
> +#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
> +
> +static inline void dma_free_attrs(struct device *dev, size_t size,
> +				  void *vaddr, dma_addr_t dma_handle,
> +				  struct dma_attrs *attrs)
>   {
>   	struct dma_map_ops *ops = get_dma_ops(dev);
>
> -	ops->free_coherent(dev, size, vaddr, dma_handle);
> +	ops->free(dev, size, vaddr, dma_handle, NULL);

    Same here...

WBR, Sergei

From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 2 Oct 2014 11:41:06 +0100
Subject: [PATCH 2/2] xen/arm: introduce XENMEM_cache_flush
In-Reply-To: <1412244417-12251-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410021102480.17038@kaball.uk.xensource.com>
 <1412244417-12251-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <542D2BC2.2040505@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/14 11:06, Stefano Stabellini wrote:
> Introduce support for new hypercall XENMEM_cache_flush.
> Use it to perform cache flashing on pages used for dma when necessary.
[...]
> --- a/arch/arm/xen/mm32.c
> +++ b/arch/arm/xen/mm32.c
[...]
> @@ -24,7 +27,21 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
>  	
>  		if (!pfn_valid(pfn))
>  		{
> -			/* TODO: cache flush */
> +			struct xen_cache_flush cflush;
> +
> +			cflush.op = 0;
> +			cflush.addr = handle + offset;
> +			cflush.size = size;
> +
> +			if (op == dmac_unmap_area && dir != DMA_TO_DEVICE)
> +				cflush.op = XENMEM_CACHE_INVAL;
> +			if (op == dmac_map_area) {
> +				cflush.op = XENMEM_CACHE_CLEAN;
> +				if (dir == DMA_FROM_DEVICE)
> +					cflush.op |= XENMEM_CACHE_INVAL;
> +			}
> +			if (cflush.op)
> +				HYPERVISOR_memory_op(XENMEM_cache_flush, &cflush);
>  		} else {
>  			struct page *page = pfn_to_page(pfn);
>  
[...]
> --- a/include/xen/interface/memory.h
> +++ b/include/xen/interface/memory.h
> @@ -263,4 +263,20 @@ struct xen_remove_from_physmap {
>  };
>  DEFINE_GUEST_HANDLE_STRUCT(xen_remove_from_physmap);
>  
> +/*
> + * Issue one or more cache maintenance operations on a memory range
> + * owned by the calling domain or granted to the calling domain by a
> + * foreign domain.
> + */
> +#define XENMEM_cache_flush                 27
> +struct xen_cache_flush {
> +/* addr is the machine address at the start of the memory range */

You say machine address here but call it with a bus address.  With no
IOMMU these are equivalent but what's correct if an IOMMU is used?

David

> +uint64_t addr;
> +uint64_t size;
> +#define XENMEM_CACHE_CLEAN      (1<<0)
> +#define XENMEM_CACHE_INVAL      (1<<1)
> +uint32_t op;
> +};
> +DEFINE_GUEST_HANDLE_STRUCT(xen_cache_flush);
> +
>  #endif /* __XEN_PUBLIC_MEMORY_H__ */
> 

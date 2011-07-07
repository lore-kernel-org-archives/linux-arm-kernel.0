From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 09:22:51 +0100
Subject: [PATCH v3 01/40] Subject: ARM: mm: proc-macros Add generic
	proc/cache/tlb struct definition macros
In-Reply-To: <1308851448-25139-2-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-2-git-send-email-dave.martin@linaro.org>
Message-ID: <20110707082251.GH8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 06:50:09PM +0100, Dave Martin wrote:
> +.macro define_cache_functions name:req, default:req, \
> +		flush_kern_dcache_area, dma_map_area, dma_flush_range
> +	.align 2
> + 	.type	\name\()_cache_fns, #object
> +ENTRY(\name\()_cache_fns)
> +	.long	\default\()_flush_icache_all
> +	.long	\default\()_flush_kern_cache_all
> +	.long	\default\()_flush_user_cache_all
> +	.long	\default\()_flush_user_cache_range
> +	.long	\default\()_coherent_kern_range
> +	.long	\default\()_coherent_user_range
> +	.ifb \flush_kern_dcache_area
> +		.long	\default\()_flush_kern_dcache_area
> +	.else
> +		.long	\flush_kern_dcache_area
> +	.endif
> +	.ifb \dma_map_area
> +		.long	\default\()_dma_map_area
> +	.else
> +		.long	\dma_map_area
> +	.endif
> +	.long	\default\()_dma_unmap_area
> +	.ifb \dma_flush_range
> +		.long	\default\()_dma_flush_range
> +	.else
> +		.long	\dma_flush_range
> +	.endif
> +	.size	\name\()_cache_fns, . - \name\()_cache_fns
> +.endm

This looks wrong.  The flush_kern_dcache_area and DMA stuff can't be
any different:

#define __cpuc_flush_icache_all         __glue(_CACHE,_flush_icache_all)
#define __cpuc_flush_kern_all           __glue(_CACHE,_flush_kern_cache_all)
#define __cpuc_flush_user_all           __glue(_CACHE,_flush_user_cache_all)
#define __cpuc_flush_user_range         __glue(_CACHE,_flush_user_cache_range)
#define __cpuc_coherent_kern_range      __glue(_CACHE,_coherent_kern_range)
#define __cpuc_coherent_user_range      __glue(_CACHE,_coherent_user_range)
#define __cpuc_flush_dcache_area        __glue(_CACHE,_flush_kern_dcache_area)

#define dmac_map_area                   __glue(_CACHE,_dma_map_area)
#define dmac_unmap_area                 __glue(_CACHE,_dma_unmap_area)
#define dmac_flush_range                __glue(_CACHE,_dma_flush_range)

If they don't conform to the "<cachename>_<functionname>" pattern then
single-cache model kernels will not compile.

As these macros are supposed to be about correctness, they should be
enforcing that too, and not allowing certain functions to be overriden
by different names.

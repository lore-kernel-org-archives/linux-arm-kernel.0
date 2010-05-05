From: gdavis@mvista.com (George G. Davis)
Date: Wed, 5 May 2010 09:26:41 -0400
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the ARMv6
	DMA cache ops
In-Reply-To: <20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100505132641.GA3169@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Definitely need this for stable DMA on ARM11 MPCore.

On Tue, May 04, 2010 at 05:44:26PM +0100, Catalin Marinas wrote:
> The Snoop Control Unit on the ARM11MPCore hardware does not detect the
> cache operations and the dma_cache_maint*() functions may leave stale
> cache entries on other CPUs. The solution implemented in this patch
> performs a Read or Write For Ownership in the ARMv6 DMA cache
> maintenance functions. These LDR/STR instructions change the cache line
> state to shared or exclusive so that the cache maintenance operation has
> the desired effect.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Tested-by: George G. Davis <gdavis@mvista.com>
---

FWIW, lack of ARM11 MPCore DMA cache coherency has been a problem for
well over two years now and it would be good if we can finally get this
fixed in mainline.  Without this applied on current, I observe various
oopses and/or filesystem errors which are resolved by this patch.

If there is some other testing that I can do to help getting this
or some other variation accepted for mainline, let me know.

Thanks!

--
Regards,
George


> ---
>  arch/arm/mm/cache-v6.S |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 9d89c67..e46ecd8 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -211,6 +211,9 @@ v6_dma_inv_range:
>  	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
>  #endif
>  1:
> +#ifdef CONFIG_SMP
> +	str	r0, [r0]			@ write for ownership
> +#endif
>  #ifdef HARVARD_CACHE
>  	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
>  #else
> @@ -231,6 +234,9 @@ v6_dma_inv_range:
>  v6_dma_clean_range:
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP
> +	ldr	r2, [r0]			@ read for ownership
> +#endif
>  #ifdef HARVARD_CACHE
>  	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
>  #else
> @@ -251,6 +257,10 @@ v6_dma_clean_range:
>  ENTRY(v6_dma_flush_range)
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  1:
> +#ifdef CONFIG_SMP
> +	ldr	r2, [r0]			@ read for ownership
> +	str	r2, [r0]			@ write for ownership
> +#endif
>  #ifdef HARVARD_CACHE
>  	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
>  #else
> @@ -273,7 +283,9 @@ ENTRY(v6_dma_map_area)
>  	add	r1, r1, r0
>  	teq	r2, #DMA_FROM_DEVICE
>  	beq	v6_dma_inv_range
> -	b	v6_dma_clean_range
> +	teq	r2, #DMA_TO_DEVICE
> +	beq	v6_dma_clean_range
> +	b	v6_dma_flush_range
>  ENDPROC(v6_dma_map_area)
>  
>  /*
> @@ -283,9 +295,6 @@ ENDPROC(v6_dma_map_area)
>   *	- dir	- DMA direction
>   */
>  ENTRY(v6_dma_unmap_area)
> -	add	r1, r1, r0
> -	teq	r2, #DMA_TO_DEVICE
> -	bne	v6_dma_inv_range
>  	mov	pc, lr
>  ENDPROC(v6_dma_unmap_area)
>  
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Feb 2011 14:30:13 -0500 (EST)
Subject: [PATCH] ARM: Thumb-2: Enable ARM/Thumb interworking for v7 cache
	maintenance
In-Reply-To: <1297792565-30401-1-git-send-email-dave.martin@linaro.org>
References: <1297792565-30401-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1102151429490.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011, Dave Martin wrote:

> Cache maintenence functions may need to be called from low-level
> platform code (such as for omap3).
> 
> Some low-level code may need to be built as ARM code even in a Thumb-2
> kernel, if the code needs to talk to a non-Thumb-2-aware bootloader
> or firmware (again, omap3 is an example).
> 
> In order to avoid the need for complex hacks to make calling
> these cache maintenance routines work, simply use "bx lr" to
> return from these functions.
> 
> There's no risk of build failures, since mm/*-v7.S are by definition
> built with -march=armv7-a.
> 
> bx lr always does the right thing for a pure ARM kernel, so we
> shouldn't need any conditional assembly here.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/mm/cache-v7.S |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 6136e68..a5e5aa1 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -29,7 +29,7 @@ ENTRY(v7_flush_icache_all)
>  	mov	r0, #0
>  	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)		@ invalidate I-cache inner shareable
>  	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)		@ I+BTB cache invalidate
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_flush_icache_all)
>  
>  /*
> @@ -87,7 +87,7 @@ finished:
>  	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
>  	dsb
>  	isb
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_flush_dcache_all)
>  
>  /*
> @@ -110,7 +110,7 @@ ENTRY(v7_flush_kern_cache_all)
>  	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)	@ I+BTB cache invalidate
>   ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
>   THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_flush_kern_cache_all)
>  
>  /*
> @@ -136,7 +136,7 @@ ENTRY(v7_flush_user_cache_all)
>   *	- we have a VIPT cache.
>   */
>  ENTRY(v7_flush_user_cache_range)
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_flush_user_cache_all)
>  ENDPROC(v7_flush_user_cache_range)
>  
> @@ -194,7 +194,7 @@ ENTRY(v7_coherent_user_range)
>  	ALT_UP(mcr	p15, 0, r0, c7, c5, 6)	@ invalidate BTB
>  	dsb
>  	isb
> -	mov	pc, lr
> +	bx	lr
>  
>  /*
>   * Fault handling for the cache operation above. If the virtual address in r0
> @@ -227,7 +227,7 @@ ENTRY(v7_flush_kern_dcache_area)
>  	cmp	r0, r1
>  	blo	1b
>  	dsb
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_flush_kern_dcache_area)
>  
>  /*
> @@ -256,7 +256,7 @@ v7_dma_inv_range:
>  	cmp	r0, r1
>  	blo	1b
>  	dsb
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_dma_inv_range)
>  
>  /*
> @@ -274,7 +274,7 @@ v7_dma_clean_range:
>  	cmp	r0, r1
>  	blo	1b
>  	dsb
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_dma_clean_range)
>  
>  /*
> @@ -292,7 +292,7 @@ ENTRY(v7_dma_flush_range)
>  	cmp	r0, r1
>  	blo	1b
>  	dsb
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_dma_flush_range)
>  
>  /*
> @@ -318,7 +318,7 @@ ENTRY(v7_dma_unmap_area)
>  	add	r1, r1, r0
>  	teq	r2, #DMA_TO_DEVICE
>  	bne	v7_dma_inv_range
> -	mov	pc, lr
> +	bx	lr
>  ENDPROC(v7_dma_unmap_area)
>  
>  	__INITDATA
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

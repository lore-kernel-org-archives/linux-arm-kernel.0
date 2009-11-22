From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 22 Nov 2009 17:16:05 -0500 (EST)
Subject: [PATCH 7/7] ARM: dma-mapping: no need to clean overlapping cache
	lines on invalidate
In-Reply-To: <E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
	<E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911221714190.2059@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2009, Russell King - ARM Linux wrote:

> Since we now clean the DMA buffers on map, there's no need to clean
> overlapping cache lines on invalidation anymore.  (Note: the DMA API
> prohibits other data sharing the same cache line as a DMA buffer
> anyway.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
[...]

> diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
> index d0d7795..b2f264e 100644
> --- a/arch/arm/mm/proc-feroceon.S
> +++ b/arch/arm/mm/proc-feroceon.S
> @@ -274,11 +274,7 @@ ENTRY(feroceon_range_flush_kern_dcache_page)
>   */
>  	.align	5
>  ENTRY(feroceon_dma_inv_range)
> -	tst	r0, #CACHE_DLINESIZE - 1
>  	bic	r0, r0, #CACHE_DLINESIZE - 1
> -	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
> -	tst	r1, #CACHE_DLINESIZE - 1
> -	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
>  1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
>  	add	r0, r0, #CACHE_DLINESIZE
>  	cmp	r0, r1

The code in feroceon_range_dma_inv_range is likely to require the same 
cleanup.


Nicolas

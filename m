From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:38:25 +0000
Subject: [PATCH 2/5] ARM: Implement read/write for ownership in the
	ARMv6 DMA cache ops
In-Reply-To: <20100322151945.6353.7333.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151945.6353.7333.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323213825.GI19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 03:19:45PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 9d89c67..b9f2cbd 100644
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

What is the effect of using the register just loaded on ARMv6?  Does it
stall like previous architectures?  If so, this str should use a different
register.

In any case, does reading then writing actually achieve anything over just
a plain write?  read surely brings the cache line into shared mode, and
a write to exclusive mode - so won't just a write do?

The converse argument is that with read allocate caches, this technique
can result in faster code, so why don't we use it in dma_inv_range?

Maybe this needs to be benchmarked to discover which method is optimal.

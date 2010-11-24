From: gdavis@mvista.com (George G. Davis)
Date: Wed, 24 Nov 2010 10:10:16 -0500
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
In-Reply-To: <1290595333.3056.6.camel@e102109-lin.cambridge.arm.com>
References: <20101123222806.GA22936@mvista.com>
	<20101123224237.GF26510@n2100.arm.linux.org.uk>
	<1290595333.3056.6.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20101124151015.GE31572@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:42:13AM +0000, Catalin Marinas wrote:
> On Tue, 2010-11-23 at 22:42 +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 24, 2010 at 01:28:06AM +0300, Valentine Barshak wrote:
> > > Cache ownership must be acqired by reading/writing data from the
> > > cache line to make cache operation have the desired effect on the
> > > SMP MPCore CPU. However, the ownership is never aquired in the
> > > v6_dma_inv_range function when cleaning the first line and
> > > flushing the last one, in case the address is not aligned
> > > to D_CACHE_LINE_SIZE boundary.
> > > Fix this by reading/writing data if needed, before performing
> > > cache operations.
> > 
> > You should do this on the data _inside_ the requested buffer.  We don't
> > know if the overlapping cache line shares itself with some atomic
> > variable, and doing a read-write on it could undo other updates to it.
> 
> We could just use the boundary addresses to avoid writing beyond the
> buffer. Something like below (pretty much moving the BIC after the RFO,
> untested):
> 
> 
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index 99fa688..d63bb55 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -204,6 +204,10 @@ ENTRY(v6_flush_kern_dcache_area)
>   */
>  v6_dma_inv_range:
>  	tst	r0, #D_CACHE_LINE_SIZE - 1
> +#ifdef CONFIG_DMA_CACHE_RWFO
> +	ldrne	r2, [r0]			@ read for ownership
> +	strne	r2, [r0]			@ write for ownership

My concern doing RWFO prior to aligning "start" is that it could be
non-word-aligned which may result in an alignment fault.

> +#endif
>  	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
>  #ifdef HARVARD_CACHE
>  	mcrne	p15, 0, r0, c7, c10, 1		@ clean D line
> @@ -211,6 +215,10 @@ v6_dma_inv_range:
>  	mcrne	p15, 0, r0, c7, c11, 1		@ clean unified line
>  #endif
>  	tst	r1, #D_CACHE_LINE_SIZE - 1
> +#ifdef CONFIG_DMA_CACHE_RWFO
> +	ldrne	r2, [r1, #-4]			@ read for ownership
> +	strne	r2, [r1, #-4]			@ write for ownership

Same concern here with "end".

Are start and end reasonably expected to be word aligned?

Thanks!

--
Regards,
George
> +#endif
>  	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
>  #ifdef HARVARD_CACHE
>  	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
> 
> 
> 
> -- 
> Catalin
> 
> 

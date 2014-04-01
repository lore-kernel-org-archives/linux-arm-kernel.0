From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 01 Apr 2014 17:10:57 +0100
Subject: Bug(?) in patch "arm64: Implement coherent DMA API based on
 swiotlb" (was Re: [GIT PULL] arm64 patches for 3.15)
In-Reply-To: <20140331175230.GA7480@arm.com>
References: <20140331175230.GA7480@arm.com>
Message-ID: <1396368657.3681.17.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-31 at 18:52 +0100, Catalin Marinas wrote:
> The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:
> 
>   Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
> 
> for you to fetch changes up to 196adf2f3015eacac0567278ba538e3ffdd16d0e:
> 
>   arm64: Remove pgprot_dmacoherent() (2014-03-24 10:35:35 +0000)

I may have spotted a bug in commit 7363590d2c46 (arm64: Implement
coherent DMA API based on swiotlb), see my inline comment below...

[...]
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 1ea9f26..97fcef5 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -166,3 +166,81 @@ ENTRY(__flush_dcache_area)
>  	dsb	sy
>  	ret
>  ENDPROC(__flush_dcache_area)
> +
> +/*
> + *	__dma_inv_range(start, end)
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +__dma_inv_range:
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +	bic	x1, x1, x3

Why is the 'end' value in x1 above rounded down to be cache aligned?
This means the cache invalidate won't include the cache line containing
the final bytes of the region, unless it happened to already be cache
line aligned. This looks especially suspect as the other two cache
operations added in the same patch (below) don't do that.

> +1:	dc	ivac, x0			// invalidate D / U line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(__dma_inv_range)
> +
> +/*
> + *	__dma_clean_range(start, end)
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +__dma_clean_range:
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +1:	dc	cvac, x0			// clean D / U line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(__dma_clean_range)
> +
> +/*
> + *	__dma_flush_range(start, end)
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +ENTRY(__dma_flush_range)
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +1:	dc	civac, x0			// clean & invalidate D / U line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(__dma_flush_range)

[...]

-- 
Tixy

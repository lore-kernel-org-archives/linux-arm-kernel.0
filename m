From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:28:09 +0000
Subject: [PATCH v3 09/31] arm64: Cache maintenance routines
In-Reply-To: <1347035226-18649-10-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-10-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071928.09999.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> +
> +/*
> + *	dmac_inv_range(start,end)

all of these appear to be unused now. Can you remove them?

> + *	Invalidate the data cache within the specified region; we will be
> + *	performing a DMA operation in this region and we want to purge old
> + *	data in the cache.
> + *
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +ENTRY(dmac_inv_range)
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +	bic	x1, x1, x3
> +1:	dc	ivac, x0			// invalidate D / U line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(dmac_inv_range)
> +
> +/*
> + *	dmac_clean_range(start,end)
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +ENTRY(dmac_clean_range)
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +1:	dc	cvac, x0			// clean D / U line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(dmac_clean_range)
> +
> +/*
> + *	dmac_flush_range(start,end)
> + *	- start   - virtual start address of region
> + *	- end     - virtual end address of region
> + */
> +ENTRY(dmac_flush_range)
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +1:	dc	civac, x0			// clean & invalidate D / U line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +ENDPROC(dmac_flush_range)
> +
> +/*
> + *	dmac_map_area(start, size, dir)
> + *	- start	- kernel virtual start address
> + *	- size	- size of region
> + *	- dir	- DMA direction
> + */
> +ENTRY(dmac_map_area)
> +	add	x1, x1, x0
> +	cmp	x2, #DMA_FROM_DEVICE
> +	b.eq	dmac_inv_range
> +	b	dmac_clean_range
> +ENDPROC(dmac_map_area)
> +
> +/*
> + *	dmac_unmap_area(start, size, dir)
> + *	- start	- kernel virtual start address
> + *	- size	- size of region
> + *	- dir	- DMA direction
> + */
> +ENTRY(dmac_unmap_area)
> +	add	x1, x1, x0
> +	cmp	x2, #DMA_TO_DEVICE
> +	b.ne	dmac_inv_range
> +	ret
> +ENDPROC(dmac_unmap_area)


Aside from this:

Acked-by: Arnd Bergmann <arnd@arndb.de>

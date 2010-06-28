From: rabin@rab.in (Rabin Vincent)
Date: Mon, 28 Jun 2010 19:52:01 +0530
Subject: [PATCH 1/3] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100625120132.30030.5577.stgit@e102109-lin.cambridge.arm.com>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
	<20100625120132.30030.5577.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100628142201.GA3287@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 01:01:32PM +0100, Catalin Marinas wrote:
> @@ -508,6 +508,12 @@ void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
>  		outer_inv_range(paddr, paddr + size);
>  
>  	dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
> +
> +	/*
> +	 * Mark the D-cache clean for this page to avoid extra flushing.
> +	 */
> +	if (dir != DMA_TO_DEVICE)
> +		set_bit(PG_dcache_clean, &page->flags);

off + size does not necessarily cover the full page.  We probably
shouldn't be setting it as clean unless it does? 

Also, off + size can cover multiple physically contiguous pages, so
perhaps they too can be set as clean if they're fully covered.

Rabin

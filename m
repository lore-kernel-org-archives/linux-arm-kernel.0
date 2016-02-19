From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 19 Feb 2016 14:50:52 +0100
Subject: [PATCH 2/2] ARM: dma-mapping: fix alloc/free for coherent + CMA +
 gfp=0
In-Reply-To: <1455869524-13874-2-git-send-email-rabin.vincent@axis.com>
References: <1455869524-13874-1-git-send-email-rabin.vincent@axis.com>
 <1455869524-13874-2-git-send-email-rabin.vincent@axis.com>
Message-ID: <xa1tio1kzu4j.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19 2016, Rabin Vincent wrote:
> Given a device which uses arm_coherent_dma_ops and on which
> dev_get_cma_area(dev) returns non-NULL, the following usage of the DMA
> API with gfp=0 results in a memory leak and memory corruption.
>
>  p = dma_alloc_coherent(dev, sz, &dma, 0);
>  if (p)
>  	dma_free_coherent(dev, sz, p, dma);
>
> The memory leak is because the alloc allocates using
> __alloc_simple_buffer() but the free attempts
> dma_release_from_contiguous(), which does not do free anything since the
> page is not in the CMA area.
>
> The memory corruption is because the free calls __dma_remap() on a page
> which is backed by only first level page tables.  The
> apply_to_page_range() + __dma_update_pte() loop ends up interpreting the
> section mapping as the address to a second level page table and writing
> the new PTE to memory which is not used by page tables.
>
> We don't have access to the GFP flags used for allocation in the free
> function, so fix it by using the new in_cma() function to determine if a
> buffer was allocated with CMA, similar to how we check for
> __in_atomic_pool().
>
> Fixes: 21caf3a7 ("ARM: 8398/1: arm DMA: Fix allocation from CMA for coherent DMA")
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
> ---
>  arch/arm/mm/dma-mapping.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 0eca381..a4592c7 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -749,16 +749,16 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  		__dma_free_buffer(page, size);
>  	} else if (!is_coherent && __free_from_pool(cpu_addr, size)) {
>  		return;
> -	} else if (!dev_get_cma_area(dev)) {
> -		if (want_vaddr && !is_coherent)
> -			__dma_free_remap(cpu_addr, size);
> -		__dma_free_buffer(page, size);
> -	} else {
> +	} else if (in_cma(dev_get_cma_area(dev), page, size >> PAGE_SHIFT)) {
>  		/*
>  		 * Non-atomic allocations cannot be freed with IRQs disabled
>  		 */
>  		WARN_ON(irqs_disabled());
>  		__free_from_contiguous(dev, page, cpu_addr, size, want_vaddr);
> +	} else {
> +		if (want_vaddr && !is_coherent)
> +			__dma_free_remap(cpu_addr, size);
> +		__dma_free_buffer(page, size);
>  	}
>  }

I haven?t looked closely at the code, but why not:

	struct cma *cma = 
        if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT)) {
		// ... do whatever other non-CMA free
	}

-- 
Best regards
Liege of Serenely Enlightened Majesty of Computer Science,
??? ?mina86? ??????  <mpn@google.com> <xmpp:mina86@jabber.org>

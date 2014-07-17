From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jul 2014 18:15:50 +0100
Subject: [PATCH] ARM: DMA: ensure that old section mappings are flushed
 from the TLB
In-Reply-To: <E1X7nlB-0000EN-7e@rmk-PC.arm.linux.org.uk>
References: <E1X7nlB-0000EN-7e@rmk-PC.arm.linux.org.uk>
Message-ID: <20140717171550.GA4844@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 04:38:17PM +0100, Russell King wrote:
> When setting up the CMA region, we must ensure that the old section
> mappings are flushed from the TLB before replacing them with page
> tables, otherwise we can suffer from mismatched aliases if the CPU
> speculatively prefetches from these mappings at an inopportune time.
> 
> A mismatched alias can occur when the TLB contains a section mapping,
> but a subsequent prefetch causes it to load a page table mapping,
> resulting in the possibility of the TLB containing two matching
> mappings for the same virtual address region.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> ---
>  arch/arm/mm/dma-mapping.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 4c88935654ca..1f88db06b133 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -461,12 +461,21 @@ void __init dma_contiguous_remap(void)
>  		map.type = MT_MEMORY_DMA_READY;
>  
>  		/*
> -		 * Clear previous low-memory mapping
> +		 * Clear previous low-memory mapping to ensure that the
> +		 * TLB does not see any conflicting entries, then flush
> +		 * the TLB of the old entries before creating new mappings.
> +		 *
> +		 * This ensures that any speculatively loaded TLB entries
> +		 * (even though they may be rare) can not cause any problems,
> +		 * and ensures that this code is architecturally compliant.
>  		 */
>  		for (addr = __phys_to_virt(start); addr < __phys_to_virt(end);
>  		     addr += PMD_SIZE)
>  			pmd_clear(pmd_off_k(addr));
>  
> +		flush_tlb_kernel_range(__phys_to_virt(start),
> +				       __phys_to_virt(end));
> +
>  		iotable_init(&map, 1);
>  	}
>  }
> -- 
> 1.8.3.1
> 
> 

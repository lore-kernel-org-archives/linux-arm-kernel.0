From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 31 Oct 2012 07:50:48 +0000
Subject: Two questions about streaming DMA flushing
In-Reply-To: <CAFNq8R7Fb5Dn6pMDDNvQp=kgpY9vmdpxyhNAPUXYA0-QbfHoJg@mail.gmail.com>
References: <CAFNq8R7Fb5Dn6pMDDNvQp=kgpY9vmdpxyhNAPUXYA0-QbfHoJg@mail.gmail.com>
Message-ID: <20121031075047.GA15743@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 02:15:04AM +0000, Li Haifeng wrote:
> Sorry to disturb you.
> 
> I have two questions for streaming DMA flushing @ arch/arm/mm/cache-v7.S.
>  
> 1.
> 332 ENTRY(v7_dma_map_area)
> 333         add     r1, r1, r0
> 334         teq     r2, #DMA_FROM_DEVICE
> 335         beq     v7_dma_inv_range
> 336         b       v7_dma_clean_range
> 337 ENDPROC(v7_dma_map_area)
> 
> The function of v7_dma_map_area will invalidate corresponding cache line
> firstly and then clean the cache for  DMA_FROM_DEVICE . I am confused the
> sequence of the operations. IMO, the invalidate should be followed by the clean
> action. Is it right?

If the direction is DMA_FROM_DEVICE, it only invalidates the cache (beq
instruction).

> 2.
> 345 ENTRY(v7_dma_unmap_area)
> 346         add     r1, r1, r0
> 347         teq     r2, #DMA_TO_DEVICE
> 348         bne     v7_dma_inv_range
> 349         mov     pc, lr
> 350 ENDPROC(v7_dma_unmap_area)
> 
> v7_dma_unmap_area, will invalidate corresponding cache line for  
> DMA_FROM_DEVICE . But, at v7_dma_map_area, the invalidate has been done. Why do
> this again?

There can be speculative loads into the cache, so once the transfer has
finished you need to invalidate the range again to avoid reading stale
data (the first invalidate is needed to make sure there aren't any dirty
cache lines that could be evicted).

-- 
Catalin

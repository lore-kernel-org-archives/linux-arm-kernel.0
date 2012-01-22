From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Jan 2012 21:17:23 +0000
Subject: [PATCH] arm: fix build failure in code for mach-bcmring/dma.c
In-Reply-To: <1327266579-21951-1-git-send-email-paul.gortmaker@windriver.com>
References: <1327266579-21951-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120122211723.GB12326@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 04:09:39PM -0500, Paul Gortmaker wrote:
> Upstream commit 99d1717dd7fecf2b10195b0d864323b952b4eba0
> 
>        "ARM: Add init_consistent_dma_size()"
> 
> essentially did this:
> 
> -#define CONSISTENT_BASE                (CONSISTENT_END - CONSISTENT_DMA_SIZE)
> +unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
> 
> but the bcmring code was still using the old CONSISTENT_BASE
> macro.  Update it to now use the dynamic variable that reflects
> the ability to resize early at boot.  To do so involves putting
> the variable alongside of init_consistent_dma_size in dma-mapping.h

Oh god, what are the bcmring people doing with this variable?

DMA_MemType_t dma_mem_type(void *addr)
{
        unsigned long addrVal = (unsigned long)addr;

        if (addrVal >= CONSISTENT_BASE) {
                /* NOTE: DMA virtual memory space starts at 0xFFxxxxxx */

                /* dma_alloc_xxx pages are physically and virtually contiguous */

                return DMA_MEM_TYPE_DMA;
        }

int dma_mem_supports_dma(void *addr)
{
        DMA_MemType_t memType = dma_mem_type(addr);

        return (memType == DMA_MEM_TYPE_DMA)
#if ALLOW_MAP_OF_KMALLOC_MEMORY
            || (memType == DMA_MEM_TYPE_KMALLOC)
#endif
            || (memType == DMA_MEM_TYPE_USER);
}

...
        case DMA_MEM_TYPE_DMA:
                {
                        /* dma_alloc_xxx pages are physically contiguous */

                        atomic_inc(&gDmaStatMemTypeCoherent);

                        physAddr = (vmalloc_to_pfn(mem) << PAGE_SHIFT) + offset;

                        dma_sync_single_for_cpu(NULL, physAddr, numBytes,
                                                memMap->dir);
                        rc = dma_map_add_segment(memMap, region, mem, physAddr,
                                                 numBytes);
                        break;

That's invalid for one thing.  Calling dma_sync_single_xxx with this
made-up stuff isn't guaranteed to work - and certainly won't have the
desired effect on ARM.  Not only that, but it's completely unnecessary
for DMA coherent memory.

So really, this code is broken.  It needs to be fixed, rather than fixing
the core ARM code to allow this brokenness to persist.

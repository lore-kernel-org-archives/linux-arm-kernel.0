From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Mar 2015 16:31:34 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
Message-ID: <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 08:31:45PM +0800, vichy wrote:
> Recently we bumped into the same issue like below path:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245908.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/031810.html
> 
> We have some question about this patch:
> a. Under what circumstances, there will be memory returned by
> dma_alloc_coherent and friends mapped as normal, cacheable mappings?

dma_alloc_coherent() allocating from ZONE_DMA (or ZONE_NORMAL) which is
already mapped in the kernel linear mapping as Normal Cacheable.

> b. why "with CMA enabled, it should be safe not to set this bit."

It's not entirely safe either. I guess the assumption is that CMA
allocates from highmem which is not mapped in the kernel linear mapping.
However, to be able to flush the caches for such highmem pages, they
need to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a
small window between dmac_flush_range() and kunmap_atomic() where
speculative cache line fills can still happen.

Bit 22 in PL310 AuxCtlr must be set for most (all) uses of the coherent
DMA API in Linux.

-- 
Catalin

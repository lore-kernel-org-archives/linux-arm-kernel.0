From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Mar 2015 17:40:19 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <20150310163411.GR8656@n2100.arm.linux.org.uk>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
 <20150310163411.GR8656@n2100.arm.linux.org.uk>
Message-ID: <20150310174018.GE13687@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:34:12PM +0000, Russell King - ARM Linux wrote:
> On Tue, Mar 10, 2015 at 04:31:34PM +0000, Catalin Marinas wrote:
> > It's not entirely safe either. I guess the assumption is that CMA
> > allocates from highmem which is not mapped in the kernel linear mapping.
> > However, to be able to flush the caches for such highmem pages, they
> > need to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a
> > small window between dmac_flush_range() and kunmap_atomic() where
> > speculative cache line fills can still happen.
> 
> That really ought to be fixed.

For non-CMA DMA allocations, the solution is to set some memory aside
which is not mapped (IIRC you tried this long time ago).

As for CMA, do we have a guarantee that memory only comes from highmem?
If yes (or we can enforce this somehow), we need something like
kmap_atomic_prot() implemented for flushing such pages.

But I still think it's easier if we just set bit 22 for PL310 ;). When
this bit is cleared, the system is no longer compliant with the
statements on mismatched memory attributes.

-- 
Catalin

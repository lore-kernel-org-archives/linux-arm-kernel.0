From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 17:48:10 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <20150310174018.GE13687@e104818-lin.cambridge.arm.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
 <20150310163411.GR8656@n2100.arm.linux.org.uk>
 <20150310174018.GE13687@e104818-lin.cambridge.arm.com>
Message-ID: <20150310174809.GV8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 05:40:19PM +0000, Catalin Marinas wrote:
> On Tue, Mar 10, 2015 at 04:34:12PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Mar 10, 2015 at 04:31:34PM +0000, Catalin Marinas wrote:
> > > It's not entirely safe either. I guess the assumption is that CMA
> > > allocates from highmem which is not mapped in the kernel linear mapping.
> > > However, to be able to flush the caches for such highmem pages, they
> > > need to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a
> > > small window between dmac_flush_range() and kunmap_atomic() where
> > > speculative cache line fills can still happen.
> > 
> > That really ought to be fixed.
> 
> For non-CMA DMA allocations, the solution is to set some memory aside
> which is not mapped (IIRC you tried this long time ago).
> 
> As for CMA, do we have a guarantee that memory only comes from highmem?
> If yes (or we can enforce this somehow), we need something like
> kmap_atomic_prot() implemented for flushing such pages.

For CMA, if it comes from lowmem, CMA changes the memory attributes to
make it non-cacheable, rather than using a separate mapping of the same
page.  That eliminates the aliasing mapping problem, and was done to
explicitly avoid this scenario.

However, the CMA changes on ARM were never properly reviewed before they
went in.  Like a lot of things today, they bypassed my tree for no good
reason (and a lot of DMA API stuff continues to do so.)  So it's not
surprising that the quality of core ARM code has been getting half-
thoughtout fixes like this...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

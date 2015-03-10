From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 17:27:14 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <3a3ada21b71c4e798951b482e56dd631@HQMAIL108.nvidia.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
 <3a3ada21b71c4e798951b482e56dd631@HQMAIL108.nvidia.com>
Message-ID: <20150310172714.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 05:11:51PM +0000, Krishna Reddy wrote:
> > > b. why "with CMA enabled, it should be safe not to set this bit."
> > 
> > It's not entirely safe either. I guess the assumption is that CMA allocates from
> > highmem which is not mapped in the kernel linear mapping.
> > However, to be able to flush the caches for such highmem pages, they need
> > to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a small
> > window between dmac_flush_range() and kunmap_atomic() where
> > speculative cache line fills can still happen.
> 
> Even Low mem CMA pages has similar race window as highmem CMA pages. 
> __free_from_contiguous() in dma-mapping.c maps the CMA Low Mem pages as
>  Cached using __dma_remap().
> During the subsequent allocation of same CMA low mem pages, the window exist between
> __dma_clear_buffer() and __dma_remap() in __alloc_from_contiguous().

Again, something else which needs to be fixed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

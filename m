From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 10 Mar 2015 17:11:51 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
Message-ID: <3a3ada21b71c4e798951b482e56dd631@HQMAIL108.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > b. why "with CMA enabled, it should be safe not to set this bit."
> 
> It's not entirely safe either. I guess the assumption is that CMA allocates from
> highmem which is not mapped in the kernel linear mapping.
> However, to be able to flush the caches for such highmem pages, they need
> to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a small
> window between dmac_flush_range() and kunmap_atomic() where
> speculative cache line fills can still happen.

Even Low mem CMA pages has similar race window as highmem CMA pages. 
__free_from_contiguous() in dma-mapping.c maps the CMA Low Mem pages as
 Cached using __dma_remap().
During the subsequent allocation of same CMA low mem pages, the window exist between
__dma_clear_buffer() and __dma_remap() in __alloc_from_contiguous().

--Krishna Reddy

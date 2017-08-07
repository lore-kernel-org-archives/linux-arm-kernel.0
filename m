From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Aug 2017 19:33:39 +0100
Subject: [PATCH 5/6] arm64: Implement pmem API support
In-Reply-To: <20170804152542.7h3mbyxnhjwroddc@armageddon.cambridge.arm.com>
References: <cover.1500397441.git.robin.murphy@arm.com>
 <ba8c28bcffc3bc856163441793bb4ef0fefa0f75.1500397441.git.robin.murphy@arm.com>
 <20170804152542.7h3mbyxnhjwroddc@armageddon.cambridge.arm.com>
Message-ID: <20170807183338.GC29632@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 04:25:42PM +0100, Catalin Marinas wrote:
> Two minor comments below.
> 
> On Tue, Jul 25, 2017 at 11:55:42AM +0100, Robin Murphy wrote:
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -960,6 +960,17 @@ config ARM64_UAO
> >  	  regular load/store instructions if the cpu does not implement the
> >  	  feature.
> >  
> > +config ARM64_PMEM
> > +	bool "Enable support for persistent memory"
> > +	select ARCH_HAS_PMEM_API
> > +	help
> > +	  Say Y to enable support for the persistent memory API based on the
> > +	  ARMv8.2 DCPoP feature.
> > +
> > +	  The feature is detected at runtime, and the kernel will use DC CVAC
> > +	  operations if DC CVAP is not supported (following the behaviour of
> > +	  DC CVAP itself if the system does not define a point of persistence).
> 
> Any reason not to have this default y?
> 
> > --- a/arch/arm64/mm/cache.S
> > +++ b/arch/arm64/mm/cache.S
> > @@ -172,6 +172,20 @@ ENDPIPROC(__clean_dcache_area_poc)
> >  ENDPROC(__dma_clean_area)
> >  
> >  /*
> > + *	__clean_dcache_area_pop(kaddr, size)
> > + *
> > + * 	Ensure that any D-cache lines for the interval [kaddr, kaddr+size)
> > + * 	are cleaned to the PoP.
> > + *
> > + *	- kaddr   - kernel address
> > + *	- size    - size in question
> > + */
> > +ENTRY(__clean_dcache_area_pop)
> > +	dcache_by_line_op cvap, sy, x0, x1, x2, x3
> > +	ret
> > +ENDPIPROC(__clean_dcache_area_pop)
> > +
> > +/*
> >   *	__dma_flush_area(start, size)
> >   *
> >   *	clean & invalidate D / U line
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index a682a0a2a0fa..a461a00ceb3e 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -183,3 +183,21 @@ bool kernel_page_present(struct page *page)
> >  }
> >  #endif /* CONFIG_HIBERNATION */
> >  #endif /* CONFIG_DEBUG_PAGEALLOC */
> > +
> > +#ifdef CONFIG_ARCH_HAS_PMEM_API
> > +#include <asm/cacheflush.h>
> > +
> > +static inline void arch_wb_cache_pmem(void *addr, size_t size)
> > +{
> > +	/* Ensure order against any prior non-cacheable writes */
> > +	dmb(sy);
> > +	__clean_dcache_area_pop(addr, size);
> > +}
> 
> Could we keep the dmb() in the actual __clean_dcache_area_pop()
> implementation?
> 
> I can do the changes myself if you don't have any objections.

I *think* the DMB can also be reworked to use the outer-shareable domain,
much as we do for the dma_* barriers.

Will

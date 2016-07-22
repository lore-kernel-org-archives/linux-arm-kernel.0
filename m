From: kwangwoo.lee@sk.com (kwangwoo.lee at sk.com)
Date: Fri, 22 Jul 2016 07:28:32 +0000
Subject: [PATCH v3 1/3] arm64: mm: add __clean_dcache_area()
In-Reply-To: <20160721161137.GG21616@arm.com>
References: <1468550782-14454-1-git-send-email-kwangwoo.lee@sk.com>
 <1468550782-14454-2-git-send-email-kwangwoo.lee@sk.com>
 <20160721161137.GG21616@arm.com>
Message-ID: <10b66389d013414490d85c6d11c69347@nmail01.hynixad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Friday, July 22, 2016 1:12 AM
> To: ???(LEE KWANGWOO) MS SW
> Cc: linux-arm-kernel at lists.infradead.org; linux-nvdimm at lists.01.org; Catalin Marinas; Mark Rutland;
> Ross Zwisler; Dan Williams; Vishal Verma; ???(CHUNG WOO SUK) MS SW; ???(KIM HYUNCHUL) MS SW;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3 1/3] arm64: mm: add __clean_dcache_area()
> 
> On Fri, Jul 15, 2016 at 11:46:20AM +0900, Kwangwoo Lee wrote:
> > Ensure D-cache lines are cleaned to the PoC(Point of Coherency).
> >
> > This function is called by arch_wb_cache_pmem() to clean the cache lines
> > and remain the data in cache for the next access.
> >
> > Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> > ---
> >  arch/arm64/include/asm/cacheflush.h |  1 +
> >  arch/arm64/mm/cache.S               | 18 ++++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> > index c64268d..903a94f 100644
> > --- a/arch/arm64/include/asm/cacheflush.h
> > +++ b/arch/arm64/include/asm/cacheflush.h
> > @@ -68,6 +68,7 @@
> >  extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
> >  extern void flush_icache_range(unsigned long start, unsigned long end);
> >  extern void __flush_dcache_area(void *addr, size_t len);
> > +extern void __clean_dcache_area(void *addr, size_t len);
> >  extern void __clean_dcache_area_pou(void *addr, size_t len);
> >  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
> >
> > diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> > index 6df0706..5a350e4 100644
> > --- a/arch/arm64/mm/cache.S
> > +++ b/arch/arm64/mm/cache.S
> > @@ -93,6 +93,24 @@ ENTRY(__flush_dcache_area)
> >  ENDPIPROC(__flush_dcache_area)
> >
> >  /*
> > + *	__clean_dcache_area(kaddr, size)
> > + *
> > + * 	Ensure that any D-cache lines for the interval [kaddr, kaddr+size)
> > + * 	are cleaned to the PoC.
> > + *
> > + *	- kaddr   - kernel address
> > + *	- size    - size in question
> > + */
> > +ENTRY(__clean_dcache_area)
> > +alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > +	dcache_by_line_op cvac, sy, x0, x1, x2, x3
> > +alternative_else
> > +	dcache_by_line_op civac, sy, x0, x1, x2, x3
> > +alternative_endif
> > +	ret
> > +ENDPROC(__clean_dcache_area)
> 
> This looks functionally equivalent to __dma_clean_range. How about we:
> 
>   1. Convert the __dma_* routines to use dcache_by_line
>   2. Introduce __clean_dcache_area_poc as a fallthrough to __dma_clean_range
>   3. Use __clean_dcache_area_poc for the pmem stuff (with some parameter
>      marshalling in the macro).

OK. I'll revise the patch following your comment in the next round. Thanks for the comment!

> Will

Best Regards,
Kwangwoo Lee

From: kwangwoo.lee@sk.com (kwangwoo.lee at sk.com)
Date: Wed, 27 Jul 2016 01:55:31 +0000
Subject: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
In-Reply-To: <b978e732-f5c3-4b77-01d9-dd5f7e2303e3@arm.com>
References: <1469518496-8177-1-git-send-email-kwangwoo.lee@sk.com>
 <b978e732-f5c3-4b77-01d9-dd5f7e2303e3@arm.com>
Message-ID: <15c12f9900fd4b31a875250c478023c6@nmail01.hynixad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Thanks a lot for your comments! Please, find my comments below.

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, July 26, 2016 7:43 PM
> To: ???(LEE KWANGWOO) MS SW; Russell King - ARM Linux; Catalin Marinas; Will Deacon; Mark Rutland;
> linux-arm-kernel at lists.infradead.org
> Cc: ???(KIM HYUNCHUL) MS SW; linux-kernel at vger.kernel.org; ???(CHUNG WOO SUK) MS SW
> Subject: Re: [PATCH v2] arm64: mm: convert __dma_* routines to use start, size
> 
> On 26/07/16 08:34, Kwangwoo Lee wrote:
> > v2)
> > change __dma_* routine names using the terminoloy guidance:
> >     area: takes a start and size
> >     range: takes a start and end
> > use __dma_flush_area() instead of __dma_flush_range() in dma-mapping.c
> >
> > v1)
> > __dma_* routines have been converted to use start and size instread of
> > start and end addresses. The patch was origianlly for adding
> > __clean_dcache_area_poc() which will be used in pmem driver to clean
> > dcache to the PoC(Point of Coherency) in arch_wb_cache_pmem().
> >
> > The functionality of __clean_dcache_area_poc()  was equivalent to
> > __dma_clean_range(). The difference was __dma_clean_range() uses the end
> > address, but __clean_dcache_area_poc() uses the size to clean.
> >
> > Thus, __clean_dcache_area_poc() has been revised with a fall through
> > function of __dma_clean_range() after the change that __dma_* routines
> > use start and size instead of using start and end.
> >
> > Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> > ---
> 
> Nit: the changelog relative to the previous posting wants to be here,
> under the "---" separator; the commit message above should describe the
> _current_ state of the patch, as that's all we'll really care about once
> it's in the Git history.

OK. I'll follow the convention and use the feature.
Thank you very much for letting me know!

> >  arch/arm64/include/asm/cacheflush.h |  3 +-
> >  arch/arm64/mm/cache.S               | 71 +++++++++++++++++++------------------
> >  arch/arm64/mm/dma-mapping.c         |  6 ++--
> >  3 files changed, 41 insertions(+), 39 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> > index c64268d..2e5fb97 100644
> > --- a/arch/arm64/include/asm/cacheflush.h
> > +++ b/arch/arm64/include/asm/cacheflush.h
> > @@ -68,6 +68,7 @@
> >  extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
> >  extern void flush_icache_range(unsigned long start, unsigned long end);
> >  extern void __flush_dcache_area(void *addr, size_t len);
> > +extern void __clean_dcache_area_poc(void *addr, size_t len);
> >  extern void __clean_dcache_area_pou(void *addr, size_t len);
> >  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
> >
> > @@ -85,7 +86,7 @@ static inline void flush_cache_page(struct vm_area_struct *vma,
> >   */
> >  extern void __dma_map_area(const void *, size_t, int);
> >  extern void __dma_unmap_area(const void *, size_t, int);
> > -extern void __dma_flush_range(const void *, const void *);
> > +extern void __dma_flush_area(const void *, size_t);
> >
> >  /*
> >   * Copy user data from/to a page which is mapped into a different
> > diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> > index 50ff9ba..4415c1b 100644
> > --- a/arch/arm64/mm/cache.S
> > +++ b/arch/arm64/mm/cache.S
> > @@ -110,14 +110,16 @@ ENDPROC(__clean_dcache_area_pou)
> >   *	- end     - end address of region
> >   */
> >  ENTRY(__inval_cache_range)
> > +	sub	x1, x1, x0
> 
> Rather than doing this, I think it would be more sensible to simply swap
> the entry points.

This is much better idea instead of adding sub instruction! :) Thanks!

> >  	/* FALLTHROUGH */
> >
> >  /*
> > - *	__dma_inv_range(start, end)
> > + *	__dma_inv_area(start, size)
> >   *	- start   - virtual start address of region
> > - *	- end     - virtual end address of region
> > + *	- size    - size in question
> >   */
> > -__dma_inv_range:
> > +__dma_inv_area:
> > +	add	x1, x1, x0
> >  	dcache_line_size x2, x3
> >  	sub	x3, x2, #1
> >  	tst	x1, x3				// end cache line aligned?
> > @@ -136,46 +138,47 @@ __dma_inv_range:
> >  	dsb	sy
> >  	ret
> >  ENDPIPROC(__inval_cache_range)
> > -ENDPROC(__dma_inv_range)
> > +ENDPROC(__dma_inv_area)
> > +
> > +/*
> > + *	__clean_dcache_area_poc(kaddr, size)
> > + *
> > + * 	Ensure that any D-cache lines for the interval [kaddr, kaddr+size)
> > + * 	are cleaned to the PoC.
> > + *
> > + *	- kaddr   - kernel address
> > + *	- size    - size in question
> > + */
> > +ENTRY(__clean_dcache_area_poc)
> > +	/* FALLTHROUGH */
> >
> >  /*
> > - *	__dma_clean_range(start, end)
> > + *	__dma_clean_area(start, size)
> >   *	- start   - virtual start address of region
> > - *	- end     - virtual end address of region
> > + *	- size    - size in question
> >   */
> > -__dma_clean_range:
> > -	dcache_line_size x2, x3
> > -	sub	x3, x2, #1
> > -	bic	x0, x0, x3
> > -1:
> > +__dma_clean_area:
> >  alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > -	dc	cvac, x0
> > +	dcache_by_line_op cvac, sy, x0, x1, x2, x3
> >  alternative_else
> > -	dc	civac, x0
> > +	dcache_by_line_op civac, sy, x0, x1, x2, x3
> 
> dcache_by_line_op is a relatively large macro - is there any way we can
> still apply the alternative to just the one instruction which needs it,
> as opposed to having to patch the entire mostly-identical routine?

I agree with your opinion. Then, how do you think about using CONFIG_* options
like below? I think that alternative_* macros seems to keep the space for
unused instruction. Is it necessary? Please, share your thought about the
space. Thanks!

+__dma_clean_area:
+#if    defined(CONFIG_ARM64_ERRATUM_826319) || \
+       defined(CONFIG_ARM64_ERRATUM_827319) || \
+       defined(CONFIG_ARM64_ERRATUM_824069) || \
+       defined(CONFIG_ARM64_ERRATUM_819472)
+       dcache_by_line_op civac, sy, x0, x1, x2, x3
+#else
+       dcache_by_line_op cvac, sy, x0, x1, x2, x3
+#endif

> Robin.

Best Regards,
Kwangwoo Lee

From: kwangwoo.lee@sk.com (kwangwoo.lee at sk.com)
Date: Mon, 11 Jul 2016 23:47:22 +0000
Subject: [PATCH v2] pmem: add pmem support codes on ARM64
In-Reply-To: <20160711143402.GA7691@leverpostej>
References: <1467964298-29241-1-git-send-email-kwangwoo.lee@sk.com>
 <20160711143402.GA7691@leverpostej>
Message-ID: <ebe42cdfaca24d61ae2adc315b63771a@nmail01.hynixad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you very much, Mark!

In linux-nvdimm list, Dan Williams posted patch series which introduced nvdimm_flush() and nvdimm_has_flush()
 which assumes ARS(Asynchronous DRAM Refresh) feature or using Flush Hint in NFIT to get persistency. 
And.. arch_wmb_pmem() has been killed in the patch.

With keeping your comments in mind, I'm going to rebase and revise my patch to be more proper solution. 

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Monday, July 11, 2016 11:34 PM
> To: ???(LEE KWANGWOO) MS SW
> Cc: linux-arm-kernel at lists.infradead.org; linux-nvdimm at lists.01.org; Ross Zwisler; Catalin Marinas;
> Will Deacon; Dan Williams; Vishal Verma; ???(CHUNG WOO SUK) MS SW; ???(KIM HYUNCHUL) MS SW; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH v2] pmem: add pmem support codes on ARM64
> 
> Hi,
> 
> On Fri, Jul 08, 2016 at 04:51:38PM +0900, Kwangwoo Lee wrote:
> > +/**
> > + * arch_memcpy_to_pmem - copy data to persistent memory
> > + * @dst: destination buffer for the copy
> > + * @src: source buffer for the copy
> > + * @n: length of the copy in bytes
> > + *
> > + * Copy data to persistent memory media. if ARCH_HAS_PMEM_API is defined,
> > + * then MEMREMAP_WB is used to memremap() during probe. A subsequent
> > + * arch_wmb_pmem() need to guarantee durability.
> > + */
> > +static inline void arch_memcpy_to_pmem(void __pmem *dst, const void *src,
> > +		size_t n)
> > +{
> > +	int unwritten;
> > +
> > +	unwritten = __copy_from_user_inatomic((void __force *) dst,
> > +			(void __user *) src, n);
> > +	if (WARN(unwritten, "%s: fault copying %p <- %p unwritten: %d\n",
> > +				__func__, dst, src, unwritten))
> > +		BUG();
> > +
> > +	__flush_dcache_area(dst, n);
> > +}
> 
> I still don't understand why we use a access helper here.
> 
> I see that default_memcpy_from_pmem is just a memcpy, and no surrounding
> framework seems to set_fs first. So this looks very suspicious.
> 
> Why are we trying to handle faults on kernel memory here? Especially as
> we're going to BUG() if that happens anyway?

I'll check this again.

> > +static inline int arch_memcpy_from_pmem(void *dst, const void __pmem *src,
> > +		size_t n)
> > +{
> > +	memcpy(dst, (void __force *) src, n);
> > +	return 0;
> > +}
> 
> Similarly, I still don't understand why this isn't a mirror image of
> arch_memcpy_to_pmem().

Ditto.

> > +
> > +/**
> > + * arch_wmb_pmem - synchronize writes to persistent memory
> > + *
> > + * After a series of arch_memcpy_to_pmem() operations this need to be called to
> > + * ensure that written data is durable on persistent memory media.
> > + */
> > +static inline void arch_wmb_pmem(void)
> > +{
> > +	/*
> > +	 * We've already arranged for pmem writes to avoid the cache in
> > +	 * arch_memcpy_to_pmem()
> > +	 */
> 
> This comment is not true. We first copied, potentially hitting and/or
> allocating in cache(s), then subsequently cleaned (and invalidated)
> those.

This function has been killed in the latest patch series by Dan Williams.
I'm going to rebase this patch set under the changes.

> > +	wmb();
> > +
> > +	/*
> > +	 * pcommit_sfence() on X86 has been removed and will be replaced with
> > +	 * a function after ARMv8.2 which will support DC CVAP to ensure
> > +	 * Point-of-Persistency. Until then, mark here with a comment to keep
> > +	 * the point for __clean_dcache_area_pop().
> > +	 */
> > +}
> 
> This comment is confusing. There's no need to mention x86 here.

OK. I'll fix the comment.

> As I mentioned on v1, in the absence of the ARMv8.2 extensions for
> persistent memory, I am not sure whether the above is sufficient. There
> could be caches after the PoC which data sits in, such that even after a
> call to __flush_dcache_area() said data has not been written back to
> persistent memory.

I'll check and investigate more on this under the consideration of ARS(Asynchronous DRAM Refresh)
and the Flush Hint Scheme from ACPI/NFIT.

> > +/**
> > + * arch_invalidate_pmem - invalidate a PMEM memory range
> > + * @addr:	virtual start address
> > + * @size:	number of bytes to zero
> > + *
> > + * After finishing ARS(Address Range Scrubbing), clean and invalidate the
> > + * address range.
> > + */
> > +static inline void arch_invalidate_pmem(void __pmem *addr, size_t size)
> > +{
> > +	__flush_dcache_area(addr, size);
> > +}
> 
> As with my prior concern, I'm not sure that this is guaranteed to make
> persistent data visible to the CPU, if there are caches after the PoC.
> 
> It looks like this is used to clear poison on x86, and I don't know
> whether the ARM behaviour is comparable.

ARS is a feature of NVDIMM. In my opinion, the persistency need to be guaranteed
after finishing arch_memcpy_to_pmem() with old arch_wmb_pmem(), ADR, or Flush Hint.
I'll check this more.

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
> This looks correct per my understanding of the errata that use this
> capability.

Thanks, I'm going to split the patch with logical units.

> Thanks,
> Mark.

Best Regards,
Kwangwoo Lee

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Feb 2011 12:12:27 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <1297780926.14691.164.camel@e102109-lin.cambridge.arm.com>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
	<20110215121437.GG4152@n2100.arm.linux.org.uk>
	<1297780926.14691.164.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110220121227.GB14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 02:42:06PM +0000, Catalin Marinas wrote:
> On Tue, 2011-02-15 at 12:14 +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 15, 2011 at 11:32:42AM +0000, Russell King - ARM Linux wrote:
> > > The point of TLB shootdown is that we unmap the entries from the page
> > > tables, then issue the TLB flushes, and then free the pages and page
> > > tables after that.  All that Peter's patch tries to do is to get ARM to
> > > use the generic stuff.
> > 
> > As Peter's patch preserves the current behaviour, that's not sufficient.
> > So, let's do this our own way and delay pages and page table frees on
> > ARMv6 and v7.  Untested.
> 
> ARMv7 should be enough, I'm not aware of any pre-v7 with this behaviour.

ARM11MPCore.  Any SMP system can access a page which was free'd by the
tlb code but hasn't been flushed from the hardware TLBs.  So maybe we
want it to be "defined(CONFIG_SMP) || defined(CONFIG_CPU_32v7)" ?

> > diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> > index f41a6f5..1ca3e16 100644
> > --- a/arch/arm/include/asm/tlb.h
> > +++ b/arch/arm/include/asm/tlb.h
> > @@ -30,6 +30,16 @@
> >  #include <asm/pgalloc.h>
> > 
> >  /*
> > + * As v6 and v7 speculatively prefetch, which can drag new entries into the
> > + * TLB, we need to delay freeing pages and page tables.
> > + */
> > +#if defined(CONFIG_CPU_32v6) || defined(CONFIG_CPU_32v7)
> > +#define tlb_fast_mode(tlb)     0
> > +#else
> > +#define tlb_fast_mode(tlb)     1
> > +#endif
> 
> We could make this v7 only. If you want it to be more dynamic, we can
> check the MMFR0[3:0] bits (Cortex-A15 sets them to 4). But
> architecturally we should assume that intermediate page table levels may
> be cached.

I don't think that a runtime check justifies the optimization.  We're
talking about the difference between storing a set of pages in an array
and freeing them later vs freeing them one at a time.  Doing a test per
page is probably more expensive than just storing them in an array.

> > -#define tlb_remove_page(tlb,page)      free_page_and_swap_cache(page)
> > -#define pte_free_tlb(tlb, ptep, addr)  pte_free((tlb)->mm, ptep)
> > +#define pte_free_tlb(tlb, ptep, addr)  __pte_free_tlb(tlb, ptep, addr)
> >  #define pmd_free_tlb(tlb, pmdp, addr)  pmd_free((tlb)->mm, pmdp)
> 
> With LPAE, we'll need a __pmd_free_tlb() but I can add this as part of
> my patches.

Yes.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

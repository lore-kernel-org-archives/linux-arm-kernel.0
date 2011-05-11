From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2011 14:40:49 +0100
Subject: [PATCH 20/19] ARM: LPAE: Invalidate the TLB before freeing the PMD
In-Reply-To: <20110511105419.GD5315@n2100.arm.linux.org.uk>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1305109399-13156-1-git-send-email-catalin.marinas@arm.com>
	<20110511105419.GD5315@n2100.arm.linux.org.uk>
Message-ID: <1305121249.10103.45.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-11 at 11:54 +0100, Russell King - ARM Linux wrote:
> On Wed, May 11, 2011 at 11:23:19AM +0100, Catalin Marinas wrote:
> > +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
> > +                               unsigned long addr)
> > +{
> > +#ifdef CONFIG_ARM_LPAE
> > +     tlb_add_flush(tlb, addr);
> > +     tlb_flush(tlb);
> > +     pmd_free((tlb)->mm, pmdp);
> > +#endif
> > +}
> 
> You're:
> 
> 1. tlb_add_flush() - Adding the address which covers the PMD to the range
>    of virtual addresses which need flushing - ok.
> 2. tlb_flush() - You're then forcing a flush.
> 3. pmd_free() - You're now freeing the page.
> 
> One of the points about the shootdown interface is that it batches things
> up.  So what's wrong with:
> 
> static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>         unsigned long addr)
> {
> #ifdef CONFIG_ARM_LPAE
>         tlb_add_flush(tlb, addr);
>         tlb_remove_page(tlb, virt_to_page(pmdp));
> #endif
> }
> 
> and leave the tlb invalidate and actual page freeing to the batching code
> to deal with?

There isn't a big overhead with my initial code as a pmd covers 1GB and
we only have 1 or 2 pmds per process that we can free.

Is there any room for optimising the mmu_gather range? I think this only
matters for case 1 in your tlb_flush() comment - unmapping a page range
with a few pages in one pmd and a few other pages in the next pmd we get
over 1GB range when we actually only need to flush the TLB for a few
pages.

If tlb_add_flush would get a start/end range (or addr/size), we know
that any TLB flush within the start..end range would be enough and thus
we avoid artificially increasing the range.

We could also modify flush_tlb_range() to branch to flush_tlb_mm() for
big ranges.

-- 
Catalin

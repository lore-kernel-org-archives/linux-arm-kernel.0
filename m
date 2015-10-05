From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Oct 2015 17:33:13 +0100
Subject: [PATCH 06/10] arm64: tlbflush: avoid flushing when fullmm == 1
In-Reply-To: <20150929092957.GA30504@e104818-lin.cambridge.arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
 <1442494219-6133-7-git-send-email-will.deacon@arm.com>
 <20150929092957.GA30504@e104818-lin.cambridge.arm.com>
Message-ID: <20151005163313.GC3211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 10:29:58AM +0100, Catalin Marinas wrote:
> On Thu, Sep 17, 2015 at 01:50:15PM +0100, Will Deacon wrote:
> > The TLB gather code sets fullmm=1 when tearing down the entire address
> > space for an mm_struct on exit or execve. Given that the ASID allocator
> > will never re-allocate a dirty ASID, this flushing is not needed and can
> > simply be avoided in the flushing code.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/tlb.h | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index d6e6b6660380..ffdaea7954bb 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -37,17 +37,21 @@ static inline void __tlb_remove_table(void *_table)
> >  
> >  static inline void tlb_flush(struct mmu_gather *tlb)
> >  {
> > -	if (tlb->fullmm) {
> > -		flush_tlb_mm(tlb->mm);
> > -	} else {
> > -		struct vm_area_struct vma = { .vm_mm = tlb->mm, };
> > -		/*
> > -		 * The intermediate page table levels are already handled by
> > -		 * the __(pte|pmd|pud)_free_tlb() functions, so last level
> > -		 * TLBI is sufficient here.
> > -		 */
> > -		__flush_tlb_range(&vma, tlb->start, tlb->end, true);
> > -	}
> > +	struct vm_area_struct vma = { .vm_mm = tlb->mm, };
> > +
> > +	/*
> > +	 * The ASID allocator will either invalidate the ASID or mark
> > +	 * it as used.
> > +	 */
> > +	if (tlb->fullmm)
> > +		return;
> 
> BTW, do we actually need this flush_tlb_mm() with the current ASID
> allocator? It doesn't reuse old ASIDs either before a full TLBI (just
> trying to remember if we had any logic; or maybe it was needed before
> non-lazy __pte_free_tlb).

I'm afraid I don't follow you here. This diff is removing the flush_tlb_mm
because, as you point out, it's no longer needed.

What am I missing?

Will

From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2015 17:58:49 +0000
Subject: [PATCH] arm64: mm: ensure that the zero page is visible to the
 page table walker
In-Reply-To: <20151210181412.GL495@leverpostej>
References: <1449769199-31361-1-git-send-email-will.deacon@arm.com>
 <20151210181412.GL495@leverpostej>
Message-ID: <20151211175849.GM18828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 06:14:12PM +0000, Mark Rutland wrote:
> Hi Will,

Hi Mark,

> On Thu, Dec 10, 2015 at 05:39:59PM +0000, Will Deacon wrote:
> > In paging_init, we allocate the zero page, memset it to zero and then
> > point TTBR0 to it in order to avoid speculative fetches through the
> > identity mapping.
> > 
> > In order to guarantee that the freshly zeroed page is indeed visible to
> > the page table walker, we need to execute a dsb instruction prior to
> > writing the TTBR.
> > 
> > Cc: <stable@vger.kernel.org> # v3.14+, for older kernels need to drop the 'ishst'
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index c04def90f3e4..c5bd5bca8e3d 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -464,6 +464,9 @@ void __init paging_init(void)
> >  
> >  	empty_zero_page = virt_to_page(zero_page);
> >  
> > +	/* Ensure the zero page is visible to the page table walker */
> > +	dsb(ishst);
> 
> I think this should live in early_alloc (likewise in late_alloc).
> 
> In the other cases we call early_alloc or late_allot we assume the
> zeroing is visible to the page table walker.
> 
> For example in in alloc_init_pte we do:
> 	
> 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
> 		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
> 		if (pmd_sect(*pmd))
> 			split_pmd(pmd, pte);
> 		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
> 		flush_tlb_all();
> 	}
> 
> There's a dsb in __pmd_populate, but it's _after_ the write to the pmd
> entry, so the walker might start walking the newly-allocated pte table
> before the zeroing is visible.

Urgh. The reason this is a problem is because we're modifying the page
tables live (which I know that you're fixing) without using
break-before-make. Consequently, the usual ordering guarantees that we
get from the tlb flush after installing the invalid entry do not apply
and we end up with the issue you point out.

> Either we need a barrier after every alloc, or we fold the barrier into
> the two allocation functions.

Could you roll this into your patch that drops the size parameter from
the alloc functions please? Then we can name them {early,late}_alloc_pgtable
and have them do the dsb in there. Maybe we can drop it again when we're
doing proper break-before-make.

Cheers,

Will

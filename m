From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Jun 2017 17:54:30 +0100
Subject: [PATCH v2 1/3] arm64: hugetlb: Fix huge_pte_offset to return
 poisoned page table entries
In-Reply-To: <87h8zr24qb.fsf@e105922-lin.cambridge.arm.com>
References: <20170517152336.6052-1-punit.agrawal@arm.com>
 <20170517152336.6052-2-punit.agrawal@arm.com>
 <20170607134731.GG30263@arm.com>
 <20170607143037.ovyo5pxywty2r6as@localhost>
 <20170607145715.GI30263@arm.com>
 <87h8zr24qb.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20170607165430.GA25749@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 04:32:28PM +0100, Punit Agrawal wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > On Wed, Jun 07, 2017 at 03:30:37PM +0100, Catalin Marinas wrote:
> >> On Wed, Jun 07, 2017 at 02:47:32PM +0100, Will Deacon wrote:
> >> > On Wed, May 17, 2017 at 04:23:34PM +0100, Punit Agrawal wrote:
> >> > > --- a/arch/arm64/mm/hugetlbpage.c
> >> > > +++ b/arch/arm64/mm/hugetlbpage.c
> >> > > @@ -136,36 +136,27 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
> >> > >  {
> >> > >  	pgd_t *pgd;
> >> > >  	pud_t *pud;
> >> > > -	pmd_t *pmd = NULL;
> >> > > -	pte_t *pte = NULL;
> >> > > +	pmd_t *pmd;
> >> > >  
> >> > >  	pgd = pgd_offset(mm, addr);
> >> > >  	pr_debug("%s: addr:0x%lx pgd:%p\n", __func__, addr, pgd);
> >> > >  	if (!pgd_present(*pgd))
> >> > >  		return NULL;
> >> > > +
> >> > >  	pud = pud_offset(pgd, addr);
> >> > > -	if (!pud_present(*pud))
> >> > > +	if (pud_none(*pud))
> >> > >  		return NULL;
> >> > 
> >> > Do you actually need this special case?
> >> > 
> >> > > -
> >> > > -	if (pud_huge(*pud))
> >> > > +	/* swap or huge page */
> >> > > +	if (!pud_present(*pud) || pud_huge(*pud))
> >> > 
> >> > ... couldn't you just add a '|| pud_none(*pud)' in here?
> >> > 
> 
> I think an earlier version took this approach but...
> 
> >> > >  		return (pte_t *)pud;
> >> 
> >> But then you no longer return NULL if *pud == 0.
> >
> > Does that actually matter? The bits of hugetlb code I looked at will
> > deferenced the returned pud and handle the huge_pte_none case correctly.
> 
> For hugetlb fault handling (hugetlb_fault()), returning NULL vs pointer
> to the pud/pmd results in different behaviour. If we return the pud when
> pud_none(), then we lose the resulting hugepage size check we get from
> huge_pte_alloc().

At a quick look, there are a few other places where not returning NULL
has some other effects (though I don't think any of them are fatal):

- copy_huge_tlb_page_range() - unnecessary allocation of a destination
  pud

- huge_pmd_share() - do we actually need the subsequent get_page()?

- page_vma_mapped_walk() - it even has a comment: "when pud is not
  present, pte will be NULL". Now, that's no longer true with swap
  entries but we'd never return NULL for a pud_none() case

Current code behaviour is to return NULL when !p*d_present(). We are
slightly relaxing this for swap entries while still returning NULL for
the p*d_none() case but I wouldn't go that far as to never return NULL
here.

-- 
Catalin

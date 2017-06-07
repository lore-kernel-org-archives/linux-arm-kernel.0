From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Jun 2017 15:30:37 +0100
Subject: [PATCH v2 1/3] arm64: hugetlb: Fix huge_pte_offset to return
 poisoned page table entries
In-Reply-To: <20170607134731.GG30263@arm.com>
References: <20170517152336.6052-1-punit.agrawal@arm.com>
 <20170517152336.6052-2-punit.agrawal@arm.com>
 <20170607134731.GG30263@arm.com>
Message-ID: <20170607143037.ovyo5pxywty2r6as@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 02:47:32PM +0100, Will Deacon wrote:
> On Wed, May 17, 2017 at 04:23:34PM +0100, Punit Agrawal wrote:
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -136,36 +136,27 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
> >  {
> >  	pgd_t *pgd;
> >  	pud_t *pud;
> > -	pmd_t *pmd = NULL;
> > -	pte_t *pte = NULL;
> > +	pmd_t *pmd;
> >  
> >  	pgd = pgd_offset(mm, addr);
> >  	pr_debug("%s: addr:0x%lx pgd:%p\n", __func__, addr, pgd);
> >  	if (!pgd_present(*pgd))
> >  		return NULL;
> > +
> >  	pud = pud_offset(pgd, addr);
> > -	if (!pud_present(*pud))
> > +	if (pud_none(*pud))
> >  		return NULL;
> 
> Do you actually need this special case?
> 
> > -
> > -	if (pud_huge(*pud))
> > +	/* swap or huge page */
> > +	if (!pud_present(*pud) || pud_huge(*pud))
> 
> ... couldn't you just add a '|| pud_none(*pud)' in here?
> 
> >  		return (pte_t *)pud;

But then you no longer return NULL if *pud == 0.

-- 
Catalin

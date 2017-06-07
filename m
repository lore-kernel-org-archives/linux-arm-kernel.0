From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 07 Jun 2017 16:32:28 +0100
Subject: [PATCH v2 1/3] arm64: hugetlb: Fix huge_pte_offset to return
 poisoned page table entries
In-Reply-To: <20170607145715.GI30263@arm.com> (Will Deacon's message of "Wed,
 7 Jun 2017 15:57:16 +0100")
References: <20170517152336.6052-1-punit.agrawal@arm.com>
 <20170517152336.6052-2-punit.agrawal@arm.com>
 <20170607134731.GG30263@arm.com>
 <20170607143037.ovyo5pxywty2r6as@localhost>
 <20170607145715.GI30263@arm.com>
Message-ID: <87h8zr24qb.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Wed, Jun 07, 2017 at 03:30:37PM +0100, Catalin Marinas wrote:
>> On Wed, Jun 07, 2017 at 02:47:32PM +0100, Will Deacon wrote:
>> > On Wed, May 17, 2017 at 04:23:34PM +0100, Punit Agrawal wrote:
>> > > --- a/arch/arm64/mm/hugetlbpage.c
>> > > +++ b/arch/arm64/mm/hugetlbpage.c
>> > > @@ -136,36 +136,27 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>> > >  {
>> > >  	pgd_t *pgd;
>> > >  	pud_t *pud;
>> > > -	pmd_t *pmd = NULL;
>> > > -	pte_t *pte = NULL;
>> > > +	pmd_t *pmd;
>> > >  
>> > >  	pgd = pgd_offset(mm, addr);
>> > >  	pr_debug("%s: addr:0x%lx pgd:%p\n", __func__, addr, pgd);
>> > >  	if (!pgd_present(*pgd))
>> > >  		return NULL;
>> > > +
>> > >  	pud = pud_offset(pgd, addr);
>> > > -	if (!pud_present(*pud))
>> > > +	if (pud_none(*pud))
>> > >  		return NULL;
>> > 
>> > Do you actually need this special case?
>> > 
>> > > -
>> > > -	if (pud_huge(*pud))
>> > > +	/* swap or huge page */
>> > > +	if (!pud_present(*pud) || pud_huge(*pud))
>> > 
>> > ... couldn't you just add a '|| pud_none(*pud)' in here?
>> > 

I think an earlier version took this approach but...

>> > >  		return (pte_t *)pud;
>> 
>> But then you no longer return NULL if *pud == 0.
>
> Does that actually matter? The bits of hugetlb code I looked at will
> deferenced the returned pud and handle the huge_pte_none case correctly.

For hugetlb fault handling (hugetlb_fault()), returning NULL vs pointer
to the pud/pmd results in different behaviour. If we return the pud when
pud_none(), then we lose the resulting hugepage size check we get from
huge_pte_alloc().

>
> Will

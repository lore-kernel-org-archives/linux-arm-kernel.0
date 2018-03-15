From: toshi.kani@hpe.com (Kani, Toshi)
Date: Thu, 15 Mar 2018 14:51:06 +0000
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <14cb9fdf-25de-6519-2200-43f585b64cdd@codeaurora.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <14cb9fdf-25de-6519-2200-43f585b64cdd@codeaurora.org>
Message-ID: <1521125462.2693.154.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-03-15 at 13:09 +0530, Chintan Pandya wrote:
> 
> On 3/14/2018 11:31 PM, Toshi Kani wrote:
> > Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> > clear a given pud/pmd entry and free up lower level page table(s).
> > Address range associated with the pud/pmd entry must have been purged
> > by INVLPG.
> > 
> > fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: <stable@vger.kernel.org>
> > ---
> >   arch/x86/mm/pgtable.c |   28 ++++++++++++++++++++++++++--
> >   1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index 1eed7ed518e6..34cda7e0551b 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -712,7 +712,22 @@ int pmd_clear_huge(pmd_t *pmd)
> >    */
> >   int pud_free_pmd_page(pud_t *pud)
> >   {
> > -	return pud_none(*pud);
> > +	pmd_t *pmd;
> > +	int i;
> > +
> > +	if (pud_none(*pud))
> > +		return 1;
> > +
> > +	pmd = (pmd_t *)pud_page_vaddr(*pud);
> > +
> > +	for (i = 0; i < PTRS_PER_PMD; i++)
> > +		if (!pmd_free_pte_page(&pmd[i]))
> 
> This is forced action and no optional. Also, pmd_free_pte_page()
> doesn't return 0 in any case. So, you may remove _if_ ?

The code needs to be written per the interface definition, not per the
current implementation.

> > +			return 0;
> > +
> > +	pud_clear(pud);
> > +	free_page((unsigned long)pmd);
> > +
> > +	return 1;
> >   }
> >   
> >   /**
> > @@ -724,6 +739,15 @@ int pud_free_pmd_page(pud_t *pud)
> >    */
> >   int pmd_free_pte_page(pmd_t *pmd)
> >   {
> > -	return pmd_none(*pmd);
> > +	pte_t *pte;
> > +
> > +	if (pmd_none(*pmd))
> 
> This should also check if pmd is already huge. Same for pud ?

Not necessary. As described in the function header, one of the entry
conditions is that a given pmd range is unmapped.  See
vunmap_pmd_range().

Thanks,
-Toshi

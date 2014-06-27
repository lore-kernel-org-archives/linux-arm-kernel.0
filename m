From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 27 Jun 2014 13:24:00 +0100
Subject: [PATCH V5 1/2] arm: mm: Introduce {pte,pmd}_isset and
 {pte,pmd}_isclear
In-Reply-To: <20140627112420.GK26276@arm.com>
References: <1403612604-2645-1-git-send-email-steve.capper@linaro.org>
 <1403612604-2645-2-git-send-email-steve.capper@linaro.org>
 <20140627112420.GK26276@arm.com>
Message-ID: <20140627122359.GA30585@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:24:20PM +0100, Will Deacon wrote:
> Hi Steve,

Hey Will,

> 
> On Tue, Jun 24, 2014 at 01:23:23PM +0100, Steve Capper wrote:
> > Long descriptors on ARM are 64 bits, and some pte functions such as
> > pte_dirty return a bitwise-and of a flag with the pte value. If the
> > flag to be tested resides in the upper 32 bits of the pte, then we run
> > into the danger of the result being dropped if downcast.
> > 
> > For example:
> > 	gather_stats(page, md, pte_dirty(*pte), 1);
> > where pte_dirty(*pte) is downcast to an int.
> > 
> > This patch introduces a new macro pte_isset which performs the bitwise
> > and, then performs a double logical invert (where needed) to ensure
> > predictable downcasting. The logical inverse pte_isclear is also
> > introduced.
> > 
> > Equivalent pmd functions for Transparent HugePages have also been
> > added.
> 
> 
> [...]
> 
> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index 85c60ad..3b10ec6 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -207,17 +207,21 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
> >  #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
> >  #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
> >  
> > -#define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
> > +#define pmd_isset(pmd, val)	((u32)(val) == (val) ? pmd_val(pmd) & (val) \
> > +						: !!(pmd_val(pmd) & (val)))
> > +#define pmd_isclear(pmd, val)	(!(pmd_val(pmd) & (val)))
> > +
> > +#define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
> >  
> >  #define __HAVE_ARCH_PMD_WRITE
> > -#define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
> > +#define pmd_write(pmd)		(pmd_isclear((pmd), PMD_SECT_RDONLY))
> >  
> >  #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
> >  #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> >  
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> > -#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
> > +#define pmd_trans_huge(pmd)	(pmd_val(pmd) && pmd_isclear((pmd), PMD_TABLE_BIT))
> 
> Why isn't this just pmd_present(pmd) && !pmd_table(pmd)? Put another way, I
> see to have forgotten why we need PMD_TABLE_BIT instead of just using
> pmd_table and pmd_sect to work out whether we have a table or a block.
> 

If we use pmd_sect, we are testing for block entries, but THPs are allowed to
be faulting entries (i.e. PROT_NONE). A non-zero pmd that does not have the
table bit set can safely be assumed to be a PROT_NONE THP.

Cheers,
-- 
Steve

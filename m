From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 13:47:13 +0100
Subject: [PATCH V5 2/2] arm: mm: Modify pte_write and pmd_write logic for
 LPAE
In-Reply-To: <20140627124200.GB30585@linaro.org>
References: <1403612604-2645-1-git-send-email-steve.capper@linaro.org>
 <1403612604-2645-3-git-send-email-steve.capper@linaro.org>
 <20140627113933.GL26276@arm.com>
 <20140627124200.GB30585@linaro.org>
Message-ID: <20140627124713.GQ26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 01:42:00PM +0100, Steve Capper wrote:
> On Fri, Jun 27, 2014 at 12:39:34PM +0100, Will Deacon wrote:
> > On Tue, Jun 24, 2014 at 01:23:24PM +0100, Steve Capper wrote:
> > > diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
> > > index 626989f..552a5f7 100644
> > > --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> > > +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> > > @@ -72,6 +72,7 @@
> > >  #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
> > >  #define PTE_BUFFERABLE		(_AT(pteval_t, 1) << 2)		/* AttrIndx[0] */
> > >  #define PTE_CACHEABLE		(_AT(pteval_t, 1) << 3)		/* AttrIndx[1] */
> > > +#define PTE_AP2			(_AT(pteval_t, 1) << 7)		/* AP[2] */
> > 
> > PTE_RDONLY? AP2 is pretty cryptic.
> 
> That is probably better, but could it be confused with L_PRE_RDONLY?
> (Please see below for the pmd analogue).

Comments below, I seem to have fallen into my own trap.

> > > @@ -257,8 +259,13 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> > >  	BUG_ON(addr >= TASK_SIZE);
> > >  
> > >  	/* create a faulting entry if PROT_NONE protected */
> > > -	if (pmd_val(pmd) & PMD_SECT_NONE)
> > > -		pmd_val(pmd) &= ~PMD_SECT_VALID;
> > > +	if (pmd_val(pmd) & L_PMD_SECT_NONE)
> > > +		pmd_val(pmd) &= ~L_PMD_SECT_VALID;
> > > +
> > > +	if (pmd_write(pmd) && pmd_dirty(pmd))
> > > +		pmd_val(pmd) &= ~PMD_SECT_RDONLY;
> > 
> > pmd_mkwrite?
> > 
> > > +	else
> > > +		pmd_val(pmd) |= PMD_SECT_RDONLY;
> > 
> > pmd_wrprotect?
> 
> I'm setting the hardware bits here. I tried to distinguish:
> PMD_SECT_RDONLY and L_PMD_SECT_RDONLY. I think I should probably rename
> PMD_SECT_RDONLY to something else?

Ok, so that's actually a really good argument to keep AP2 as the name for
both ptes and pmds. In that case, the comment we have " /* AP[2] */ is
useless and should say "RDONLY". Then we have non-ambiguous symbol names
alongside descriptive comments -- not something I'm used to in the kernel
sources!

Will

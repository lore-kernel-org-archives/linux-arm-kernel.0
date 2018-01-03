From: steve.capper@arm.com (Steve Capper)
Date: Wed, 3 Jan 2018 13:03:58 +0000
Subject: [PATCH] arm64: dirty memory check, enable soft dirty for arm64
In-Reply-To: <20180102181910.gxiqaehznpw2hc6u@armageddon.cambridge.arm.com>
References: <1512029649-61312-1-git-send-email-bin.lu@arm.com>
 <20180102181910.gxiqaehznpw2hc6u@armageddon.cambridge.arm.com>
Message-ID: <20180103130358.iur5hkk4hhb6ldws@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Jan 02, 2018 at 06:19:10PM +0000, Catalin Marinas wrote:
> Hi Bin,
> 
> On Thu, Nov 30, 2017 at 12:14:09AM -0800, Bin Lu wrote:
> >     pmd_dirty and pmd_mkclean for THP page MADV_FREE also were
> >     supported in this patch.
> [...]
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -306,6 +306,28 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
> >  	return __pgprot(pgprot_val(prot) & ~PTE_TABLE_BIT);
> >  }
> >  
> > +#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> > +static inline bool pte_soft_dirty(pte_t pte)
> > +{
> > +        return pte_sw_dirty(pte);
> > +}
> > +
> > +static inline pte_t pte_mksoft_dirty(pte_t pte)
> > +{
> > +        return pte_mkdirty(pte);
> > +}
> > +
> > +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> > +{
> > +        return pte_mkclean(pte);
> > +}
> > +
> > +#define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
> > +#define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
> > +#define pmd_clear_soft_dirty(pmd) pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
> 
> IIUC, a pmd_mkclean() would result in a pte_soft_dirty() == false. Is
> this the expected behaviour with MADV_FREE? The x86 code sets both
> _PAGE_DIRTY and _PAGE_SOFT_DIRTY in pmd_mkdirty() but only clears
> _PAGE_DIRTY in pmd_mkclean().
> 

For MADV_FREE, my understanding is that userspace hints to the memory
manager that pages are no longer needed and if no subsequent
modifications are made to the page then the kernel can free the pages
(and swap in a zero page should userspace attempt to read back the page
after it's been freed).

We would get a divergence in behaviour between arm64 and x86 when a
userspace program calls MADV_FREE on a soft dirty page, and where the
memory manager has not yet freed it.

So on x86 the page would be flagged as soft dirty and on arm64 this
would not be soft dirty.  I originally thought that this would be okay
as userspace has flagged the page as no longer needed. Having had
another big think about it though, I think we'd have one potential
problem with the following course of events:

 * CRIU dumps out page A from running process,
 * process subsequently modifies page A -> marked as soft dirty,
 * process calls MADV_FREE, page A no longer soft dirty,
 * CRIU does not pick up on the changes made to page A, so the other end
   gets an old page restored.

Apologies for missing this before, I neglected to make the distinction
between stale data and dropped data (userspace knows about dropped data
because the page comes back in as zeros).

The arm64 pte_dirty() checks for software and hardware dirty, thus our
pte_mkclean() should clear both states lest MADV_FREE would result in no
pages being swapped out under memory pressure.

Adding an extra dirty bit would fix this (but then we'd have effectively
three dirty bits for ptes), it is not clear to me whether or not the
HW/SW dirty bit logic could be tweaked for arm64 to give us behaviour
parity with x86.

Anyway some more thought required :-).

Cheers,
-- 
Steve

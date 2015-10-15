From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 13:44:51 +0100
Subject: [PATCHv3 03/11] arm64: Introduce helpers for page table levels
In-Reply-To: <20151015113735.GB21930@cbox>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
 <20151015113735.GB21930@cbox>
Message-ID: <20151015124451.GI8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 01:37:35PM +0200, Christoffer Dall wrote:
> On Wed, Oct 14, 2015 at 12:20:26PM +0100, Suzuki K. Poulose wrote:
> > Introduce helpers for finding the number of page table
> > levels required for a given VA width, shift for a particular
> > page table level.
> > 
> > Convert the existing users to the new helpers. More users
> > to follow.
> > 
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> > 
> > ---
> > Changes since V2:
> >   - Add comments around the macros
> >   - Change ARM64_HW_PGTABLE_LEVEL_SHIFT to accept pagetable level as
> >     described by ARM ARM
> > ---
> >  arch/arm64/include/asm/pgtable-hwdef.h |   25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> > index 95c1ec0..c6194ab 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -16,13 +16,31 @@
> >  #ifndef __ASM_PGTABLE_HWDEF_H
> >  #define __ASM_PGTABLE_HWDEF_H
> >  
> > +/*
> > + * Number of page-table levels required to address 'va_bits' wide
> > + * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
> > + * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
> > + *
> > + *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
> > + *
> > + * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
> > + * due to build issues. So we use the following magic formula.
> > + */
> > +#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
> > +
> > +/*
> > + * Size mapped by an entry at level n
> > + * We map PAGE_SHIFT - 3 at all levels, except the PAGE_SHIFT bits at the last level
> > + */
> > +#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
> 
> I feel like I'm partially failing the interview question again, in that
> I don't fully understand the '+ 3' in the end?

The last level handles PAGE_SHIFT bits (the bits from the VA that are
the same in the PA). We only accounted for (PAGE_SHIFT - 3) bits at each
level when multiplying, so we add those 3 missing bits back at the end.

Thanks,
Mark.

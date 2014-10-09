From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 9 Oct 2014 13:01:37 +0200
Subject: [PATCH v2 1/3] arm64: KVM: Implement 48 VA support for KVM EL2
 and Stage-2
In-Reply-To: <20141008094703.GB5906@e104818-lin.cambridge.arm.com>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
 <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
 <20141007104846.GB12675@e104818-lin.cambridge.arm.com>
 <5433EA8B.6010502@arm.com> <20141007193954.GI3717@cbox>
 <20141008094703.GB5906@e104818-lin.cambridge.arm.com>
Message-ID: <20141009110137.GX3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 10:47:04AM +0100, Catalin Marinas wrote:
> On Tue, Oct 07, 2014 at 08:39:54PM +0100, Christoffer Dall wrote:
> > I came up with the following based on your feedback, but I personally
> > don't find it a lot easier to read than what I had already.  Suggestions
> > are welcome:
> 
> At least PTRS_PER_S2_PGD and KVM_PREALLOC_LEVEL are clearer to me as
> formulas than the magic numbers.
> 

Agreed.

> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index a030d16..7941a51 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> [...]
> > +/*
> > + * In the case where PGDIR_SHIFT is larger than KVM_PHYS_SHIFT, we can address
> > + * the entire IPA input range with a single pgd entry, and we would only need
> > + * one pgd entry.
> > + */
> 
> It may be worth here stating that this pgd is actually fake (covered
> below as well). Maybe something like "single (fake) pgd entry".
> 

Yes.

> > +#if PGDIR_SHIFT > KVM_PHYS_SHIFT
> > +#define PTRS_PER_S2_PGD                (1)
> > +#else
> > +#define PTRS_PER_S2_PGD                (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
> > +#endif
> > +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > 
> > +/*
> > + * If we are concatenating first level stage-2 page tables, we would have less
> > + * than or equal to 16 pointers in the fake PGD, because that's what the
> > + * architecture allows.  In this case, (4 - CONFIG_ARM64_PGTABLE_LEVELS)
> > + * represents the first level for the host, and we add 1 to go to the next
> > + * level (which uses contatenation) for the stage-2 tables.
> > + */
> > +#if PTRS_PER_S2_PGD <= 16
> > +#define KVM_PREALLOC_LEVEL     (4 - CONFIG_ARM64_PGTABLE_LEVELS + 1)
> > +#else
> > +#define KVM_PREALLOC_LEVEL     (0)
> > +#endif
> > +
> > +/**
> > + * kvm_prealloc_hwpgd - allocate inital table for VTTBR
> > + * @kvm:       The KVM struct pointer for the VM.
> > + * @pgd:       The kernel pseudo pgd
> > + *
> > + * When the kernel uses more levels of page tables than the guest, we allocate
> > + * a fake PGD and pre-populate it to point to the next-level page table, which
> > + * will be the real initial page table pointed to by the VTTBR.
> > + *
> > + * When KVM_PREALLOC_LEVEL==2, we allocate a single page for the PMD and
> > + * the kernel will use folded pud.  When KVM_PREALLOC_LEVEL==1, we
> > + * allocate 2 consecutive PUD pages.
> > + */
> 
> I don't have a strong preference here, if you find the code easier to
> read as separate kvm_prealloc_hwpgd() functions, use those, as per your
> original patch. My point was to no longer define the functions based on
> #if 64K && 3-levels etc. but only on KVM_PREALLOC_LEVEL.
> 
> Anyway, I think the code below looks ok, with some fixes.
> 

I think it's nicer too once I got used to it.

> > +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> > +{
> > +       pud_t *pud;
> > +       pmd_t *pmd;
> > +       unsigned int order, i;
> > +       unsigned long hwpgd;
> > +
> > +       if (KVM_PREALLOC_LEVEL == 0)
> > +               return 0;
> > +
> > +       order = get_order(PTRS_PER_S2_PGD);
> 
> Isn't order always 0 here? Based on our IRC discussion, PTRS_PER_S2_PGD
> is 16 or less and the order should not be used.
> 

no, if the kernel has 4K pages and 4 levels, then PGDIR_SHIFT is 39, and
KVM_PHYS_SHIFT stays 40, so that means PTRS_PER_S2_PGD becomes 2, which
means we concatenate two first level stage-2 page tables, which means we
need to allocate two consecutive pages, giving us an order of 1, not 0.

That's exactly why we use get_order(PTRS_PER_S2_PGD) instead of
S2_PGD_ORDER, which is only used when we're not doing the fake PGD trick
(see my response to Marc's mail).

> > +       hwpgd = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> 
> I assume you need __get_free_pages() for alignment.
> 

yes, would you prefer a comment to that fact?

> > +       if (!hwpgd)
> > +               return -ENOMEM;
> > +
> > +       if (KVM_PREALLOC_LEVEL == 1) {
> > +               pud = (pud_t *)hwpgd;
> > +               for (i = 0; i < PTRS_PER_S2_PGD; i++)
> > +                       pgd_populate(NULL, pgd + i, pud + i * PTRS_PER_PUD);
> > +       } else if (KVM_PREALLOC_LEVEL == 2) {
> > +               pud = pud_offset(pgd, 0);
> > +               pmd = (pmd_t *)hwpgd;
> > +               for (i = 0; i < PTRS_PER_S2_PGD; i++)
> > +                       pud_populate(NULL, pud + i, pmd + i * PTRS_PER_PMD);
> > +       }
> 
> It could be slightly shorter as (I can't guarantee clearer ;)):
> 
> 	for (i = 0; i < PTRS_PER_S2_PGD; i++) {
> 		if (KVM_PREALLOC_LEVEL == 1)
> 			pgd_populate(NULL, pgd + i,
> 				     (pud_t *)hwpgd + i * PTRS_PER_PUD);
> 		else if (KVM_PREALLOC_LEVEL == 2)
> 			pud_populate(NULL, pud_offset(pgd, 0) + i,
> 				     (pmd_t *)hwpgd + i * PTRS_PER_PMD)
> 	}
> 
> Or you could write a kvm_populate_swpgd() to handle the ifs and casting.
> 

I actually quite like this, let's see how it looks in the next revision
and if people really dislike it, we can look at factoring it out
further.

> > +
> > +       return 0;
> > +}
> > +
> > +static inline void *kvm_get_hwpgd(struct kvm *kvm)
> > +{
> > +       pgd_t *pgd = kvm->arch.pgd;
> > +       pud_t *pud;
> > +       pmd_t *pmd;
> > +
> > +       switch (KVM_PREALLOC_LEVEL) {
> > +       case 0:
> > +               return pgd;
> > +       case 1:
> > +               pud = pud_offset(pgd, 0);
> > +               return pud;
> > +       case 2:
> > +               pud = pud_offset(pgd, 0);
> > +               pmd = pmd_offset(pud, 0);
> > +               return pmd;
> > +       default:
> > +               BUG();
> > +               return NULL;
> > +       }
> 
> 	/* not needed? Use BUG_ON or BUILD_BUG_ON */
> 	if (KVM_PREALLOC_LEVEL == 0)
> 		return pgd;
> 
> 	pud = pud_offset(pgd, 0);
> 	if (KVM_PREALLOC_LEVEL == 1)
> 		return pud;
> 
> 	return pmd_offset(pud, 0);

I like this, but...

> 
> You don't need KVM_PREALLOC_LEVEL == 0 case since this function wouldn't
> be called. So you could do with some (BUILD_)BUG_ON and 4 lines after.
> 
It is needed and it is called from arch/arm/kvm/arm.c in update_vttbr().

Thanks!
-Christoffer

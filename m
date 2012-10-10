From: mingyu84.kim@samsung.com (Min-gyu Kim)
Date: Wed, 10 Oct 2012 10:02:11 +0900
Subject: [kvmarm] [PATCH v2 06/14] KVM: ARM: Memory virtualization setup
In-Reply-To: <6994599196536c9557528c465f8f93b0@localhost>
References: <20121001090945.49198.68950.stgit@ubuntu>
 <20121001091042.49198.93241.stgit@ubuntu>
 <000401cda2a0$69670a40$3c351ec0$@samsung.com>
 <CANM98qKAFQgfwRuFP2WOP4Af+1Un-wuQPC8-TiGi4B+s3XB2hQ@mail.gmail.com>
 <6994599196536c9557528c465f8f93b0@localhost>
Message-ID: <001501cda682$e220eba0$a662c2e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Tuesday, October 09, 2012 9:56 PM
> To: Christoffer Dall
> Cc: Min-gyu Kim; ???; linux-arm-kernel at lists.infradead.org;
> kvm at vger.kernel.org; kvmarm at lists.cs.columbia.edu
> Subject: Re: [kvmarm] [PATCH v2 06/14] KVM: ARM: Memory virtualization
> setup
> 
> On Sat, 6 Oct 2012 17:33:43 -0400, Christoffer Dall
> <c.dall@virtualopensystems.com> wrote:
> > On Thu, Oct 4, 2012 at 10:23 PM, Min-gyu Kim
> > <mingyu84.kim@samsung.com>
> > wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org]
> >>> On Behalf Of Christoffer Dall
> >>> Sent: Monday, October 01, 2012 6:11 PM
> >>> To: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >>> kvmarm at lists.cs.columbia.edu
> >>> Cc: Marc Zyngier
> >>> Subject: [PATCH v2 06/14] KVM: ARM: Memory virtualization setup
> >>>
> >>> +static void stage2_set_pte(struct kvm *kvm, struct
> kvm_mmu_memory_cache
> >>> *cache,
> >>> +                        phys_addr_t addr, const pte_t *new_pte) {
> >>> +     pgd_t *pgd;
> >>> +     pud_t *pud;
> >>> +     pmd_t *pmd;
> >>> +     pte_t *pte, old_pte;
> >>> +
> >>> +     /* Create 2nd stage page table mapping - Level 1 */
> >>> +     pgd = kvm->arch.pgd + pgd_index(addr);
> >>> +     pud = pud_offset(pgd, addr);
> >>> +     if (pud_none(*pud)) {
> >>> +             if (!cache)
> >>> +                     return; /* ignore calls from kvm_set_spte_hva */
> >>> +             pmd = mmu_memory_cache_alloc(cache);
> >>> +             pud_populate(NULL, pud, pmd);
> >>> +             pmd += pmd_index(addr);
> >>> +             get_page(virt_to_page(pud));
> >>> +     } else
> >>> +             pmd = pmd_offset(pud, addr);
> >>> +
> >>> +     /* Create 2nd stage page table mapping - Level 2 */
> >>> +     if (pmd_none(*pmd)) {
> >>> +             if (!cache)
> >>> +                     return; /* ignore calls from kvm_set_spte_hva */
> >>> +             pte = mmu_memory_cache_alloc(cache);
> >>> +             clean_pte_table(pte);
> >>> +             pmd_populate_kernel(NULL, pmd, pte);
> >>> +             pte += pte_index(addr);
> >>> +             get_page(virt_to_page(pmd));
> >>> +     } else
> >>> +             pte = pte_offset_kernel(pmd, addr);
> >>> +
> >>> +     /* Create 2nd stage page table mapping - Level 3 */
> >>> +     old_pte = *pte;
> >>> +     set_pte_ext(pte, *new_pte, 0);
> >>> +     if (pte_present(old_pte))
> >>> +             __kvm_tlb_flush_vmid(kvm);
> >>> +     else
> >>> +             get_page(virt_to_page(pte)); }
> >>
> >>
> >> I'm not sure about the 3-level page table, but isn't it necessary to
> >> clean the page table for 2nd level?
> >> There are two mmu_memory_cache_alloc calls. One has following
> >> clean_pte_table and the other doesn't have.
> >
> > hmm, it probably is - I couldn't really find the common case where
> > this is done in the kernel normally (except for some custom loop in
> > ioremap and idmap), but I added this fix:
> >
> > diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c index
> > 5394a52..f11ba27f 100644
> > --- a/arch/arm/kvm/mmu.c
> > +++ b/arch/arm/kvm/mmu.c
> > @@ -430,6 +430,7 @@ static void stage2_set_pte(struct kvm *kvm, struct
> > kvm_mmu_memory_cache *cache,
> >  		if (!cache)
> >  			return; /* ignore calls from kvm_set_spte_hva */
> >  		pmd = mmu_memory_cache_alloc(cache);
> > +		clean_dcache_area(pmd, PTRS_PER_PMD * sizeof(pmd_t));
> >  		pud_populate(NULL, pud, pmd);
> >  		pmd += pmd_index(addr);
> >  		get_page(virt_to_page(pud));
> 
> There ought to be a test of ID_MMFR3[23:20] to find out whether or not it
> is useful to clean the dcache. Not sure if that's a massive gain, but it
> is certainly an optimisation to consider for the kernel as a whole.

That's part of what I was wondering. clean_dcache_area is substituted by nop if
TLB_CAN_READ_FROM_L1_CACHE is defined(mm/proc-v7.S). 
But I couldn't find any place where it is defined.
If it is part of bsp to enable TLB_CAN_RAD_FROM_L1_CACHE according to ID_MMFR3[23:20],
it would not be necessary to concerned about cleaning or not cleaning.

However, am I right?

> 
>         M.
> --
> Fast, cheap, reliable. Pick two.

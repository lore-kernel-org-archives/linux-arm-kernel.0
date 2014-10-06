From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 6 Oct 2014 15:41:18 +0200
Subject: [PATCH 1/2] arm64: KVM: Implement 48 VA support for KVM EL2 and
 Stage-2
In-Reply-To: <20140930123944.GB12702@e104818-lin.cambridge.arm.com>
References: <1411674174-30672-1-git-send-email-christoffer.dall@linaro.org>
 <1411674174-30672-2-git-send-email-christoffer.dall@linaro.org>
 <20140930123944.GB12702@e104818-lin.cambridge.arm.com>
Message-ID: <20141006134118.GA3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Sep 30, 2014 at 01:39:47PM +0100, Catalin Marinas wrote:
> Hi Christoffer,
> 
> On Thu, Sep 25, 2014 at 08:42:53PM +0100, Christoffer Dall wrote:
> > diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> > index 7796051..048f37f 100644
> > --- a/arch/arm/kvm/arm.c
> > +++ b/arch/arm/kvm/arm.c
> > @@ -409,7 +409,7 @@ static void update_vttbr(struct kvm *kvm)
> >         kvm_next_vmid++;
> >
> >         /* update vttbr to be used with the new vmid */
> > -       pgd_phys = virt_to_phys(kvm->arch.pgd);
> > +       pgd_phys = kvm_get_hwpgd(kvm);
> >         BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
> >         vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
> >         kvm->arch.vttbr = pgd_phys | vmid;
> > diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> > index bb06f76..4532f5f 100644
> > --- a/arch/arm/kvm/mmu.c
> > +++ b/arch/arm/kvm/mmu.c
> > @@ -33,6 +33,7 @@
> >
> >  extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
> >
> > +static int kvm_prealloc_levels;
> 
> Do you have plans to determine this dynamically? In this patch, I can
> only see it being assigned to KVM_PREALLOC_LEVELS. I guess you could
> simply use the macro.
> 

Yes, I could.  Not really sure why I did this.

> > @@ -521,6 +554,7 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t phys_addr)
> >   */
> >  int kvm_alloc_stage2_pgd(struct kvm *kvm)
> >  {
> > +       int ret;
> >         pgd_t *pgd;
> >
> >         if (kvm->arch.pgd != NULL) {
> > @@ -533,9 +567,17 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
> >                 return -ENOMEM;
> >
> >         memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
> 
> I don't think you need to allocate a full page here (not shown here in
> the diff context) but it may not be trivial since you use get_page() to
> keep track of when page tables could be freed (do you do this for the
> pgd as well?).
> 

The code becomes a bit weird, because we'd have to check if this is
really just the fake pseudo-pgds and we can just use kmalloc(), but if
it's not, we have to use __get_free_pages() to adhere to the
architecture's alignment requirements for the VTTBR physical address.

I'll try to fix this in the next version and we can see how it looks
like.

As far as the get_page() counting goes, since we always fully propogate
this first level pseudo table, we never mess with the page counts except
for in kvm_prealloc_hwpgd() and kvm_free_hwpgd() so we can just take all
the get/put_page stuff out of those and we should be in the clear.

> > +
> > +       ret = kvm_prealloc_hwpgd(kvm, pgd);
> > +       if (ret)
> > +               goto out;
> > +
> >         kvm_clean_pgd(pgd);
> >         kvm->arch.pgd = pgd;
> > -
> > +       ret = 0;
> > +out:
> > +       if (ret)
> > +               free_pages((unsigned long)pgd, S2_PGD_ORDER);
> >         return 0;
> >  }
> 
> Does this always return 0, even in case of error?

Me being braindead, sorry.

> Does it look better
> as:
> 
>         ret = kvm_prealloc_hwpgd(kvm, pgd);
>         if (ret)
>                 goto out;
> 
>         kvm_clean_pgd(pgd);
>         kvm->arch.pgd = pgd;
> 
>         return 0;
> 
> out:
>         free_pages((unsigned long)pgd, S2_PGD_ORDER);
>         return ret;
> 

probably looks better, I'd rename out to out_err, but yes.

> > @@ -572,19 +614,36 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
> >                 return;
> >
> >         unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
> > +       kvm_free_hwpgd(kvm);
> >         free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
> >         kvm->arch.pgd = NULL;
> >  }
> >
> > -static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> > +static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >                              phys_addr_t addr)
> >  {
> >         pgd_t *pgd;
> >         pud_t *pud;
> > -       pmd_t *pmd;
> >
> >         pgd = kvm->arch.pgd + pgd_index(addr);
> > -       pud = pud_offset(pgd, addr);
> > +       if (pgd_none(*pgd)) {
> > +               if (!cache)
> > +                       return NULL;
> > +               pud = mmu_memory_cache_alloc(cache);
> > +               pgd_populate(NULL, pgd, pud);
> > +               get_page(virt_to_page(pgd));
> > +       }
> > +
> > +       return pud_offset(pgd, addr);
> > +}
> 
> This function looks correct, though we would not expect pgd_none() to
> ever be true as we pre-populate it.
> You could but a WARN_ON or something
> until we actually have hardware 4-levels stage 2 (though I don't see a
> need yet).
> 

pgd_none will never be true, because on both aarch64 and arm we fold the
pud into the pgd (and include pgtable-nopud.h) if we have less than 4
levels, and if we do have 4 levels, then we have preallocated and
prepopulated the pgd.  If I got this right, I agree, and we should add
the WARN_ON or VM_BUG_ON or something.

> > +static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> > +                            phys_addr_t addr)
> > +{
> > +       pud_t *pud;
> > +       pmd_t *pmd;
> > +
> > +       pud = stage2_get_pud(kvm, cache, addr);
> >         if (pud_none(*pud)) {
> >                 if (!cache)
> >                         return NULL;
> > @@ -630,7 +689,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> >         pmd_t *pmd;
> >         pte_t *pte, old_pte;
> >
> > -       /* Create stage-2 page table mapping - Level 1 */
> > +       /* Create stage-2 page table mapping - Levels 0 and 1 */
> >         pmd = stage2_get_pmd(kvm, cache, addr);
> >         if (!pmd) {
> >                 /*
> > @@ -688,7 +747,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> >         for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
> >                 pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
> >
> > -               ret = mmu_topup_memory_cache(&cache, 2, 2);
> > +               ret = mmu_topup_memory_cache(&cache, KVM_MMU_CACHE_MIN_PAGES,
> > +                                               KVM_MMU_CACHE_MIN_PAGES);
> 
> BTW, why do you need to preallocate the pages in KVM's own cache? Would
> GFP_ATOMIC not work within the kvm->mmu_lock region?
> 

It would, but it doesn't really seem like the sort of thing you would
want to tap into the GFP_ATOMIC pool for, would it?  A bunch of VMs
could seriously trash your host by asking for a lot of address space.

I think that was the rationale for doing things this way on x86 and it
made sense to me...

> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fd4e81a..0f3e0a9 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -200,7 +200,6 @@ config ARM64_VA_BITS_42
> >
> >  config ARM64_VA_BITS_48
> >         bool "48-bit"
> > -       depends on BROKEN
> 
> I'm ok with removing BROKEN here but I think at the same time we need to
> disable the SMMU driver which has similar issues with (not) supporting
> 4-levels page tables for stage 2 (stage 1 should be fine).

Should that be in separate patches, or is it fine to just include it
here?

> 
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index a030d16..313c6f9 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> [...]
> > @@ -118,13 +128,123 @@ static inline bool kvm_page_empty(void *ptr)
> >  }
> >
> >  #define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
> > -#ifndef CONFIG_ARM64_64K_PAGES
> > -#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> > -#else
> > +#if CONFIG_ARM64_PGTABLE_LEVELS == 2
> >  #define kvm_pmd_table_empty(pmdp) (0)
> > -#endif
> >  #define kvm_pud_table_empty(pudp) (0)
> > +#elif CONFIG_ARM64_PGTABLE_LEVELS == 3
> > +#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> > +#define kvm_pud_table_empty(pudp) (0)
> > +#elif CONFIG_ARM64_PGTABLE_LEVELS == 4
> > +#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> > +#define kvm_pud_table_empty(pudp) kvm_page_empty(pudp)
> > +#endif
> 
> Not sure whether it's clearer as (up to you):
> 
> #ifdef __PAGETABLE_PMD_FOLDED
> #define kvm_pmd_table_empty(pmdp)       (0)
> #else
> #define kvm_pmd_table_empty(pmdp)       kvm_page_empty(pmdp)
> #endif
> 
> #ifdef __PAGETABLE_PUD_FOLDED
> #define kvm_pud_table_empty(pudp)       (0)
> #else
> #define kvm_pud_table_empty(pudp)       kvm_page_empty(pudp)
> #endif
> 
> 

I think it probably is more clear.

> > +
> > +/**
> > + * kvm_prealloc_hwpgd - allocate inital table for VTTBR
> > + * @kvm:       The KVM struct pointer for the VM.
> > + * @pgd:       The kernel pseudo pgd
> 
> "hwpgd" doesn't sound like the right name since it's actually a fake pgd
> that it is allocating. Maybe "swpgd"?
> 

The fake pgd was already allocated in kvm_alloc_stage2_pgd(), now we're
allocating the first-level page table that is going to be walked by the
MMU for Stage-2 translations (the address of which will go into the
VTTBR), so that's the reasoning for calling it the hwpgd.

Does that make sense?

> > + *
> > + * When the kernel uses more levels of page tables than the guest, we allocate
> > + * a fake PGD and pre-populate it to point to the next-level page table, which
> > + * will be the real initial page table pointed to by the VTTBR.
> > + *
> > + * When KVM_PREALLOC_PMD is defined, we allocate a single page for the PMD and
> > + * the kernel will use folded pud.  When KVM_PREALLOC_PUD is defined, we
> > + * allocate 2 consecutive PUD pages.
> > + */
> > +#if defined(CONFIG_ARM64_64K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 3
> > +#define KVM_PREALLOC_LEVELS    2
> > +#define PTRS_PER_S2_PGD                1
> > +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > +
> > +
> > +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> > +{
> > +       pud_t *pud;
> > +       pmd_t *pmd;
> > +
> > +       pud = pud_offset(pgd, 0);
> > +       pmd = (pmd_t *)__get_free_pages(GFP_KERNEL, 0);
> > +
> > +       if (!pmd)
> > +               return -ENOMEM;
> > +       memset(pmd, 0, PAGE_SIZE);
> 
> You could use __GFP_ZERO.
> 

yes, Ard also commented on that, we should do that.

> > +       pud_populate(NULL, pud, pmd);
> > +       get_page(virt_to_page(pud));
> > +
> > +       return 0;
> > +}
> >
> > +static inline void kvm_free_hwpgd(struct kvm *kvm)
> > +{
> > +       pgd_t *pgd = kvm->arch.pgd;
> > +       pud_t *pud = pud_offset(pgd, 0);
> > +       pmd_t *pmd = pmd_offset(pud, 0);
> > +       free_pages((unsigned long)pmd, 0);
> > +       put_page(virt_to_page(pud));
> > +}
> > +
> > +static inline phys_addr_t kvm_get_hwpgd(struct kvm *kvm)
> > +{
> > +       pgd_t *pgd = kvm->arch.pgd;
> > +       pud_t *pud = pud_offset(pgd, 0);
> > +       pmd_t *pmd = pmd_offset(pud, 0);
> > +       return virt_to_phys(pmd);
> > +
> > +}
> > +#elif defined(CONFIG_ARM64_4K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 4
> > +#define KVM_PREALLOC_LEVELS    1
> > +#define PTRS_PER_S2_PGD                2
> > +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > +
> > +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> > +{
> > +       pud_t *pud;
> > +
> > +       pud = (pud_t *)__get_free_pages(GFP_KERNEL, 1);
> > +       if (!pud)
> > +               return -ENOMEM;
> > +       memset(pud, 0, 2 * PAGE_SIZE);
> > +       pgd_populate(NULL, pgd, pud);
> > +       pgd_populate(NULL, pgd + 1, pud + PTRS_PER_PUD);
> > +       get_page(virt_to_page(pgd));
> > +       get_page(virt_to_page(pgd));
> > +
> > +       return 0;
> > +}
> > +
> > +static inline void kvm_free_hwpgd(struct kvm *kvm)
> > +{
> > +       pgd_t *pgd = kvm->arch.pgd;
> > +       pud_t *pud = pud_offset(pgd, 0);
> > +       free_pages((unsigned long)pud, 1);
> > +       put_page(virt_to_page(pgd));
> > +       put_page(virt_to_page(pgd));
> > +}
> > +
> > +static inline phys_addr_t kvm_get_hwpgd(struct kvm *kvm)
> > +{
> > +       pgd_t *pgd = kvm->arch.pgd;
> > +       pud_t *pud = pud_offset(pgd, 0);
> > +       return virt_to_phys(pud);
> > +}
> > +#else
> > +#define KVM_PREALLOC_LEVELS    0
> > +#define PTRS_PER_S2_PGD                (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
> > +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > +
> > +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> > +{
> > +       return 0;
> > +}
> > +
> > +static inline void kvm_free_hwpgd(struct kvm *kvm) { }
> > +
> > +static inline phys_addr_t kvm_get_hwpgd(struct kvm *kvm)
> > +{
> > +       return virt_to_phys(kvm->arch.pgd);
> > +}
> > +#endif
> 
> I think all the above could be squashed into a single set of function
> implementations with the right macros defined before.
> 
> For the KVM levels, you could use something like (we exchanged emails in
> private on this topic and how I got to these macros but they need better
> checking):
> 
> #define KVM_PGTABLE_LEVELS      ((KVM_PHYS_SHIFT - PAGE_SHIFT - 5) / (PAGE_SHIFT - 3) + 1)
> #define KVM_PREALLOC_LEVELS     (CONFIG_ARM64_PGTABLE_LEVELS - KVM_PGTABLE_LEVELS)
> #if PGDIR_SHIFT > KVM_PHYS_SHIFT
> #define PTRS_PER_S2_PGD		(1)
> #else
> #define PTRS_PER_S2_PGD		(1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
> #endif
> 

I'll revisit this, but the amount of time I needed to spend making sure
I understand this sort of indicated to me that it was simpler to just
spell it out.  What do you think?  Do you strongly prefer the simple
macro definitions?

Thanks for the review!

-Christoffer

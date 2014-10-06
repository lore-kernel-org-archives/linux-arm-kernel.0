From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 6 Oct 2014 21:54:36 +0200
Subject: [PATCH 1/2] arm64: KVM: Implement 48 VA support for KVM EL2 and
 Stage-2
In-Reply-To: <20141006155443.GA6536@e104818-lin.cambridge.arm.com>
References: <1411674174-30672-1-git-send-email-christoffer.dall@linaro.org>
 <1411674174-30672-2-git-send-email-christoffer.dall@linaro.org>
 <20140930123944.GB12702@e104818-lin.cambridge.arm.com>
 <20141006134118.GA3717@cbox>
 <20141006155443.GA6536@e104818-lin.cambridge.arm.com>
Message-ID: <20141006195436.GC3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 04:54:46PM +0100, Catalin Marinas wrote:
> On Mon, Oct 06, 2014 at 02:41:18PM +0100, Christoffer Dall wrote:
> > On Tue, Sep 30, 2014 at 01:39:47PM +0100, Catalin Marinas wrote:
> > > On Thu, Sep 25, 2014 at 08:42:53PM +0100, Christoffer Dall wrote:
> > > > @@ -572,19 +614,36 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
> > > >                 return;
> > > >
> > > >         unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
> > > > +       kvm_free_hwpgd(kvm);
> > > >         free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
> > > >         kvm->arch.pgd = NULL;
> > > >  }
> > > >
> > > > -static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> > > > +static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> > > >                              phys_addr_t addr)
> > > >  {
> > > >         pgd_t *pgd;
> > > >         pud_t *pud;
> > > > -       pmd_t *pmd;
> > > >
> > > >         pgd = kvm->arch.pgd + pgd_index(addr);
> > > > -       pud = pud_offset(pgd, addr);
> > > > +       if (pgd_none(*pgd)) {
> > > > +               if (!cache)
> > > > +                       return NULL;
> > > > +               pud = mmu_memory_cache_alloc(cache);
> > > > +               pgd_populate(NULL, pgd, pud);
> > > > +               get_page(virt_to_page(pgd));
> > > > +       }
> > > > +
> > > > +       return pud_offset(pgd, addr);
> > > > +}
> > >
> > > This function looks correct, though we would not expect pgd_none() to
> > > ever be true as we pre-populate it.
> > > You could but a WARN_ON or something
> > > until we actually have hardware 4-levels stage 2 (though I don't see a
> > > need yet).
> >
> > pgd_none will never be true, because on both aarch64 and arm we fold the
> > pud into the pgd (and include pgtable-nopud.h) if we have less than 4
> > levels, and if we do have 4 levels, then we have preallocated and
> > prepopulated the pgd.  If I got this right, I agree, and we should add
> > the WARN_ON or VM_BUG_ON or something.
> 
> Yes.
> 
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index fd4e81a..0f3e0a9 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -200,7 +200,6 @@ config ARM64_VA_BITS_42
> > > >
> > > >  config ARM64_VA_BITS_48
> > > >         bool "48-bit"
> > > > -       depends on BROKEN
> > >
> > > I'm ok with removing BROKEN here but I think at the same time we need to
> > > disable the SMMU driver which has similar issues with (not) supporting
> > > 4-levels page tables for stage 2 (stage 1 should be fine).
> >
> > Should that be in separate patches, or is it fine to just include it
> > here?
> 
> I think a separate patch replacing BROKEN with !ARM_SMMU. But we'll
> need to test the kernel a bit more to make sure there isn't anything
> else that's broken before merging it.
> 
> > > > +
> > > > +/**
> > > > + * kvm_prealloc_hwpgd - allocate inital table for VTTBR
> > > > + * @kvm:       The KVM struct pointer for the VM.
> > > > + * @pgd:       The kernel pseudo pgd
> > >
> > > "hwpgd" doesn't sound like the right name since it's actually a fake pgd
> > > that it is allocating. Maybe "swpgd"?
> >
> > The fake pgd was already allocated in kvm_alloc_stage2_pgd(), now we're
> > allocating the first-level page table that is going to be walked by the
> > MMU for Stage-2 translations (the address of which will go into the
> > VTTBR), so that's the reasoning for calling it the hwpgd.
> 
> OK, it makes sense now.
> 
> > > > +#define KVM_PREALLOC_LEVELS    0
> > > > +#define PTRS_PER_S2_PGD                (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
> > > > +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> > > > +
> > > > +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static inline void kvm_free_hwpgd(struct kvm *kvm) { }
> > > > +
> > > > +static inline phys_addr_t kvm_get_hwpgd(struct kvm *kvm)
> > > > +{
> > > > +       return virt_to_phys(kvm->arch.pgd);
> > > > +}
> > > > +#endif
> > >
> > > I think all the above could be squashed into a single set of function
> > > implementations with the right macros defined before.
> > >
> > > For the KVM levels, you could use something like (we exchanged emails in
> > > private on this topic and how I got to these macros but they need better
> > > checking):
> > >
> > > #define KVM_PGTABLE_LEVELS      ((KVM_PHYS_SHIFT - PAGE_SHIFT - 5) / (PAGE_SHIFT - 3) + 1)
> > > #define KVM_PREALLOC_LEVELS     (CONFIG_ARM64_PGTABLE_LEVELS - KVM_PGTABLE_LEVELS)
> > > #if PGDIR_SHIFT > KVM_PHYS_SHIFT
> > > #define PTRS_PER_S2_PGD               (1)
> > > #else
> > > #define PTRS_PER_S2_PGD               (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
> > > #endif
> >
> > I'll revisit this, but the amount of time I needed to spend making sure
> > I understand this sort of indicated to me that it was simpler to just
> > spell it out.  What do you think?  Do you strongly prefer the simple
> > macro definitions?
> 
> I don't have a strong preference but I was looking to reduce the #ifdef
> complexity when we make the next change to the host page table (16K
> pages is coming as well with 3 or 4 levels).
> 
I looked a bit at this tonight, and I still have some reservations:

The KVM_PREALLOC_LEVELS macro doesn't seem to yield the right result, or
at least not the result we have now, because it will give us 1 in both
the 64K and 4K situation.  I've renamed the symbol to KVM_PREALLOC_LEVEL
in the new version to be slightly more clear.

In the case where PGDIR_SHIFT > KVM_PHYS_SHIFT, we should have
PTRS_PER_S2_PGD == 2, and this now has a real consequence when we're no
longer allocating on a page-basis for the (potentially) fake PGD.

Finally, I'm a bit worried about introducing a bunch of macro logic
which is really hard to intuitively understand.  Maybe I'm over
emphasizing this issue, but I fint the KVM_PGTABLE_LEVELS definition
pretty hard to explain.

Anyway, I'm open to revisit this in v2.

Thanks,
-Christoffer

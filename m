From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 4 Jun 2014 15:30:29 +0200
Subject: [PATCH v2] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <CAPvkgC2MQdxuCWXygQ-072Pr-GBFGcC044AfKWR4kpuBbEmOJQ@mail.gmail.com>
References: <1401286977-59260-1-git-send-email-christoffer.dall@linaro.org>
 <CAPvkgC2MQdxuCWXygQ-072Pr-GBFGcC044AfKWR4kpuBbEmOJQ@mail.gmail.com>
Message-ID: <20140604133029.GE19587@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 02:52:58PM +0100, Steve Capper wrote:
> Hi Christoffer,
> I have some comments below:
> 
> On 28 May 2014 15:22, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > unmap_range() was utterly broken, to quote Marc, and broke in all sorts
> > of situations.  It was also quite complicated to follow and didn't
> > follow the usual scheme of having a separate iterating function for each
> > level of page tables.
> >
> > Address this by refactoring the code and introduce a pgd_clear()
> > function.
> >
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> > Changes since v2:
> >  - Don't define custom __unused but reuse __maybe_unused
> >
> >  arch/arm/include/asm/kvm_mmu.h   |  12 ++++
> >  arch/arm/kvm/mmu.c               | 122 ++++++++++++++++++++++-----------------
> >  arch/arm64/include/asm/kvm_mmu.h |  15 +++++
> >  3 files changed, 95 insertions(+), 54 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> > index 5c7aa3c..5cc0b0f 100644
> > --- a/arch/arm/include/asm/kvm_mmu.h
> > +++ b/arch/arm/include/asm/kvm_mmu.h
> > @@ -127,6 +127,18 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
> >         (__boundary - 1 < (end) - 1)? __boundary: (end);                \
> >  })
> >
> > +static inline bool kvm_page_empty(void *ptr)
> > +{
> > +       struct page *ptr_page = virt_to_page(ptr);
> > +       return page_count(ptr_page) == 1;
> > +}
> > +
> > +
> > +#define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
> > +#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> > +#define kvm_pud_table_empty(pudp) (0)
> > +
> > +
> >  struct kvm;
> >
> >  #define kvm_flush_dcache_to_poc(a,l)   __cpuc_flush_dcache_area((a), (l))
> > diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> > index 16f8049..6ee6e06 100644
> > --- a/arch/arm/kvm/mmu.c
> > +++ b/arch/arm/kvm/mmu.c
> > @@ -90,10 +90,13 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
> >         return p;
> >  }
> >
> > -static bool page_empty(void *ptr)
> > +static void clear_pgd_entry(struct kvm *kvm, pgd_t *pgd, phys_addr_t addr)
> >  {
> > -       struct page *ptr_page = virt_to_page(ptr);
> > -       return page_count(ptr_page) == 1;
> > +       pud_t *pud_table __maybe_unused = pud_offset(pgd, 0);
> > +       pgd_clear(pgd);
> > +       kvm_tlb_flush_vmid_ipa(kvm, addr);
> > +       pud_free(NULL, pud_table);
> > +       put_page(virt_to_page(pgd));
> >  }
> >
> >  static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
> > @@ -124,70 +127,81 @@ static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
> >         put_page(virt_to_page(pmd));
> >  }
> >
> > -static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
> > +static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
> > +                      unsigned long long addr, unsigned long long end)
> 
> We have a lot of unsigned long longs in this patch, should they not be
> phys_addr_t instead?
> 

I guess they should, I *think* the confusion came from the fact that
unmap_range is also called on the hyp page table manipulation code,
which works on VAs and not PAs, and we wanted to avoid the confusion.
But I can't be sure.

That being said, I'm thinking that once we fix the whoel
SL0/TTBR0_X/T0SZ dynamic mess, then this function may no longer work for
both hyp page tables and Stage-2 page tables and then even this pseudo
relevant argument goes away.

I would like to see if Marc remembers something here, but otherwise we
could change all the unsigned long long's to phys_addr_t's.

> >  {
> > -       if (pte_present(*pte)) {
> > -               kvm_set_pte(pte, __pte(0));
> > -               put_page(virt_to_page(pte));
> > -               kvm_tlb_flush_vmid_ipa(kvm, addr);
> > -       }
> > +       pte_t *pte, *start_pte;
> > +       unsigned long long start_addr = addr;
> > +
> > +       start_pte = pte = pte_offset_kernel(pmd, addr);
> > +       do {
> > +               if (!pte_none(*pte)) {
> > +                       kvm_set_pte(pte, __pte(0));
> > +                       put_page(virt_to_page(pte));
> > +                       kvm_tlb_flush_vmid_ipa(kvm, addr);
> > +               }
> > +       } while (pte++, addr += PAGE_SIZE, addr != end);
> > +
> > +       if (kvm_pte_table_empty(start_pte))
> > +               clear_pmd_entry(kvm, pmd, start_addr);
> 
> I don't quite follow this clear_p[um]d_entry logic.
> So this clear_pmd_entry will de-allocate the page containing the ptes
> (referenced from the pmd entry)?

Yes.

> If so, what happens if not all the ptes in the page need to be unmapped?

Well, then pte_table_empty() will return false (because there are still
active pte's in the pte table) and we won't call the function.

The idea is that we ref-count each page table page with the number of
active entries in that page (in addition to the initial reference from
allocating the table).  So a ref-count of 1 means that there are no
active entries (xxx_table_empty() returns true), a refcount of 513 means
there are 512 active entries.

Makes sense?

> 
> The clear_p[um]d_entry functions appear to be split in two with one
> codepath for huge entries (without any de-allocation) and the other
> path for table entries that does have de-allocation. Would it be
> better to perhaps split these functions in two with a more descriptive
> name for the clear and de-allocate case?

yeah, that might make it less convoluted.  I'll have a go at that (the
huge path can just be inlined into the unmap functions I believe).

> 
> >  }
> >
> > -static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
> > -                       unsigned long long start, u64 size)
> > +static void unmap_pmds(struct kvm *kvm, pud_t *pud,
> > +                      unsigned long long addr, unsigned long long end)
> >  {
> > -       pgd_t *pgd;
> > -       pud_t *pud;
> > -       pmd_t *pmd;
> > -       pte_t *pte;
> > -       unsigned long long addr = start, end = start + size;
> > -       u64 next;
> > -
> > -       while (addr < end) {
> > -               pgd = pgdp + pgd_index(addr);
> > -               pud = pud_offset(pgd, addr);
> > -               pte = NULL;
> > -               if (pud_none(*pud)) {
> > -                       addr = kvm_pud_addr_end(addr, end);
> > -                       continue;
> > -               }
> > +       unsigned long long next, start_addr = addr;
> > +       pmd_t *pmd, *start_pmd;
> >
> > -               if (pud_huge(*pud)) {
> > -                       /*
> > -                        * If we are dealing with a huge pud, just clear it and
> > -                        * move on.
> > -                        */
> > -                       clear_pud_entry(kvm, pud, addr);
> > -                       addr = kvm_pud_addr_end(addr, end);
> > -                       continue;
> > +       start_pmd = pmd = pmd_offset(pud, addr);
> > +       do {
> > +               next = kvm_pmd_addr_end(addr, end);
> > +               if (!pmd_none(*pmd)) {
> > +                       if (kvm_pmd_huge(*pmd))
> > +                               clear_pmd_entry(kvm, pmd, addr);
> > +                       else
> > +                               unmap_ptes(kvm, pmd, addr, next);
> >                 }
> > +       } while (pmd++, addr = next, addr != end);
> >
> > -               pmd = pmd_offset(pud, addr);
> > -               if (pmd_none(*pmd)) {
> > -                       addr = kvm_pmd_addr_end(addr, end);
> > -                       continue;
> > -               }
> > +       if (kvm_pmd_table_empty(start_pmd))
> > +               clear_pud_entry(kvm, pud, start_addr);
> > +}
> >
> > -               if (!kvm_pmd_huge(*pmd)) {
> > -                       pte = pte_offset_kernel(pmd, addr);
> > -                       clear_pte_entry(kvm, pte, addr);
> > -                       next = addr + PAGE_SIZE;
> > -               }
> > +static void unmap_puds(struct kvm *kvm, pgd_t *pgd,
> > +                      unsigned long long addr, unsigned long long end)
> > +{
> > +       unsigned long long next, start_addr = addr;
> > +       pud_t *pud, *start_pud;
> >
> > -               /*
> > -                * If the pmd entry is to be cleared, walk back up the ladder
> > -                */
> > -               if (kvm_pmd_huge(*pmd) || (pte && page_empty(pte))) {
> > -                       clear_pmd_entry(kvm, pmd, addr);
> > -                       next = kvm_pmd_addr_end(addr, end);
> > -                       if (page_empty(pmd) && !page_empty(pud)) {
> > +       start_pud = pud = pud_offset(pgd, addr);
> > +       do {
> > +               next = kvm_pud_addr_end(addr, end);
> > +               if (!pud_none(*pud)) {
> > +                       if (pud_huge(*pid)) {
> >                                 clear_pud_entry(kvm, pud, addr);
> > -                               next = kvm_pud_addr_end(addr, end);
> > +                       } else {
> > +                               unmap_pmds(kvm, pud, addr, next);
> >                         }
> >                 }
> > +       } while (pud++, addr = next, addr != end);
> >
> > -               addr = next;
> > -       }
> > +       if (kvm_pud_table_empty(start_pud))
> > +               clear_pgd_entry(kvm, pgd, start_addr);
> > +}
> > +
> > +
> > +static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
> > +                       unsigned long long start, u64 size)
> > +{
> > +       pgd_t *pgd;
> > +       unsigned long long addr = start, end = start + size;
> > +       unsigned long long next;
> > +
> > +       pgd = pgdp + pgd_index(addr);
> > +       do {
> > +               next = kvm_pgd_addr_end(addr, end);
> > +               unmap_puds(kvm, pgd, addr, next);
> > +       } while (pgd++, addr = next, addr != end);
> >  }
> >
> >  static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 7d29847..8e138c7 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -125,6 +125,21 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
> >  #define kvm_pud_addr_end(addr, end)    pud_addr_end(addr, end)
> >  #define kvm_pmd_addr_end(addr, end)    pmd_addr_end(addr, end)
> >
> > +static inline bool kvm_page_empty(void *ptr)
> > +{
> > +       struct page *ptr_page = virt_to_page(ptr);
> > +       return page_count(ptr_page) == 1;
> > +}
> > +
> > +#define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
> > +#ifndef CONFIG_ARM64_64K_PAGES
> > +#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> > +#else
> > +#define kvm_pmd_table_empty(pmdp) (0)
> > +#endif
> > +#define kvm_pud_table_empty(pudp) (0)
> > +
> > +
> >  struct kvm;
> >
> >  #define kvm_flush_dcache_to_poc(a,l)   __flush_dcache_area((a), (l))
> > --
> > 1.8.5.2
> >
> 
> Cheers,

Thanks for looking at the code!

-Christoffer

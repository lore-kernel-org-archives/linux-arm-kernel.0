From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 4 Jun 2014 15:54:57 +0200
Subject: [PATCH v2] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <538F2126.4000604@arm.com>
References: <1401286977-59260-1-git-send-email-christoffer.dall@linaro.org>
 <CAPvkgC2MQdxuCWXygQ-072Pr-GBFGcC044AfKWR4kpuBbEmOJQ@mail.gmail.com>
 <20140604133029.GE19587@lvm> <538F2126.4000604@arm.com>
Message-ID: <20140604135457.GF19587@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 02:37:42PM +0100, Marc Zyngier wrote:
> On 04/06/14 14:30, Christoffer Dall wrote:
> > On Tue, Jun 03, 2014 at 02:52:58PM +0100, Steve Capper wrote:
> >> Hi Christoffer,
> >> I have some comments below:
> >>
> >> On 28 May 2014 15:22, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >>> unmap_range() was utterly broken, to quote Marc, and broke in all sorts
> >>> of situations.  It was also quite complicated to follow and didn't
> >>> follow the usual scheme of having a separate iterating function for each
> >>> level of page tables.
> >>>
> >>> Address this by refactoring the code and introduce a pgd_clear()
> >>> function.
> >>>
> >>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> >>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >>> ---
> >>> Changes since v2:
> >>>  - Don't define custom __unused but reuse __maybe_unused
> >>>
> >>>  arch/arm/include/asm/kvm_mmu.h   |  12 ++++
> >>>  arch/arm/kvm/mmu.c               | 122 ++++++++++++++++++++++-----------------
> >>>  arch/arm64/include/asm/kvm_mmu.h |  15 +++++
> >>>  3 files changed, 95 insertions(+), 54 deletions(-)
> >>>
> >>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> >>> index 5c7aa3c..5cc0b0f 100644
> >>> --- a/arch/arm/include/asm/kvm_mmu.h
> >>> +++ b/arch/arm/include/asm/kvm_mmu.h
> >>> @@ -127,6 +127,18 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
> >>>         (__boundary - 1 < (end) - 1)? __boundary: (end);                \
> >>>  })
> >>>
> >>> +static inline bool kvm_page_empty(void *ptr)
> >>> +{
> >>> +       struct page *ptr_page = virt_to_page(ptr);
> >>> +       return page_count(ptr_page) == 1;
> >>> +}
> >>> +
> >>> +
> >>> +#define kvm_pte_table_empty(ptep) kvm_page_empty(ptep)
> >>> +#define kvm_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
> >>> +#define kvm_pud_table_empty(pudp) (0)
> >>> +
> >>> +
> >>>  struct kvm;
> >>>
> >>>  #define kvm_flush_dcache_to_poc(a,l)   __cpuc_flush_dcache_area((a), (l))
> >>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >>> index 16f8049..6ee6e06 100644
> >>> --- a/arch/arm/kvm/mmu.c
> >>> +++ b/arch/arm/kvm/mmu.c
> >>> @@ -90,10 +90,13 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
> >>>         return p;
> >>>  }
> >>>
> >>> -static bool page_empty(void *ptr)
> >>> +static void clear_pgd_entry(struct kvm *kvm, pgd_t *pgd, phys_addr_t addr)
> >>>  {
> >>> -       struct page *ptr_page = virt_to_page(ptr);
> >>> -       return page_count(ptr_page) == 1;
> >>> +       pud_t *pud_table __maybe_unused = pud_offset(pgd, 0);
> >>> +       pgd_clear(pgd);
> >>> +       kvm_tlb_flush_vmid_ipa(kvm, addr);
> >>> +       pud_free(NULL, pud_table);
> >>> +       put_page(virt_to_page(pgd));
> >>>  }
> >>>
> >>>  static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
> >>> @@ -124,70 +127,81 @@ static void clear_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr)
> >>>         put_page(virt_to_page(pmd));
> >>>  }
> >>>
> >>> -static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
> >>> +static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
> >>> +                      unsigned long long addr, unsigned long long end)
> >>
> >> We have a lot of unsigned long longs in this patch, should they not be
> >> phys_addr_t instead?
> >>
> > 
> > I guess they should, I *think* the confusion came from the fact that
> > unmap_range is also called on the hyp page table manipulation code,
> > which works on VAs and not PAs, and we wanted to avoid the confusion.
> > But I can't be sure.
> > 
> > That being said, I'm thinking that once we fix the whoel
> > SL0/TTBR0_X/T0SZ dynamic mess, then this function may no longer work for
> > both hyp page tables and Stage-2 page tables and then even this pseudo
> > relevant argument goes away.
> > 
> > I would like to see if Marc remembers something here, but otherwise we
> > could change all the unsigned long long's to phys_addr_t's.
> 
> I don't think that'd be a problem, as long as we have a nice comment
> about that.
> 
ok, I'll fix it in the next revision.

-Christoffer

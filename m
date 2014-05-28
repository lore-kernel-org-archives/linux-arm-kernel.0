From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 28 May 2014 16:25:38 +0200
Subject: [PATCH] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <5385EF2D.8000104@arm.com>
References: <1401117643-23034-1-git-send-email-christoffer.dall@linaro.org>
 <5385D0E2.3000000@arm.com> <20140528134535.GA38250@lvm>
 <5385EF2D.8000104@arm.com>
Message-ID: <20140528142538.GC38250@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 03:14:05PM +0100, Marc Zyngier wrote:
> On 28/05/14 14:45, Christoffer Dall wrote:
> > On Wed, May 28, 2014 at 01:04:50PM +0100, Marc Zyngier wrote:
> >> On 26/05/14 16:20, Christoffer Dall wrote:
> >>> unmap_range() was utterly broken, to quote Marc, and broke in all sorts
> >>> of situations.  It was also quite complicated to follow and didn't
> >>> follow the usual scheme of having a separate iterating function for each
> >>> level of page tables.
> >>>
> >>> Address this by refactoring the code and introduce a pgd_clear()
> >>> function.
> >>>
> >>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >>> ---
> >>>  arch/arm/include/asm/kvm_mmu.h   |  12 ++++
> >>>  arch/arm/kvm/mmu.c               | 126 ++++++++++++++++++++++-----------------
> >>>  arch/arm64/include/asm/kvm_mmu.h |  15 +++++
> >>>  3 files changed, 99 insertions(+), 54 deletions(-)
> >>>
> >>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> >>> index 5c7aa3c..5cc0b0f 100644
> >>> --- a/arch/arm/include/asm/kvm_mmu.h
> >>> +++ b/arch/arm/include/asm/kvm_mmu.h
> >>> @@ -127,6 +127,18 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
> >>>  	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> >>>  })
> >>>  
> >>> +static inline bool kvm_page_empty(void *ptr)
> >>> +{
> >>> +	struct page *ptr_page = virt_to_page(ptr);
> >>> +	return page_count(ptr_page) == 1;
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
> >>>  #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
> >>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >>> index 16f8049..0572522 100644
> >>> --- a/arch/arm/kvm/mmu.c
> >>> +++ b/arch/arm/kvm/mmu.c
> >>> @@ -46,6 +46,10 @@ static phys_addr_t hyp_idmap_vector;
> >>>  
> >>>  #define kvm_pmd_huge(_x)	(pmd_huge(_x) || pmd_trans_huge(_x))
> >>>  
> >>> +#ifndef __unused
> >>> +#    define __unused			__attribute__((unused))
> >>> +#endif
> >>> +
> >>
> >> Do we actually need this?
> >>
> > 
> > my GCC complains in clear_pgd_entry if pud's are not used.  Other
> > suggestions on how to solve this are very welcome.
> 
> My point was not about the use of the "unused" attribute (I can see why
> GCC screams when we don't have 4 levels of page tables), but I though
> that we could use the "__maybe_unused" attribute (defined in compiler.h).
> 
ah, that's helpful.  v2 on the list.

Thanks,
-Christoffer

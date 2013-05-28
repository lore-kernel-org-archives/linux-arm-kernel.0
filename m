From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 27 May 2013 19:10:02 -0700
Subject: [PATCH v3 3/7] ARM: KVM: relax cache maintainance when building
 page tables
In-Reply-To: <1368529900-22572-4-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
 <1368529900-22572-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130528021002.GC16071@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 12:11:36PM +0100, Marc Zyngier wrote:
> Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
> introduced code that flushes page tables to the point of coherency.
> This is overkill (point of unification is enough and already done),
> and actually not required if running on a SMP capable platform
> (the HW PTW can snoop other cpus' L1).
> 
> Remove this code and let ae8a8b9553bd (ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead) turn it into
> a no-op for SMP ARMv7.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h | 17 +++++++++++------
>  arch/arm/kvm/mmu.c             |  7 ++++---
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 472ac70..8c03c96 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -65,11 +65,6 @@ void kvm_clear_hyp_idmap(void);
>  static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
>  {
>  	pte_val(*pte) = new_pte;
> -	/*
> -	 * flush_pmd_entry just takes a void pointer and cleans the necessary
> -	 * cache entries, so we can reuse the function for ptes.
> -	 */
> -	flush_pmd_entry(pte);
>  }
>  
>  static inline bool kvm_is_write_fault(unsigned long hsr)
> @@ -83,9 +78,19 @@ static inline bool kvm_is_write_fault(unsigned long hsr)
>  		return true;
>  }
>  
> +static inline void kvm_clean_dcache_area(void *addr, size_t size)
> +{
> +	clean_dcache_area(addr, size);
> +}
> +
> +static inline void kvm_clean_pte_entry(pte_t *pte)
> +{
> +	kvm_clean_dcache_area(pte, sizeof(*pte));
> +}
> +
>  static inline void kvm_clean_pgd(pgd_t *pgd)
>  {
> -	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
> +	kvm_clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
>  }
>  
>  static inline void kvm_clean_pmd_entry(pmd_t *pmd)
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 84ba67b..451bad3 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -113,6 +113,7 @@ static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>  {
>  	if (pte_present(*pte)) {
>  		kvm_set_pte(pte, __pte(0));
> +		kvm_clean_pte_entry(pte);
>  		put_page(virt_to_page(pte));
>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
>  	}
> @@ -234,9 +235,10 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
>  		pte = pte_offset_kernel(pmd, addr);
>  		kvm_set_pte(pte, pfn_pte(pfn, prot));
>  		get_page(virt_to_page(pte));
> -		kvm_flush_dcache_to_poc(pte, sizeof(*pte));
>  		pfn++;
>  	} while (addr += PAGE_SIZE, addr != end);
> +
> +	kvm_clean_dcache_area((void *)start, end - start);
>  }
>  
>  static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
> @@ -261,7 +263,6 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
>  			}
>  			pmd_populate_kernel(NULL, pmd, pte);
>  			get_page(virt_to_page(pmd));
> -			kvm_flush_dcache_to_poc(pmd, sizeof(*pmd));
>  		}
>  
>  		next = pmd_addr_end(addr, end);
> @@ -299,7 +300,6 @@ static int __create_hyp_mappings(pgd_t *pgdp,
>  			}
>  			pud_populate(NULL, pud, pmd);
>  			get_page(virt_to_page(pud));
> -			kvm_flush_dcache_to_poc(pud, sizeof(*pud));
>  		}
>  
>  		next = pgd_addr_end(addr, end);
> @@ -469,6 +469,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>  	/* Create 2nd stage page table mapping - Level 3 */
>  	old_pte = *pte;
>  	kvm_set_pte(pte, *new_pte);
> +	kvm_clean_pte_entry(pte);
>  	if (pte_present(old_pte))
>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
>  	else
> -- 
> 1.8.2.3
> 
> 
I don't care for this change, you have three places where you call
kvm_set_pte and immediately follow with kvm_clean_pte_entry now, just to
optimize the uncommon case only relevant when creating new VMs, and at
the same time do things differently from the rest of the kernel with
set_pte functions (yes, I know it's a static in this file, but that
doesn't mean that readers of this file wouldn't make that association).
The next function that calls kvm_set_pte must now also remember to call
the clean functions, bah.

I think the kvm_clean_pte_entry should just be called from within
kvm_set_pte.

-Christoffer

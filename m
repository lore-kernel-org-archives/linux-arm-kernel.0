From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Jan 2014 12:07:22 -0800
Subject: [PATCH v2 04/10] arm64: KVM: flush VM pages before letting the
 guest enable caches
In-Reply-To: <1390402602-22777-5-git-send-email-marc.zyngier@arm.com>
References: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
 <1390402602-22777-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140129200722.GG3570@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 02:56:36PM +0000, Marc Zyngier wrote:
> When the guest runs with caches disabled (like in an early boot
> sequence, for example), all the writes are diectly going to RAM,
> bypassing the caches altogether.
> 
> Once the MMU and caches are enabled, whatever sits in the cache
> becomes suddently visible, which isn't what the guest expects.

nit: s/suddently/suddenly/

> 
> A way to avoid this potential disaster is to invalidate the cache
> when the MMU is being turned on. For this, we hook into the SCTLR_EL1
> trapping code, and scan the stage-2 page tables, invalidating the
> pages/sections that have already been mapped in.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h   |  2 +
>  arch/arm/kvm/mmu.c               | 83 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>  arch/arm64/kvm/sys_regs.c        |  5 ++-
>  4 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index f997b9e..cbab9ba 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -141,6 +141,8 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
>  
> +void stage2_flush_vm(struct kvm *kvm);
> +
>  #endif	/* !__ASSEMBLY__ */
>  
>  #endif /* __ARM_KVM_MMU_H__ */
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 415fd63..52f8b7d 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -187,6 +187,89 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>  	}
>  }
>  
> +void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
> +		       unsigned long addr, unsigned long end)
> +{
> +	pte_t *pte;
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +	do {
> +		if (!pte_none(*pte)) {
> +			hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
> +			kvm_flush_dcache_to_poc((void*)hva, PAGE_SIZE);
> +		}
> +	} while(pte++, addr += PAGE_SIZE, addr != end);
> +}
> +
> +void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
> +		       unsigned long addr, unsigned long end)
> +{
> +	pmd_t *pmd;
> +	unsigned long next;
> +
> +	pmd = pmd_offset(pud, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (!pmd_none(*pmd)) {
> +			if (kvm_pmd_huge(*pmd)) {
> +				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
> +				kvm_flush_dcache_to_poc((void*)hva, PMD_SIZE);
> +			} else {
> +				stage2_flush_ptes(kvm, pmd, addr, next);
> +			}
> +		}
> +	} while(pmd++, addr = next, addr != end);
> +}
> +
> +void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
> +		       unsigned long addr, unsigned long end)
> +{
> +	pud_t *pud;
> +	unsigned long next;
> +
> +	pud = pud_offset(pgd, addr);
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (!pud_none(*pud)) {
> +			if (pud_huge(*pud)) {
> +				hva_t hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
> +				kvm_flush_dcache_to_poc((void*)hva, PUD_SIZE);
> +			} else {
> +				stage2_flush_pmds(kvm, pud, addr, next);
> +			}
> +		}
> +	} while(pud++, addr = next, addr != end);
> +}
> +
> +static void stage2_flush_memslot(struct kvm *kvm,
> +				 struct kvm_memory_slot *memslot)
> +{
> +	unsigned long addr = memslot->base_gfn << PAGE_SHIFT;
> +	unsigned long end = addr + PAGE_SIZE * memslot->npages;
> +	unsigned long next;

hmm, these are IPAs right, which can be larger than 32 bits with LPAE
on arm, so shouldn't this be phys_addr_t ?

If so, that propagates throughout the child subroutines, and you should
check if you can actually use pgd_addr_end.

> +	pgd_t *pgd;
> +
> +	pgd = kvm->arch.pgd + pgd_index(addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		stage2_flush_puds(kvm, pgd, addr, next);
> +	} while(pgd++, addr = next, addr != end);

I think the CodingStyle mandates a space after the while, which applies
to all the functions above.

> +}
> +

Could you add documentation for stage2_flush_vm?

/**
 * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
 * @kvm: The struct kvm pointer
 *
 * Go through the stage 2 page tables and invalidate any cache lines
 * backing memory already mapped to the VM.
 */

or some variation thereof...

> +void stage2_flush_vm(struct kvm *kvm)
> +{
> +	struct kvm_memslots *slots;
> +	struct kvm_memory_slot *memslot;
> +
> +	spin_lock(&kvm->mmu_lock);
> +
> +	slots = kvm_memslots(kvm);
> +	kvm_for_each_memslot(memslot, slots)
> +		stage2_flush_memslot(kvm, memslot);
> +
> +	spin_unlock(&kvm->mmu_lock);

don't you need to also srcu_read_lock(kvm->srcu) here?

> +}
> +
>  /**
>   * free_boot_hyp_pgd - free HYP boot page tables
>   *
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 2232dd0..b7b2ca3 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -139,6 +139,7 @@ static inline void coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
>  	}
>  }
>  
> +void stage2_flush_vm(struct kvm *kvm);
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 1a4731b..3d27bb8 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -27,6 +27,7 @@
>  #include <asm/kvm_host.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_coproc.h>
> +#include <asm/kvm_mmu.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cputype.h>
>  #include <trace/events/kvm.h>
> @@ -163,8 +164,10 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
>  	else
>  		vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
>  
> -	if ((val & (0b101)) == 0b101)	/* MMU+Caches enabled? */
> +	if ((val & (0b101)) == 0b101) {	/* MMU+Caches enabled? */
>  		vcpu->arch.hcr_el2 &= ~HCR_TVM;
> +		stage2_flush_vm(vcpu->kvm);
> +	}
>  
>  	return true;
>  }
> -- 
> 1.8.3.4
> 

Thanks,
-- 
Christoffer

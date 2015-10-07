From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Oct 2015 11:23:52 +0100
Subject: [PATCH 12/15] arm: kvm: Move fake PGD handling to arch specific
 files
In-Reply-To: <1442331684-28818-13-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-13-git-send-email-suzuki.poulose@arm.com>
Message-ID: <5614F2B8.6030509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/15 16:41, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> Rearrange the code for fake pgd handling, which is applicable
> to only ARM64. The intention is to keep the common code cleaner,
> unaware of the underlying hacks.
> 
> Cc: kvmarm at lists.cs.columbia.edu
> Cc: christoffer.dall at linaro.org
> Cc: Marc.Zyngier at arm.com
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h   |    7 ++++++
>  arch/arm/kvm/mmu.c               |   44 +++++---------------------------------
>  arch/arm64/include/asm/kvm_mmu.h |   43 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 405aa18..1c9aa8a 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -173,6 +173,13 @@ static inline unsigned int kvm_get_hwpgd_size(void)
>  	return PTRS_PER_S2_PGD * sizeof(pgd_t);
>  }
>  
> +static inline pgd_t *kvm_setup_fake_pgd(pgd_t *pgd)
> +{
> +	return pgd;
> +}
> +
> +static inline void kvm_free_fake_pgd(pgd_t *pgd) {}
> +
>  struct kvm;
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 7b42012..b210622 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -677,43 +677,11 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  	 * guest, we allocate a fake PGD and pre-populate it to point
>  	 * to the next-level page table, which will be the real
>  	 * initial page table pointed to by the VTTBR.
> -	 *
> -	 * When KVM_PREALLOC_LEVEL==2, we allocate a single page for
> -	 * the PMD and the kernel will use folded pud.
> -	 * When KVM_PREALLOC_LEVEL==1, we allocate 2 consecutive PUD
> -	 * pages.
>  	 */
> -	if (KVM_PREALLOC_LEVEL > 0) {
> -		int i;
> -
> -		/*
> -		 * Allocate fake pgd for the page table manipulation macros to
> -		 * work.  This is not used by the hardware and we have no
> -		 * alignment requirement for this allocation.
> -		 */
> -		pgd = kmalloc(PTRS_PER_S2_PGD * sizeof(pgd_t),
> -				GFP_KERNEL | __GFP_ZERO);
> -
> -		if (!pgd) {
> -			kvm_free_hwpgd(hwpgd);
> -			return -ENOMEM;
> -		}
> -
> -		/* Plug the HW PGD into the fake one. */
> -		for (i = 0; i < PTRS_PER_S2_PGD; i++) {
> -			if (KVM_PREALLOC_LEVEL == 1)
> -				pgd_populate(NULL, pgd + i,
> -					     (pud_t *)hwpgd + i * PTRS_PER_PUD);
> -			else if (KVM_PREALLOC_LEVEL == 2)
> -				pud_populate(NULL, pud_offset(pgd, 0) + i,
> -					     (pmd_t *)hwpgd + i * PTRS_PER_PMD);
> -		}
> -	} else {
> -		/*
> -		 * Allocate actual first-level Stage-2 page table used by the
> -		 * hardware for Stage-2 page table walks.
> -		 */
> -		pgd = (pgd_t *)hwpgd;
> +	pgd = kvm_setup_fake_pgd(hwpgd);
> +	if (IS_ERR(pgd)) {
> +		kvm_free_hwpgd(hwpgd);
> +		return PTR_ERR(pgd);
>  	}
>  
>  	kvm_clean_pgd(pgd);
> @@ -820,9 +788,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>  
>  	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
>  	kvm_free_hwpgd(kvm_get_hwpgd(kvm));
> -	if (KVM_PREALLOC_LEVEL > 0)
> -		kfree(kvm->arch.pgd);
> -
> +	kvm_free_fake_pgd(kvm->arch.pgd);
>  	kvm->arch.pgd = NULL;
>  }
>  
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 6150567..2567fe8 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -198,6 +198,49 @@ static inline unsigned int kvm_get_hwpgd_size(void)
>  	return PTRS_PER_S2_PGD * sizeof(pgd_t);
>  }
>  
> +/*
> + * Allocate fake pgd for the page table manipulation macros to
> + * work.  This is not used by the hardware and we have no
> + * alignment requirement for this allocation.
> + */
> +static inline pgd_t* kvm_setup_fake_pgd(pgd_t *hwpgd)
> +{
> +	int i;
> +	pgd_t *pgd;
> +
> +	if (!KVM_PREALLOC_LEVEL)
> +		return hwpgd;
> +	/*
> +	 * When KVM_PREALLOC_LEVEL==2, we allocate a single page for
> +	 * the PMD and the kernel will use folded pud.
> +	 * When KVM_PREALLOC_LEVEL==1, we allocate 2 consecutive PUD
> +	 * pages.
> +	 */
> +	pgd = kmalloc(PTRS_PER_S2_PGD * sizeof(pgd_t),
> +			GFP_KERNEL | __GFP_ZERO);
> +
> +	if (!pgd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Plug the HW PGD into the fake one. */
> +	for (i = 0; i < PTRS_PER_S2_PGD; i++) {
> +		if (KVM_PREALLOC_LEVEL == 1)
> +			pgd_populate(NULL, pgd + i,
> +				     (pud_t *)hwpgd + i * PTRS_PER_PUD);
> +		else if (KVM_PREALLOC_LEVEL == 2)
> +			pud_populate(NULL, pud_offset(pgd, 0) + i,
> +				     (pmd_t *)hwpgd + i * PTRS_PER_PMD);
> +	}
> +
> +	return pgd;
> +}
> +
> +static inline void kvm_free_fake_pgd(pgd_t *pgd)
> +{
> +	if (KVM_PREALLOC_LEVEL > 0)
> +		kfree(pgd);
> +}
> +
>  static inline bool kvm_page_empty(void *ptr)
>  {
>  	struct page *ptr_page = virt_to_page(ptr);
> 

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

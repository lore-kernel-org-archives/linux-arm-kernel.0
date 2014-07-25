From: agraf@suse.de (Alexander Graf)
Date: Fri, 25 Jul 2014 08:16:34 +0200
Subject: [PATCH v9 2/4] arm: ARMv7  dirty page logging inital mem region
 write protect (w/no huge PUD support)
In-Reply-To: <1406249768-25315-3-git-send-email-m.smarduch@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <53D1F642.6010007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25.07.14 02:56, Mario Smarduch wrote:
> Patch adds  support for initial write protection VM memlsot. This patch series
> assumes that huge PUDs will not be used in 2nd stage tables.

Is this a valid assumption?

>
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>   arch/arm/include/asm/kvm_host.h       |    1 +
>   arch/arm/include/asm/kvm_mmu.h        |   20 ++++++
>   arch/arm/include/asm/pgtable-3level.h |    1 +
>   arch/arm/kvm/arm.c                    |    9 +++
>   arch/arm/kvm/mmu.c                    |  128 +++++++++++++++++++++++++++++++++
>   5 files changed, 159 insertions(+)
>
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 042206f..6521a2d 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -231,5 +231,6 @@ int kvm_perf_teardown(void);
>   u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>   int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>   void kvm_arch_flush_remote_tlbs(struct kvm *);
> +void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>   
>   #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 5cc0b0f..08ab5e8 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -114,6 +114,26 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
>   	pmd_val(*pmd) |= L_PMD_S2_RDWR;
>   }
>   
> +static inline void kvm_set_s2pte_readonly(pte_t *pte)
> +{
> +	pte_val(*pte) = (pte_val(*pte) & ~L_PTE_S2_RDWR) | L_PTE_S2_RDONLY;
> +}
> +
> +static inline bool kvm_s2pte_readonly(pte_t *pte)
> +{
> +	return (pte_val(*pte) & L_PTE_S2_RDWR) == L_PTE_S2_RDONLY;
> +}
> +
> +static inline void kvm_set_s2pmd_readonly(pmd_t *pmd)
> +{
> +	pmd_val(*pmd) = (pmd_val(*pmd) & ~L_PMD_S2_RDWR) | L_PMD_S2_RDONLY;
> +}
> +
> +static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
> +{
> +	return (pmd_val(*pmd) & L_PMD_S2_RDWR) == L_PMD_S2_RDONLY;
> +}
> +
>   /* Open coded p*d_addr_end that can deal with 64bit addresses */
>   #define kvm_pgd_addr_end(addr, end)					\
>   ({	u64 __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;		\
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 85c60ad..d8bb40b 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -129,6 +129,7 @@
>   #define L_PTE_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
>   #define L_PTE_S2_RDWR			(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
>   
> +#define L_PMD_S2_RDONLY			(_AT(pteval_t, 1) << 6)   /* HAP[1]   */
>   #define L_PMD_S2_RDWR			(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
>   
>   /*
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 3c82b37..e11c2dd 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -242,6 +242,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>   				   const struct kvm_memory_slot *old,
>   				   enum kvm_mr_change change)
>   {
> +#ifdef CONFIG_ARM

Same question on CONFIG_ARM here. Is this the define used to distinguish 
between 32bit and 64bit?


Alex

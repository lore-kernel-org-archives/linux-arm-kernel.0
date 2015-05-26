From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 May 2015 10:36:36 +0100
Subject: [v4 4/4] arm: kvm: add stub implementation for kvm_cpu_reset()
In-Reply-To: <1431047884-5637-5-git-send-email-takahiro.akashi@linaro.org>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
 <1431047884-5637-5-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <55643EA4.4080206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/15 02:18, AKASHI Takahiro wrote:
> Just to avoid compiling errors on arm.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm/include/asm/kvm_asm.h  |    1 +
>  arch/arm/include/asm/kvm_host.h |   12 ++++++++++++
>  arch/arm/include/asm/kvm_mmu.h  |    5 +++++
>  arch/arm/kvm/init.S             |    6 ++++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> index 25410b2..462babf 100644
> --- a/arch/arm/include/asm/kvm_asm.h
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -85,6 +85,7 @@ struct kvm_vcpu;
>  
>  extern char __kvm_hyp_init[];
>  extern char __kvm_hyp_init_end[];
> +extern char __kvm_hyp_reset[];
>  
>  extern char __kvm_hyp_exit[];
>  extern char __kvm_hyp_exit_end[];
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index ca97764..6d38134 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -220,6 +220,18 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>  	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
>  }
>  
> +static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
> +					phys_addr_t phys_idmap_start,
> +					unsigned long stub_vector_ptr,
> +					unsigned long reset_func)
> +{
> +	/*
> +	 * TODO
> +	 * kvm_call_reset(boot_pgd_ptr, phys_idmap_start, stub_vector_ptr,
> +	 *		  reset_func);
> +	 */
> +}
> +
>  static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>  {
>  	return 0;
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 37ca2a4..d85bcd1 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -66,6 +66,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
>  phys_addr_t kvm_mmu_get_httbr(void);
>  phys_addr_t kvm_mmu_get_boot_httbr(void);
>  phys_addr_t kvm_get_idmap_vector(void);
> +phys_addr_t kvm_get_idmap_start(void);
>  int kvm_mmu_init(void);
>  void kvm_clear_hyp_idmap(void);
>  
> @@ -270,6 +271,10 @@ static inline void __kvm_flush_dcache_pud(pud_t pud)
>  void kvm_set_way_flush(struct kvm_vcpu *vcpu);
>  void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
>  
> +extern char __hyp_idmap_text_start[];
> +#define kvm_virt_to_trampoline(x)       \
> +			(TRAMPOLINE_VA + ((x) - __hyp_idmap_text_start))
> +
>  #endif	/* !__ASSEMBLY__ */
>  
>  #endif /* __ARM_KVM_MMU_H__ */
> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 3988e72..9178c9a 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -156,4 +156,10 @@ target:	@ We're now in the trampoline code, switch page tables
>  	.globl __kvm_hyp_init_end
>  __kvm_hyp_init_end:
>  
> +	.globl __kvm_hyp_reset
> +__kvm_hyp_reset:
> +	@ TODO
> +
> +	eret
> +
>  	.popsection
> 

So before this patch, KVM is broken on ARM. This is not acceptable.
Please merge it with patch #1.

Thanks,

	M.

-- 
Jazz is not dead. It just smells funny...

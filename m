From: christoffer.dall@arm.com (Christoffer Dall)
Date: Mon, 3 Sep 2018 11:41:30 +0200
Subject: [PATCH 6/7] KVM: arm64: Set SCTLR_EL2.DSSBS if SSBD is
 forcefully disabled and !vhe
In-Reply-To: <1535645767-9901-7-git-send-email-will.deacon@arm.com>
References: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
 <1535645767-9901-7-git-send-email-will.deacon@arm.com>
Message-ID: <20180903094130.GF4029@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:16:06PM +0100, Will Deacon wrote:
> When running without VHE, it is necessary to set SCTLR_EL2.DSSBS if SSBD
> has been forcefully disabled on the kernel command-line.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

> ---
>  arch/arm64/include/asm/kvm_host.h | 11 +++++++++++
>  arch/arm64/kvm/hyp/sysreg-sr.c    | 11 +++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index f26055f2306e..15501921fc75 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -389,6 +389,8 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
>  DECLARE_PER_CPU(kvm_cpu_context_t, kvm_host_cpu_state);
>  
> +void __kvm_enable_ssbs(void);
> +
>  static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>  				       unsigned long hyp_stack_ptr,
>  				       unsigned long vector_ptr)
> @@ -409,6 +411,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
>  	 */
>  	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
>  	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
> +
> +	/*
> +	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
> +	 * at EL2.
> +	 */
> +	if (!has_vhe() && this_cpu_has_cap(ARM64_SSBS) &&
> +	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
> +		kvm_call_hyp(__kvm_enable_ssbs);
> +	}
>  }
>  
>  static inline bool kvm_arch_check_sve_has_vhe(void)
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 9ce223944983..76d016b446b2 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -288,3 +288,14 @@ void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu)
>  
>  	vcpu->arch.sysregs_loaded_on_cpu = false;
>  }
> +
> +void __hyp_text __kvm_enable_ssbs(void)
> +{
> +	u64 tmp;
> +
> +	asm volatile(
> +	"mrs	%0, sctlr_el2\n"
> +	"orr	%0, %0, %1\n"
> +	"msr	sctlr_el2, %0"
> +	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
> +}
> -- 
> 2.1.4
> 

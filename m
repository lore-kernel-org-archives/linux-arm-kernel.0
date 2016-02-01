From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Feb 2016 15:17:29 +0100
Subject: [PATCH v2 13/21] arm64: KVM: VHE: Make __fpsimd_enabled VHE aware
In-Reply-To: <1453737235-16522-14-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160201141729.GS1478@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:53:47PM +0000, Marc Zyngier wrote:
> As non-VHE and VHE have different ways to express the trapping of
> FPSIMD registers to EL2, make __fpsimd_enabled a patchable predicate
> and provide a VHE implementation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/hyp/hyp.h    |  5 +----
>  arch/arm64/kvm/hyp/switch.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/hyp.h b/arch/arm64/kvm/hyp/hyp.h
> index 5dfa883..44eaff7 100644
> --- a/arch/arm64/kvm/hyp/hyp.h
> +++ b/arch/arm64/kvm/hyp/hyp.h
> @@ -171,10 +171,7 @@ void __debug_cond_restore_host_state(struct kvm_vcpu *vcpu);
>  
>  void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
>  void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
> -static inline bool __fpsimd_enabled(void)
> -{
> -	return !(read_sysreg(cptr_el2) & CPTR_EL2_TFP);
> -}
> +bool __fpsimd_enabled(void);
>  
>  u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
>  void __noreturn __hyp_do_panic(unsigned long, ...);
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 9071dee..6f264dc 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -17,6 +17,25 @@
>  
>  #include "hyp.h"
>  
> +static bool __hyp_text __fpsimd_enabled_nvhe(void)
> +{
> +	return !(read_sysreg(cptr_el2) & CPTR_EL2_TFP);
> +}
> +
> +static bool __hyp_text __fpsimd_enabled_vhe(void)
> +{
> +	return !!(read_sysreg(cpacr_el1) & (3 << 20));

so this access to cpacr_el1 is really rewritten by the HW to access the
cptr_el2, and the cptr_el2 is redefined to have bits[21:20] have the
semantics that if the bits are both set we don't trap (FPEN), so that
means SIMD is enabled for the guest to use.  Right, simple, crisp,
clear, and intuitive.

nit: you could add a define for the bitfield somewhere reusable?

> +}
> +
> +static hyp_alternate_select(__fpsimd_is_enabled,
> +			    __fpsimd_enabled_nvhe, __fpsimd_enabled_vhe,
> +			    ARM64_HAS_VIRT_HOST_EXTN);
> +
> +bool __hyp_text __fpsimd_enabled(void)
> +{
> +	return __fpsimd_is_enabled()();
> +}
> +
>  static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>  {
>  	u64 val;
> -- 
> 2.1.4
> 

Otherwise,
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

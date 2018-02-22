From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 16:34:55 +0100
Subject: [PATCH v4 31/40] KVM: arm64: Move common VHE/non-VHE trap config
 in separate functions
In-Reply-To: <20180215210332.8648-32-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-32-christoffer.dall@linaro.org>
Message-ID: <20180222153455.y6e4kbtfyhgbs3ud@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:23PM +0100, Christoffer Dall wrote:
> As we are about to be more lazy with some of the trap configuration
> register read/writes for VHE systems, move the logic that is currently
> shared between VHE and non-VHE into a separate function which can be
> called from either the world-switch path or from vcpu_load/vcpu_put.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v3:
>      - Separate fpsimd32 trap configuration into a separate function
>        which is still called from __activate_traps, because we no longer
>        defer saving/restoring of VFP registers to load/put.
> 
>  arch/arm64/kvm/hyp/switch.c | 76 +++++++++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 909aa3fe9196..17e3c6f26a34 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -56,7 +56,45 @@ static inline void __hyp_text __fpsimd_save_fpexc32(struct kvm_vcpu *vcpu)
>  	vcpu->arch.ctxt.sys_regs[FPEXC32_EL2] = read_sysreg(fpexc32_el2);
>  }
>  
> -static void __hyp_text __activate_traps_vhe(void)
> +static void __hyp_text __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * We are about to set CPTR_EL2.TFP to trap all floating point
> +	 * register accesses to EL2, however, the ARM ARM clearly states that
> +	 * traps are only taken to EL2 if the operation would not otherwise
> +	 * trap to EL1.  Therefore, always make sure that for 32-bit guests,
> +	 * we set FPEXC.EN to prevent traps to EL1, when setting the TFP bit.
> +	 * If FP/ASIMD is not implemented, FPEXC is UNDEFINED and any access to
> +	 * it will cause an exception.
> +	 */
> +	if (vcpu_el1_is_32bit(vcpu) && system_supports_fpsimd()) {
> +		write_sysreg(1 << 30, fpexc32_el2);
> +		isb();
> +	}
> +}
> +
> +static void __hyp_text __activate_traps_common(struct kvm_vcpu *vcpu)
> +{
> +	/* Trap on AArch32 cp15 c15 (impdef sysregs) accesses (EL1 or EL0) */
> +	write_sysreg(1 << 15, hstr_el2);

Could use a blank line here.

> +	/*
> +	 * Make sure we trap PMU access from EL0 to EL2. Also sanitize
> +	 * PMSELR_EL0 to make sure it never contains the cycle
> +	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
> +	 * EL1 instead of being trapped to EL2.
> +	 */
> +	write_sysreg(0, pmselr_el0);
> +	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
> +	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
> +}
> +
> +static void __hyp_text __deactivate_traps_common(void)
> +{
> +	write_sysreg(0, hstr_el2);
> +	write_sysreg(0, pmuserenr_el0);
> +}
> +
> +static void __hyp_text __activate_traps_vhe(struct kvm_vcpu *vcpu)
>  {
>  	u64 val;
>  
> @@ -68,7 +106,7 @@ static void __hyp_text __activate_traps_vhe(void)
>  	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
>  }
>  
> -static void __hyp_text __activate_traps_nvhe(void)
> +static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
>  {
>  	u64 val;
>  
> @@ -85,37 +123,14 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>  {
>  	u64 hcr = vcpu->arch.hcr_el2;
>  
> -	/*
> -	 * We are about to set CPTR_EL2.TFP to trap all floating point
> -	 * register accesses to EL2, however, the ARM ARM clearly states that
> -	 * traps are only taken to EL2 if the operation would not otherwise
> -	 * trap to EL1.  Therefore, always make sure that for 32-bit guests,
> -	 * we set FPEXC.EN to prevent traps to EL1, when setting the TFP bit.
> -	 * If FP/ASIMD is not implemented, FPEXC is UNDEFINED and any access to
> -	 * it will cause an exception.
> -	 */
> -	if (vcpu_el1_is_32bit(vcpu) && system_supports_fpsimd()) {
> -		write_sysreg(1 << 30, fpexc32_el2);
> -		isb();
> -	}
> +	write_sysreg(hcr, hcr_el2);
>  
>  	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN) && (hcr & HCR_VSE))
>  		write_sysreg_s(vcpu->arch.vsesr_el2, SYS_VSESR_EL2);
>  
> -	write_sysreg(hcr, hcr_el2);
> -
> -	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
> -	write_sysreg(1 << 15, hstr_el2);
> -	/*
> -	 * Make sure we trap PMU access from EL0 to EL2. Also sanitize
> -	 * PMSELR_EL0 to make sure it never contains the cycle
> -	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
> -	 * EL1 instead of being trapped to EL2.
> -	 */
> -	write_sysreg(0, pmselr_el0);
> -	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
> -	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
> -	__activate_traps_arch()();
> +	__activate_traps_fpsimd32(vcpu);
> +	__activate_traps_common(vcpu);
> +	__activate_traps_arch()(vcpu);
>  }
>  
>  static void __hyp_text __deactivate_traps_vhe(void)
> @@ -160,9 +175,8 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.hcr_el2 & HCR_VSE)
>  		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
>  
> +	__deactivate_traps_common();
>  	__deactivate_traps_arch()();
> -	write_sysreg(0, hstr_el2);
> -	write_sysreg(0, pmuserenr_el0);
>  }
>  
>  static void __hyp_text __activate_vm(struct kvm *kvm)
> -- 
> 2.14.2
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

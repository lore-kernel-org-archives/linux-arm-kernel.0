From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 12:41:32 +0100
Subject: [RFC 18/55] KVM: arm64: Forward traps due to HCR_EL2.NV1 bit to
 the guest hypervisor
In-Reply-To: <1483943091-1364-19-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-19-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222114132.GL26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:24:14AM -0500, Jintack Lim wrote:
> Forward ELR_EL1, SPSR_EL1 and VBAR_EL1 traps to the guest hypervisor if
> it has set the NV1 bit to the virtual HCR_EL2. The guest hypervisor
> would set this NV1 bit to run a hypervisor in its VM (i.e. another level
> of nested hypervisor).

Ah so this is recursively supporting the NV1 bit ?

> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
>  arch/arm64/include/asm/kvm_arm.h |  1 +
>  arch/arm64/kvm/sys_regs.c        | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 2a2752b..feded61 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -23,6 +23,7 @@
>  #include <asm/types.h>
>  
>  /* Hyp Configuration Register (HCR) bits */
> +#define HCR_NV1		(UL(1) << 43)
>  #define HCR_E2H		(UL(1) << 34)
>  #define HCR_ID		(UL(1) << 33)
>  #define HCR_CD		(UL(1) << 32)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 19d6a6e..59f9cc6 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -906,10 +906,21 @@ static inline void access_rw(struct sys_reg_params *p, u64 *sysreg)
>  		*sysreg = p->regval;
>  }
>  
> +static bool forward_nv1_traps(struct kvm_vcpu *vcpu, struct sys_reg_params *p)
> +{
> +	if (!vcpu_mode_el2(vcpu) && (vcpu_el2_reg(vcpu, HCR_EL2) & HCR_NV1))
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool access_elr(struct kvm_vcpu *vcpu,
>  		struct sys_reg_params *p,
>  		const struct sys_reg_desc *r)
>  {
> +	if (forward_nv1_traps(vcpu, p))
> +		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +
>  	access_rw(p, &vcpu->arch.ctxt.gp_regs.elr_el1);
>  	return true;
>  }
> @@ -918,6 +929,9 @@ static bool access_spsr(struct kvm_vcpu *vcpu,
>  		struct sys_reg_params *p,
>  		const struct sys_reg_desc *r)
>  {
> +	if (forward_nv1_traps(vcpu, p))
> +		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +
>  	access_rw(p, &vcpu->arch.ctxt.gp_regs.spsr[KVM_SPSR_EL1]);
>  	return true;
>  }
> @@ -926,6 +940,9 @@ static bool access_vbar(struct kvm_vcpu *vcpu,
>  		struct sys_reg_params *p,
>  		const struct sys_reg_desc *r)
>  {
> +	if (forward_nv1_traps(vcpu, p))
> +		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +
>  	access_rw(p, &vcpu_sys_reg(vcpu, r->reg));
>  	return true;
>  }
> -- 
> 1.9.1
> 
> 

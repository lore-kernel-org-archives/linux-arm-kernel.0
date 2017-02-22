From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 12:40:26 +0100
Subject: [RFC 17/55] KVM: arm64: Trap SPSR_EL1, ELR_EL1 and VBAR_EL1 in
 virtual EL2
In-Reply-To: <1483943091-1364-18-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-18-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222114026.GK26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:24:13AM -0500, Jintack Lim wrote:
> For the same reason we trap virtual memory register accesses in virtual
> EL2, we need to trap SPSR_EL1, ELR_EL1 and VBAR_EL1 accesses. ARM v8.3
> introduces the HCR_EL2.NV1 bit to be able to trap on those register
> accesses in EL1. Do not set this bit until the whole nesting support is
> complete.

You'll only enable this feature for a non-VHE guest hypervisor, right?

> 
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
>  arch/arm64/kvm/sys_regs.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 0f5d21b..19d6a6e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -898,6 +898,38 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +static inline void access_rw(struct sys_reg_params *p, u64 *sysreg)
> +{
> +	if (!p->is_write)
> +		p->regval = *sysreg;
> +	else
> +		*sysreg = p->regval;
> +}
> +
> +static bool access_elr(struct kvm_vcpu *vcpu,
> +		struct sys_reg_params *p,
> +		const struct sys_reg_desc *r)
> +{
> +	access_rw(p, &vcpu->arch.ctxt.gp_regs.elr_el1);
> +	return true;
> +}
> +
> +static bool access_spsr(struct kvm_vcpu *vcpu,
> +		struct sys_reg_params *p,
> +		const struct sys_reg_desc *r)
> +{
> +	access_rw(p, &vcpu->arch.ctxt.gp_regs.spsr[KVM_SPSR_EL1]);
> +	return true;
> +}
> +
> +static bool access_vbar(struct kvm_vcpu *vcpu,
> +		struct sys_reg_params *p,
> +		const struct sys_reg_desc *r)
> +{
> +	access_rw(p, &vcpu_sys_reg(vcpu, r->reg));
> +	return true;
> +}
> +
>  static bool trap_el2_reg(struct kvm_vcpu *vcpu,
>  			 struct sys_reg_params *p,
>  			 const struct sys_reg_desc *r)
> @@ -1013,6 +1045,13 @@ static bool trap_el2_reg(struct kvm_vcpu *vcpu,
>  	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b010),
>  	  access_vm_reg, reset_val, TCR_EL1, 0 },
>  
> +	/* SPSR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0100), CRm(0b0000), Op2(0b000),
> +	  access_spsr},
> +	/* ELR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0100), CRm(0b0000), Op2(0b001),
> +	  access_elr},
> +
>  	/* AFSR0_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b000),
>  	  access_vm_reg, reset_unknown, AFSR0_EL1 },
> @@ -1045,7 +1084,7 @@ static bool trap_el2_reg(struct kvm_vcpu *vcpu,
>  
>  	/* VBAR_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
> -	  NULL, reset_val, VBAR_EL1, 0 },
> +	  access_vbar, reset_val, VBAR_EL1, 0 },
>  
>  	/* ICC_SGI1R_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
> -- 
> 1.9.1
> 
> 

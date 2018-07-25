From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 25 Jul 2018 16:46:55 +0100
Subject: [RFC PATCH 09/16] KVM: arm64: Allow ID registers to by
 dynamically read-as-zero
In-Reply-To: <1529593060-542-10-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <876013tj0w.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> When a feature-dependent ID register is hidden from the guest, it
> needs to exhibit read-as-zero behaviour as defined by the Arm
> architecture, rather than appearing to be entirely absent.
>
> This patch updates the ID register emulation logic to make use of
> the new check_present() method to determine whether the register
> should read as zero instead of yielding the host's sanitised
> value.  Because currently a false result from this method truncates
> the trap call chain before the sysreg's emulate method() is called,
> a flag is added to distinguish this special case, and helpers are
> refactored appropriately.
>
> This invloves some trivial updates to pass the vcpu pointer down
> into the ID register emulation/access functions.
>
> A new ID_SANITISED_IF() macro is defined for declaring
> conditionally visible ID registers.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
<snip>
> @@ -2337,7 +2352,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
>  	if (!r)
>  		return set_invariant_sys_reg(reg->id, uaddr);
>
> -	if (!sys_reg_present(vcpu, r))
> +	if (!sys_reg_present_or_raz(vcpu, r))
>  		return -ENOENT;

It's all very well being raz, but shouldn't you catch this further down
and not attempt to write the register that doesn't exist?

>
>  	if (r->set_user)
> @@ -2408,7 +2423,7 @@ static int walk_one_sys_reg(struct kvm_vcpu *vcpu,
>  	if (!(rd->reg || rd->get_user))
>  		return 0;
>
> -	if (!sys_reg_present(vcpu, rd))
> +	if (!sys_reg_present_or_raz(vcpu, rd))
>  		return 0;
>
>  	if (!copy_reg_to_user(rd, uind))
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index dfbb342..304928f 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -66,14 +66,25 @@ struct sys_reg_desc {
>  			const struct kvm_one_reg *reg, void __user *uaddr);
>  	bool (*check_present)(const struct kvm_vcpu *vpcu,
>  			      const struct sys_reg_desc *rd);
> +
> +	/* OR of SR_* flags */
> +	unsigned int flags;
>  };
>
> +#define SR_RAZ_IF_ABSENT	(1 << 0)
> +
>  static inline bool sys_reg_present(const struct kvm_vcpu *vcpu,
>  				   const struct sys_reg_desc *rd)
>  {
>  	return likely(!rd->check_present) || rd->check_present(vcpu, rd);
>  }
>
> +static inline bool sys_reg_present_or_raz(const struct kvm_vcpu *vcpu,
> +					  const struct sys_reg_desc *rd)
> +{
> +	return sys_reg_present(vcpu, rd) || (rd->flags & SR_RAZ_IF_ABSENT);
> +}
> +
>  static inline void print_sys_reg_instr(const struct sys_reg_params *p)
>  {
>  	/* Look, we even formatted it for you to paste into the table! */


--
Alex Benn?e

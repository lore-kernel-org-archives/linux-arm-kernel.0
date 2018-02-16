From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 16 Feb 2018 09:13:27 +0100
Subject: [PATCH] KVM: arm: Enable emulation of the physical timer
In-Reply-To: <1518518476-26645-1-git-send-email-j.fanguede@virtualopensystems.com>
References: <1518518476-26645-1-git-send-email-j.fanguede@virtualopensystems.com>
Message-ID: <20180216081327.GA10440@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 11:41:16AM +0100, J?r?my Fangu?de wrote:
> Set the handlers to emulate read and write operations for CNTP_CTL,
> CNTP_CVAL and CNTP_TVAL registers in such a way that VMs can use the
> physical timer.
> 
> Signed-off-by: J?r?my Fangu?de <j.fanguede@virtualopensystems.com>
> ---
> 
> This patch is the equivalent of this one: [1], but for arm 32bits
> instead of ARMv8 aarch32.
> 
> [1] https://patchwork.kernel.org/patch/10207019/
> 

Thanks, both queued.

-Christoffer

> ---
>  arch/arm/kvm/coproc.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 6d1d2e2..3a02e76 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -270,6 +270,60 @@ static bool access_gic_sre(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +static bool access_cntp_tval(struct kvm_vcpu *vcpu,
> +			     const struct coproc_params *p,
> +			     const struct coproc_reg *r)
> +{
> +	u64 now = kvm_phys_timer_read();
> +	u64 val;
> +
> +	if (p->is_write) {
> +		val = *vcpu_reg(vcpu, p->Rt1);
> +		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val + now);
> +	} else {
> +		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
> +		*vcpu_reg(vcpu, p->Rt1) = val - now;
> +	}
> +
> +	return true;
> +}
> +
> +static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
> +			    const struct coproc_params *p,
> +			    const struct coproc_reg *r)
> +{
> +	u32 val;
> +
> +	if (p->is_write) {
> +		val = *vcpu_reg(vcpu, p->Rt1);
> +		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CTL, val);
> +	} else {
> +		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CTL);
> +		*vcpu_reg(vcpu, p->Rt1) = val;
> +	}
> +
> +	return true;
> +}
> +
> +static bool access_cntp_cval(struct kvm_vcpu *vcpu,
> +			     const struct coproc_params *p,
> +			     const struct coproc_reg *r)
> +{
> +	u64 val;
> +
> +	if (p->is_write) {
> +		val = (u64)*vcpu_reg(vcpu, p->Rt2) << 32;
> +		val |= *vcpu_reg(vcpu, p->Rt1);
> +		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val);
> +	} else {
> +		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
> +		*vcpu_reg(vcpu, p->Rt1) = val;
> +		*vcpu_reg(vcpu, p->Rt2) = val >> 32;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * We could trap ID_DFR0 and tell the guest we don't support performance
>   * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
> @@ -423,10 +477,17 @@ static const struct coproc_reg cp15_regs[] = {
>  	{ CRn(13), CRm( 0), Op1( 0), Op2( 4), is32,
>  			NULL, reset_unknown, c13_TID_PRIV },
>  
> +	/* CNTP */
> +	{ CRm64(14), Op1( 2), is64, access_cntp_cval},
> +
>  	/* CNTKCTL: swapped by interrupt.S. */
>  	{ CRn(14), CRm( 1), Op1( 0), Op2( 0), is32,
>  			NULL, reset_val, c14_CNTKCTL, 0x00000000 },
>  
> +	/* CNTP */
> +	{ CRn(14), CRm( 2), Op1( 0), Op2( 0), is32, access_cntp_tval },
> +	{ CRn(14), CRm( 2), Op1( 0), Op2( 1), is32, access_cntp_ctl },
> +
>  	/* The Configuration Base Address Register. */
>  	{ CRn(15), CRm( 0), Op1( 4), Op2( 0), is32, access_cbar},
>  };
> -- 
> 2.7.4
> 

From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 21 Nov 2018 16:09:03 +0000
Subject: [RFC PATCH v2 16/23] KVM: arm64: Enumerate SVE register indices
 for KVM_GET_REG_LIST
In-Reply-To: <1538141967-15375-17-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-17-git-send-email-Dave.Martin@arm.com>
Message-ID: <87k1l6ifa8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> This patch includes the SVE register IDs in the list returned by
> KVM_GET_REG_LIST, as appropriate.
>
> On a non-SVE-enabled vcpu, no extra IDs are added.
>
> On an SVE-enabled vcpu, the appropriate number of slice IDs are
> enumerated for each SVE register, depending on the maximum vector
> length for the vcpu.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>
> Changes since RFCv1:
>
>  * Simplify enumerate_sve_regs() based on Andrew Jones' approach.
>
>  * Reg copying loops are inverted for brevity, since the order we
>    spit out the regs in doesn't really matter.
>
> (I tried to keep part of my approach to avoid the duplicate logic
> between num_sve_regs() and copy_sve_reg_indices(), but although
> it works in principle, gcc fails to fully collapse the num_regs()
> case... so I gave up.  The two functions need to be manually kept
> consistent, but hopefully that's fairly straightforward.)
> ---
>  arch/arm64/kvm/guest.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 320db0f..89eab68 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -323,6 +323,46 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
>  }
>
> +static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
> +{
> +	const unsigned int slices = DIV_ROUND_UP(
> +		vcpu->arch.sve_max_vl,
> +		KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));

Having seen this formulation come up several times now I wonder if there
should be a kernel private define, KVM_SVE_ZREG/PREG_SIZE to avoid this
clumsiness.

You could still use the KVM_REG_SIZE to extract it as I guess this is to
make changes simpler if/when the SVE reg size gets bumped up.

> +
> +	if (!vcpu_has_sve(vcpu))
> +		return 0;
> +
> +	return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */);
> +}
> +
> +static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu, u64 __user **uind)
> +{
> +	const unsigned int slices = DIV_ROUND_UP(
> +		vcpu->arch.sve_max_vl,
> +		KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));
> +	unsigned int i, n;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		return 0;
> +
> +	for (i = 0; i < slices; i++) {
> +		for (n = 0; n < SVE_NUM_ZREGS; n++) {
> +			if (put_user(KVM_REG_ARM64_SVE_ZREG(n, i), (*uind)++))
> +				return -EFAULT;
> +		}
> +
> +		for (n = 0; n < SVE_NUM_PREGS; n++) {
> +			if (put_user(KVM_REG_ARM64_SVE_PREG(n, i), (*uind)++))
> +				return -EFAULT;
> +		}
> +
> +		if (put_user(KVM_REG_ARM64_SVE_FFR(i), (*uind)++))
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
>   *
> @@ -333,6 +373,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>  	unsigned long res = 0;
>
>  	res += num_core_regs();
> +	res += num_sve_regs(vcpu);
>  	res += kvm_arm_num_sys_reg_descs(vcpu);
>  	res += kvm_arm_get_fw_num_regs(vcpu);
>  	res += NUM_TIMER_REGS;
> @@ -357,6 +398,10 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>  		uindices++;
>  	}
>
> +	ret = copy_sve_reg_indices(vcpu, &uindices);
> +	if (ret)
> +		return ret;
> +
>  	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
>  	if (ret)
>  		return ret;

Otherwise:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

--
Alex Benn?e

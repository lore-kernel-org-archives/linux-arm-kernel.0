From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 13 Mar 2013 14:30:19 -0400
Subject: [PATCH 10/29] arm64: KVM: Cortex-A57 specific system registers
 handling
In-Reply-To: <1362455265-24165-11-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <5140C5BB.7010401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I wonder if two of these registers could be handled in a generic fashion.

On 03/04/2013 10:47 PM, Marc Zyngier wrote:
> Add the support code for Cortex-A57 specific system registers.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/sys_regs_a57.c | 96 +++++++++++++++++++++++++++++++++++++++++++

[...]

> +#define MPIDR_EL1_AFF0_MASK	0xff
> +
> +static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	/*
> +	 * Simply map the vcpu_id into the Aff0 field of the MPIDR.
> +	 */
> +	vcpu->arch.sys_regs[MPIDR_EL1] = (1 << 31) | (vcpu->vcpu_id & MPIDR_EL1_AFF0_MASK);
> +}

What's A57-specific about this MPIDR behavior?

[...]

> +/*
> + * A57-specific sys-reg registers.
> + * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
> + */
> +static const struct sys_reg_desc a57_sys_regs[] = {
> +	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b101), /* MPIDR_EL1 */
> +	  NULL, reset_mpidr, MPIDR_EL1 },
> +	{ Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b000), /* SCTLR_EL1 */
> +	  NULL, reset_val, SCTLR_EL1, 0x00C50078 },
> +	{ Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b001), /* ACTLR_EL1 */
> +	  access_actlr, reset_actlr, ACTLR_EL1 },
> +	{ Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b010), /* CPACR_EL1 */
> +	  NULL, reset_val, CPACR_EL1, 0 },

What's A57-specific about this CPACR behavior?

> +};

[...]

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation

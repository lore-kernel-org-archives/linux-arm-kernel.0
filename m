From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 12 Mar 2013 09:20:57 -0400
Subject: [PATCH 06/29] arm64: KVM: fault injection into a guest
In-Reply-To: <1362455265-24165-7-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <513F2BB9.80306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I noticed you went through the trouble of defining several constants in an
earlier patch. Perhaps you could put them to use here?

On 03/04/2013 10:47 PM, Marc Zyngier wrote:
> Implement the injection of a fault (undefined, data abort or
> prefetch abort) into a 64bit guest.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/inject_fault.c | 117 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 arch/arm64/kvm/inject_fault.c

[...]

> +static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
> +{
> +	unsigned long cpsr = *vcpu_cpsr(vcpu);
> +	int is_aarch32;
> +	u32 esr = 0;
> +
> +	is_aarch32 = vcpu_mode_is_32bit(vcpu);
> +
> +	*vcpu_spsr(vcpu) = cpsr;
> +	vcpu->arch.regs.elr_el1 = *vcpu_pc(vcpu);
> +
> +	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_A_BIT | PSR_F_BIT | PSR_I_BIT;
> +	*vcpu_pc(vcpu) = vcpu->arch.sys_regs[VBAR_EL1] + 0x200;
> +
> +	vcpu->arch.sys_regs[FAR_EL1] = addr;
> +
> +	/*
> +	 * Build an {i,d}abort, depending on the level and the
> +	 * instruction set. Report an external synchronous abort.
> +	 */
> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
> +		esr |= (1 << 25);

ESR_EL2_IL

> +	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
> +		esr |= (0x20 << 26);

ESR_EL2_EC_IABT << ESR_EL2_EC_SHIFT

> +	else
> +		esr |= (0x21 << 26);

ESR_EL2_EC_IABT_HYP << ESR_EL2_EC_SHIFT

> +
> +	if (!is_iabt)
> +		esr |= (1 << 28);

ESR_EL2_EC_DABT << ESR_EL2_EC_SHIFT

> +
> +	vcpu->arch.sys_regs[ESR_EL1] = esr | 0x10;
> +}
> +
> +static void inject_undef64(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long cpsr = *vcpu_cpsr(vcpu);
> +	u32 esr = 0;
> +
> +	*vcpu_spsr(vcpu) = cpsr;
> +	vcpu->arch.regs.elr_el1 = *vcpu_pc(vcpu);
> +
> +	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_F_BIT | PSR_I_BIT;
> +	*vcpu_pc(vcpu) = vcpu->arch.sys_regs[VBAR_EL1] + 0x200;
> +
> +	/*
> +	 * Build an unknown exception, depending on the instruction
> +	 * set.
> +	 */
> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
> +		esr |= (1 << 25);

ESR_EL2_IL

> +
> +	vcpu->arch.sys_regs[ESR_EL1] = esr;
> +}

[...]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation

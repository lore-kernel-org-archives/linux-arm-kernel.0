From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Mar 2013 14:25:14 +0000
Subject: [PATCH 06/29] arm64: KVM: fault injection into a guest
In-Reply-To: <513F2BB9.80306@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-7-git-send-email-marc.zyngier@arm.com>
 <513F2BB9.80306@codeaurora.org>
Message-ID: <513F3ACA.7020002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/13 13:20, Christopher Covington wrote:

Hi Christopher,

> I noticed you went through the trouble of defining several constants in an
> earlier patch. Perhaps you could put them to use here?
> 
> On 03/04/2013 10:47 PM, Marc Zyngier wrote:
>> Implement the injection of a fault (undefined, data abort or
>> prefetch abort) into a 64bit guest.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/inject_fault.c | 117 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 117 insertions(+)
>>  create mode 100644 arch/arm64/kvm/inject_fault.c
> 
> [...]
> 
>> +static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
>> +{
>> +	unsigned long cpsr = *vcpu_cpsr(vcpu);
>> +	int is_aarch32;
>> +	u32 esr = 0;
>> +
>> +	is_aarch32 = vcpu_mode_is_32bit(vcpu);
>> +
>> +	*vcpu_spsr(vcpu) = cpsr;
>> +	vcpu->arch.regs.elr_el1 = *vcpu_pc(vcpu);
>> +
>> +	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_A_BIT | PSR_F_BIT | PSR_I_BIT;
>> +	*vcpu_pc(vcpu) = vcpu->arch.sys_regs[VBAR_EL1] + 0x200;
>> +
>> +	vcpu->arch.sys_regs[FAR_EL1] = addr;
>> +
>> +	/*
>> +	 * Build an {i,d}abort, depending on the level and the
>> +	 * instruction set. Report an external synchronous abort.
>> +	 */
>> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
>> +		esr |= (1 << 25);
> 
> ESR_EL2_IL

This is the illustration of what I was saying earlier about confusing
levels. Here, we're dealing with the guest's EL1. Using the _EL2 define
is semantically wrong, even if it has the same value.

> 
>> +	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
>> +		esr |= (0x20 << 26);
> 
> ESR_EL2_EC_IABT << ESR_EL2_EC_SHIFT
> 
>> +	else
>> +		esr |= (0x21 << 26);
> 
> ESR_EL2_EC_IABT_HYP << ESR_EL2_EC_SHIFT

Even worse here. What this actually mean is "Exception@the current
level", which is EL1. Having _HYP here is completely misleading.

Now, maybe I should review all these defines and give them a more
general meaning. Then we'd be able to share the defines across levels
(arm/arch64/kernel/entry.S could use some defines too...). But overall,
I'm quite reluctant to start mixing ESR_EL1 and ESR_EL2.

>> +
>> +	if (!is_iabt)
>> +		esr |= (1 << 28);
> 
> ESR_EL2_EC_DABT << ESR_EL2_EC_SHIFT

Nasty. Works, but very nasty... ;-)

>> +
>> +	vcpu->arch.sys_regs[ESR_EL1] = esr | 0x10;
>> +}
>> +
>> +static void inject_undef64(struct kvm_vcpu *vcpu)
>> +{
>> +	unsigned long cpsr = *vcpu_cpsr(vcpu);
>> +	u32 esr = 0;
>> +
>> +	*vcpu_spsr(vcpu) = cpsr;
>> +	vcpu->arch.regs.elr_el1 = *vcpu_pc(vcpu);
>> +
>> +	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_F_BIT | PSR_I_BIT;
>> +	*vcpu_pc(vcpu) = vcpu->arch.sys_regs[VBAR_EL1] + 0x200;
>> +
>> +	/*
>> +	 * Build an unknown exception, depending on the instruction
>> +	 * set.
>> +	 */
>> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
>> +		esr |= (1 << 25);
> 
> ESR_EL2_IL
> 
>> +
>> +	vcpu->arch.sys_regs[ESR_EL1] = esr;
>> +}

Thanks for reviewing,

	M.
-- 
Jazz is not dead. It just smells funny...

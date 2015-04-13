From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Mon, 13 Apr 2015 08:59:21 +0100
Subject: [PATCH v2 09/10] KVM: arm64: trap nested debug register access
In-Reply-To: <20150410123830.GB3227@hawk.usersys.redhat.com>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-10-git-send-email-alex.bennee@linaro.org>
 <20150410123830.GB3227@hawk.usersys.redhat.com>
Message-ID: <877ftglaqu.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andrew Jones <drjones@redhat.com> writes:

> On Tue, Mar 31, 2015 at 04:08:07PM +0100, Alex Benn?e wrote:
>> When we are using the hardware registers for guest debug we need to deal
>> with the guests access to them. There is already a mechanism for dealing
>> with these accesses so we build on top of that.
>> 
>>   - mdscr_el1_bits is renamed as we save the whole register
>>   - any access to mdscr_el1 is now stored in the mirror location
>>   - if we are using HW assisted debug we do the same with DBG[WB][CV]R
>> 
>> There is one register (MDCCINT_EL1) which guest debug doesn't care about
>> so this behaves as before.
>> 
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 2c359c9..3d32d45 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -122,10 +122,13 @@ struct kvm_vcpu_arch {
>>  	 * here.
>>  	 */
>>  
>> -	/* Registers pre any guest debug manipulations */
>> +	/* Registers before any guest debug manipulations. These
>
> starting comment /* on own line
>
>> +	 * shadow registers are updated by the kvm_handle_sys_reg
>> +	 * trap handler if the guest accesses or updates them
>> +	 */
>>  	struct {
>>  		u32	pstate_ss_bit;
>> -		u32	mdscr_el1_bits;
>> +		u32	mdscr_el1;
>>  
>>  		struct kvm_guest_debug_arch debug_regs;
>>  	} debug_saved_regs;
>> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
>> index 3b368f3..638c111 100644
>> --- a/arch/arm64/kvm/debug.c
>> +++ b/arch/arm64/kvm/debug.c
>> @@ -55,8 +55,6 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
>>  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM | MDCR_EL2_TPMCR);
>>  	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TDRA | MDCR_EL2_TDOSA);
>>  
>> -	trace_kvm_arch_setup_debug_reg32("MDCR_EL2", vcpu->arch.mdcr_el2);
>> -
>
> I guess I'll see this come back in the next patch. You must be playing
> 'now you see me, now you don't'

Oops, missed that on the rebase.

>
>>  	/*
>>  	 * If we are not treating debug registers are dirty we need
>>  	 * to trap if the guest starts accessing them.
>> @@ -71,8 +69,10 @@ void kvm_arch_setup_debug(struct kvm_vcpu *vcpu)
>>  		/* Save pstate/mdscr */
>>  		vcpu_debug_saved_reg(vcpu, pstate_ss_bit) =
>>  			*vcpu_cpsr(vcpu) & DBG_SPSR_SS;
>> -		vcpu_debug_saved_reg(vcpu, mdscr_el1_bits) =
>> -			vcpu_sys_reg(vcpu, MDSCR_EL1) & MDSCR_EL1_DEBUG_BITS;
>> +
>> +		vcpu_debug_saved_reg(vcpu, mdscr_el1) =
>> +			vcpu_sys_reg(vcpu, MDSCR_EL1);
>> +
>>  		/*
>>  		 * Single Step (ARM ARM D2.12.3 The software step state
>>  		 * machine)
>> @@ -161,9 +161,8 @@ void kvm_arch_clear_debug(struct kvm_vcpu *vcpu)
>>  		*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
>>  		*vcpu_cpsr(vcpu) |= vcpu_debug_saved_reg(vcpu, pstate_ss_bit);
>>  
>> -		vcpu_sys_reg(vcpu, MDSCR_EL1) &= ~MDSCR_EL1_DEBUG_BITS;
>> -		vcpu_sys_reg(vcpu, MDSCR_EL1) |=
>> -			vcpu_debug_saved_reg(vcpu, mdscr_el1_bits);
>> +		vcpu_sys_reg(vcpu, MDSCR_EL1) =
>> +			vcpu_debug_saved_reg(vcpu, mdscr_el1);
>>  
>>  		/*
>>  		 * If we were using HW debug we need to restore the
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index be9b188..d43d7d1 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -208,39 +208,61 @@ static bool trap_debug_regs(struct kvm_vcpu *vcpu,
>>  			    const struct sys_reg_params *p,
>>  			    const struct sys_reg_desc *r)
>>  {
>> -	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
>> -		struct kvm_guest_debug_arch *saved;
>> -		__u64 *val;
>> -
>> -		saved = &vcpu_debug_saved_reg(vcpu, debug_regs);
>> -
>> -		if (r->reg >= DBGBCR0_EL1 && r->reg <= DBGBCR15_EL1)
>> -			val = &saved->dbg_bcr[r->reg - DBGBCR0_EL1];
>> -		else if (r->reg >= DBGBVR0_EL1 && r->reg <= DBGBVR15_EL1)
>> -			val = &saved->dbg_bvr[r->reg - DBGBVR0_EL1];
>> -		else if (r->reg >= DBGWCR0_EL1 && r->reg <= DBGWCR15_EL1)
>> -			val = &saved->dbg_wcr[r->reg - DBGWCR0_EL1];
>> -		else if (r->reg >= DBGWVR0_EL1 && r->reg <= DBGWVR15_EL1)
>> -			val = &saved->dbg_wvr[r->reg - DBGWVR0_EL1];
>> -		else {
>> -			kvm_err("Bad register index %d\n", r->reg);
>> -			return false;
>> +	if (vcpu->guest_debug) {
>> +
>> +		/* MDSCR_EL1 */
>> +		if (r->reg == MDSCR_EL1) {
>> +			if (p->is_write)
>> +				vcpu_debug_saved_reg(vcpu, mdscr_el1) =
>> +					*vcpu_reg(vcpu, p->Rt);
>> +			else
>> +				*vcpu_reg(vcpu, p->Rt) =
>> +					vcpu_debug_saved_reg(vcpu, mdscr_el1);
>
> With this lines wrapping, {}'s might be nice.

My natural inclination is to wrap in {}'s but I know the kernel is a fan
of the single-statement if forms.

>
>> +
>> +			return true;
>>  		}
>>  
>> -		if (p->is_write)
>> -			*val = *vcpu_reg(vcpu, p->Rt);
>> -		else
>> -			*vcpu_reg(vcpu, p->Rt) = *val;
>> +		/* MDCCINT_EL1 */
>> +		if (r->reg == MDCCINT_EL1)
>> +			goto old;
>
> "old"? As in the old way this worked? Someday (soon) all this code will
> be "old". How about just 'out'? Or use some other way to get the flow
> such that we avoid code duplication, but doesn't require a goto?

I'll see if I can structure this better.

>
>> +
>> +		/* We only shadow DBG* if guest being debugged */
>> +		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
>> +			struct kvm_guest_debug_arch *saved;
>> +			__u64 *val;
>> +
>> +			saved = &vcpu_debug_saved_reg(vcpu, debug_regs);
>> +
>> +			if (r->reg >= DBGBCR0_EL1 && r->reg <= DBGBCR15_EL1)
>> +				val = &saved->dbg_bcr[r->reg - DBGBCR0_EL1];
>> +			else if (r->reg >= DBGBVR0_EL1 && r->reg <= DBGBVR15_EL1)
>> +				val = &saved->dbg_bvr[r->reg - DBGBVR0_EL1];
>> +			else if (r->reg >= DBGWCR0_EL1 && r->reg <= DBGWCR15_EL1)
>> +				val = &saved->dbg_wcr[r->reg - DBGWCR0_EL1];
>> +			else if (r->reg >= DBGWVR0_EL1 && r->reg <= DBGWVR15_EL1)
>> +				val = &saved->dbg_wvr[r->reg - DBGWVR0_EL1];
>> +			else {
>> +				kvm_err("Bad register index %d\n", r->reg);
>> +				return false;
>> +			}
>>  
>> -	} else {
>> -		if (p->is_write) {
>> -			vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
>> -			vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
>> -		} else {
>> -			*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
>> +			if (p->is_write)
>> +				*val = *vcpu_reg(vcpu, p->Rt);
>> +			else
>> +				*vcpu_reg(vcpu, p->Rt) = *val;
>> +
>> +			return true;
>>  		}
>>  	}
>>  
>> +old:
>> +	if (p->is_write) {
>> +		vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
>> +		vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
>> +	} else {
>> +		*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
>> +	}
>> +
>>  	return true;
>>  }
>>  
>> -- 
>> 2.3.4
>> 

-- 
Alex Benn?e

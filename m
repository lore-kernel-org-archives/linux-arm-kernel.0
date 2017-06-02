From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Jun 2017 09:48:43 +0100
Subject: [RFC 08/55] KVM: arm64: Set virtual EL2 context depending on the
 guest exception level
In-Reply-To: <jpgtw3zzcee.fsf@linux.bootlegged.copy>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-9-git-send-email-jintack@cs.columbia.edu>
 <jpgtw3zzcee.fsf@linux.bootlegged.copy>
Message-ID: <178e3aaf-dd25-9590-35d7-c1f2705a5c06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/17 21:22, Bandan Das wrote:
> Jintack Lim <jintack@cs.columbia.edu> writes:
> 
>> From: Christoffer Dall <christoffer.dall@linaro.org>
>>
>> Set up virutal EL2 context to hardware if the guest exception level is
>> EL2.
>>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
>> ---
>>  arch/arm64/kvm/context.c | 32 ++++++++++++++++++++++++++------
>>  1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
>> index 320afc6..acb4b1e 100644
>> --- a/arch/arm64/kvm/context.c
>> +++ b/arch/arm64/kvm/context.c
>> @@ -25,10 +25,25 @@
>>  void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
>> +	if (unlikely(vcpu_mode_el2(vcpu))) {
>> +		ctxt->hw_pstate = *vcpu_cpsr(vcpu) & ~PSR_MODE_MASK;
>>  
>> -	ctxt->hw_pstate = *vcpu_cpsr(vcpu);
>> -	ctxt->hw_sys_regs = ctxt->sys_regs;
>> -	ctxt->hw_sp_el1 = ctxt->gp_regs.sp_el1;
>> +		/*
>> +		 * We emulate virtual EL2 mode in hardware EL1 mode using the
>> +		 * same stack pointer mode as the guest expects.
>> +		 */
>> +		if ((*vcpu_cpsr(vcpu) & PSR_MODE_MASK) == PSR_MODE_EL2h)
>> +			ctxt->hw_pstate |= PSR_MODE_EL1h;
>> +		else
>> +			ctxt->hw_pstate |= PSR_MODE_EL1t;
>> +
> 
> I see vcpu_mode(el2) does
> return mode == PSR_MODE_EL2h || mode == PSR_MODE_EL2t;
> 
> I can't seem to find this, what's the difference between
> the modes: PSR_MODE_EL2h/EL2t ?

The difference is the stack pointer that is getting used. When the CPU
is at ELxh, it uses SPx at ELx. When at ELxt, it uses SP0 (the userspace
stack pointer). See the definition of SPSR_EL2 in the ARMv8 ARM.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

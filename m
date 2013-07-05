From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 05 Jul 2013 15:44:28 +0100
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <51D6D377.70708@linaro.org>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
 <51C2D528.90805@arm.com> <51D6D377.70708@linaro.org>
Message-ID: <51D6DBCC.9040807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/13 15:08, Andre Przywara wrote:
> Hi Marc,
> 
>  >> ...
>>>
>>> +int kvm_arm_num_timer_regs(void)
>>> +{
>>> +	return 3;
>>> +}
>>> +
>>> +int kvm_arm_copy_timer_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>>> +{
>>> +	if (put_user(KVM_REG_ARM_TIMER_CTL, uindices))
>>> +		return -EFAULT;
>>> +	uindices++;
>>> +	if (put_user(KVM_REG_ARM_TIMER_CNT, uindices))
>>> +		return -EFAULT;
>>> +	uindices++;
>>> +	if (put_user(KVM_REG_ARM_TIMER_CVAL, uindices))
>>> +		return -EFAULT;
>>
>> So these macros are going to break arm64. Any chance you could introduce
>> them at the same time on both platforms? The rest of the work can be
>> delayed, but you shouldn't break arm64 (you'd expect me to say that,
>> wouldn't you? ;-).
> 
> Is that just due to KVM_REG_ARM instead of KVM_REG_ARM64?
> Or do you expect the numbering to be completely different since there is 
> no mrc/mcr anymore (IIRC)?

Both. The encoding is different (32bit is encoded CRn/CRm/Op1/Op2, and
64bit is Op0/Op1/CRn/CRm/Op2), and the KVM_REG_ARM64 is different too.

> Is put_user an issue here (should not, right?)

No, except for the reason outlined below.

> Is there already a document describing arch timer access on AARCH64?

No, but it is strikingly similar to the AArch32. Have a look at
arch/arm64/include/asm/arch_timer.h and arch/arm64/kvm/hyp.S for details.

> If I am thinking in a totally wrong direction, please bear with me and 
> feel free to point me to the right one ;-)
> /me is now looking at getting a cross compiler to see what you mean...

That'd be a good thing! ;-)

>> Also, I'd like to keep userspace access out of the timer code itself.
>> Low level code shouldn't have to know about that. Can you create proper
>> accessors instead, and move whole userspace access to coproc.c?
> 
> IIRC Christoffer recommended to keep this code completely out of 
> coproc.c ;-) This also helps to keep coproc.c clean of ARCH_TIMER ifdefs 
> in coproc.c (which I completely forgot in this version, btw, but that's 
> already fixed).

I thought we agreed on moving the userspace access out of the timer
code. In a reply to the email you just quoted, Christoffer says:
"I'm fine with this, coproc.c or guest.c - either way.".

The man has spoken! ;-)

>>
>>> +	return 0;
>>> +}
>>> +
>>> +int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>> +{
>>> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>>> +	void __user *uaddr = (void __user *)(long)reg->addr;
>>> +	u64 val;
>>> +	int ret;
>>> +
>>> +	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
>>> +	if (ret != 0)
>>> +		return ret;
>>> +
>>> +	switch (reg->id) {
>>> +	case KVM_REG_ARM_TIMER_CTL:
>>> +		timer->cntv_ctl = val;
>>> +		break;
>>> +	case KVM_REG_ARM_TIMER_CNT:
>>> +		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - val;
>>
>> I just realized what bothers me here: You're computing cntvoff on a per
>> vcpu basis, while this is a VM property. Which means that as you're
>> restoring vcpus, you'll be changing cntvoff - sounds like a bad idea to me.
>>
>> The counter is really global. Do we have a way to handle VM-wide
>> registers? I think Christoffer was trying to some a similar thing with
>> the GIC...
> 
> So the consensus of this discussion was just to block writing when the 
> VCPU is running, right? Or is there something else?

Yup. No update while vcpus are running.

	M.
-- 
Jazz is not dead. It just smells funny...

From: andre.przywara@linaro.org (Andre Przywara)
Date: Fri, 05 Jul 2013 16:08:55 +0200
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <51C2D528.90805@arm.com>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
 <51C2D528.90805@arm.com>
Message-ID: <51D6D377.70708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

 >> ...
>>
>> +int kvm_arm_num_timer_regs(void)
>> +{
>> +	return 3;
>> +}
>> +
>> +int kvm_arm_copy_timer_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>> +{
>> +	if (put_user(KVM_REG_ARM_TIMER_CTL, uindices))
>> +		return -EFAULT;
>> +	uindices++;
>> +	if (put_user(KVM_REG_ARM_TIMER_CNT, uindices))
>> +		return -EFAULT;
>> +	uindices++;
>> +	if (put_user(KVM_REG_ARM_TIMER_CVAL, uindices))
>> +		return -EFAULT;
>
> So these macros are going to break arm64. Any chance you could introduce
> them at the same time on both platforms? The rest of the work can be
> delayed, but you shouldn't break arm64 (you'd expect me to say that,
> wouldn't you? ;-).

Is that just due to KVM_REG_ARM instead of KVM_REG_ARM64?
Or do you expect the numbering to be completely different since there is 
no mrc/mcr anymore (IIRC)?
Is put_user an issue here (should not, right?)
Is there already a document describing arch timer access on AARCH64?

If I am thinking in a totally wrong direction, please bear with me and 
feel free to point me to the right one ;-)
/me is now looking at getting a cross compiler to see what you mean...

> Also, I'd like to keep userspace access out of the timer code itself.
> Low level code shouldn't have to know about that. Can you create proper
> accessors instead, and move whole userspace access to coproc.c?

IIRC Christoffer recommended to keep this code completely out of 
coproc.c ;-) This also helps to keep coproc.c clean of ARCH_TIMER ifdefs 
in coproc.c (which I completely forgot in this version, btw, but that's 
already fixed).

>
>> +	return 0;
>> +}
>> +
>> +int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>> +	void __user *uaddr = (void __user *)(long)reg->addr;
>> +	u64 val;
>> +	int ret;
>> +
>> +	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
>> +	if (ret != 0)
>> +		return ret;
>> +
>> +	switch (reg->id) {
>> +	case KVM_REG_ARM_TIMER_CTL:
>> +		timer->cntv_ctl = val;
>> +		break;
>> +	case KVM_REG_ARM_TIMER_CNT:
>> +		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - val;
>
> I just realized what bothers me here: You're computing cntvoff on a per
> vcpu basis, while this is a VM property. Which means that as you're
> restoring vcpus, you'll be changing cntvoff - sounds like a bad idea to me.
>
> The counter is really global. Do we have a way to handle VM-wide
> registers? I think Christoffer was trying to some a similar thing with
> the GIC...

So the consensus of this discussion was just to block writing when the 
VCPU is running, right? Or is there something else?

Regards,
Andre.

>
>> +		break;
>> +	case KVM_REG_ARM_TIMER_CVAL:
>> +		timer->cntv_cval = val;
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>> +	void __user *uaddr = (void __user *)(long)reg->addr;
>> +	u64 val;
>> +
>> +	switch (reg->id) {
>> +	case KVM_REG_ARM_TIMER_CTL:
>> +		val = timer->cntv_ctl;
>> +		break;
>> +	case KVM_REG_ARM_TIMER_CNT:
>> +		val = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
>> +		break;
>> +	case KVM_REG_ARM_TIMER_CVAL:
>> +		val = timer->cntv_cval;
>> +		break;
>> +	}
>> +	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id));
>> +}
>>
>>   static int kvm_timer_cpu_notify(struct notifier_block *self,
>>   				unsigned long action, void *cpu)
>> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
>> index 152d036..a50ffb6 100644
>> --- a/arch/arm/kvm/guest.c
>> +++ b/arch/arm/kvm/guest.c
>> @@ -121,7 +121,8 @@ static unsigned long num_core_regs(void)
>>    */
>>   unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>>   {
>> -	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu);
>> +	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu)
>> +		+ kvm_arm_num_timer_regs();
>>   }
>>
>>   /**
>> @@ -133,6 +134,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>>   {
>>   	unsigned int i;
>>   	const u64 core_reg = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE;
>> +	int ret;
>>
>>   	for (i = 0; i < sizeof(struct kvm_regs)/sizeof(u32); i++) {
>>   		if (put_user(core_reg | i, uindices))
>> @@ -140,9 +142,25 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>>   		uindices++;
>>   	}
>>
>> +	ret = kvm_arm_copy_timer_indices(vcpu, uindices);
>> +	if (ret)
>> +		return ret;
>> +	uindices += kvm_arm_num_timer_regs();
>> +
>>   	return kvm_arm_copy_coproc_indices(vcpu, uindices);
>>   }
>>
>> +static bool is_timer_reg(u64 index)
>> +{
>> +	switch (index) {
>> +	case KVM_REG_ARM_TIMER_CTL:
>> +	case KVM_REG_ARM_TIMER_CNT:
>> +	case KVM_REG_ARM_TIMER_CVAL:
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>   {
>>   	/* We currently use nothing arch-specific in upper 32 bits */
>> @@ -153,6 +171,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>   	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
>>   		return get_core_reg(vcpu, reg);
>>
>> +	if (is_timer_reg(reg->id))
>> +		return kvm_arm_timer_get_reg(vcpu, reg);
>> +
>>   	return kvm_arm_coproc_get_reg(vcpu, reg);
>>   }
>>
>> @@ -166,6 +187,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>   	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
>>   		return set_core_reg(vcpu, reg);
>>
>> +	if (is_timer_reg(reg->id))
>> +		return kvm_arm_timer_set_reg(vcpu, reg);
>> +
>>   	return kvm_arm_coproc_set_reg(vcpu, reg);
>>   }
>
> This is otherwise moving in the right direction.
>
> Thanks,
>
> 	M.
>

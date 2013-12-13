From: andre.przywara@linaro.org (Andre Przywara)
Date: Fri, 13 Dec 2013 21:35:49 +0100
Subject: [PATCH v5] ARM/KVM: save and restore generic timer registers
In-Reply-To: <20131213201017.GC2871@cbox>
References: <1386941006-23388-1-git-send-email-andre.przywara@linaro.org>
 <20131213201017.GC2871@cbox>
Message-ID: <52AB6FA5.30104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2013 09:10 PM, Christoffer Dall wrote:
> On Fri, Dec 13, 2013 at 02:23:26PM +0100, Andre Przywara wrote:
>> For migration to work we need to save (and later restore) the state of
>> each core's virtual generic timer.
>> Since this is per VCPU, we can use the [gs]et_one_reg ioctl and export
>> the three needed registers (control, counter, compare value).
>> Though they live in cp15 space, we don't use the existing list, since
>> they need special accessor functions and the arch timer is optional.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> ---
>> Changes from v1:
>> - move code out of coproc.c and into guest.c and arch_timer.c
>> - present the registers with their native CP15 addresses, but without
>>    using space in the VCPU's cp15 array
>> - do the user space copying in the accessor functions
>>
>> Changes from v2:
>> - fix compilation without CONFIG_ARCH_TIMER
>> - fix compilation for arm64 by defining the appropriate registers there
>> - move userspace access out of arch_timer.c into coproc.c
>> - Christoffer: removed whitespace in function declaration
>>
>> Changes from v3:
>> - adapted Marc's SYSREG macro magic from kvmtool for nicer looking code
>>
>> Changes from v4:
>> - remove ARM64-REG32 type, the ARM ARM defines no 32-bit system registers
>>
>>   arch/arm/include/asm/kvm_host.h   |  3 ++
>>   arch/arm/include/uapi/asm/kvm.h   | 20 +++++++++
>>   arch/arm/kvm/guest.c              | 92 ++++++++++++++++++++++++++++++++++++++-
>>   arch/arm64/include/uapi/asm/kvm.h | 18 ++++++++
>>   virt/kvm/arm/arch_timer.c         | 34 +++++++++++++++
>>   5 files changed, 166 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index 8a6f6db..098f7dd 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -225,4 +225,7 @@ static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>>   int kvm_perf_init(void);
>>   int kvm_perf_teardown(void);
>>
>> +u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>> +int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>> +
>>   #endif /* __ARM_KVM_HOST_H__ */
>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>> index c498b60..835b867 100644
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -119,6 +119,26 @@ struct kvm_arch_memory_slot {
>>   #define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
>>   #define KVM_REG_ARM_32_CRN_SHIFT	11
>>
>> +#define ARM_CP15_REG_SHIFT_MASK(x,n) \
>> +	(((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
>> +
>> +#define __ARM_CP15_REG(op1,crn,crm,op2) \
>> +	(KVM_REG_ARM | (15 << KVM_REG_ARM_COPROC_SHIFT) | \
>> +	ARM_CP15_REG_SHIFT_MASK(op1, OPC1) | \
>> +	ARM_CP15_REG_SHIFT_MASK(crn, 32_CRN) | \
>> +	ARM_CP15_REG_SHIFT_MASK(crm, CRM) | \
>> +	ARM_CP15_REG_SHIFT_MASK(op2, 32_OPC2))
>> +
>> +#define ARM_CP15_REG32(...) (__ARM_CP15_REG(__VA_ARGS__) | KVM_REG_SIZE_U32)
>> +
>> +#define __ARM_CP15_REG64(op1,crm) \
>> +	(__ARM_CP15_REG(op1, 0, crm, 0) | KVM_REG_SIZE_U64)
>> +#define ARM_CP15_REG64(...) __ARM_CP15_REG64(__VA_ARGS__)
>> +
>> +#define KVM_REG_ARM_TIMER_CTL		ARM_CP15_REG32(0, 14, 3, 1)
>> +#define KVM_REG_ARM_TIMER_CNT		ARM_CP15_REG64(1, 14)
>> +#define KVM_REG_ARM_TIMER_CVAL		ARM_CP15_REG64(3, 14)
>> +
>>   /* Normal registers are mapped as coprocessor 16. */
>>   #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
>>   #define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
>> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
>> index 20f8d97..2786eae 100644
>> --- a/arch/arm/kvm/guest.c
>> +++ b/arch/arm/kvm/guest.c
>> @@ -109,6 +109,83 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>>   	return -EINVAL;
>>   }
>>
>> +#ifndef CONFIG_KVM_ARM_TIMER
>> +
>> +#define NUM_TIMER_REGS 0
>> +
>> +static int copy_timer_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>> +{
>> +	return 0;
>> +}
>> +
>> +static bool is_timer_reg(u64 index)
>> +{
>> +	return false;
>> +}
>> +
>> +int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, u64 regid, u64 value)
>> +{
>> +	return 0;
>> +}
>> +
>> +u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
>> +{
>> +	return 0;
>> +}
>> +
>> +#else
>> +
>> +#define NUM_TIMER_REGS 3
>> +
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
>> +static int copy_timer_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>> +{
>> +	if (put_user(KVM_REG_ARM_TIMER_CTL, uindices))
>> +		return -EFAULT;
>> +	uindices++;
>> +	if (put_user(KVM_REG_ARM_TIMER_CNT, uindices))
>> +		return -EFAULT;
>> +	uindices++;
>> +	if (put_user(KVM_REG_ARM_TIMER_CVAL, uindices))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +#endif
>> +
>> +static int set_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	void __user *uaddr = (void __user *)(long)reg->addr;
>> +	u64 val;
>> +	int ret;
>> +
>> +	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
>> +	if (ret != 0)
>> +		return ret;
>> +
>> +	return kvm_arm_timer_set_reg(vcpu, reg->id, val);
>> +}
>> +
>> +static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	void __user *uaddr = (void __user *)(long)reg->addr;
>> +	u64 val;
>> +
>> +	val = kvm_arm_timer_get_reg(vcpu, reg->id);
>> +	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id));
>> +}
>> +
>
> how does any of this code get called for arm64?

Currently not at all. Sorry if there was a misunderstanding regarding 
this. I don't have the hardware to test this, so I just did the 32-bit 
part. The 64-bit pieces were just to make it _compile_ on 64-bit, which 
is needed because of shared code in the arch_timer area.
See Marc's comment here:
https://lists.cs.columbia.edu/pipermail/kvmarm/2013-June/006133.html

Regards,
Andre.

>
> -Christoffer
>
>>   static unsigned long num_core_regs(void)
>>   {
>>   	return sizeof(struct kvm_regs) / sizeof(u32);
>> @@ -121,7 +198,8 @@ static unsigned long num_core_regs(void)
>>    */
>>   unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>>   {
>> -	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu);
>> +	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu)
>> +		+ NUM_TIMER_REGS;
>>   }
>>
>>   /**
>> @@ -133,6 +211,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>>   {
>>   	unsigned int i;
>>   	const u64 core_reg = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE;
>> +	int ret;
>>
>>   	for (i = 0; i < sizeof(struct kvm_regs)/sizeof(u32); i++) {
>>   		if (put_user(core_reg | i, uindices))
>> @@ -140,6 +219,11 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>>   		uindices++;
>>   	}
>>
>> +	ret = copy_timer_indices(vcpu, uindices);
>> +	if (ret)
>> +		return ret;
>> +	uindices += NUM_TIMER_REGS;
>> +
>>   	return kvm_arm_copy_coproc_indices(vcpu, uindices);
>>   }
>>
>> @@ -153,6 +237,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>   	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
>>   		return get_core_reg(vcpu, reg);
>>
>> +	if (is_timer_reg(reg->id))
>> +		return get_timer_reg(vcpu, reg);
>> +
>>   	return kvm_arm_coproc_get_reg(vcpu, reg);
>>   }
>>
>> @@ -166,6 +253,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>   	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
>>   		return set_core_reg(vcpu, reg);
>>
>> +	if (is_timer_reg(reg->id))
>> +		return set_timer_reg(vcpu, reg);
>> +
>>   	return kvm_arm_coproc_set_reg(vcpu, reg);
>>   }
>>
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 5031f42..7c25ca8 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -129,6 +129,24 @@ struct kvm_arch_memory_slot {
>>   #define KVM_REG_ARM64_SYSREG_OP2_MASK	0x0000000000000007
>>   #define KVM_REG_ARM64_SYSREG_OP2_SHIFT	0
>>
>> +#define ARM64_SYS_REG_SHIFT_MASK(x,n) \
>> +	(((x) << KVM_REG_ARM64_SYSREG_ ## n ## _SHIFT) & \
>> +	KVM_REG_ARM64_SYSREG_ ## n ## _MASK)
>> +
>> +#define __ARM64_SYS_REG(op0,op1,crn,crm,op2) \
>> +	(KVM_REG_ARM64 | KVM_REG_ARM64_SYSREG | \
>> +	ARM64_SYS_REG_SHIFT_MASK(op0, OP0) | \
>> +	ARM64_SYS_REG_SHIFT_MASK(op1, OP1) | \
>> +	ARM64_SYS_REG_SHIFT_MASK(crn, CRN) | \
>> +	ARM64_SYS_REG_SHIFT_MASK(crm, CRM) | \
>> +	ARM64_SYS_REG_SHIFT_MASK(op2, OP2))
>> +
>> +#define ARM64_SYS_REG(...) (__ARM64_SYS_REG(__VA_ARGS__) | KVM_REG_SIZE_U64)
>> +
>> +#define KVM_REG_ARM_TIMER_CTL		ARM64_SYS_REG(3, 3, 14, 3, 1)
>> +#define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
>> +#define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
>> +
>>   /* KVM_IRQ_LINE irq field index values */
>>   #define KVM_ARM_IRQ_TYPE_SHIFT		24
>>   #define KVM_ARM_IRQ_TYPE_MASK		0xff
>> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
>> index c2e1ef4..5081e80 100644
>> --- a/virt/kvm/arm/arch_timer.c
>> +++ b/virt/kvm/arm/arch_timer.c
>> @@ -182,6 +182,40 @@ static void kvm_timer_init_interrupt(void *info)
>>   	enable_percpu_irq(host_vtimer_irq, 0);
>>   }
>>
>> +int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, u64 regid, u64 value)
>> +{
>> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>> +
>> +	switch (regid) {
>> +	case KVM_REG_ARM_TIMER_CTL:
>> +		timer->cntv_ctl = value;
>> +		break;
>> +	case KVM_REG_ARM_TIMER_CNT:
>> +		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - value;
>> +		break;
>> +	case KVM_REG_ARM_TIMER_CVAL:
>> +		timer->cntv_cval = value;
>> +		break;
>> +	default:
>> +		return -1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
>> +{
>> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>> +
>> +	switch (regid) {
>> +	case KVM_REG_ARM_TIMER_CTL:
>> +		return timer->cntv_ctl;
>> +	case KVM_REG_ARM_TIMER_CNT:
>> +		return kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
>> +	case KVM_REG_ARM_TIMER_CVAL:
>> +		return timer->cntv_cval;
>> +	}
>> +	return (u64)-1;
>> +}
>>
>>   static int kvm_timer_cpu_notify(struct notifier_block *self,
>>   				unsigned long action, void *cpu)
>> --
>> 1.7.12.1
>>

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Jun 2013 11:10:48 +0100
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <51C2D528.90805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/13 16:16, Andre Przywara wrote:
> For migration to work we need to save (and later restore) the state of
> each core's virtual generic timer.
> Since this is per VCPU, we can use the [gs]et_one_reg ioctl and export
> the three needed registers (control, counter, compare value).
> Though they live in cp15 space, we don't use the existing list, since
> they need special accessor functions and also the arch timer is
> optional.
> 
> Changes from v1:
> - move code out of coproc.c and into guest.c and arch_timer.c
> - present the registers with their native CP15 addresses, but without
>   using space in the VCPU's cp15 array
> - do the user space copying in the accessor functions
> 
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
> ---
>  arch/arm/include/asm/kvm_host.h |  5 ++++
>  arch/arm/include/uapi/asm/kvm.h | 16 ++++++++++
>  arch/arm/kvm/arch_timer.c       | 65 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kvm/guest.c            | 26 ++++++++++++++++-
>  4 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 57cb786..1096e33 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -224,4 +224,9 @@ static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +int kvm_arm_num_timer_regs(void);
> +int kvm_arm_copy_timer_indices(struct kvm_vcpu *, u64 __user *);
> +int kvm_arm_timer_get_reg(struct kvm_vcpu *, const struct kvm_one_reg *);
> +int kvm_arm_timer_set_reg(struct kvm_vcpu *, const struct kvm_one_reg *);
> +
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index c1ee007..e3b0115 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -118,6 +118,22 @@ struct kvm_arch_memory_slot {
>  #define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
>  #define KVM_REG_ARM_32_CRN_SHIFT	11
>  
> +#define KVM_REG_ARM_32_CP15		(KVM_REG_ARM | KVM_REG_SIZE_U32      | \
> +					(15ULL << KVM_REG_ARM_COPROC_SHIFT))
> +#define KVM_REG_ARM_64_CP15		(KVM_REG_ARM | KVM_REG_SIZE_U64      | \
> +					(15ULL << KVM_REG_ARM_COPROC_SHIFT))
> +#define KVM_REG_ARM_TIMER_CTL		(KVM_REG_ARM_32_CP15                 | \
> +					( 3ULL << KVM_REG_ARM_CRM_SHIFT)     | \
> +					(14ULL << KVM_REG_ARM_32_CRN_SHIFT)  | \
> +					( 0ULL << KVM_REG_ARM_OPC1_SHIFT)    | \
> +					( 1ULL << KVM_REG_ARM_32_OPC2_SHIFT))
> +#define KVM_REG_ARM_TIMER_CNT		(KVM_REG_ARM_64_CP15 | \
> +					(14ULL << KVM_REG_ARM_CRM_SHIFT)     | \
> +					( 1ULL << KVM_REG_ARM_OPC1_SHIFT))
> +#define KVM_REG_ARM_TIMER_CVAL		(KVM_REG_ARM_64_CP15 | \
> +					(14ULL << KVM_REG_ARM_CRM_SHIFT)     | \
> +					( 3ULL << KVM_REG_ARM_OPC1_SHIFT))
> +
>  /* Normal registers are mapped as coprocessor 16. */
>  #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
>  #define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
> diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
> index c55b608..8d709eb 100644
> --- a/arch/arm/kvm/arch_timer.c
> +++ b/arch/arm/kvm/arch_timer.c
> @@ -18,6 +18,7 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/of_irq.h>
> +#include <linux/uaccess.h>
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
>  #include <linux/interrupt.h>
> @@ -171,6 +172,70 @@ static void kvm_timer_init_interrupt(void *info)
>  	enable_percpu_irq(timer_irq.irq, 0);
>  }
>  
> +int kvm_arm_num_timer_regs(void)
> +{
> +	return 3;
> +}
> +
> +int kvm_arm_copy_timer_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> +{
> +	if (put_user(KVM_REG_ARM_TIMER_CTL, uindices))
> +		return -EFAULT;
> +	uindices++;
> +	if (put_user(KVM_REG_ARM_TIMER_CNT, uindices))
> +		return -EFAULT;
> +	uindices++;
> +	if (put_user(KVM_REG_ARM_TIMER_CVAL, uindices))
> +		return -EFAULT;

So these macros are going to break arm64. Any chance you could introduce
them at the same time on both platforms? The rest of the work can be
delayed, but you shouldn't break arm64 (you'd expect me to say that,
wouldn't you? ;-).

Also, I'd like to keep userspace access out of the timer code itself.
Low level code shouldn't have to know about that. Can you create proper
accessors instead, and move whole userspace access to coproc.c?

> +	return 0;
> +}
> +
> +int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	void __user *uaddr = (void __user *)(long)reg->addr;
> +	u64 val;
> +	int ret;
> +
> +	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
> +	if (ret != 0)
> +		return ret;
> +
> +	switch (reg->id) {
> +	case KVM_REG_ARM_TIMER_CTL:
> +		timer->cntv_ctl = val;
> +		break;
> +	case KVM_REG_ARM_TIMER_CNT:
> +		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - val;

I just realized what bothers me here: You're computing cntvoff on a per
vcpu basis, while this is a VM property. Which means that as you're
restoring vcpus, you'll be changing cntvoff - sounds like a bad idea to me.

The counter is really global. Do we have a way to handle VM-wide
registers? I think Christoffer was trying to some a similar thing with
the GIC...

> +		break;
> +	case KVM_REG_ARM_TIMER_CVAL:
> +		timer->cntv_cval = val;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> +	void __user *uaddr = (void __user *)(long)reg->addr;
> +	u64 val;
> +
> +	switch (reg->id) {
> +	case KVM_REG_ARM_TIMER_CTL:
> +		val = timer->cntv_ctl;
> +		break;
> +	case KVM_REG_ARM_TIMER_CNT:
> +		val = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
> +		break;
> +	case KVM_REG_ARM_TIMER_CVAL:
> +		val = timer->cntv_cval;
> +		break;
> +	}
> +	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id));
> +}
>  
>  static int kvm_timer_cpu_notify(struct notifier_block *self,
>  				unsigned long action, void *cpu)
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 152d036..a50ffb6 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -121,7 +121,8 @@ static unsigned long num_core_regs(void)
>   */
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>  {
> -	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu);
> +	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu)
> +		+ kvm_arm_num_timer_regs();
>  }
>  
>  /**
> @@ -133,6 +134,7 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>  {
>  	unsigned int i;
>  	const u64 core_reg = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE;
> +	int ret;
>  
>  	for (i = 0; i < sizeof(struct kvm_regs)/sizeof(u32); i++) {
>  		if (put_user(core_reg | i, uindices))
> @@ -140,9 +142,25 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>  		uindices++;
>  	}
>  
> +	ret = kvm_arm_copy_timer_indices(vcpu, uindices);
> +	if (ret)
> +		return ret;
> +	uindices += kvm_arm_num_timer_regs();
> +
>  	return kvm_arm_copy_coproc_indices(vcpu, uindices);
>  }
>  
> +static bool is_timer_reg(u64 index)
> +{
> +	switch (index) {
> +	case KVM_REG_ARM_TIMER_CTL:
> +	case KVM_REG_ARM_TIMER_CNT:
> +	case KVM_REG_ARM_TIMER_CVAL:
> +		return true;
> +	}
> +	return false;
> +}
> +
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>  	/* We currently use nothing arch-specific in upper 32 bits */
> @@ -153,6 +171,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
>  		return get_core_reg(vcpu, reg);
>  
> +	if (is_timer_reg(reg->id))
> +		return kvm_arm_timer_get_reg(vcpu, reg);
> +
>  	return kvm_arm_coproc_get_reg(vcpu, reg);
>  }
>  
> @@ -166,6 +187,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
>  		return set_core_reg(vcpu, reg);
>  
> +	if (is_timer_reg(reg->id))
> +		return kvm_arm_timer_set_reg(vcpu, reg);
> +
>  	return kvm_arm_coproc_set_reg(vcpu, reg);
>  }

This is otherwise moving in the right direction.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

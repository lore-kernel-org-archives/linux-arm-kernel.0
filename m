From: james.morse@arm.com (James Morse)
Date: Fri, 29 Jun 2018 16:59:06 +0100
Subject: [PATCH v5 1/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <1529960309-2513-2-git-send-email-gengdongjiu@huawei.com>
References: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
 <1529960309-2513-2-git-send-email-gengdongjiu@huawei.com>
Message-ID: <ec201845-fd1e-fd0a-7dfe-bacf23bb44a2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 25/06/18 21:58, Dongjiu Geng wrote:
> For the migrating VMs, user space may need to know the exception
> state. For example, in the machine A, KVM make an SError pending,
> when migrate to B, KVM also needs to pend an SError.
> 
> This new IOCTL exports user-invisible states related to SError.
> Together with appropriate user space changes, user space can get/set
> the SError exception state to do migrate/snapshot/suspend.


> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 469de8a..357304a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -335,6 +335,11 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
> +
> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
>  

(Nit: funny indentation)


> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 56a0260..8be14cc 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -289,6 +289,49 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,

> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	int i;
> +	bool serror_pending = events->exception.serror_pending;
> +	bool has_esr = events->exception.serror_has_esr;
> +
> +	/* check whether the reserved field is zero */
> +	for (i = 0; i < ARRAY_SIZE(events->reserved); i++)
> +		if (events->reserved[i])
> +			return -EINVAL;
> +
> +	/* check whether the pad field is zero */
> +	for (i = 0; i < ARRAY_SIZE(events->exception.pad); i++)
> +		if (events->exception.pad[i])
> +			return -EINVAL;
> +
> +	if (serror_pending && has_esr) {
> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
> +			return -EINVAL;
> +

> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);

This silently discards all but the bottom 24 bits of serror_esr.

It makes sense that this field is 64 bit, because the register is 64 bit, and it
would let us use this API to migrate any new state that appears in the higher
bits... But those bits will come with an ID/feature field, we shouldn't accept
an attempt to restore them on a CPU that doesn't support the feature. If that
happens here, it silently succeeds, but the kernel just threw the extra bits away.

You added documentation that only the bottom 24bits can be set, can we add
checks to enforce this, so the bits can be used later.


> +	} else if (serror_pending) {
> +		kvm_inject_vabt(vcpu);
> +	}
> +
> +	return 0;
> +}

> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a4c1b76..4e6f366 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1107,6 +1107,27 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_arm_vcpu_has_attr(vcpu, &attr);
>  		break;
>  	}
> +#ifdef __KVM_HAVE_VCPU_EVENTS

So its this #ifdef, or a uapi struct for a feature 32bit doesn't support.
I think the right thing to do is wire this up for 32bit, it also calls
kvm_inject_vabt() in handle_exit.c, so must have the same migration problems.

I'll post a patch to do this as I've got something I can test it on.


> +	case KVM_GET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		if (kvm_arm_vcpu_get_events(vcpu, &events))
> +			return -EINVAL;
> +
> +		if (copy_to_user(argp, &events, sizeof(events)))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	case KVM_SET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		if (copy_from_user(&events, argp, sizeof(events)))
> +			return -EFAULT;
> +
> +		return kvm_arm_vcpu_set_events(vcpu, &events);
> +	}
> +#endif

(It bugs me that the architecture has some rules about merging multiple
architected ESR values, that we neither enforce, nor document as user-space's
problem. It doesn't matter for RAS, but might for any future ESR encodings. But
I guess user-space wouldn't be aware of them anyway, and it can already put
bogus values in SPSR/ESR/ELR etc.)


With a check against the top bits of ESR:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

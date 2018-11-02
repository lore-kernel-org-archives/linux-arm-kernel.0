From: christoffer.dall@arm.com (Christoffer Dall)
Date: Fri, 2 Nov 2018 09:32:27 +0100
Subject: [RFC PATCH v2 20/23] KVM: arm64: Add arch vm ioctl hook
In-Reply-To: <1538141967-15375-21-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-21-git-send-email-Dave.Martin@arm.com>
Message-ID: <20181102083227.GU12057@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 02:39:24PM +0100, Dave Martin wrote:
> To enable arm64-specific vm ioctls to be added cleanly, this patch
> adds a kvm_arm_arch_vm_ioctl() hook so that these don't pollute the
> common code.

Hmmm, I don't really see the strenght of that argument, and have the
same concern as before.  I'd like to avoid the additional indirection
and instead just follow the existing pattern with a dummy implementation
on the 32-bit side that returns an error.


Thanks,

    Christoffer

> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   | 6 ++++++
>  arch/arm64/include/asm/kvm_host.h | 2 ++
>  arch/arm64/kvm/guest.c            | 6 ++++++
>  virt/kvm/arm/arm.c                | 2 +-
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index df2659d..0850fcd 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -285,6 +285,12 @@ static inline int kvm_arm_arch_vcpu_ioctl(struct vcpu *vcpu,
>  	return -EINVAL;
>  }
>  
> +static inline int kvm_arm_arch_vm_ioctl(struct kvm *kvm,
> +	unsigned int ioctl, unsigned long arg)
> +{
> +	return -EINVAL;
> +}
> +
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 5225485..ae25f14 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -63,6 +63,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
>  int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext);
>  int kvm_arm_arch_vcpu_ioctl(struct kvm_vcpu *vcpu,
>  			    unsigned int ioctl, unsigned long arg);
> +int kvm_arm_arch_vm_ioctl(struct kvm *kvm,
> +			  unsigned int ioctl, unsigned long arg);
>  void __extended_idmap_trampoline(phys_addr_t boot_pgd, phys_addr_t idmap_start);
>  
>  struct kvm_arch {
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index d96145a..f066b17 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -714,6 +714,12 @@ int kvm_arm_arch_vcpu_ioctl(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +int kvm_arm_arch_vm_ioctl(struct kvm *kvm,
> +			  unsigned int ioctl, unsigned long arg)
> +{
> +	return -EINVAL;
> +}
> +
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
>  	return -EINVAL;
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 6e894a8..6582a38 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1279,7 +1279,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		return 0;
>  	}
>  	default:
> -		return -EINVAL;
> +		return kvm_arm_arch_vm_ioctl(kvm, ioctl, arg);
>  	}
>  }
>  
> -- 
> 2.1.4
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

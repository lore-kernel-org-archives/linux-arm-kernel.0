From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sun, 12 May 2013 22:52:53 -0700
Subject: [PATCH v2] ARM: KVM: prevent NULL pointer dereferences with KVM
 VCPU ioctl
In-Reply-To: <1368052086-25059-1-git-send-email-andre.przywara@linaro.org>
References: <1368052086-25059-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <20130513055253.GC64337@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 12:28:06AM +0200, Andre Przywara wrote:
> Some ARM KVM VCPU ioctls require the vCPU to be properly initialized
> with the KVM_ARM_VCPU_INIT ioctl before being used with further
> requests. KVM_RUN checks whether this initialization has been
> done, but other ioctls do not.
> Namely KVM_GET_REG_LIST will dereference an array with index -1
> without initialization and thus leads to a kernel oops.
> Fix this by adding checks before executing the ioctl handlers.
> 
> Changes from v1:
>  * moved check into a static function with a meaningful name
> 
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
> ---
>  arch/arm/kvm/arm.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index c1fe498..b73b587 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -676,6 +676,15 @@ static void vcpu_pause(struct kvm_vcpu *vcpu)
>  	wait_event_interruptible(*wq, !vcpu->arch.pause);
>  }
>  
> +/*
> + * Some ioctls require initialization by KVM_ARM_VCPU_INIT first, check
> + * this with this function
> + */
> +static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.target >= 0;
> +}
> +

this should probably be a static inline in a header file instead, it's
likely that it could be called from another file.

>  /**
>   * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
>   * @vcpu:	The VCPU pointer
> @@ -692,8 +701,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	int ret;
>  	sigset_t sigsaved;
>  
> -	/* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
> -	if (unlikely(vcpu->arch.target < 0))
> +	if (unlikely(!kvm_vcpu_initialized(vcpu)))
>  		return -ENOEXEC;
>  
>  	ret = kvm_vcpu_first_run_init(vcpu);
> @@ -893,6 +901,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	case KVM_SET_ONE_REG:
>  	case KVM_GET_ONE_REG: {
>  		struct kvm_one_reg reg;
> +
> +		if (unlikely(!kvm_vcpu_initialized(vcpu)))
> +			return -ENOEXEC;
> +
>  		if (copy_from_user(&reg, argp, sizeof(reg)))
>  			return -EFAULT;
>  		if (ioctl == KVM_SET_ONE_REG)
> @@ -905,6 +917,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		struct kvm_reg_list reg_list;
>  		unsigned n;
>  
> +		if (unlikely(!kvm_vcpu_initialized(vcpu)))
> +			return -ENOEXEC;
> +
>  		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
>  			return -EFAULT;
>  		n = reg_list.n;
> -- 
> 1.7.12.1
> 

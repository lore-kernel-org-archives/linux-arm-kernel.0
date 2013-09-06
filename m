From: claudio.fontana@huawei.com (Claudio Fontana)
Date: Fri, 6 Sep 2013 10:08:32 +0200
Subject: [RFC PATCH 1/3] ARM: KVM: Implement target CPU=Host
In-Reply-To: <1378392362-6773-2-git-send-email-anup.patel@linaro.org>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <1378392362-6773-2-git-send-email-anup.patel@linaro.org>
Message-ID: <52298D80.5090201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.09.2013 16:46, Anup Patel wrote:
> This patch implements KVM_ARM_TARGET_HOST for KVM ARM.
> 
> If user space provides KVM_ARM_TARGET_HOST as target type in
> KVM_ARM_VCPU_INIT ioctl then we find out appropriate target
> type based on underlying host and return that to user space
> via struct kvm_vcpu_init.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/include/asm/kvm_host.h |    2 +-
>  arch/arm/include/uapi/asm/kvm.h |    1 +
>  arch/arm/kvm/arm.c              |    9 ++++++++-
>  arch/arm/kvm/guest.c            |   11 +++++++++--
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 7d22517..3bb6c2b 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -153,7 +153,7 @@ struct kvm_vcpu_stat {
>  
>  struct kvm_vcpu_init;
>  int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> -			const struct kvm_vcpu_init *init);
> +			struct kvm_vcpu_init *init);
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  struct kvm_one_reg;
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index c1ee007..644012e 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -63,6 +63,7 @@ struct kvm_regs {
>  
>  /* Supported Processor Types */
>  #define KVM_ARM_TARGET_CORTEX_A15	0
> +#define KVM_ARM_TARGET_HOST		0x0FFFFFFF
>  #define KVM_ARM_NUM_TARGETS		1
>  
>  /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 741f66a..d8e494e 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -698,6 +698,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>  			 unsigned int ioctl, unsigned long arg)
>  {
> +	int err;
>  	struct kvm_vcpu *vcpu = filp->private_data;
>  	void __user *argp = (void __user *)arg;
>  
> @@ -708,8 +709,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		if (copy_from_user(&init, argp, sizeof(init)))
>  			return -EFAULT;
>  
> -		return kvm_vcpu_set_target(vcpu, &init);
> +		err = kvm_vcpu_set_target(vcpu, &init);
> +		if (err)
> +			return err;
> +
> +		if (copy_to_user(argp, &init, sizeof(init)))
> +			return -EFAULT;
>  
> +		return 0;
>  	}
>  	case KVM_SET_ONE_REG:
>  	case KVM_GET_ONE_REG: {
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 152d036..050df63 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -198,12 +198,19 @@ int __attribute_const__ kvm_target_cpu(void)
>  }
>  
>  int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> -			const struct kvm_vcpu_init *init)
> +			struct kvm_vcpu_init *init)
>  {
>  	unsigned int i;
> +	int phys_target = kvm_target_cpu();
> +
> +	if (phys_target < 0) {
> +		return phys_target;
> +	}
>  
>  	/* We can only do a cortex A15 for now. */
> -	if (init->target != kvm_target_cpu())
> +	if (init->target == KVM_ARM_TARGET_HOST)
> +		init->target = phys_target;
> +	else if (init->target != phys_target)
>  		return -EINVAL;
>  
>  	vcpu->arch.target = init->target;
> 

Acked-by: Claudio Fontana <claudio.fontana@huawei.com>

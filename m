From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 08 Dec 2014 11:52:17 +0000
Subject: [PATCH v2 4/6] arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
In-Reply-To: <1417641522-29056-5-git-send-email-christoffer.dall@linaro.org>
References: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
 <1417641522-29056-5-git-send-email-christoffer.dall@linaro.org>
Message-ID: <548590F1.8000306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/14 21:18, Christoffer Dall wrote:
> It is not clear that this ioctl can be called multiple times for a given
> vcpu.  Userspace already does this, so clarify the ABI.
> 
> Also specify that userspace is expected to always make secondary and
> subsequent calls to the ioctl with the same parameters for the VCPU as
> the initial call (which userspace also already does).
> 
> Add code to check that userspace doesn't violate that ABI in the future,
> and move the kvm_vcpu_set_target() function which is currently
> duplicated between the 32-bit and 64-bit versions in guest.c to a common
> static function in arm.c, shared between both architectures.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  Documentation/virtual/kvm/api.txt |  5 +++++
>  arch/arm/include/asm/kvm_host.h   |  2 --
>  arch/arm/kvm/arm.c                | 43 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/kvm/guest.c              | 25 -----------------------
>  arch/arm64/include/asm/kvm_host.h |  2 --
>  arch/arm64/kvm/guest.c            | 25 -----------------------
>  6 files changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index bb82a90..81f1b97 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2453,6 +2453,11 @@ return ENOEXEC for that vcpu.
>  Note that because some registers reflect machine topology, all vcpus
>  should be created before this ioctl is invoked.
>  
> +Userspace can call this function multiple times for a given vcpu, including
> +after the vcpu has been run. This will reset the vcpu to its initial
> +state. All calls to this function after the initial call must use the same
> +target and same set of feature flags, otherwise EINVAL will be returned.
> +
>  Possible features:
>  	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
>  	  Depends on KVM_CAP_ARM_PSCI.  If not set, the CPU will be powered on
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 53036e2..254e065 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -150,8 +150,6 @@ struct kvm_vcpu_stat {
>  	u32 halt_wakeup;
>  };
>  
> -int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> -			const struct kvm_vcpu_init *init);
>  int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 24c9ca4..4043769 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -263,6 +263,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  {
>  	/* Force users to call KVM_ARM_VCPU_INIT */
>  	vcpu->arch.target = -1;
> +	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
>  
>  	/* Set up the timer */
>  	kvm_timer_vcpu_init(vcpu);
> @@ -649,6 +650,48 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>  	return -EINVAL;
>  }
>  
> +static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> +			       const struct kvm_vcpu_init *init)
> +{
> +	unsigned int i;
> +	int phys_target = kvm_target_cpu();
> +
> +	if (init->target != phys_target)
> +		return -EINVAL;
> +
> +	/*
> +	 * Secondary and subsequent calls to KVM_ARM_VCPU_INIT must
> +	 * use the same target.
> +	 */
> +	if (vcpu->arch.target != -1 && vcpu->arch.target != init->target)
> +		return -EINVAL;
> +
> +	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
> +	for (i = 0; i < sizeof(init->features) * 8; i++) {
> +		bool set = (init->features[i / 32] & (1 << (i % 32)));
> +
> +		if (set && i >= KVM_VCPU_MAX_FEATURES)
> +			return -ENOENT;
> +
> +		/*
> +		 * Secondary and subsequent calls to KVM_ARM_VCPU_INIT must
> +		 * use the same feature set.
> +		 */
> +		if (vcpu->arch.target != -1 && i < KVM_VCPU_MAX_FEATURES &&
> +		    test_bit(i, vcpu->arch.features) != set)
> +			return -EINVAL;
> +
> +		if (set)
> +			set_bit(i, vcpu->arch.features);
> +	}
> +
> +	vcpu->arch.target = phys_target;
> +
> +	/* Now we know what it is, we can reset it. */
> +	return kvm_reset_vcpu(vcpu);
> +}
> +
> +
>  static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>  					 struct kvm_vcpu_init *init)
>  {
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 8c97208..384bab6 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -273,31 +273,6 @@ int __attribute_const__ kvm_target_cpu(void)
>  	}
>  }
>  
> -int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> -			const struct kvm_vcpu_init *init)
> -{
> -	unsigned int i;
> -
> -	/* We can only cope with guest==host and only on A15/A7 (for now). */
> -	if (init->target != kvm_target_cpu())
> -		return -EINVAL;
> -
> -	vcpu->arch.target = init->target;
> -	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
> -
> -	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
> -	for (i = 0; i < sizeof(init->features) * 8; i++) {
> -		if (test_bit(i, (void *)init->features)) {
> -			if (i >= KVM_VCPU_MAX_FEATURES)
> -				return -ENOENT;
> -			set_bit(i, vcpu->arch.features);
> -		}
> -	}
> -
> -	/* Now we know what it is, we can reset it. */
> -	return kvm_reset_vcpu(vcpu);
> -}
> -
>  int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
>  {
>  	int target = kvm_target_cpu();
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 2012c4b..65c6152 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -165,8 +165,6 @@ struct kvm_vcpu_stat {
>  	u32 halt_wakeup;
>  };
>  
> -int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> -			const struct kvm_vcpu_init *init);
>  int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 84d5959..9535bd5 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -296,31 +296,6 @@ int __attribute_const__ kvm_target_cpu(void)
>  	return -EINVAL;
>  }
>  
> -int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> -			const struct kvm_vcpu_init *init)
> -{
> -	unsigned int i;
> -	int phys_target = kvm_target_cpu();
> -
> -	if (init->target != phys_target)
> -		return -EINVAL;
> -
> -	vcpu->arch.target = phys_target;
> -	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
> -
> -	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
> -	for (i = 0; i < sizeof(init->features) * 8; i++) {
> -		if (init->features[i / 32] & (1 << (i % 32))) {
> -			if (i >= KVM_VCPU_MAX_FEATURES)
> -				return -ENOENT;
> -			set_bit(i, vcpu->arch.features);
> -		}
> -	}
> -
> -	/* Now we know what it is, we can reset it. */
> -	return kvm_reset_vcpu(vcpu);
> -}
> -
>  int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
>  {
>  	int target = kvm_target_cpu();
> 

Very nice cleanup.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

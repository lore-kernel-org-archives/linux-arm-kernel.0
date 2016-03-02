From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 2 Mar 2016 09:08:02 +0000
Subject: [PATCH v2 8/8] arm64: kvm: Check support for AArch32 for 32bit
 guests
In-Reply-To: <1456393968-17386-9-git-send-email-suzuki.poulose@arm.com>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
 <1456393968-17386-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <56D6AD72.8010108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/16 09:52, Suzuki K Poulose wrote:
> Add a check to make sure the system supports AArch32 state
> before initialising a 32bit guest.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: kvmarm at lists.cs.columbia.edu
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> ---
> 
> I really wanted to pass kvm_vcpu down to the helpers. But then, I can't
> define the arch specific helper in asm/kvm_host.h due to lack of kvm_vcpu's
> definition yet:
> 
>  In file included from include/linux/kvm_host.h:35:0,
>                   from arch/arm64/kernel/asm-offsets.c:24:
>  ./arch/arm64/include/asm/kvm_host.h: In function ?kvm_arch_vcpu_validate_features?:
>  ./arch/arm64/include/asm/kvm_host.h:344:48: error: dereferencing pointer to incomplete type
>    return  !test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features) ||

Why don't you just have the prototype in kvm_host.h, and move the actual
implementation to something like guest.c? But I think there is a better
approach, see below.

> ---
>  arch/arm/include/asm/kvm_host.h   |    5 +++++
>  arch/arm/kvm/arm.c                |    3 +++
>  arch/arm64/include/asm/kvm_host.h |    8 ++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index f9f2779..945c23a 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -238,6 +238,11 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>  
> +static inline bool kvm_arch_vcpu_validate_features(struct kvm_vcpu_arch *arch_vcpu)
> +{
> +	return true;
> +}
> +
>  static inline void kvm_arm_init_debug(void) {}
>  static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index dda1959..fc4ea37 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -787,6 +787,9 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  			set_bit(i, vcpu->arch.features);
>  	}
>  
> +	if (!kvm_arch_vcpu_validate_features(&vcpu->arch))
> +		return -EINVAL;
> +
>  	vcpu->arch.target = phys_target;
>  
>  	/* Now we know what it is, we can reset it. */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 689d4c9..9d60a6c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -24,6 +24,8 @@
>  
>  #include <linux/types.h>
>  #include <linux/kvm_types.h>
> +#include <asm/cpufeature.h>
> +#include <asm/kvm_arm.h>
>  #include <asm/kvm.h>
>  #include <asm/kvm_mmio.h>
>  
> @@ -338,6 +340,12 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>  
> +static inline bool kvm_arch_vcpu_validate_features(struct kvm_vcpu_arch *arch_vcpu)
> +{
> +	return  !test_bit(KVM_ARM_VCPU_EL1_32BIT, arch_vcpu->features) ||
> +		system_supports_32bit_el0();
> +}
> +

This is really convoluted (it took me 5 minutes staring at the
expression and remembering that AArch32 EL1 implies AArch32 EL0 to get it).

Now, we already have kvm_reset_vcpu() that validates AArch32 support. It
would probably be better to move things there. Thoughts?

>  void kvm_arm_init_debug(void);
>  void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

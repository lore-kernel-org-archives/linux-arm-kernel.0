From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Sep 2013 15:15:46 +0100
Subject: [PATCH v3 2/4] ARM64: KVM: Implement kvm_vcpu_preferred_target()
 function
In-Reply-To: <1379596302-21522-3-git-send-email-anup.patel@linaro.org>
References: <1379596302-21522-1-git-send-email-anup.patel@linaro.org>
 <1379596302-21522-3-git-send-email-anup.patel@linaro.org>
Message-ID: <523B0712.1020705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/13 14:11, Anup Patel wrote:
> This patch implements kvm_vcpu_preferred_target() function for
> KVM ARM64 which will help us implement KVM_ARM_PREFERRED_TARGET
> ioctl for user space.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/include/asm/kvm_host.h |    1 +

This hunk belongs to patch #1, and the similar hunk in #1 belongs here.

	M.

>  arch/arm64/kvm/guest.c          |   21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 7d22517..76f3c19 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -154,6 +154,7 @@ struct kvm_vcpu_stat {
>  struct kvm_vcpu_init;
>  int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  			const struct kvm_vcpu_init *init);
> +int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  struct kvm_one_reg;
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index d7bf7d6..4da7882 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -254,6 +254,27 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  	return kvm_reset_vcpu(vcpu);
>  }
>  
> +int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
> +{
> +	int target = kvm_target_cpu();
> +
> +	if (target < 0)
> +		return -ENODEV;
> +
> +	memset(init, 0, sizeof(*init));
> +
> +	/* 
> +	 * For now, we return all optional features are available
> +	 * for preferred target. In future, we might have features
> +	 * available based on underlying host.
> +	 */
> +	init->target = (__u32)target;
> +	init->features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
> +	init->features[0] |= (1 << KVM_ARM_VCPU_EL1_32BIT);
> +
> +	return 0;
> +}
> +
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
>  	return -EINVAL;
> 


-- 
Jazz is not dead. It just smells funny...

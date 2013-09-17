From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 17 Sep 2013 22:05:23 +0100
Subject: [PATCH v2 1/4] ARM: KVM: Implement kvm_vcpu_preferred_target()
 function
In-Reply-To: <1379156917-17497-2-git-send-email-anup.patel@linaro.org>
References: <1379156917-17497-1-git-send-email-anup.patel@linaro.org>
 <1379156917-17497-2-git-send-email-anup.patel@linaro.org>
Message-ID: <20130917210523.GE7623@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 04:38:34PM +0530, Anup Patel wrote:
> This patch implements kvm_vcpu_preferred_target() function for
> KVM ARM which will help us implement KVM_ARM_PREFERRED_TARGET ioctl
> for user space.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/kvm/guest.c              |   19 +++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h |    1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 152d036..dae1e9f 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -222,6 +222,25 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  	return kvm_reset_vcpu(vcpu);
>  }
>  
> +int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
> +{
> +	int target = kvm_target_cpu();
> +
> +	if (target < 0)
> +		return target;
> +
> +	memset(init, 0, sizeof(*init));
> +
> +	/* For now, we return all optional features are available

kernel coding style requires wings for comments

> +	 * for preferred target. In future, we might have features
> +	 * available based on underlying host.
> +	 */
> +	init->target = (__u32)target;
> +	init->features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
> +
> +	return 0;
> +}
> +
>  int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
>  {
>  	return -EINVAL;
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index f318c43..b609db3 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -156,6 +156,7 @@ struct kvm_vcpu_stat {
>  struct kvm_vcpu_init;
>  int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  			const struct kvm_vcpu_init *init);
> +int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init);
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  struct kvm_one_reg;
> -- 
> 1.7.9.5
> 

-- 
Christoffer

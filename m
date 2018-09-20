From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 20 Sep 2018 12:22:17 +0200
Subject: [PATCH v5 06/18] kvm: arm/arm64: Allow arch specific
 configurations for VM
In-Reply-To: <20180917104144.19188-7-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-7-suzuki.poulose@arm.com>
Message-ID: <27461411-7c9d-7ea4-da39-b8f4628911ef@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
> Allow the arch backends to perform VM specific initialisation.
> This will be later used to handle IPA size configuration and per-VM
> VTCR configuration on arm64.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  arch/arm/include/asm/kvm_host.h   | 7 +++++++
>  arch/arm64/include/asm/kvm_host.h | 2 ++
>  arch/arm64/kvm/reset.c            | 7 +++++++
>  virt/kvm/arm/arm.c                | 5 +++--
>  4 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 3ad482d2f1eb..72d46418e1ef 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -354,4 +354,11 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>  struct kvm *kvm_arch_alloc_vm(void);
>  void kvm_arch_free_vm(struct kvm *kvm);
>  
> +static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
> +{
> +	if (type)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3d6d7336f871..b04280ae1be0 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -513,4 +513,6 @@ void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
>  struct kvm *kvm_arch_alloc_vm(void);
>  void kvm_arch_free_vm(struct kvm *kvm);
>  
> +int kvm_arm_config_vm(struct kvm *kvm, unsigned long type);
> +
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index e37c78bbe1ca..b0c07dab5cb3 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -133,3 +133,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	/* Reset timer */
>  	return kvm_timer_vcpu_reset(vcpu);
>  }
> +
> +int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
> +{
> +	if (type)
> +		return -EINVAL;
> +	return 0;
> +}
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index c92053bc3f96..327d0fd28380 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -120,8 +120,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  {
>  	int ret, cpu;
>  
> -	if (type)
> -		return -EINVAL;
> +	ret = kvm_arm_config_vm(kvm, type);
> +	if (ret)
> +		return ret;
>  
>  	kvm->arch.last_vcpu_ran = alloc_percpu(typeof(*kvm->arch.last_vcpu_ran));
>  	if (!kvm->arch.last_vcpu_ran)
> 

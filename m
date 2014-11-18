From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 18 Nov 2014 11:36:17 +0100
Subject: [PATCH v4 02/19] arm/arm64: KVM: pass down user space provided
 GIC type into vGIC code
In-Reply-To: <1415959683-26027-3-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-3-git-send-email-andre.przywara@arm.com>
Message-ID: <546B2121.5040602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 11:07 AM, Andre Przywara wrote:
> With the introduction of a second emulated GIC model we need to let
> userspace specify the GIC model to use for each VM. Pass the
> userspace provided value down into the vGIC code and store it there
> to differentiate later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> Changelog v3...v4:
> - added Acked-by
> 
>  arch/arm/kvm/arm.c     |    2 +-
>  include/kvm/arm_vgic.h |    7 +++++--
>  virt/kvm/arm/vgic.c    |    5 +++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index c2a5c69..8817fbd 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -753,7 +753,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	switch (ioctl) {
>  	case KVM_CREATE_IRQCHIP: {
>  		if (vgic_present)
> -			return kvm_vgic_create(kvm);
> +			return kvm_vgic_create(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
>  		else
>  			return -ENXIO;
>  	}
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 206dcc3..dde5a00 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -140,6 +140,9 @@ struct vgic_dist {
>  	bool			in_kernel;
>  	bool			ready;
>  
> +	/* vGIC model the kernel emulates for the guest (GICv2 or GICv3) */
just a small question related to GICv2m, will it be considered as
another model or is the same as GICv2 from a guest perspective?

Eric
> +	u32			vgic_model;
> +
>  	int			nr_cpus;
>  	int			nr_irqs;
>  
> @@ -275,7 +278,7 @@ struct kvm_exit_mmio;
>  int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
>  int kvm_vgic_hyp_init(void);
>  int kvm_vgic_init(struct kvm *kvm);
> -int kvm_vgic_create(struct kvm *kvm);
> +int kvm_vgic_create(struct kvm *kvm, u32 type);
>  void kvm_vgic_destroy(struct kvm *kvm);
>  void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
>  void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
> @@ -326,7 +329,7 @@ static inline int kvm_vgic_init(struct kvm *kvm)
>  	return 0;
>  }
>  
> -static inline int kvm_vgic_create(struct kvm *kvm)
> +static inline int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
>  	return 0;
>  }
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 3aaca49..2403d72 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1931,7 +1931,7 @@ out:
>  	return ret;
>  }
>  
> -int kvm_vgic_create(struct kvm *kvm)
> +int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
>  	int i, vcpu_lock_idx = -1, ret = 0;
>  	struct kvm_vcpu *vcpu;
> @@ -1963,6 +1963,7 @@ int kvm_vgic_create(struct kvm *kvm)
>  
>  	spin_lock_init(&kvm->arch.vgic.lock);
>  	kvm->arch.vgic.in_kernel = true;
> +	kvm->arch.vgic.vgic_model = type;
>  	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
>  	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>  	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
> @@ -2388,7 +2389,7 @@ static void vgic_destroy(struct kvm_device *dev)
>  
>  static int vgic_create(struct kvm_device *dev, u32 type)
>  {
> -	return kvm_vgic_create(dev->kvm);
> +	return kvm_vgic_create(dev->kvm, type);
>  }
>  
>  static struct kvm_device_ops kvm_arm_vgic_v2_ops = {
> 

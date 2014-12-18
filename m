From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Dec 2014 09:03:33 +0000
Subject: [PATCH v5 02/19] arm/arm64: KVM: pass down user space provided
 GIC type into vGIC code
In-Reply-To: <1418042274-3246-3-git-send-email-andre.przywara@arm.com> (Andre
 Przywara's message of "Mon, 8 Dec 2014 12:37:37 +0000")
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-3-git-send-email-andre.przywara@arm.com>
Message-ID: <86388d2uu2.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08 2014 at 12:37:37 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> With the introduction of a second emulated GIC model we need to let
> userspace specify the GIC model to use for each VM. Pass the
> userspace provided value down into the vGIC code and store it there
> to differentiate later.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

> ---
> Changelog v4...v5:
>  (none)
>
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
> index aacdb59..c2e0795 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1931,7 +1931,7 @@ out:
>  	return ret;
>  }
>  
> -int kvm_vgic_create(struct kvm *kvm)
> +int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
>  	int i, vcpu_lock_idx = -1, ret;
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

-- 
Jazz is not dead. It just smells funny.

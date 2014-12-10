From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 10 Dec 2014 11:11:41 +0100
Subject: [PATCH 1/5] arm/arm64: KVM: vgic: move reset initialization into
 vgic_init_maps()
In-Reply-To: <1418139844-27892-2-git-send-email-christoffer.dall@linaro.org>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <54881C5D.7060203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,
Reviewed-by: Eric Auger <eric.auger@linaro.org>
see few comments below.
On 12/09/2014 04:44 PM, Christoffer Dall wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> VGIC initialization currently happens in three phases:
>  (1) kvm_vgic_create() (triggered by userspace GIC creation)
>  (2) vgic_init_maps() (triggered by userspace GIC register read/write
>      requests, or from kvm_vgic_init() if not already run)
>  (3) kvm_vgic_init() (triggered by first VM run)
> 
> We were doing initialization of some state to correspond with the
> state of a freshly-reset GIC in kvm_vgic_init(); this is too late,
> since it will overwrite changes made by userspace using the
> register access APIs before the VM is run. Move this initialization
> earlier, into the vgic_init_maps() phase.
> 
> This fixes a bug where QEMU could successfully restore a saved
> VM state snapshot into a VM that had already been run, but could
> not restore it "from cold" using the -loadvm command line option
> (the symptoms being that the restored VM would run but interrupts
> were ignored).
> 
> Finally rename vgic_init_maps to vgic_init and renamed kvm_vgic_init to
> kvm_vgic_map_resources.
> 
>   [ This patch is originally written by Peter Maydell, but I have
>     modified it somewhat heavily, renaming various bits and moving code
>     around.  If something is broken, I am to be blamed. - Christoffer ]
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> This patch was originally named "vgic: move reset initialization into
> vgic_init_maps()" but I renamed it slightly to match the other vgic
> patches in the kernel.  I also did the additional changes since the
> original patch:
>  - Renamed kvm_vgic_init to kvm_vgic_map_resources
>  - Renamed vgic_init_maps to vgic_init
>  - Moved vgic_enable call into existing vcpu loop in vgic_init
>  - Moved ITARGETSRn initializtion above vcpu loop in vgic_init (the idea
typo
>    is to init global state first, then vcpu state).

kvm_vgic_vcpu_init also has disappeared and PPI settings of
dist->irq_enabled and dist->irq_cfg now are in former vgic_init_maps.

Maybe it would be simpler to review if there were 2 patches: one for
init redistribution from kvm_vgic_init to vgic_init_maps and one for the
renaming.

kvm_vgic_map_resources: difficult to understand it also inits the
internal states. Wouldn't kvm_vgic_set_ready be aligned with ready
terminology?

Best Regards

Eric

>  - Added comment in kvm_vgic_map_resources




> 
>  arch/arm/kvm/arm.c     |  6 ++--
>  include/kvm/arm_vgic.h |  4 +--
>  virt/kvm/arm/vgic.c    | 77 +++++++++++++++++++++-----------------------------
>  3 files changed, 37 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 9e193c8..a56cbb5 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -427,11 +427,11 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
>  	vcpu->arch.has_run_once = true;
>  
>  	/*
> -	 * Initialize the VGIC before running a vcpu the first time on
> -	 * this VM.
> +	 * Map the VGIC hardware resources before running a vcpu the first
> +	 * time on this VM.
>  	 */
>  	if (unlikely(!vgic_initialized(vcpu->kvm))) {
> -		ret = kvm_vgic_init(vcpu->kvm);
> +		ret = kvm_vgic_map_resources(vcpu->kvm);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 206dcc3..fe9783b 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -274,7 +274,7 @@ struct kvm_exit_mmio;
>  #ifdef CONFIG_KVM_ARM_VGIC
>  int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
>  int kvm_vgic_hyp_init(void);
> -int kvm_vgic_init(struct kvm *kvm);
> +int kvm_vgic_map_resources(struct kvm *kvm);
>  int kvm_vgic_create(struct kvm *kvm);
>  void kvm_vgic_destroy(struct kvm *kvm);
>  void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
> @@ -321,7 +321,7 @@ static inline int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr,
>  	return -ENXIO;
>  }
>  
> -static inline int kvm_vgic_init(struct kvm *kvm)
> +static inline int kvm_vgic_map_resources(struct kvm *kvm)
>  {
>  	return 0;
>  }
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index aacdb59..91e6bfc 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -91,6 +91,7 @@
>  #define ACCESS_WRITE_VALUE	(3 << 1)
>  #define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
>  
> +static int vgic_init(struct kvm *kvm);
>  static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu);
>  static void vgic_update_state(struct kvm *kvm);
> @@ -1726,39 +1727,14 @@ static int vgic_vcpu_init_maps(struct kvm_vcpu *vcpu, int nr_irqs)
>  
>  	int sz = (nr_irqs - VGIC_NR_PRIVATE_IRQS) / 8;
>  	vgic_cpu->pending_shared = kzalloc(sz, GFP_KERNEL);
> -	vgic_cpu->vgic_irq_lr_map = kzalloc(nr_irqs, GFP_KERNEL);
> +	vgic_cpu->vgic_irq_lr_map = kmalloc(nr_irqs, GFP_KERNEL);
>  
>  	if (!vgic_cpu->pending_shared || !vgic_cpu->vgic_irq_lr_map) {
>  		kvm_vgic_vcpu_destroy(vcpu);
>  		return -ENOMEM;
>  	}
>  
> -	return 0;
> -}
> -
> -/**
> - * kvm_vgic_vcpu_init - Initialize per-vcpu VGIC state
> - * @vcpu: pointer to the vcpu struct
> - *
> - * Initialize the vgic_cpu struct and vgic_dist struct fields pertaining to
> - * this vcpu and enable the VGIC for this VCPU
> - */
> -static void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
> -{
> -	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> -	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> -	int i;
> -
> -	for (i = 0; i < dist->nr_irqs; i++) {
> -		if (i < VGIC_NR_PPIS)
> -			vgic_bitmap_set_irq_val(&dist->irq_enabled,
> -						vcpu->vcpu_id, i, 1);
> -		if (i < VGIC_NR_PRIVATE_IRQS)
> -			vgic_bitmap_set_irq_val(&dist->irq_cfg,
> -						vcpu->vcpu_id, i, VGIC_CFG_EDGE);
> -
> -		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
> -	}
> +	memset(vgic_cpu->vgic_irq_lr_map, LR_EMPTY, nr_irqs);
>  
>  	/*
>  	 * Store the number of LRs per vcpu, so we don't have to go
> @@ -1767,7 +1743,7 @@ static void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  	 */
>  	vgic_cpu->nr_lr = vgic->nr_lr;
>  
> -	vgic_enable(vcpu);
> +	return 0;
>  }
>  
>  void kvm_vgic_destroy(struct kvm *kvm)
> @@ -1804,12 +1780,12 @@ void kvm_vgic_destroy(struct kvm *kvm)
>   * Allocate and initialize the various data structures. Must be called
>   * with kvm->lock held!
>   */
> -static int vgic_init_maps(struct kvm *kvm)
> +static int vgic_init(struct kvm *kvm)
>  {
>  	struct vgic_dist *dist = &kvm->arch.vgic;
>  	struct kvm_vcpu *vcpu;
>  	int nr_cpus, nr_irqs;
> -	int ret, i;
> +	int ret, i, vcpu_id;
>  
>  	if (dist->nr_cpus)	/* Already allocated */
>  		return 0;
> @@ -1859,16 +1835,28 @@ static int vgic_init_maps(struct kvm *kvm)
>  	if (ret)
>  		goto out;
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> +	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
> +		vgic_set_target_reg(kvm, 0, i);
> +
> +	kvm_for_each_vcpu(vcpu_id, vcpu, kvm) {
>  		ret = vgic_vcpu_init_maps(vcpu, nr_irqs);
>  		if (ret) {
>  			kvm_err("VGIC: Failed to allocate vcpu memory\n");
>  			break;
>  		}
> -	}
>  
> -	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
> -		vgic_set_target_reg(kvm, 0, i);
> +		for (i = 0; i < dist->nr_irqs; i++) {
> +			if (i < VGIC_NR_PPIS)
> +				vgic_bitmap_set_irq_val(&dist->irq_enabled,
> +							vcpu->vcpu_id, i, 1);
> +			if (i < VGIC_NR_PRIVATE_IRQS)
> +				vgic_bitmap_set_irq_val(&dist->irq_cfg,
> +							vcpu->vcpu_id, i,
> +							VGIC_CFG_EDGE);
> +		}
> +
> +		vgic_enable(vcpu);
> +	}
>  
>  out:
>  	if (ret)
> @@ -1878,18 +1866,16 @@ out:
>  }
>  
>  /**
> - * kvm_vgic_init - Initialize global VGIC state before running any VCPUs
> + * kvm_vgic_map_resources - Configure global VGIC state before running any VCPUs
>   * @kvm: pointer to the kvm struct
>   *
>   * Map the virtual CPU interface into the VM before running any VCPUs.  We
>   * can't do this at creation time, because user space must first set the
> - * virtual CPU interface address in the guest physical address space.  Also
> - * initialize the ITARGETSRn regs to 0 on the emulated distributor.
> + * virtual CPU interface address in the guest physical address space.
>   */
> -int kvm_vgic_init(struct kvm *kvm)
> +int kvm_vgic_map_resources(struct kvm *kvm)
>  {
> -	struct kvm_vcpu *vcpu;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	if (!irqchip_in_kernel(kvm))
>  		return 0;
> @@ -1906,7 +1892,11 @@ int kvm_vgic_init(struct kvm *kvm)
>  		goto out;
>  	}
>  
> -	ret = vgic_init_maps(kvm);
> +	/*
> +	 * Initialize the vgic if this hasn't already been done on demand by
> +	 * accessing the vgic state from userspace.
> +	 */
> +	ret = vgic_init(kvm);
>  	if (ret) {
>  		kvm_err("Unable to allocate maps\n");
>  		goto out;
> @@ -1920,9 +1910,6 @@ int kvm_vgic_init(struct kvm *kvm)
>  		goto out;
>  	}
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_vgic_vcpu_init(vcpu);
> -
>  	kvm->arch.vgic.ready = true;
>  out:
>  	if (ret)
> @@ -2167,7 +2154,7 @@ static int vgic_attr_regs_access(struct kvm_device *dev,
>  
>  	mutex_lock(&dev->kvm->lock);
>  
> -	ret = vgic_init_maps(dev->kvm);
> +	ret = vgic_init(dev->kvm);
>  	if (ret)
>  		goto out;
>  
> 

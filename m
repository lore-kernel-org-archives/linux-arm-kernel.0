From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 15 Oct 2014 09:27:15 -0700
Subject: [PATCH v2 05/15] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1408626416-11326-6-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20141015162715.GF14272@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:06:46PM +0100, Andre Przywara wrote:
> Currently we only have one virtual GIC model supported, so all guests
> use the same emulation code. With the addition of another model we
> end up with different guests using potentially different vGIC models,
> so we have to split up some functions to be per VM.
> Introduce a vgic_vm_ops struct to hold function pointers for those
> functions that are different and provide the necessary code to
> initialize them.
> This includes functions that depend on the emulated GIC model only
> and functions that depend on the combination of host and guest GIC.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  include/kvm/arm_vgic.h |   18 ++++++++--
>  virt/kvm/arm/vgic-v2.c |   17 +++++++--
>  virt/kvm/arm/vgic-v3.c |   16 +++++++--
>  virt/kvm/arm/vgic.c    |   92 +++++++++++++++++++++++++++++++++++-------------
>  4 files changed, 113 insertions(+), 30 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 4feac9a..7e7c99e 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -99,8 +99,6 @@ struct vgic_vmcr {
>  };
>  
>  struct vgic_ops {
> -	struct vgic_lr	(*get_lr)(const struct kvm_vcpu *, int);
> -	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
>  	void	(*sync_lr_elrsr)(struct kvm_vcpu *, int, struct vgic_lr);
>  	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
>  	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
> @@ -123,6 +121,17 @@ struct vgic_params {
>  	unsigned int	maint_irq;
>  	/* Virtual control interface base address */
>  	void __iomem	*vctrl_base;
> +	bool (*init_emul)(struct kvm *kvm, int type);
> +};
> +
> +struct vgic_vm_ops {
> +	struct vgic_lr	(*get_lr)(const struct kvm_vcpu *, int);
> +	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
> +	bool	(*handle_mmio)(struct kvm_vcpu *, struct kvm_run *,
> +			       struct kvm_exit_mmio *);
> +	bool	(*queue_sgi)(struct kvm_vcpu *vcpu, int irq);
> +	void	(*unqueue_sgi)(struct kvm_vcpu *vcpu, int irq, int source);
> +	int	(*vgic_init)(struct kvm *kvm, const struct vgic_params *params);
>  };
>  
>  struct vgic_dist {
> @@ -131,6 +140,9 @@ struct vgic_dist {
>  	bool			in_kernel;
>  	bool			ready;
>  
> +	/* vGIC model the kernel emulates for the guest (GICv2 or GICv3) */
> +	u32			vgic_model;
> +
>  	int			nr_cpus;
>  	int			nr_irqs;
>  
> @@ -168,6 +180,8 @@ struct vgic_dist {
>  
>  	/* Bitmap indicating which CPU has something pending */
>  	unsigned long		irq_pending_on_cpu;
> +
> +	struct vgic_vm_ops	vm_ops;
>  #endif
>  };
>  
> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> index 01124ef..90947c6 100644
> --- a/virt/kvm/arm/vgic-v2.c
> +++ b/virt/kvm/arm/vgic-v2.c
> @@ -161,8 +161,6 @@ static void vgic_v2_enable(struct kvm_vcpu *vcpu)
>  }
>  
>  static const struct vgic_ops vgic_v2_ops = {
> -	.get_lr			= vgic_v2_get_lr,
> -	.set_lr			= vgic_v2_set_lr,
>  	.sync_lr_elrsr		= vgic_v2_sync_lr_elrsr,
>  	.get_elrsr		= vgic_v2_get_elrsr,
>  	.get_eisr		= vgic_v2_get_eisr,
> @@ -176,6 +174,20 @@ static const struct vgic_ops vgic_v2_ops = {
>  
>  static struct vgic_params vgic_v2_params;
>  
> +static bool vgic_v2_init_emul(struct kvm *kvm, int type)
> +{
> +	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> +
> +	switch (type) {
> +	case KVM_DEV_TYPE_ARM_VGIC_V2:
> +		vm_ops->get_lr = vgic_v2_get_lr;
> +		vm_ops->set_lr = vgic_v2_set_lr;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * vgic_v2_probe - probe for a GICv2 compatible interrupt controller in DT
>   * @node:	pointer to the DT node
> @@ -214,6 +226,7 @@ int vgic_v2_probe(struct device_node *vgic_node,
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> +	vgic->init_emul = vgic_v2_init_emul;

this feels overly complicated, can't each host-support function just
export this function and we call it directly from the vgic creation
code?

That or just keep the host-specific functions the way they are and
handle the split within these functions?

Bah, I'm not sure, this patch is just terrible to review...  Perhaps
it's because we're doing some combination of introducing infrastructure
and also changing random bits and naming to be version-specific.

>  
>  	vgic->nr_lr = readl_relaxed(vgic->vctrl_base + GICH_VTR);
>  	vgic->nr_lr = (vgic->nr_lr & 0x3f) + 1;
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> index 1c2c8ee..a38339e 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -157,8 +157,6 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
>  }
>  
>  static const struct vgic_ops vgic_v3_ops = {
> -	.get_lr			= vgic_v3_get_lr,
> -	.set_lr			= vgic_v3_set_lr,
>  	.sync_lr_elrsr		= vgic_v3_sync_lr_elrsr,
>  	.get_elrsr		= vgic_v3_get_elrsr,
>  	.get_eisr		= vgic_v3_get_eisr,
> @@ -170,6 +168,19 @@ static const struct vgic_ops vgic_v3_ops = {
>  	.enable			= vgic_v3_enable,
>  };
>  
> +static bool vgic_v3_init_emul_compat(struct kvm *kvm, int type)

why _compat?

> +{
> +	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> +
> +	switch (type) {
> +	case KVM_DEV_TYPE_ARM_VGIC_V2:
> +		vm_ops->get_lr = vgic_v3_get_lr;
> +		vm_ops->set_lr = vgic_v3_set_lr;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static struct vgic_params vgic_v3_params;
>  
>  /**
> @@ -231,6 +242,7 @@ int vgic_v3_probe(struct device_node *vgic_node,
>  		goto out;
>  	}
>  
> +	vgic->init_emul = vgic_v3_init_emul_compat;
>  	vgic->vcpu_base = vcpu_res.start;
>  	vgic->vctrl_base = NULL;
>  	vgic->type = VGIC_V3;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index bef9aa0..5e0bc24 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -99,6 +99,8 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  static const struct vgic_ops *vgic_ops;
>  static const struct vgic_params *vgic;
>  
> +#define vgic_vm_op(kvm, fn) ((kvm)->arch.vgic.vm_ops.fn)

yuck, we have only 5 of these, can't we create a define for each or
create small wrapper functions instead?  That would make ctags behave
nicely too.

> +
>  /*
>   * struct vgic_bitmap contains a bitmap of unsigned longs, but
>   * extracts u32s out of them.
> @@ -668,11 +670,16 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
>   * to the distributor but the active state stays in the LRs, because we don't
>   * track the active state on the distributor side.
>   */
> -static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
> +

extra whitespace and misplaced comment

> +static void vgic_v2_unqueue_sgi(struct kvm_vcpu *vcpu, int irq, int source)

not sure about this name, it's not really unqueueing anything, it's just
setting the source for an SGI you're setting on the distributor...

>  {
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
> +}

missing whitespace

> +static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
> +{
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> -	int vcpu_id = vcpu->vcpu_id;
>  	int i;
>  
>  	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> @@ -699,7 +706,8 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>  		 */
>  		vgic_dist_irq_set(vcpu, lr.irq);
>  		if (lr.irq < VGIC_NR_SGIS)
> -			*vgic_get_sgi_sources(dist, vcpu_id, lr.irq) |= 1 << lr.source;
> +			vgic_vm_op(vcpu->kvm, unqueue_sgi)(vcpu, lr.irq,
> +							   lr.source);
>  		lr.state &= ~LR_STATE_PENDING;
>  		vgic_set_lr(vcpu, i, lr);
>  
> @@ -1050,7 +1058,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	if (!irqchip_in_kernel(vcpu->kvm))
>  		return false;
>  
> -	return vgic_v2_handle_mmio(vcpu, run, mmio);
> +	return vgic_vm_op(vcpu->kvm, handle_mmio)(vcpu, run, mmio);
>  }
>  
>  static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
> @@ -1158,13 +1166,13 @@ static void vgic_update_state(struct kvm *kvm)
>  
>  static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
>  {
> -	return vgic_ops->get_lr(vcpu, lr);
> +	return vgic_vm_op(vcpu->kvm, get_lr)(vcpu, lr);
>  }
>  
>  static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr,
>  			       struct vgic_lr vlr)
>  {
> -	vgic_ops->set_lr(vcpu, lr, vlr);
> +	return vgic_vm_op(vcpu->kvm, set_lr)(vcpu, lr, vlr);
>  }
>  
>  static void vgic_sync_lr_elrsr(struct kvm_vcpu *vcpu, int lr,
> @@ -1302,7 +1310,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  	return true;
>  }
>  
> -static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
> +static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
>  {
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>  	unsigned long sources;
> @@ -1377,7 +1385,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
>  
>  	/* SGIs */
>  	for_each_set_bit(i, vgic_cpu->pending_percpu, VGIC_NR_SGIS) {
> -		if (!vgic_queue_sgi(vcpu, i))
> +		if (!vgic_vm_op(vcpu->kvm, queue_sgi)(vcpu, i))
>  			overflow = 1;
>  	}
>  
> @@ -1873,9 +1881,6 @@ static int vgic_init_maps(struct kvm *kvm)
>  		}
>  	}
>  
> -	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
> -		vgic_set_target_reg(kvm, 0, i);
> -
>  out:
>  	if (ret)
>  		kvm_vgic_destroy(kvm);
> @@ -1883,6 +1888,31 @@ out:
>  	return ret;
>  }
>  
> +static int vgic_v2_init(struct kvm *kvm, const struct vgic_params *params)
> +{
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +	int ret, i;
> +
> +	if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
> +	    IS_VGIC_ADDR_UNDEF(dist->vgic_cpu_base)) {
> +		kvm_err("Need to set vgic distributor addresses first\n");
> +		return -ENXIO;
> +	}
> +
> +	ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
> +				    params->vcpu_base,
> +				    KVM_VGIC_V2_CPU_SIZE);
> +	if (ret) {
> +		kvm_err("Unable to remap VGIC CPU to VCPU\n");
> +		return ret;
> +	}
> +
> +	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
> +		vgic_set_target_reg(kvm, 0, i);
> +
> +	return 0;
> +}
> +
>  /**
>   * kvm_vgic_init - Initialize global VGIC state before running any VCPUs
>   * @kvm: pointer to the kvm struct
> @@ -1905,25 +1935,15 @@ int kvm_vgic_init(struct kvm *kvm)
>  	if (vgic_initialized(kvm))
>  		goto out;
>  
> -	if (IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_dist_base) ||
> -	    IS_VGIC_ADDR_UNDEF(kvm->arch.vgic.vgic_cpu_base)) {
> -		kvm_err("Need to set vgic cpu and dist addresses first\n");
> -		ret = -ENXIO;
> -		goto out;
> -	}
> -
>  	ret = vgic_init_maps(kvm);
>  	if (ret) {
>  		kvm_err("Unable to allocate maps\n");
>  		goto out;
>  	}
>  
> -	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
> -				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE);
> -	if (ret) {
> -		kvm_err("Unable to remap VGIC CPU to VCPU\n");
> +	ret = vgic_vm_op(kvm, vgic_init)(kvm, vgic);
> +	if (ret)
>  		goto out;
> -	}
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm)
>  		kvm_vgic_vcpu_init(vcpu);
> @@ -1936,6 +1956,21 @@ out:
>  	return ret;
>  }
>  
> +static bool init_emulation_ops(struct kvm *kvm, int type)
> +{
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +
> +	switch (type) {
> +	case KVM_DEV_TYPE_ARM_VGIC_V2:
> +		dist->vm_ops.handle_mmio = vgic_v2_handle_mmio;
> +		dist->vm_ops.queue_sgi = vgic_v2_queue_sgi;
> +		dist->vm_ops.unqueue_sgi = vgic_v2_unqueue_sgi;
> +		dist->vm_ops.vgic_init = vgic_v2_init;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
>  	int i, vcpu_lock_idx = -1, ret = 0;
> @@ -1943,7 +1978,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  
>  	mutex_lock(&kvm->lock);
>  
> -	if (kvm->arch.vgic.vctrl_base) {
> +	if (kvm->arch.vgic.in_kernel) {

unrelated change?

>  		ret = -EEXIST;
>  		goto out;
>  	}
> @@ -1966,12 +2001,21 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  		}
>  	}
>  
> +	if (!vgic->init_emul(kvm, type)) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
>  	spin_lock_init(&kvm->arch.vgic.lock);
>  	kvm->arch.vgic.in_kernel = true;
> +	kvm->arch.vgic.vgic_model = type;
>  	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
>  	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>  	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>  
> +	if (!init_emulation_ops(kvm, type))
> +		ret = -ENODEV;
> +
>  out_unlock:
>  	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
>  		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer

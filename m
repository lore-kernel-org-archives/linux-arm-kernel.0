From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 14:59:23 +0100
Subject: [PATCH v3 05/19] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <1414776414-13426-6-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20141103135923.GF16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:40PM +0000, Andre Przywara wrote:
> Currently we only have one virtual GIC model supported, so all guests
> use the same emulation code. With the addition of another model we
> end up with different guests using potentially different vGIC models,
> so we have to split up some functions to be per VM.
> Introduce a vgic_vm_ops struct to hold function pointers for those
> functions that are different and provide the necessary code to
> initialize them.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  include/kvm/arm_vgic.h |   10 ++++++
>  virt/kvm/arm/vgic.c    |   81 +++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 22 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index dde5a00..bfb660a 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -134,6 +134,14 @@ struct vgic_params {
>  	void __iomem	*vctrl_base;
>  };
>  
> +struct vgic_vm_ops {
> +	bool	(*handle_mmio)(struct kvm_vcpu *, struct kvm_run *,
> +			       struct kvm_exit_mmio *);
> +	bool	(*queue_sgi)(struct kvm_vcpu *vcpu, int irq);
> +	void	(*add_sgi_source)(struct kvm_vcpu *vcpu, int irq, int source);
> +	int	(*vgic_init)(struct kvm *kvm, const struct vgic_params *params);
> +};
> +
>  struct vgic_dist {
>  #ifdef CONFIG_KVM_ARM_VGIC
>  	spinlock_t		lock;
> @@ -215,6 +223,8 @@ struct vgic_dist {
>  
>  	/* Bitmap indicating which CPU has something pending */
>  	unsigned long		*irq_pending_on_cpu;
> +
> +	struct vgic_vm_ops	vm_ops;
>  #endif
>  };
>  
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 0cbdde9..2c16684 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -105,6 +105,8 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  static const struct vgic_ops *vgic_ops;
>  static const struct vgic_params *vgic;
>  
> +#define vgic_vm_op(kvm, fn) ((kvm)->arch.vgic.vm_ops.fn)
> +

another one?  why did you simply ignore my comment from the last review?

If it wasn't obvious last time around, YUCK, and no ;)

>  /*
>   * struct vgic_bitmap contains a bitmap made of unsigned longs, but
>   * extracts u32s out of them.
> @@ -761,6 +763,13 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
>  	return false;
>  }
>  
> +static void vgic_v2_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
> +{
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
> +}
> +
>  /**
>   * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
>   * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
> @@ -775,9 +784,7 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
>   */
>  static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>  {
> -	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> -	int vcpu_id = vcpu->vcpu_id;
>  	int i;
>  
>  	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> @@ -804,7 +811,8 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>  		 */
>  		vgic_dist_irq_set_pending(vcpu, lr.irq);
>  		if (lr.irq < VGIC_NR_SGIS)
> -			*vgic_get_sgi_sources(dist, vcpu_id, lr.irq) |= 1 << lr.source;
> +			vgic_vm_op(vcpu->kvm, add_sgi_source)(vcpu, lr.irq,
> +							      lr.source);
>  		lr.state &= ~LR_STATE_PENDING;
>  		vgic_set_lr(vcpu, i, lr);
>  
> @@ -1162,7 +1170,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	if (!irqchip_in_kernel(vcpu->kvm))
>  		return false;
>  
> -	return vgic_v2_handle_mmio(vcpu, run, mmio);
> +	return vgic_vm_op(vcpu->kvm, handle_mmio)(vcpu, run, mmio);
>  }
>  
>  static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
> @@ -1414,7 +1422,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  	return true;
>  }
>  
> -static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
> +static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
>  {
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>  	unsigned long sources;
> @@ -1489,7 +1497,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
>  
>  	/* SGIs */
>  	for_each_set_bit(i, vgic_cpu->pending_percpu, VGIC_NR_SGIS) {
> -		if (!vgic_queue_sgi(vcpu, i))
> +		if (!vgic_vm_op(vcpu->kvm, queue_sgi)(vcpu, i))
>  			overflow = 1;
>  	}
>  
> @@ -1944,9 +1952,6 @@ static int vgic_init_maps(struct kvm *kvm)
>  		}
>  	}
>  
> -	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
> -		vgic_set_target_reg(kvm, 0, i);
> -

Remind me, why are we moving this chunk?

>  out:
>  	if (ret)
>  		kvm_vgic_destroy(kvm);
> @@ -1954,6 +1959,31 @@ out:
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
> +				    KVM_VGIC_V2_CPU_SIZE, true);
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
> @@ -1976,26 +2006,15 @@ int kvm_vgic_init(struct kvm *kvm)
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
> -				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
> -				    true);
> -	if (ret) {
> -		kvm_err("Unable to remap VGIC CPU to VCPU\n");
> +	ret = vgic_vm_op(kvm, vgic_init)(kvm, vgic);
> +	if (ret)
>  		goto out;
> -	}
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm)
>  		kvm_vgic_vcpu_init(vcpu);
> @@ -2008,6 +2027,21 @@ out:
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
> +		dist->vm_ops.add_sgi_source = vgic_v2_add_sgi_source;
> +		dist->vm_ops.vgic_init = vgic_v2_init;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
>  	int i, vcpu_lock_idx = -1, ret = 0;
> @@ -2045,6 +2079,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
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

-Christoffer

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 20:03:20 +0100
Subject: [PATCH v3 05/19] arm/arm64: KVM: introduce per-VM ops
In-Reply-To: <5458F7A3.9000901@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-6-git-send-email-andre.przywara@arm.com>
 <20141103135923.GF16132@cbox> <5458F7A3.9000901@arm.com>
Message-ID: <20141104190320.GA16138@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 03:58:27PM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> as hinted on IRC, an earlier reply on this one got lost on my machine,
> so please excuse my apparent ignorance on your previous comments.
> 
> On 03/11/14 13:59, Christoffer Dall wrote:
> > On Fri, Oct 31, 2014 at 05:26:40PM +0000, Andre Przywara wrote:
> >> Currently we only have one virtual GIC model supported, so all guests
> >> use the same emulation code. With the addition of another model we
> >> end up with different guests using potentially different vGIC models,
> >> so we have to split up some functions to be per VM.
> >> Introduce a vgic_vm_ops struct to hold function pointers for those
> >> functions that are different and provide the necessary code to
> >> initialize them.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  include/kvm/arm_vgic.h |   10 ++++++
> >>  virt/kvm/arm/vgic.c    |   81 +++++++++++++++++++++++++++++++++++-------------
> >>  2 files changed, 69 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> >> index dde5a00..bfb660a 100644
> >> --- a/include/kvm/arm_vgic.h
> >> +++ b/include/kvm/arm_vgic.h
> >> @@ -134,6 +134,14 @@ struct vgic_params {
> >>  	void __iomem	*vctrl_base;
> >>  };
> >>  
> >> +struct vgic_vm_ops {
> >> +	bool	(*handle_mmio)(struct kvm_vcpu *, struct kvm_run *,
> >> +			       struct kvm_exit_mmio *);
> >> +	bool	(*queue_sgi)(struct kvm_vcpu *vcpu, int irq);
> >> +	void	(*add_sgi_source)(struct kvm_vcpu *vcpu, int irq, int source);
> >> +	int	(*vgic_init)(struct kvm *kvm, const struct vgic_params *params);
> >> +};
> >> +
> >>  struct vgic_dist {
> >>  #ifdef CONFIG_KVM_ARM_VGIC
> >>  	spinlock_t		lock;
> >> @@ -215,6 +223,8 @@ struct vgic_dist {
> >>  
> >>  	/* Bitmap indicating which CPU has something pending */
> >>  	unsigned long		*irq_pending_on_cpu;
> >> +
> >> +	struct vgic_vm_ops	vm_ops;
> >>  #endif
> >>  };
> >>  
> >> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >> index 0cbdde9..2c16684 100644
> >> --- a/virt/kvm/arm/vgic.c
> >> +++ b/virt/kvm/arm/vgic.c
> >> @@ -105,6 +105,8 @@ static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
> >>  static const struct vgic_ops *vgic_ops;
> >>  static const struct vgic_params *vgic;
> >>  
> >> +#define vgic_vm_op(kvm, fn) ((kvm)->arch.vgic.vm_ops.fn)
> >> +
> > 
> > another one?  why did you simply ignore my comment from the last review?
> > 
> > If it wasn't obvious last time around, YUCK, and no ;)
> 
> OK, which version would you like?
> 
> 1) Actually my first solution was to decode it on each call-site directly:
> 
> vcpu->kvm->arch.vgic.vm_ops.add_sgi_source(vcpu, lr.irq, lr.source);
> 
> However one reviewer suggested to wrap it with the macro you see above.
> 

yeah, those lines did become very long.

> 2) Provide a static inline for each seems like overkill, since there is
> only one caller for each of them, but it would look like this:
> 
> static void add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
> {
>         vcpu->kvm->arch.vgic.vm_ops.add_sgi_source(vcpu, irq, source);
> }
> 
> Both don't look very convincing to me, so if you see other
> colors^Wsolutions, please let me know ;-)

I strongly prefer the static inline version, I don't think it's that
bad.  You could also stick with a macro solution, but then you should do
something like:

#define add_sgu_source(vcpu, irq, source) \
	vcpu->kvm->arch.vgic.vm_ops.add_sgi_source(vcpu, irq, source)

There's only a handful or so of these, right, so I really don't see a
big problem having a number of static inlines.

> 
> We have to choose between them at _runtime_, because there could be two
> guests with different vGIC models running at the same time.
> 
> >>  /*
> >>   * struct vgic_bitmap contains a bitmap made of unsigned longs, but
> >>   * extracts u32s out of them.
> >> @@ -761,6 +763,13 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
> >>  	return false;
> >>  }
> >>  
> >> +static void vgic_v2_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
> >> +{
> >> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >> +
> >> +	*vgic_get_sgi_sources(dist, vcpu->vcpu_id, irq) |= 1 << source;
> >> +}
> >> +
> >>  /**
> >>   * vgic_unqueue_irqs - move pending IRQs from LRs to the distributor
> >>   * @vgic_cpu: Pointer to the vgic_cpu struct holding the LRs
> >> @@ -775,9 +784,7 @@ static bool handle_mmio_sgi_reg(struct kvm_vcpu *vcpu,
> >>   */
> >>  static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
> >>  {
> >> -	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >> -	int vcpu_id = vcpu->vcpu_id;
> >>  	int i;
> >>  
> >>  	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> >> @@ -804,7 +811,8 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
> >>  		 */
> >>  		vgic_dist_irq_set_pending(vcpu, lr.irq);
> >>  		if (lr.irq < VGIC_NR_SGIS)
> >> -			*vgic_get_sgi_sources(dist, vcpu_id, lr.irq) |= 1 << lr.source;
> >> +			vgic_vm_op(vcpu->kvm, add_sgi_source)(vcpu, lr.irq,
> >> +							      lr.source);
> >>  		lr.state &= ~LR_STATE_PENDING;
> >>  		vgic_set_lr(vcpu, i, lr);
> >>  
> >> @@ -1162,7 +1170,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >>  	if (!irqchip_in_kernel(vcpu->kvm))
> >>  		return false;
> >>  
> >> -	return vgic_v2_handle_mmio(vcpu, run, mmio);
> >> +	return vgic_vm_op(vcpu->kvm, handle_mmio)(vcpu, run, mmio);
> >>  }
> >>  
> >>  static u8 *vgic_get_sgi_sources(struct vgic_dist *dist, int vcpu_id, int sgi)
> >> @@ -1414,7 +1422,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
> >>  	return true;
> >>  }
> >>  
> >> -static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
> >> +static bool vgic_v2_queue_sgi(struct kvm_vcpu *vcpu, int irq)
> >>  {
> >>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >>  	unsigned long sources;
> >> @@ -1489,7 +1497,7 @@ static void __kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
> >>  
> >>  	/* SGIs */
> >>  	for_each_set_bit(i, vgic_cpu->pending_percpu, VGIC_NR_SGIS) {
> >> -		if (!vgic_queue_sgi(vcpu, i))
> >> +		if (!vgic_vm_op(vcpu->kvm, queue_sgi)(vcpu, i))
> >>  			overflow = 1;
> >>  	}
> >>  
> >> @@ -1944,9 +1952,6 @@ static int vgic_init_maps(struct kvm *kvm)
> >>  		}
> >>  	}
> >>  
> >> -	for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i += 4)
> >> -		vgic_set_target_reg(kvm, 0, i);
> >> -
> > 
> > Remind me, why are we moving this chunk?
> 
> The target registers are only valid for vGICv2 (we have other means for
> GICv3), so this belongs now into the vGICv2 specific code.
> 

ah, right, obvious ;)

Thanks,
-Christoffer

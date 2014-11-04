From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 20:12:52 +0100
Subject: [PATCH v3 06/19] arm/arm64: KVM: move [sg]et_lr into per-VM ops
In-Reply-To: <5458FF32.5040900@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-7-git-send-email-andre.przywara@arm.com>
 <20141103141510.GG16132@cbox> <5458FF32.5040900@arm.com>
Message-ID: <20141104191252.GB16138@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 04:30:42PM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 03/11/14 14:15, Christoffer Dall wrote:
> > On Fri, Oct 31, 2014 at 05:26:41PM +0000, Andre Przywara wrote:
> >> The function to set the VGIC's list registers are not only dependent
> >> on the host GIC model, but need to behave slightly different for
> >> the type of emulated guest GIC.
> >> So move the functions into the new struct vgic_vm_ops and initialize
> >> them properly to prepare for guest GICv3 support later.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  include/kvm/arm_vgic.h |    5 +++--
> >>  virt/kvm/arm/vgic-v2.c |   17 +++++++++++++++--
> >>  virt/kvm/arm/vgic-v3.c |   16 ++++++++++++++--
> >>  virt/kvm/arm/vgic.c    |    9 +++++++--
> >>  4 files changed, 39 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> >> index bfb660a..a6d41f1 100644
> >> --- a/include/kvm/arm_vgic.h
> >> +++ b/include/kvm/arm_vgic.h
> >> @@ -108,8 +108,6 @@ struct vgic_vmcr {
> >>  };
> >>  
> >>  struct vgic_ops {
> >> -	struct vgic_lr	(*get_lr)(const struct kvm_vcpu *, int);
> >> -	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
> >>  	void	(*sync_lr_elrsr)(struct kvm_vcpu *, int, struct vgic_lr);
> >>  	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
> >>  	u64	(*get_eisr)(const struct kvm_vcpu *vcpu);
> >> @@ -132,9 +130,12 @@ struct vgic_params {
> >>  	unsigned int	maint_irq;
> >>  	/* Virtual control interface base address */
> >>  	void __iomem	*vctrl_base;
> >> +	bool (*init_emul)(struct kvm *kvm, int type);
> >>  };
> >>  
> >>  struct vgic_vm_ops {
> >> +	struct vgic_lr	(*get_lr)(const struct kvm_vcpu *, int);
> >> +	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
> >>  	bool	(*handle_mmio)(struct kvm_vcpu *, struct kvm_run *,
> >>  			       struct kvm_exit_mmio *);
> >>  	bool	(*queue_sgi)(struct kvm_vcpu *vcpu, int irq);
> > 
> > 
> > this has now become incredibly confusing, what are your thoughts on
> > renaming vgic_ops to kvm_gic_ops to make it clear that this structure is
> > about hardware-managing ops and vgic_vm_ops is about the vgic, the
> > virtual instance?
> 
> Mmh, makes some sense, but I am bit reluctant to rename existing
> identifiers. I get about 20 hits for vgic_ops, so if you will ack this
> rename, I can go ahead with it.
> 

Just something I wanted to throw out there for both you and Marc.  We
can change it later if needed, let's focus on getting these patches into
shape for now.

> > 
> >> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> >> index 2935405..bdc8d97 100644
> >> --- a/virt/kvm/arm/vgic-v2.c
> >> +++ b/virt/kvm/arm/vgic-v2.c
> >> @@ -143,8 +143,6 @@ static void vgic_v2_enable(struct kvm_vcpu *vcpu)
> >>  }
> >>  
> >>  static const struct vgic_ops vgic_v2_ops = {
> >> -	.get_lr			= vgic_v2_get_lr,
> >> -	.set_lr			= vgic_v2_set_lr,
> >>  	.sync_lr_elrsr		= vgic_v2_sync_lr_elrsr,
> >>  	.get_elrsr		= vgic_v2_get_elrsr,
> >>  	.get_eisr		= vgic_v2_get_eisr,
> >> @@ -158,6 +156,20 @@ static const struct vgic_ops vgic_v2_ops = {
> >>  
> >>  static struct vgic_params vgic_v2_params;
> >>  
> >> +static bool vgic_v2_init_emul(struct kvm *kvm, int type)
> >> +{
> >> +	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> >> +
> >> +	switch (type) {
> >> +	case KVM_DEV_TYPE_ARM_VGIC_V2:
> >> +		vm_ops->get_lr = vgic_v2_get_lr;
> >> +		vm_ops->set_lr = vgic_v2_set_lr;
> >> +		return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >>  /**
> >>   * vgic_v2_probe - probe for a GICv2 compatible interrupt controller in DT
> >>   * @node:	pointer to the DT node
> >> @@ -196,6 +208,7 @@ int vgic_v2_probe(struct device_node *vgic_node,
> >>  		ret = -ENOMEM;
> >>  		goto out;
> >>  	}
> >> +	vgic->init_emul = vgic_v2_init_emul;
> >>  
> >>  	vgic->nr_lr = readl_relaxed(vgic->vctrl_base + GICH_VTR);
> >>  	vgic->nr_lr = (vgic->nr_lr & 0x3f) + 1;
> >> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> >> index 1c2c8ee..a38339e 100644
> >> --- a/virt/kvm/arm/vgic-v3.c
> >> +++ b/virt/kvm/arm/vgic-v3.c
> >> @@ -157,8 +157,6 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
> >>  }
> >>  
> >>  static const struct vgic_ops vgic_v3_ops = {
> >> -	.get_lr			= vgic_v3_get_lr,
> >> -	.set_lr			= vgic_v3_set_lr,
> >>  	.sync_lr_elrsr		= vgic_v3_sync_lr_elrsr,
> >>  	.get_elrsr		= vgic_v3_get_elrsr,
> >>  	.get_eisr		= vgic_v3_get_eisr,
> >> @@ -170,6 +168,19 @@ static const struct vgic_ops vgic_v3_ops = {
> >>  	.enable			= vgic_v3_enable,
> >>  };
> >>  
> >> +static bool vgic_v3_init_emul_compat(struct kvm *kvm, int type)
> >> +{
> >> +	struct vgic_vm_ops *vm_ops = &kvm->arch.vgic.vm_ops;
> >> +
> >> +	switch (type) {
> >> +	case KVM_DEV_TYPE_ARM_VGIC_V2:
> >> +		vm_ops->get_lr = vgic_v3_get_lr;
> >> +		vm_ops->set_lr = vgic_v3_set_lr;
> >> +		return true;
> >> +	}
> >> +	return false;
> >> +}
> >> +
> >>  static struct vgic_params vgic_v3_params;
> >>  
> >>  /**
> >> @@ -231,6 +242,7 @@ int vgic_v3_probe(struct device_node *vgic_node,
> >>  		goto out;
> >>  	}
> >>  
> >> +	vgic->init_emul = vgic_v3_init_emul_compat;
> >>  	vgic->vcpu_base = vcpu_res.start;
> >>  	vgic->vctrl_base = NULL;
> >>  	vgic->type = VGIC_V3;
> >> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >> index 2c16684..8c2e707 100644
> >> --- a/virt/kvm/arm/vgic.c
> >> +++ b/virt/kvm/arm/vgic.c
> >> @@ -1278,13 +1278,13 @@ static void vgic_update_state(struct kvm *kvm)
> >>  
> >>  static struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
> >>  {
> >> -	return vgic_ops->get_lr(vcpu, lr);
> >> +	return vgic_vm_op(vcpu->kvm, get_lr)(vcpu, lr);
> >>  }
> >>  
> >>  static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr,
> >>  			       struct vgic_lr vlr)
> >>  {
> >> -	vgic_ops->set_lr(vcpu, lr, vlr);
> >> +	return vgic_vm_op(vcpu->kvm, set_lr)(vcpu, lr, vlr);
> >>  }
> >>  
> >>  static void vgic_sync_lr_elrsr(struct kvm_vcpu *vcpu, int lr,
> >> @@ -2072,6 +2072,11 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
> >>  		}
> >>  	}
> >>  
> >> +	if (!vgic->init_emul(kvm, type)) {
> >> +		ret = -ENODEV;
> >> +		goto out_unlock;
> >> +	}
> >> +
> >>  	spin_lock_init(&kvm->arch.vgic.lock);
> >>  	kvm->arch.vgic.in_kernel = true;
> >>  	kvm->arch.vgic.vgic_model = type;
> >> -- 
> >> 1.7.9.5
> >>
> > 
> > Thanks for splitting up the patches, it's certainly better to review.
> > 
> > However, my question from the last round still stands.  What you're
> > doing here is setting a sh*tload of function pointers through an amazing
> > amount of abstractions to avoid something like
> > 
> > void vgic_v2_set_lr(struct kvm_vgic *vgic)
> > {
> > 	switch (vgic->type) {
> > 	case KVM_DEV_TYPE_ARM_VGIC_V2:
> > 		foo();
> > 		break;
> > 	case KVM_DEV_TYPE_ARM_VGIC_V3:
> > 		bar();
> > 		break;
> > 	}
> > }
> > 
> > So I have to ask: What's the benefit? That you'll have fewer
> > conditionals?  But god have mercy on the poor people having to debug
> > some issue and figure out which function the code actually calls when it
> > (inside another complicated piece of logic) sets a LR.
> 
> So the big aim here is to separate the stages cleanly. We have the
> backend (vgic-v2.c and vgic-v3.c), which cares about the host hardware
> specific functions. Then we have the frontend (vgic-v2-emul.c and
> vgic-v3-emul.c), which cares about the guest-facing emulation part.
> vgic.c is now just the "middle end", connecting one of the front-ends
> with one of the back-ends - depending on both the host's hardware
> (back-end) and the user's choices at VM creation time (front-end).
> Ideally any new hardware or emulation model would just require an extra
> file with little or no changes to vgic.c.
> Not sure whether we will see much more instances of either the front- or
> back-end, but I like the possibility to add one later - this may be
> useful already for the ITS emulation.
> 
> So my goal was to avoid any emulation or host specific calls in vgic.c,
> just rely on proper initialization in an init() function.
> Like your example above would require to export the respective functions
> and put their prototypes in the header file, also to enumerate all
> combinations in vgic.c, which I don't like very much.

I accept the point that you set things up cleanly and thus you only have
to make a single call that abstracts something away underneeth to get a
cleaner middle-end implementation.

However, in my experience the things we're debugging with this type of
code requires you to go through the code and carefully consider how the
hardware registers and state ends up looking like, and the thing is, now
you see some function pointer being called, but there's really no easy
way to resolve that into an actual function implementation.

The way you've written the code requires you to go through 4 files
without gicv3 emulation in place (vgic.c, vgic-v2.c, vgic-v3.c, and
vgic-v2-emul.c) and find all init functions, and keep all settings in
your head, remember what function some pointer was configured to use, go
back to where you came from, see which arguments are passed to that
function, look up that function, and continue debugging.  I think that's
a high price to pay for some theoretically cleaner abstraction.

There's just something too complicated about the way it is now, so we
need to do something.

> 
> I can give it a try anyway to check how it looks like and what it gives us.
> 
> > This just feels like we're doing something incredibly wrong...
> 
> TBH I have this feeling sometimes when reading the VGIC code (especially
> the endianness code), which is probably just due to the nature of the
> GIC being a beast on itself and emulating it is not a walk in the park.
> That does even more apply to the GICv3 and emulating a GICv2 on top of a
> hardware GICv3, for instance.
> 

Marc and I talked about that very feeling during KVM Forum.  I think we
could address some of that, sacrificing a bit of performance for reduced
state and less code, but overall yes, the GIC is complicated and
incompatible with regular humans.

-Christoffer

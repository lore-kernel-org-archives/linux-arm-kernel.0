From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 10 Nov 2014 14:24:38 +0100
Subject: [PATCH v3 18/19] arm/arm64: KVM: enable kernel side of GICv3
 emulation
In-Reply-To: <5460AD3D.5050008@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-19-git-send-email-andre.przywara@arm.com>
 <20141107160735.GT16132@cbox> <5460AD3D.5050008@arm.com>
Message-ID: <20141110132438.GD7544@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 12:19:09PM +0000, Andre Przywara wrote:
> Hej Christoffer,

  ^^^ Nice, Hej Andre,

> 
> On 07/11/14 16:07, Christoffer Dall wrote:
> > On Fri, Oct 31, 2014 at 05:26:53PM +0000, Andre Przywara wrote:
> >> With all the necessary GICv3 emulation code in place, we can now
> >> connect the code to the GICv3 backend in the kernel.
> >> The LR register handling is different depending on the emulated GIC
> >> model, so provide different implementations for each.
> >> Also allow non-v2-compatible GICv3 implementations (which don't
> >> provide MMIO regions for the virtual CPU interface in the DT), but
> >> restrict those hosts to use GICv3 guests only.
> > 
> > s/use/support/
> > 
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  virt/kvm/arm/vgic-v3.c |  168 ++++++++++++++++++++++++++++++++++++------------
> >>  virt/kvm/arm/vgic.c    |    4 ++
> >>  2 files changed, 130 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> >> index ce50918..c0e901c 100644
> >> --- a/virt/kvm/arm/vgic-v3.c
> >> +++ b/virt/kvm/arm/vgic-v3.c
> >> @@ -34,6 +34,7 @@
> >>  #define GICH_LR_VIRTUALID		(0x3ffUL << 0)
> >>  #define GICH_LR_PHYSID_CPUID_SHIFT	(10)
> >>  #define GICH_LR_PHYSID_CPUID		(7UL << GICH_LR_PHYSID_CPUID_SHIFT)
> >> +#define ICH_LR_VIRTUALID_MASK		(BIT_ULL(32) - 1)
> >>  
> >>  /*
> >>   * LRs are stored in reverse order in memory. make sure we index them
> >> @@ -43,7 +44,35 @@
> >>  
> >>  static u32 ich_vtr_el2;
> >>  
> >> -static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
> >> +static u64 sync_lr_val(u8 state)
> > 
> > is this lr_state_to_val ?
> > 
> >> +{
> >> +	u64 lr_val = 0;
> >> +
> >> +	if (state & LR_STATE_PENDING)
> >> +		lr_val |= ICH_LR_PENDING_BIT;
> >> +	if (state & LR_STATE_ACTIVE)
> >> +		lr_val |= ICH_LR_ACTIVE_BIT;
> >> +	if (state & LR_EOI_INT)
> >> +		lr_val |= ICH_LR_EOI;
> >> +
> >> +	return lr_val;
> >> +}
> >> +
> >> +static u8 sync_lr_state(u64 lr_val)
> > 
> > and lr_val_to_state ?
> > 
> > at least these sync names don't make much sense to me...
> > 
> >> +{
> >> +	u8 state = 0;
> >> +
> >> +	if (lr_val & ICH_LR_PENDING_BIT)
> >> +		state |= LR_STATE_PENDING;
> >> +	if (lr_val & ICH_LR_ACTIVE_BIT)
> >> +		state |= LR_STATE_ACTIVE;
> >> +	if (lr_val & ICH_LR_EOI)
> >> +		state |= LR_EOI_INT;
> >> +
> >> +	return state;
> >> +}
> >> +
> >> +static struct vgic_lr vgic_v2_on_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
> >>  {
> >>  	struct vgic_lr lr_desc;
> >>  	u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
> >> @@ -53,30 +82,53 @@ static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
> >>  		lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0x7;
> >>  	else
> >>  		lr_desc.source = 0;
> >> -	lr_desc.state	= 0;
> >> +	lr_desc.state	= sync_lr_state(val);
> >>  
> >> -	if (val & ICH_LR_PENDING_BIT)
> >> -		lr_desc.state |= LR_STATE_PENDING;
> >> -	if (val & ICH_LR_ACTIVE_BIT)
> >> -		lr_desc.state |= LR_STATE_ACTIVE;
> >> -	if (val & ICH_LR_EOI)
> >> -		lr_desc.state |= LR_EOI_INT;
> >> +	return lr_desc;
> >> +}
> >> +
> >> +static struct vgic_lr vgic_v3_on_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
> >> +{
> >> +	struct vgic_lr lr_desc;
> >> +	u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)];
> >> +
> >> +	lr_desc.irq	= val & ICH_LR_VIRTUALID_MASK;
> >> +	lr_desc.source	= 0;
> >> +	lr_desc.state	= sync_lr_state(val);
> >>  
> >>  	return lr_desc;
> >>  }
> >>  
> >> -static void vgic_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
> >> -			   struct vgic_lr lr_desc)
> >> +static void vgic_v3_on_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
> >> +				 struct vgic_lr lr_desc)
> >>  {
> >> -	u64 lr_val = (((u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT) |
> >> -		      lr_desc.irq);
> >> +	u64 lr_val;
> >>  
> >> -	if (lr_desc.state & LR_STATE_PENDING)
> >> -		lr_val |= ICH_LR_PENDING_BIT;
> >> -	if (lr_desc.state & LR_STATE_ACTIVE)
> >> -		lr_val |= ICH_LR_ACTIVE_BIT;
> >> -	if (lr_desc.state & LR_EOI_INT)
> >> -		lr_val |= ICH_LR_EOI;
> >> +	lr_val = lr_desc.irq;
> >> +
> >> +	/*
> >> +	 * currently all guest IRQs are Group1, as Group0 would result
> > 
> > Can you guess my comment here?
> > 
> >> +	 * in a FIQ in the guest, which it wouldn't expect.
> >> +	 * Eventually we want to make this configurable, so we may revisit
> >> +	 * this in the future.
> >> +	 */
> >> +	lr_val |= ICH_LR_GROUP;
> >> +
> >> +	lr_val |= sync_lr_val(lr_desc.state);
> >> +
> >> +	vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)] = lr_val;
> >> +}
> >> +
> >> +static void vgic_v2_on_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
> >> +				 struct vgic_lr lr_desc)
> >> +{
> >> +	u64 lr_val;
> >> +
> >> +	lr_val = lr_desc.irq;
> >> +
> >> +	lr_val |= (u32)lr_desc.source << GICH_LR_PHYSID_CPUID_SHIFT;
> >> +
> >> +	lr_val |= sync_lr_val(lr_desc.state);
> >>  
> >>  	vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[LR_INDEX(lr)] = lr_val;
> >>  }
> >> @@ -145,9 +197,8 @@ static void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
> >>  
> >>  static void vgic_v3_enable(struct kvm_vcpu *vcpu)
> >>  {
> >> -	struct vgic_v3_cpu_if *vgic_v3;
> >> +	struct vgic_v3_cpu_if *vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;
> >>  
> >> -	vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;
> > 
> > unnecessary change?
> > 
> >>  	/*
> >>  	 * By forcing VMCR to zero, the GIC will restore the binary
> >>  	 * points to their reset values. Anything else resets to zero
> 
> So most of the code above is gone now in this form due to the drop of
> init_emul and friends I did earlier last week due to your comments.
> So I will skip those comments for now (or better: try to translate them
> to the new code structure if possbile) and eagerly wait for them to
> reappear in a different form in the v4 comments ;-)

sounds good, I'll go hunt again in the v4 :)

> 
> >> @@ -155,7 +206,14 @@ static void vgic_v3_enable(struct kvm_vcpu *vcpu)
> >>  	 */
> >>  	vgic_v3->vgic_vmcr = 0;
> >>  
> >> -	vgic_v3->vgic_sre = 0;
> >> +	/*
> >> +	 * Set the SRE_EL1 value depending on the configured
> >> +	 * emulated vGIC model.
> >> +	 */
> >> +	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
> >> +		vgic_v3->vgic_sre = ICC_SRE_EL1_SRE;
> > 
> > If we're on hardware with the GICv2 backwards compatibility can the
> > guest not actually set ICC_SRE_EL1_SRE to 0 but then we are not
> > preserving this because we wouldn't be trapping such accesses anymore?
> > 
> > Also, this is really about the reset value of that field, which the
> > comment above is not being specific about.
> > 
> > Further, that would mean that the field is NOT actually RAO/WI, and thus
> > the spec dictates that the field should reset to zero if EL1 is the
> > highest implemented exception level and the field is not RAO/WI, which
> > is what the guest expects, no?
> 
> I am still thinking about this (because it is probably true). Need to
> discuss with Marc what we can do about this.
> 

Kudos for understanding my cryptic comment.

-Christoffer

From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 19 Jul 2018 22:56:53 +0200
Subject: [PATCH v4 03/10] KVM: arm/arm64: vgic: GICv2 IGROUPR should read
 as zero
In-Reply-To: <20180719181636.mtlxhyrxtsweio2y@kamzik.brq.redhat.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-4-git-send-email-christoffer.dall@arm.com>
 <20180719181636.mtlxhyrxtsweio2y@kamzik.brq.redhat.com>
Message-ID: <20180719205653.GA6399@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 08:16:36PM +0200, Andrew Jones wrote:
> On Mon, Jul 16, 2018 at 03:06:20PM +0200, Christoffer Dall wrote:
> > We currently don't support grouping in the emulated VGIC, which is a
> > known defect on KVM (not hurting any currently used guests as far as
> > we're aware). This is currently handled by treating all interrupts as
> > group 0 interrupts for an emulated GICv2 and always signaling interrupts
> > as group 0 to the virtual CPU interface.
> > 
> > However, when reading which group interrupts belongs to in the guest
> > from the emulated VGIC, the VGIC currently reports group 1 instead of
> > group 0, which is misleading.  Fix this temporarily before introducing
> > full group support by changing the hander to _raz instead of _rao.
> > 
> > Fixes: fb848db39661a "KVM: arm/arm64: vgic-new: Add GICv2 MMIO handling framework"
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > ---
> >  virt/kvm/arm/vgic/vgic-init.c    | 2 +-
> >  virt/kvm/arm/vgic/vgic-mmio-v2.c | 8 +++++++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> > index 8b6fc45..230c922 100644
> > --- a/virt/kvm/arm/vgic/vgic-init.c
> > +++ b/virt/kvm/arm/vgic/vgic-init.c
> > @@ -298,7 +298,7 @@ int vgic_init(struct kvm *kvm)
> >  
> >  	vgic_debug_init(kvm);
> >  
> > -	dist->implementation_rev = 0;
> > +	dist->implementation_rev = 1;
> >  	dist->initialized = true;
> >  
> >  out:
> > diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > index f0c5351..db646f1 100644
> > --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> > @@ -22,6 +22,12 @@
> >  #include "vgic.h"
> >  #include "vgic-mmio.h"
> >  
> > +/*
> > + * The Revision field in the IIDR have the following meanings:
> > + *
> > + * Revision 1: Report GICv2 interrupts as group 0 instead of group 1
> > + */
> > +
> >  static unsigned long vgic_mmio_read_v2_misc(struct kvm_vcpu *vcpu,
> >  					    gpa_t addr, unsigned int len)
> >  {
> > @@ -365,7 +371,7 @@ static const struct vgic_register_region vgic_v2_dist_registers[] = {
> >  		vgic_mmio_read_v2_misc, vgic_mmio_write_v2_misc, 12,
> >  		VGIC_ACCESS_32bit),
> >  	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_IGROUP,
> > -		vgic_mmio_read_rao, vgic_mmio_write_wi, NULL, NULL, 1,
> > +		vgic_mmio_read_raz, vgic_mmio_write_wi, NULL, NULL, 1,
> >  		VGIC_ACCESS_32bit),
> >  	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ENABLE_SET,
> >  		vgic_mmio_read_enable, vgic_mmio_write_senable, NULL, NULL, 1,
> > -- 
> > 2.7.4
> >
> 
> I realize that this is fixing the emulation, so any guest that would find
> this change a problem is broken, but guest-visible changes without user
> consent always seem a bit wrong.
> 
> We could drop this patch and only allow gicv2 guests to read ones from the
> IGROUP registers until v2_groups_user_writable is true. Then, if a broken
> guest needs to run on a host with an updated kernel, userspace, which must
> have been updated too, can give the guest the broken group view it needs.

That won't really help because those interrupts will no longer be
injected as IRQs, but as FIQs, which is also a departure from what the
guest expects.

> 
> That said, I'm not overly concerned about this guest-visible issue. So

Any guests relying on this broken behavior will not run on hardwre, so
I'm not going to change this.

> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks!
-Christoffer

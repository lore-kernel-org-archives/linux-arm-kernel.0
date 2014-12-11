From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Dec 2014 12:48:39 +0100
Subject: [PATCH 3/5] arm/arm64: KVM: Add (new) vgic_initialized macro
In-Reply-To: <54882016.2080200@linaro.org>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-4-git-send-email-christoffer.dall@linaro.org>
 <54882016.2080200@linaro.org>
Message-ID: <20141211114839.GD28388@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 11:27:34AM +0100, Eric Auger wrote:
> 
> On 12/09/2014 04:44 PM, Christoffer Dall wrote:
> > Some code paths will need to check to see if the internal state of the
> > vgic has been initialized (such as when creating new VCPUs), so
> > introduce such a macro that checks the nr_cpus field which is set when
> > the vgic has been initialized.
> > 
> > Also set nr_cpus = 0 in kvm_vgic_destroy, because the error path in
> > vgic_init() will call this function, and code should never errornously
> > assume the vgic to be properly initialized after an error.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  include/kvm/arm_vgic.h | 6 ++++++
> >  virt/kvm/arm/vgic.c    | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> > index 3e262b9..ac4888d 100644
> > --- a/include/kvm/arm_vgic.h
> > +++ b/include/kvm/arm_vgic.h
> > @@ -287,6 +287,7 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >  		      struct kvm_exit_mmio *mmio);
> >  
> >  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
> > +#define vgic_initialized(k)	(!!((k)->arch.vgic.nr_cpus))
> >  #define vgic_ready(k)		((k)->arch.vgic.ready)
> >  
> >  int vgic_v2_probe(struct device_node *vgic_node,
> > @@ -369,6 +370,11 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
> >  	return 0;
> >  }
> >  
> > +static inline bool vgic_initialized(struct kvm *kvm)
> > +{
> > +	return true;
> > +}
> > +
> >  static inline bool vgic_ready(struct kvm *kvm)
> >  {
> >  	return true;
> > diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> > index 6293349..c98cc6b 100644
> > --- a/virt/kvm/arm/vgic.c
> > +++ b/virt/kvm/arm/vgic.c
> > @@ -1774,6 +1774,7 @@ void kvm_vgic_destroy(struct kvm *kvm)
> >  	dist->irq_spi_cpu = NULL;
> >  	dist->irq_spi_target = NULL;
> >  	dist->irq_pending_on_cpu = NULL;
> > +	dist->nr_cpus = 0;
> Reviewed-by: Eric Auger <eric.auger@linaro.org>
> we could use that new vgic_initialized at the entry of vgic_init instead
> of testing dist->nr_cpus, hence introducing one user.
> 
Yeah, we could, I can fix that up when applying/respinning.

Thanks,
-Christoffer

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 14 Mar 2014 12:09:39 -0700
Subject: [PATCH] KVM: ARM: vgic: plug irq injection race
In-Reply-To: <86d2horgh5.fsf@arm.com>
References: <1392388086-24730-1-git-send-email-marc.zyngier@arm.com>
 <20140314042052.GH24808@cbox> <86d2horgh5.fsf@arm.com>
Message-ID: <20140314190939.GE28661@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 02:40:22PM +0000, Marc Zyngier wrote:
> On Fri, Mar 14 2014 at 04:20:52 AM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Fri, Feb 14, 2014 at 02:28:06PM +0000, Marc Zyngier wrote:
> >> As it stands, nothing prevents userspace from injecting an interrupt
> >> before the guest's GIC is actually initialized.
> >> 
> >> This goes unnoticed so far (as everything is pretty much statically
> >> allocated), but ends up exploding in a spectacular way once we switch
> >> to a more dynamic allocation (the GIC data structure isn't there yet).
> >> 
> >> The fix is to test for the "ready" flag in the VGIC distributor before
> >> trying to inject the interrupt. Note that in order to avoid breaking
> >> userspace, we have to ignore what is essentially an error.
> >> 
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  virt/kvm/arm/vgic.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >> index be456ce..d40fe61 100644
> >> --- a/virt/kvm/arm/vgic.c
> >> +++ b/virt/kvm/arm/vgic.c
> >> @@ -1386,7 +1386,8 @@ out:
> >>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
> >>  			bool level)
> >>  {
> >> -	if (vgic_update_irq_state(kvm, cpuid, irq_num, level))
> >> +	if (likely(vgic_initialized(kvm)) &&
> >
> > Do we need a barrier in kvm_vgic_init before setting the
> > kvm->arch.vgic.ready to ensure we observe the correctly initialized
> > values of the irq_spi_cpu field here?
> 
> Ah, I see. Yes, possibly.
> 
You can probably just mode the assignment of ready=true below the
critical section and you should be good, right?

Thanks,
-Christoffer

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Dec 2014 12:55:16 +0100
Subject: [PATCH 4/5] arm/arm64: KVM: Don't allow creating VCPUs after
 vgic_initialized
In-Reply-To: <54883DFC.4060001@linaro.org>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-5-git-send-email-christoffer.dall@linaro.org>
 <54883DFC.4060001@linaro.org>
Message-ID: <20141211115516.GE28388@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 01:35:08PM +0100, Eric Auger wrote:
> On 12/09/2014 04:44 PM, Christoffer Dall wrote:
> > When the vgic initializes its internal state it does so based on the
> > number of VCPUs available at the time.  If we allow KVM to create more
> > VCPUs after the VGIC has been initialized, we are likely to error out in
> > unfortunate ways later, perform buffer overflows etc.
> > 
> > Cc: Eric Auger <eric.auger@linaro.org>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> > This replaces Eric Auger's previous patch
> > (https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012646.html),
> > because it fits better with testing to include it in this series and I
> > realized that we need to add a check against irqchip_in_kernel() as
> > well.
> > 
> >  arch/arm/kvm/arm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> > index a9d005f..d4da244 100644
> > --- a/arch/arm/kvm/arm.c
> > +++ b/arch/arm/kvm/arm.c
> > @@ -213,6 +213,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
> >  	int err;
> >  	struct kvm_vcpu *vcpu;
> >  
> > +	if (irqchip_in_kernel(kvm) && vgic_initialized(kvm)) {
> Reviewed-by: Eric Auger <eric.auger@linaro.org>
> a question about that irqchip_in_kernel(kvm):
> kvm->arch.vgic.in_kernel is set in kvm_vgic_create but nobody resets it,
> especially in destroy, am i wrong?

no, because we don't allow creating a vgic in the kernel for a VM and
then letting the VM go back to having a userspace driven gic.

> if the vgic is initialized shouldn't it be also created? Shouldn't we
> test irqchip_in_kernel in vgic_init instead?

no, vgic_init will never be called if you didn't create a vgic, and
irqchip_in_kernel() should always return false in that case.

If you can find a flow where this breaks, please let me know, because
then it's a bug, but it looks right to me.

> Also in case we need irqchip_in_kernel(kvm) here we might need it also
> in kvm_vgic_inject_irq because dist->lock is grabbed in
> vgic_update_irq_pending.
> 
Huh, you're right about that.  In fact, I don't think we should allow
initializing the arch timers if userspace didn't create an in-kernel
irqchip, avoiding the call path alltogether.

We probaby need to add that to this series.

Unless I missed something obvious here: Nice catch!

Thanks,
-Christoffer

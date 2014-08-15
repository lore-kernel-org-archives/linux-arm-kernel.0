From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 15 Aug 2014 11:45:49 +0200
Subject: [PATCH 2/6] arm/arm64: KVM: Rename irq_active to irq_queued
In-Reply-To: <87mwb7s1qz.fsf@approximate.cambridge.arm.com>
References: <1405003196-12403-1-git-send-email-christoffer.dall@linaro.org>
 <1405003196-12403-3-git-send-email-christoffer.dall@linaro.org>
 <87mwb7s1qz.fsf@approximate.cambridge.arm.com>
Message-ID: <20140815094549.GU10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 01:18:44PM +0100, Marc Zyngier wrote:
> Hi Christoffer,
> 
> On Thu, Jul 10 2014 at  3:39:52 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > We have a special bitmap on the distributor struct to keep track of when
> > level-triggered interrupts are queued on the list registers.  This was
> > named irq_active, which is confusing, because the active state of an
> > interrupt as per the GIC spec is a different thing, not specifically
> > related to edge-triggered/level-triggered configurations but rather
> > indicates an interrupt which has been ack'ed but not yet eoi'ed.
> >
> > Rename the bitmap and the corresponding accessor functions to irq_queued
> > to clarify what this is actually used for.
> >
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> So to illustrate what I was going on about the first time you summitted
> this patch, have a look at my below take on this. It is basically yours,
> but just with the bitmap named "irq_can_sample", which is exactly what
> this bitmap is about.
> 
> What do you think?

I find this more difficult to understand, because it prompts me to ask
the question in my head "why is it that we forbid sampling of the irq
line in some situations, and when is it that we set that bit?".

What I tried to say with my "irq_queued" suggestion is simply "the irq
in now on a LR, so wait until we hear something else from that LR before
we consider the external input again, so "level_irq_on_lr" as another
suggestion would precisely indicate when this bit is set or not,
regardless of having a true understanding of how the hardware works and
how we emulate it.

Maybe I have two neurons that need help to conenct with each other to
understand the can_sample stuff.

Grumble grumble....

[...]

> @@ -1429,7 +1429,7 @@ static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
>  		goto out;
>  	}
>  
> -	if (is_level && vgic_irq_is_active(vcpu, irq_num)) {
> +	if (is_level && !vgic_irq_can_sample(vcpu, irq_num)) {
>  		/*
>  		 * Level interrupt in progress, will be picked up
>  		 * when EOId.
> @@ -1506,6 +1506,9 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  		if (i < VGIC_NR_PRIVATE_IRQS)
>  			vgic_bitmap_set_irq_val(&dist->irq_cfg,
>  						vcpu->vcpu_id, i, VGIC_CFG_EDGE);
> +		/* Let vcpu0 also allow sampling of SPIs */

huh, what does this comment mean?  Isn't the vcpu_id == 0 thingy above
to catch all SPIs, not related specifically to vcpu0 and just to avoid
setting the same bits in the shared bitmap for all vcpus?

> +		if (i < VGIC_NR_PRIVATE_IRQS || vcpu->vcpu_id == 0)
> +			vgic_irq_allow_sample(vcpu, i);
>  
>  		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
>  	}
> -- 
> 2.0.0
> 
> 
> -- 
> Jazz is not dead. It just smells funny.

Thanks :)
-Christoffer

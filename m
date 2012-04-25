From: neilb@suse.de (NeilBrown)
Date: Thu, 26 Apr 2012 07:04:07 +1000
Subject: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice
 level-triggered interrupts.
In-Reply-To: <alpine.LFD.2.02.1204251402360.2542@ionos>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.85239.stgit@notabene.brown>
 <alpine.LFD.2.02.1204251018530.2542@ionos>
 <20120425193916.0db1b4b1@notabene.brown>
 <alpine.LFD.2.02.1204251402360.2542@ionos>
Message-ID: <20120426070407.7646fb66@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Apr 2012 14:54:54 +0200 (CEST) Thomas Gleixner
<tglx@linutronix.de> wrote:

> On Wed, 25 Apr 2012, NeilBrown wrote:
> > On Wed, 25 Apr 2012 10:50:15 +0200 (CEST) Thomas Gleixner
> > <tglx@linutronix.de> wrote:
> > 
> > > On Wed, 25 Apr 2012, NeilBrown wrote:
> > > 
> > > > Level triggered interrupts do not cause IRQS_PENDING to be set, so
> > > > check_wakeup_irqs ignores them.
> > > > They don't need to set IRQS_PENDING as the level stays high which
> > > > shows that they must be pending.  However if such an interrupt fired
> > > > during late suspend, it will have been masked so the fact that it
> > > > is still asserted will not cause the suspend to abort.
> > > > 
> > > > So if any wakeup interrupt is masked, unmask it when checking wakeup
> > > > irqs.  If the interrupt is asserted, suspend will abort.
> > > > 
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > > 
> > > >  kernel/irq/pm.c |    6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > > > index 15e53b1..0d26206 100644
> > > > --- a/kernel/irq/pm.c
> > > > +++ b/kernel/irq/pm.c
> > > > @@ -106,6 +106,12 @@ int check_wakeup_irqs(void)
> > > >  		if (irqd_is_wakeup_set(&desc->irq_data)) {
> > > >  			if (desc->istate & IRQS_PENDING)
> > > >  				return -EBUSY;
> > > > +			if (irqd_irq_masked(&desc->irq_data))
> > > > +				/* Probably a level interrupt
> > > > +				 * which fired recently and was
> > > > +				 * masked
> > > > +				 */
> > > > +				unmask_irq(desc);
> > > 
> > > Oh no. We don't unmask unconditionally. What about an interrupt which
> > > is disabled, has no handler ..... ? That needs more thought.
> > 
> > If there is no handler, then irqd_is_wakeup_set() should fail should it not?
> 
> Well, it does not. The wakeup state is a permanent flag on the irq
> line. Though we don't have IRQS_SUSPENDED on that descriptor.
>  
> > For disabled: would it be OK to check desc->depth?
> > Something like:
> >      if (desc->depth == 1 && (desc->state & IRQS_SUSPENDED) &&
> >          irqd_irq_masked(&desc->irq_data))
> >               unmask_irq(desc);
> > 
> 
> Why not simply managing the pending bit for level irqs ?

Primarily because I was aiming for the simplest patch that would have the
desired effect.  Also because 'pending' is implicit in the level so it seems
superfluous to store the bit separately.  And understanding all the
consequences of that change is not something I felt up to.

However: thanks for the patch. I'll try to explore it tomorrow and see if
seems to be behaving correctly.

Thanks,
NeilBrown

> 
> Index: tip/kernel/irq/chip.c
> ===================================================================
> --- tip.orig/kernel/irq/chip.c
> +++ tip/kernel/irq/chip.c
> @@ -379,8 +379,10 @@ handle_level_irq(unsigned int irq, struc
>  	 * If its disabled or no action available
>  	 * keep it masked and get out of here
>  	 */
> -	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data)))
> +	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
> +		desc->istate |= IRQS_PENDING;
>  		goto out_unlock;
> +	}
>  
>  	handle_irq_event(desc);
>  
> Index: tip/kernel/irq/resend.c
> ===================================================================
> --- tip.orig/kernel/irq/resend.c
> +++ tip/kernel/irq/resend.c
> @@ -58,10 +58,13 @@ void check_irq_resend(struct irq_desc *d
>  	/*
>  	 * We do not resend level type interrupts. Level type
>  	 * interrupts are resent by hardware when they are still
> -	 * active.
> +	 * active. Clear the pending bit so suspend/resume does not
> +	 * get confused.
>  	 */
> -	if (irq_settings_is_level(desc))
> +	if (irq_settings_is_level(desc)) {
> +		desc->istate &= ~IRQS_PENDING;
>  		return;
> +	}
>  	if (desc->istate & IRQS_REPLAY)
>  		return;
>  	if (desc->istate & IRQS_PENDING) {
> 
> And to handle interrupts which have been disabled before suspend add:
> 
> Index: tip/kernel/irq/pm.c
> ===================================================================
> --- tip.orig/kernel/irq/pm.c
> +++ tip/kernel/irq/pm.c
> @@ -103,7 +103,8 @@ int check_wakeup_irqs(void)
>  	int irq;
>  
>  	for_each_irq_desc(irq, desc) {
> -		if (irqd_is_wakeup_set(&desc->irq_data)) {
> +		if (desc->depth == 1 &&
> +		    irqd_is_wakeup_set(&desc->irq_data)) {
>  			if (desc->istate & IRQS_PENDING)
>  				return -EBUSY;
>  			continue;

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120426/729f0202/attachment.sig>

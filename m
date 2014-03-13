From: carlo@caione.org (Carlo Caione)
Date: Thu, 13 Mar 2014 10:56:57 +0100
Subject: [linux-sunxi] Re: [PATCH v2 4/4] irqchip: sun4i: Use
 handle_fasteoi_late_irq for the ENMI (irq 0)
In-Reply-To: <20140313093457.GF2815@lukather>
References: <1394644627-12315-1-git-send-email-hdegoede@redhat.com>
 <1394644627-12315-5-git-send-email-hdegoede@redhat.com>
 <20140313093457.GF2815@lukather>
Message-ID: <20140313095657.GA32357@localhost.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:34:57AM +0100, Maxime Ripard wrote:
> On Wed, Mar 12, 2014 at 06:17:07PM +0100, Hans de Goede wrote:
> > The ENMI needs to have the ack done *after* clearing the interrupt source,
> > otherwise we will get a spurious interrupt for each real interrupt. Switch
> > to the new handle_fasteoi_late_irq handler which gives us the desired behavior.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/irqchip/irq-sun4i.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> > index 8a2fbee..4b1c874 100644
> > --- a/drivers/irqchip/irq-sun4i.c
> > +++ b/drivers/irqchip/irq-sun4i.c
> > @@ -77,15 +77,22 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
> >  static struct irq_chip sun4i_irq_chip = {
> >  	.name		= "sun4i_irq",
> >  	.irq_ack	= sun4i_irq_ack,
> > +	.irq_eoi	= sun4i_irq_ack, /* For the ENMI */
> 
> Hmmm, I wonder if that actually does something.
> 
> There's been a patch floating around that I was sure was merged, but
> apparently wasn't that remove sun4i_irq_ack, because the register we
> were writing to are in read only, and it wasn't doing anything.
> 
> >  	.irq_mask	= sun4i_irq_mask,
> >  	.irq_unmask	= sun4i_irq_unmask,
> > +	.flags		= IRQCHIP_EOI_THREADED, /* Only affects the ENMI */
> >  };
> >  
> >  static int sun4i_irq_map(struct irq_domain *d, unsigned int virq,
> >  			 irq_hw_number_t hw)
> >  {
> > -	irq_set_chip_and_handler(virq, &sun4i_irq_chip,
> > -				 handle_level_irq);
> > +	if (hw == 0) /* IRQ 0, the ENMI needs special handling */
> > +		irq_set_chip_and_handler(virq, &sun4i_irq_chip,
> > +					 handle_fasteoi_late_irq);
> > +	else
> > +		irq_set_chip_and_handler(virq, &sun4i_irq_chip,
> > +					 handle_level_irq);
> > +
> >  	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
> 
> Could that solve the other NMI-related issue we have with Carlo's
> patches?

Yes, I think that the issue is the same. I'll submit a new revision for
the irqchip patchset soon.
The only thing that it is not clear to me is whether the problem is
still there for the NMI controller also for edge-triggered interrupts or
not (hard to verify it experimentally).

Regards,

-- 
Carlo Caione

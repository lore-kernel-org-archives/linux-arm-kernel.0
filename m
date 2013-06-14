From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 14 Jun 2013 23:00:30 +0100
Subject: [PATCH] of: irq: Pass trigger type in IRQ resource flags
In-Reply-To: <54821523.hBKS2L2vLj@flatron>
References: <1368917790-23770-1-git-send-email-tomasz.figa@gmail.com>
 <54821523.hBKS2L2vLj@flatron>
Message-ID: <20130614220030.82ECF3E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Jun 2013 20:20:39 +0200, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
> 
> On Sunday 19 of May 2013 00:56:30 Tomasz Figa wrote:
> > Some drivers might rely on availability of trigger flags in IRQ
> > resource, for example to configure the hardware for particular interrupt
> > type. However current code creating IRQ resources from data in device
> > tree does not configure trigger flags in resulting resources.
> > 
> > This patch solves the problem, based on the fact that
> > irq_of_parse_and_map() configures the trigger based on DT interrupt
> > specifier, IRQD_TRIGGER_* flags are consistent with IORESOURCE_IRQ_*,
> > and we can get trigger type by calling irqd_get_trigger_type() after
> > mapping the interrupt.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> >  drivers/of/irq.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index a3c1c5a..79a7a26 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -355,6 +355,16 @@ int of_irq_to_resource(struct device_node *dev, int
> > index, struct resource *r) r->start = r->end = irq;
> >  		r->flags = IORESOURCE_IRQ;
> >  		r->name = name ? name : dev->full_name;
> > +
> > +		/*
> > +		 * Some drivers might rely on availability of trigger 
> flags
> > +		 * in IRQ resource. Since irq_of_parse_and_map() 
> configures the
> > +		 * trigger based on interrupt specifier and IRQD_TRIGGER_*
> > +		 * flags are consistent with IORESOURCE_IRQ_*, we can get
> > +		 * trigger type that was just set and pass it through 
> resource
> > +		 * flags as well.
> > +		 */
> > +		r->flags |= irqd_get_trigger_type(irq_get_irq_data(irq));
> >  	}
> > 
> >  	return irq;
> 
> Any comments on this patch?

That's actually a pretty good solution and a whole lot less invasive
that the approach that Javier was pursuing. Javier, I'm going to pick
up this patch. Please yell if it doesn't solve the problem that you're
trying to solve.

g.

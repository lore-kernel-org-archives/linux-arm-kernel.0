From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 4 May 2013 10:04:32 +0200 (CEST)
Subject: [RFC patch 7/8] genirq: generic chip: Add linear irq domain
 support
In-Reply-To: <518472C4.5080209@gmail.com>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
 <20130503214629.810207749@linutronix.de> <518472C4.5080209@gmail.com>
Message-ID: <alpine.LFD.2.02.1305040959060.8869@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 May 2013, Sebastian Hesselbarth wrote:

> On 05/03/2013 11:50 PM, Thomas Gleixner wrote:
> > Provide infrastructure for irq chip implementations which work on
> > linear irq domains.
> 
> Thomas,
> 
> I am happy that I put you into rant mode. It took me little more
> than an hour to read through your patches, prepare orion irqchip
> driver on top of them and finally got it working.

Cool.
 
> Anyway, I found some more issues.

That was expected. :)

> > +	for (i = 0; i < numchips; i++, gc++) {
> 
> The memory you allocated for gc, num_ct * ct, and dgc doesn't allow
> to increment through gc. gc is struct irq_chip_generic * but next
> gc is at sizeof(*gc) + num_ct * sizeof(struct irq_chip_type).
> This also affects indexing dgc->gc later.

Indeed.
 
> I chose to fix it by having an index helper but that first maps
> dgc-gc to unsigned char * and then adds the correct offset. Not

void * is the preferred over uchar *

> nice but it works. Maybe having real array of ptr to gc is more
> intuitive here even if we will have to have split kzallocs.

No, you still can have a single kzalloc. It's just a matter of setting
the pointers correctly.

> > +		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
> > +				      NULL, handler);
> 
> irq_init_generic_chip does not take care of initalizing ct
> mask_cache ptr. This should be done here.

Right.
 
> > +		gc->domain = d;
> > +		raw_spin_lock_irqsave(&gc_lock, flags);
> > +		list_add_tail(&gc->list, &gc_list);
> > +		raw_spin_unlock_irqrestore(&gc_lock, flags);
> > +	}
> > +	d->gc = dgc;
> 
> Moving this assignment above the for loop allows to get
> gc by index as indexing helper relies on domain, not domain
> generic chip.
> 
> You want me to prepare patches for the above? Maybe you can

That'd be nice.

> split your RFC into 1-6 and 7-8. Then you can have 1-6 applied
> independently of irq_domain_generic_chip stuff.

> Thanks for the RFC again!

Welcome. Have fun!

	 tglx

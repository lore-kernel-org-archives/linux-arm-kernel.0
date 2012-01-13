From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 13 Jan 2012 14:00:41 -0700
Subject: [PATCH 1/2] versatile: sic: add device tree bindings
In-Reply-To: <20120113103554.GE14007@page>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
 <1326415441-17695-2-git-send-email-jamie@jamieiles.com>
 <20120113022932.GB25999@ponder.secretlab.ca>
 <20120113103554.GE14007@page>
Message-ID: <20120113210041.GD22767@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:35:54AM +0000, Jamie Iles wrote:
> On Thu, Jan 12, 2012 at 07:29:32PM -0700, Grant Likely wrote:
> > On Fri, Jan 13, 2012 at 12:44:00AM +0000, Jamie Iles wrote:
> > > @@ -53,6 +59,10 @@ void __init fpga_irq_init(int parent_irq, u32 
> > > valid, struct fpga_irq_data *f)
> > >  	f->chip.irq_ack = fpga_irq_mask;
> > >  	f->chip.irq_mask = fpga_irq_mask;
> > >  	f->chip.irq_unmask = fpga_irq_unmask;
> > > +	f->domain.irq_base = f->irq_start;
> > > +	f->domain.nr_irq = 32;
> > > +	f->domain.ops = &irq_domain_simple_ops;
> > > +	irq_domain_add(&f->domain);
> > >  
> > >  	if (parent_irq != -1) {
> > >  		irq_set_handler_data(parent_irq, f);
> > > @@ -70,3 +80,40 @@ void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
> > >  		}
> > >  	}
> > >  }
> > 
> > There is a loop in fpga_irq_init() that sets up all the irqs, but with
> > the introduction of the full irq_domain, that can be moved out to the
> > .map irq_domain ops function.  The irq_domain will call it to set up
> > each irq when it is requested.
> 
> That's not quite working for me - I have the following .map() function:
> 
> static int sic_irq_map(struct irq_domain *d, unsigned int virq,
> 		       irq_hw_number_t hw)
> {
> 	struct fpga_irq_data *f = d->host_data;
> 
> 	irq_set_chip_data(virq, f);
> 	irq_set_chip_and_handler(virq, &f->chip, handle_level_irq);
> 	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
> 
> 	return 0;
> }
> 
> but when irq_domain_add_legacy() iterates over the irq's I haven't had 
> chance to set the host_data.  The patch below works for me, not sure 
> what you think.

Let me look at it a bit.  You can leave the initialization loop in
fpga_irq_init() for now.  I'm looking at adding a mask field to
irq_domain_add_legacy in addition to the host_data pointer.  I also
want to investigate replacing fpga_irq with generic-chip.c.  The
problem I've currently got though is that irq_domain_add_legacy() can
currently support any number of irqs, but adding a simple mask
argument will limit it to 32.  That won't work for large irq
controllers like the gic.

g.

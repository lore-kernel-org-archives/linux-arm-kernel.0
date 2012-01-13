From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 Jan 2012 10:58:34 +0000
Subject: [PATCH 1/2] versatile: sic: add device tree bindings
In-Reply-To: <20120113104842.GS1068@n2100.arm.linux.org.uk>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
 <1326415441-17695-2-git-send-email-jamie@jamieiles.com>
 <20120113104842.GS1068@n2100.arm.linux.org.uk>
Message-ID: <20120113105834.GF14007@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:48:42AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 13, 2012 at 12:44:00AM +0000, Jamie Iles wrote:
> > +#ifdef CONFIG_OF
> > +int __init sic_of_init(struct device_node *np, struct device_node *parent)
> > +{
> > +	struct fpga_irq_data *sic_data = kzalloc(sizeof(*sic_data), GFP_KERNEL);
> > +	int err = -ENOMEM, irq;
> > +
> > +	if (WARN_ON(!sic_data))
> > +		return err;
> > +
> > +	sic_data->base = of_iomap(np, 0);
> > +	if (WARN_ON(!sic_data->base))
> > +		goto out_free_data;
> > +
> > +	irq = irq_of_parse_and_map(np, 0);
> > +	if (irq < 0)
> > +		goto out_free_data;
> > +
> > +	sic_data->irq_start = irq_alloc_descs(-1, 0, 32, numa_node_id());
> > +	if (WARN_ON(sic_data->irq_start < 0)) {
> > +		err = sic_data->irq_start;
> > +		goto out_unmap;
> > +	}
> > +	sic_data->domain.of_node = of_node_get(np);
> > +
> > +	fpga_irq_init(irq, ~0, sic_data);
> 
> I notice that you completely ignore the validity mask, and initialize all
> 32 interrupts.  This is wrong.  You don't think I put the validity mask
> there just to obfuscate the code?

OK, that is wrong.  The validity mask is used for the non-DT platforms, 
for the DT one I'll add a property stating the valid mask:

	arm,valid-irq-mask = <0x001fffff>;

to the node in the trees.

> And this shouldn't be called 'sic' at all.  It may be the secondary
> interrupt controller on the Versatile, but it's also the PIC, SIC and
> CIC on Integrator platforms.  Calling anything in this file (which is
> entirely separate of any platform) 'sic' is _wrong_.

OK, I didn't know that.  So fpga-irq is an appropriate name (is it 
always an FPGA?) and arm,versatile-fpga-irq OK for a compatible string?

Jamie

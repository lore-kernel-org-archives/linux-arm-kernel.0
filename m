From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Aug 2014 14:23:48 +0200 (CEST)
Subject: [RESEND PATCH v2 1/4] irqchip: gic: Change irq type check when
 extension is present
In-Reply-To: <53FDB4B3.6000400@arm.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
 <53F724F5.3040004@arm.com>
 <1409133344.25382.37.camel@coredoba.hi.pengutronix.de>
 <53FDB4B3.6000400@arm.com>
Message-ID: <alpine.DEB.2.10.1408271347210.3323@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Aug 2014, Marc Zyngier wrote:
> > As in the DT the actual IRQ polarity should be used, simply configuring
> > the HW IRQ polarity in the bootloader is not enough without telling the
> > GIC driver which polarity is supported on which IRQ, right?
> 
> Looking a bit closer at things, what you describe in DT is the IRQ
> polarity the interrupt controller sees. Nothing else should interpret
> that field.
> 
> So it is legal (IMO) to have a device with an interrupt specifier
> describing a rising edge interrupt, and yet have the device generating a
> falling edge, with Mediatek's special sauce doing the conversion in between.
> 
> Something will have to configure the polarity widget though, but that
> can be left outside of the GIC.

This seems to become a popular topic and it looks like the whole GIC
extension thing is going to explode sooner than later.

We are currently discussing hierarchical irq domains to solve a
different issue in x86 land. See the related discussion here:

	  https://lkml.org/lkml/2014/8/1/67

Now looking at these GIC plus extra sauce problems, I wonder whether
this wouldn't be solvable in a similar way. If you look at it from the
HW perspective you have:

   ---------      ---------
---| MAGIC |------|ARM GIC|
---|       |------|       |
---|       |------|       |
---|       |------|       |
---|       |------|       |
   ---------      ---------

The MAGIC interrupt controller only provides functionality which is
not available from the ARM architected GIC but maps 1:1 to the ARM GIC
interrupt lines. So it looks like a variation to the more dynamic
mapping of MSI -> Remap -> CPU-Vector problem we need to solve on x86.

The idea is to have two irq domains: magic_domain and armgic_domain.

The magic_domain is the frontend facing the devices and the
armgic_domain is the parent domain. This is also reflected in
hierarchical data structures, i.e. irq_desc->irq_data will get a new
field parent_data, which points to the irq_data of the parent
interrupt controller, which is allocated separately when the interrupt
line is instantiated.

So in the above case the hotpath ack/eoi functions of the irq chip
associated to the device interrupt, i.e. magic_chip, would do:

irq_ack(struct irq_data *d)
{
	struct irq_data *pd = d->parent_data;

	pd->chip->irq_ack(pd);
}

Granted, that's another level of indirection, but this is going to be
more efficient than a boatload of conditional hooks in the GIC code
proper. Not to talk about the maintainability of the whole maze.

The irq_set_type() function would do:

irq_set_type(struct irq_data *d, int type)
{
	struct irq_data *pd = d->parent_data;

	gic_type = set_magic_chip_type(d, type);

	return pd->chip->irq_set_type(d, gic_type);
}

Switching to this allows to completely avoid the gazillion of hooks in
the gic code and should work nicely with multiplatform kernels by
simpling hooking up the domain parent relation ship to the proper
magic domain or leave the armgic as the direct device interface in
case the SoC does not have the magic chip in front of the arm gic.

Thoughts?

Thanks,

	tglx

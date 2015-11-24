From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Nov 2015 17:38:51 +0000
Subject: [PATCH 1/4] bus: uniphier-system-bus: add UniPhier System Bus
 Controller driver
In-Reply-To: <CAK7LNAR_6qwVK9fNEAX-L_v1Z5cdGMU33bP75Rdtu5bdmid-3Q@mail.gmail.com>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
 <1448357962-12259-2-git-send-email-yamada.masahiro@socionext.com>
 <20151124115053.GB4108@leverpostej>
 <CAK7LNAR_6qwVK9fNEAX-L_v1Z5cdGMU33bP75Rdtu5bdmid-3Q@mail.gmail.com>
Message-ID: <20151124173850.GC8468@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >> +UniPhier System Bus Controller
> >> +------------------------------
> >> +
> >> +The UniPhier System Bus Controller is a hardware block with registers that
> >> +controls the System Bus accessing; how each bank is mapped onto the parent bus,
> >> +various timing parameters of the bus access, etc.
> >> +
> >> +Required properties for System Bus Controller:
> >> +- compatible: should be "socionext,uniphier-system-bus-controller".
> >> +- reg: offsets and lengths of the register sets for the device.  It should
> >> +  contain 2 regions: base & control register, misc register, in this order.
> >
> > The example also has a system-bus phandle.
> 
> Actually, I was wondering which is better to describe the relation between
> the bus and the controller,  phandle or compatible string..

To describe relationships between nodes, use phandles.

Compatible strings alone cannot define relationships -- you cannot
encode how multiple instances are related.

> > Is the "misc register" part of the bus controller, or is it a shared
> > system controller?
> 
> It is a part of the bus controller, but used for another purpose.
> (i.e. partly this is syscon.  I know this is strange, but it is
> what the hardware developers designed.)

Ok. What else is going to need to use this in future?

> > Assuming that the controller and bus are 1-1 related, make this a single
> > node. e.g.
> >
> > system-bus {
> >         compatible = "socionext,uniphier-system-bus";
> >         reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
> >         #address-cells = <2>;
> >         #size-cells = <1>;
> >         ranges = <1 0x00000000 0x42000000 0x02000000>,
> >                  <5 0x00000000 0x48000000 0x01000000>;
> >
> >         ...
> >         child nodes here
> >         ...
> >
> > };
> 
> Hmm, make sense.  But, I prefer to reflect the hardware structure.
> 
> The range of System Bus is <0x40000000 0x10000000>.
> 
> The register of the System Bus Controller is
> <0x58c00000 0x400>  (and <0x59800000 0x2000>)
> 
> 
> The bus and its controller is different.

So? We always describe the programming interface (i.e. the slave
interface of the device that responds to the CPU).

There's no need for separate nodes. It only makes the driver more
complicated.

> >> +static int uniphier_sbc_probe(struct platform_device *pdev)
> >> +{
> >> +     struct device *dev = &pdev->dev;
> >> +     struct uniphier_sbc_priv *priv;
> >> +     struct resource *regs;
> >> +     struct device_node *bus_np;
> >> +     int child_addrc, addrc, sizec, bank;
> >> +     u64 child_addr, addr, size;
> >> +     const __be32 *ranges;
> >> +     int rlen, rone, ret;
> >> +
> >> +     bus_np = of_find_compatible_node(NULL, NULL,
> >> +                                      "socionext,uniphier-system-bus");
> >
> > This is broken if you ever have multiple instances.
> >
> > Either use a single node, or if there is a more complex relationship
> > between busses and their controllers, describe that explicitly with
> > phandles.
> 
> 
> Probably, I will stick to phandle in v2.

I would prefer a single node unless there's some other complication
regarding the relationship of the controller and the bus itself.

Thanks,
Mark.

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 22:42:05 +0000
Subject: [PATCH v4 5/5] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303222315.44882.heiko@sntech.de>
References: <201303221843.37668.heiko@sntech.de>
 <201303222055.57400.arnd@arndb.de> <201303222315.44882.heiko@sntech.de>
Message-ID: <201303222242.05269.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Heiko St?bner wrote:
> Not all main interrupts are parent interrupts, so it would be difficult to 
> distinguish between main interrupts that are a parent and the ones that are 
> not - is a "-1" a valid cell-value for interrupts?

I'm actually not sure if negative numbers are valid syntax in dtc, but
you could certainly define some value to mean "none", or you add another
flag in the trigger type cell.

>         <main_irq -1 trigger_type> /* directly used main interrupt */
>         <main_irq child_irq trigger_type> /* sub-interrupt */
> 
> Or are you thinking of something like:
>         <main_irq is_a_parent child_irq trigger_type>

The first one would work, the second one with four cells seems a bit
strange if the second cell is just a bit. My first idea was to use 
a bit mask for the child irq, in which only one bit is set, so
it would be <3 0x40000 4> instead of <3 18 4>, and a zero bitmask
would indicate no sub-interrupt. This is probably harder to read
though and not a good representation.

> I looked a bit more thru the other irqchips and it seems the bcm2835 is doing 
> something similar but without having a parent relationship:
>         <controller-num irq-num>
> 
> so this could be adapted to:
>         <controller-num irq-num parent-num trigger_type>
> 
> controller-num being 0 for intc, 1 for subintc, 2 intc2 . The controller 
> itself knows if it's a sub- or main controller - when it should handle the 
> parent-number or simply ignore it.

Yes, that looks more logical.

You could in theory also compact collapse multiple cells into one, so
instead of using <1 3 18 4> it could be <0x10031204> or <0x10030012 4>
to save a little space while making it a little less readable.
 
> > The alternative would be to have three completely separate nodes,
> > and then you can describe the parent-child relationship like
> > 
> > intc: interrupt-controller at 4a000000 {
> >       compatible = "samsung,s3c2416-intc";
> >       reg = <0x4a000000 0x18>;
> >       interrupt-controller;
> >       #interrupt-cells = <2>;
> > };
> > 
> > subintc: interrupt-controller at 4a000018 {
> >       compatible = "samsung,s3c2416-subintc";
> >       reg = <0x4a000018 0x28>;
> >       interrupt-controller;
> >       #interrupt-cells = <3>;
> >       interrupt-parent = <&intc>;
> >       interrupts  = <28 0>, <23 0>, <15 0>, <31 0>, <16 0>, <17 0>, <18 0>, <9
> > 0>; };
> 
> 
> The first two iterations had separate nodes, but the interrupt controller 
> posseses more interesting registers that are shared between all of the 
> controllers, so it did sound better to have them together.

Yes, makes sense.

> Also the interrupts property is most likely not able to accurately describe 
> the parent relationship, as the interrupts are very much different in all 
> s3c24xx SoCs - I would need to tell every sub-interrupt where it cascasdes 
> from, because most of them do different things on different s3c24xx SoCs.
>
> I did start with this approach, using the interrupt index as mapping for the 
> hwirq - interrupts[0] for hwirq 0 and so on. But it looked ugly. Using only 
> one interrupts element per sub-group would require per-SoC mapping data to be 
> present in the driver, indicating that interrupts[0] is responsible for bits 
> 0,1,2 and so on.
> 
> Therefore the idea of handling the parent relationship in the device-nodes 
> interrupt property sounds much nicer :-)

Ok.

	Arnd

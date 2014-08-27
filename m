From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Aug 2014 17:22:05 +0200 (CEST)
Subject: [RESEND PATCH v2 1/4] irqchip: gic: Change irq type check when
 extension is present
In-Reply-To: <20140827142935.GA9490@leverpostej>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
 <53F724F5.3040004@arm.com>
 <1409133344.25382.37.camel@coredoba.hi.pengutronix.de>
 <53FDB4B3.6000400@arm.com>
 <alpine.DEB.2.10.1408271347210.3323@nanos>
 <87ppfmoxxz.fsf@approximate.cambridge.arm.com>
 <20140827142935.GA9490@leverpostej>
Message-ID: <alpine.DEB.2.10.1408271657310.3323@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Aug 2014, Mark Rutland wrote:
> On Wed, Aug 27, 2014 at 02:37:44PM +0100, Marc Zyngier wrote:
> > We need to work out how to drive the whole stacking from a DT
> > perspective: Mark, any idea?
> 
> Describing the lines the magic irqchip has to its parent irqchip is
> simple, the standard interrupts property can handle that:
> 
> parent: parent {
> 	...
> 	#interrupt-cells = <1>;
> };
> 
> magic {
> 	...
> 	interrupt-parent = <&parent>;
> 	interrupts = <3>, <6>, <17>, <2>;
> 	#interrupt-cells = <1>;
> };
> 
> The harder part is describing the configuration of each interrupt to the
> magic irqchip (e.g. edge vs level triggered), which is inseparable form
> the line identifier in the interrupt-specifier.

Do we really need to decribe that at the this level?

You have the parent ARMGIC and the maGIC with a specified (or even
dynamic) routing of the maGIC lines to the ARMGIC.

Now the device which uses a maGIC interrupt specifies the interrupt
type at the maGIC.

So the type setter function of the maGIC configures the maGIC hardware
in such a way that the output to the ARMGIC results in a type which
the ARMGIC can handle and calls the type setter function of the maGIC
with that type.

I don't think you need to decribe this in the magic/parent relation
ship at all. maGIC should know what kind of output it can provide to
ARMGIC so that should just work, unless I'm missing something.

> If there interrupts don't share the same configuration then I'm not sure
> how we describe that in the DT. That's especially problematic if the
> assignment of parent line is dynamic (as with the crossbar iirc).

Why is this an issue?

There are two ways to solve that:

1) You can do a fully dynamic allocation at the parent level, which of
   course requires that the whole parent range is dynamically
   managed. That's what we are planning for the MSI/Remap/Vector
   stacking

2) You define the irq lines at the parent which are available for
   dynamic stacking and let the allocation code hand one out.

3) You tell the maGIC controller which lines of the parent are
   available for it, so it can only stack onto those lines and instead
   of letting the parent allocate a free one, the maGIC needs to map
   its stuff to one of those ARMGIC lines.

Which one to chose depends on the particular maGIC incarnation, but
its not a big issue to select one ...

Thanks,

	tglx

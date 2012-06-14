From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jun 2012 11:55:56 +0000
Subject: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for
 DT boards
In-Reply-To: <20120614091858.GD4799@lunn.ch>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
 <201206140812.34399.arnd@arndb.de> <20120614091858.GD4799@lunn.ch>
Message-ID: <201206141155.56289.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012, Andrew Lunn wrote:
> > I think if you compute the number of interrupts in the domain from the number of
> > registers that are described in the device tree, call orion_irq_init()
> > based on those registers, and use irq domains for the gpio stuff as Rob suggested,
> > this init_irq function can become completely generic to all orion platforms.
> 
> I'm reworking the GPIO stuff at the moment, moving it to use IRQ
> domains for its interrupts. That code will be generic to all Orion
> platforms. I'm modeling the code on the AT91 GPIO handler, since that
> has a similar structure, one hardware interrupt for a number of GPIO
> lines, which is in software demultiplexed and triggers secondary level
> interrupts. The major difference is that AT91 has one hardware
> interrupt for a GPIO chip with 32 lines, where as Orion has 4 hardware
> interrupt lines, so maybe four interrupt domains, for one GPIO chip
> with 32 lines.

My guess is that you're still better off with a single interrupt domain
for 32 lines, or even for all the gpio lines, but I'm sure you can
find a solution that works best for you.

> Non-GPIO interrupts are more of a problem. Underneath it uses the
> generic-chip interrupt code. The patchset to add _domain versions of
> these calls is stalled. So i think for the moment, we need to stay
> with the domain bolted on top, until generic-chip gets domain
> support. I would also expect that generic-chip also gets a common DT
> binding which any SoC can use.

I suggested that before, and the comments I got back then were that
we should treat the generic irq chip more like a library and keep
the device tree binding at a higher level. If I understood things right,
that means we would just have one plat-orion (or mach-mvebu later)
irq chip abstraction that handles the DT binding and the irq domains
itself but uses the generic irq chip code to implement the actual
irq handling.

> My aim at the moment is to get something which works well enough that
> we can add DT support to other drivers. Without interrupts, we are not
> going to get very far. We can later rip it out what i create now and
> replace it once generic-chip becomes domain and DT aware, and there
> should be no effect on other drivers.

Right. I just want to ensure that we don't need to change the bindings
in incompatible ways.

	Arnd

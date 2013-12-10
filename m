From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 22:57:33 +0100
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1386706817.7152.254.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <CACRpkdYF-O6Qgjue6x+R6fVuSXSyO4YHw1meusuyQhtSA9PnvQ@mail.gmail.com>
 <1386706817.7152.254.camel@host5.omatika.ru>
Message-ID: <201312102257.33942.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, Sergei Ianovich wrote:
> On Tue, 2013-12-10 at 13:33 +0100, Linus Walleij wrote:
> > On Fri, Dec 6, 2013 at 6:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Friday 06 December 2013, Sergei Ianovich wrote:
> > >> On Fri, 2013-12-06 at 01:40 +0100, Arnd Bergmann wrote:
> > >>
> > >> > > +
> > >> > > +static struct irq_chip lp8x4x_irq_chip = {
> > >> > > +     .name                   = "FPGA",
> > >> > > +     .irq_ack                = lp8x4x_ack_irq,
> > >> > > +     .irq_mask               = lp8x4x_mask_irq,
> > >> > > +     .irq_unmask             = lp8x4x_unmask_irq,
> > >> > > +};
> > >> >
> > >> > Please try to move the irqchip code to drivers/irqchip/.
> > >>
> > >> CONFIG_IRQCHIP depends on CONFIG_OF_IRQ which in turn depends on Open
> > >> Firmware.
> > >
> > > Hmm, I wonder if we should try to change Kconfig then. Let's leave it
> > > alone for now, maybe Linus Walleij has some comments since he has
> > > been looking into moving drivers out in the past.
> > 
> > I don't get this, if the subarch has deps in place for IRQCHIP and
> > OF_IRQ just move the implementation to drivers/irqchip/foo.c
> > edit drivers/irqchip/Makefile to compile the file for ARCH_FOO.
> > What would the problem be? It's not like having the irqchip in the
> > object is optional...
> 
> This chip is used only of one machine and only required for
> machine-special devices. If those devices are not selected, the chip
> will just waist memory.

It should be possible to make it a loadable module, with deferred
probing etc. You wouldn't use IRQCHIP_DECLARE() for this though,
but instead have a platform driver that sets up the irq domain.

It probably makes sense to have a single driver file for the
FPGA device that does this, and only split out the other devices
from it that consume the irqs.

> > Another way is to create a separate Kconfig entry for it in
> > drivers/irqchip/Kconfig if you want the set-up to be more
> > distributed, but that is usually just done when the irqchip is
> > used on more than one platform.
> 
> Please consult, how to approach this driver using device tree. If I
> assign an "interrupts" property in the node, and the property will point
> to pxa-gpio interrupt controller using a phandle, is there a guaranty
> that my device will be probed later than pxa-gpio interrupt controller?

Yes, the interrupt controllers get probed in the right order based
on their "interrupt-parent" properties, starting with the root
controller.

If you have a platform driver rather than IRQCHIP_DECLARE(), that gets
initialized after all IRQCHIP_DECLARE() calls, so it's not a problem.

If both the gpio chip and the fpga are loadable modules, it's still
fine, but the probe() function for the fpga needs to call
irq_of_parse_and_map() to get the parent IRQ and bail out of
-EPROBE_DEFER if it gets this error while trying to map the
gpio IRQ.

	Arnd

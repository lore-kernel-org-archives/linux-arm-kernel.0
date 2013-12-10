From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 11 Dec 2013 00:20:17 +0400
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <CACRpkdYF-O6Qgjue6x+R6fVuSXSyO4YHw1meusuyQhtSA9PnvQ@mail.gmail.com>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <201312060140.10376.arnd@arndb.de>
 <1386347911.7152.70.camel@host5.omatika.ru>
 <201312061814.15730.arnd@arndb.de>
 <CACRpkdYF-O6Qgjue6x+R6fVuSXSyO4YHw1meusuyQhtSA9PnvQ@mail.gmail.com>
Message-ID: <1386706817.7152.254.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 13:33 +0100, Linus Walleij wrote:
> On Fri, Dec 6, 2013 at 6:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 06 December 2013, Sergei Ianovich wrote:
> >> On Fri, 2013-12-06 at 01:40 +0100, Arnd Bergmann wrote:
> >>
> >> > > +
> >> > > +static struct irq_chip lp8x4x_irq_chip = {
> >> > > +     .name                   = "FPGA",
> >> > > +     .irq_ack                = lp8x4x_ack_irq,
> >> > > +     .irq_mask               = lp8x4x_mask_irq,
> >> > > +     .irq_unmask             = lp8x4x_unmask_irq,
> >> > > +};
> >> >
> >> > Please try to move the irqchip code to drivers/irqchip/.
> >>
> >> CONFIG_IRQCHIP depends on CONFIG_OF_IRQ which in turn depends on Open
> >> Firmware.
> >
> > Hmm, I wonder if we should try to change Kconfig then. Let's leave it
> > alone for now, maybe Linus Walleij has some comments since he has
> > been looking into moving drivers out in the past.
> 
> I don't get this, if the subarch has deps in place for IRQCHIP and
> OF_IRQ just move the implementation to drivers/irqchip/foo.c
> edit drivers/irqchip/Makefile to compile the file for ARCH_FOO.
> What would the problem be? It's not like having the irqchip in the
> object is optional...

This chip is used only of one machine and only required for
machine-special devices. If those devices are not selected, the chip
will just waist memory.

> I would prefer if you augment the code to use
> IRQCHIP_DECLARE() so you can get rid of all the criss-cross
> calls, but this init contains a comment saying that GPIO
> has to be up before you initialize the irq_chip, can you please
> explain why it's like that?

This is a tertiary irq chip (primary is on CPU, secondary is GPIO). It
triggers a GPIO interrupt if it detects one of its own.

> Another way is to create a separate Kconfig entry for it in
> drivers/irqchip/Kconfig if you want the set-up to be more
> distributed, but that is usually just done when the irqchip is
> used on more than one platform.

Please consult, how to approach this driver using device tree. If I
assign an "interrupts" property in the node, and the property will point
to pxa-gpio interrupt controller using a phandle, is there a guaranty
that my device will be probed later than pxa-gpio interrupt controller?

Or how could that be achieved?

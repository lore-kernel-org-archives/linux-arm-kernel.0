From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 18:14:15 +0100
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1386347911.7152.70.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <201312060140.10376.arnd@arndb.de>
 <1386347911.7152.70.camel@host5.omatika.ru>
Message-ID: <201312061814.15730.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Sergei Ianovich wrote:
> On Fri, 2013-12-06 at 01:40 +0100, Arnd Bergmann wrote:
> 
> > Ideally we want shared defconfigs where you enable multiple (or all) pxa boards
> > at once and end up with a kernel that works on all of them.
> > 
> > For most other platforms the goal is even to have a shared defconfig across
> > SoC families, but PXA is one of the exceptions that I would make because
> > it is both old and rather different from even the ARM9 or Marvell Feroceon
> > based SoCs.
> 
> There is probably no in point sharing this config with most other
> devices on PXA2xx SoC. This device is an industrial PC. Its config needs
> to be optimized for low latency even by the cost of greater power
> consumption. It is not supposed to run on batteries or enter any low
> power mode anyway.

Ok, I see. Note that while most of them are mobile, I believe there are
a couple of pxa boards that are in the same category as yours.

Unfortunately, PXA already has most defconfigs than any other platform (25
at the moment) and I would like to see that reduced in the future if
I can find someone to do the work.

> > we try to avoid hardwired virtual addresses entirely and instead use platform
> > device resources, but I realize that there are limits to how far you get with
> > that. Please make an effort to convert as many parts of the FPGA into platform
> > devices with regular resources, but know that we would not enforce this as
> > strictly as we do for new platforms.
> > 
> > > +
> > > +static struct irq_chip lp8x4x_irq_chip = {
> > > +     .name                   = "FPGA",
> > > +     .irq_ack                = lp8x4x_ack_irq,
> > > +     .irq_mask               = lp8x4x_mask_irq,
> > > +     .irq_unmask             = lp8x4x_unmask_irq,
> > > +};
> > 
> > Please try to move the irqchip code to drivers/irqchip/.
> 
> CONFIG_IRQCHIP depends on CONFIG_OF_IRQ which in turn depends on Open
> Firmware.

Hmm, I wonder if we should try to change Kconfig then. Let's leave it
alone for now, maybe Linus Walleij has some comments since he has
been looking into moving drivers out in the past.

> The device is shipped with such a flash device partition table, which
> makes migration to device tree rather difficult. The partition for
> U-Boot is just 256kiB. This is a high aim already. U-Boot needs to be
> compiled without command line help and USB support to fit into this
> size. Otherwise the main flash needs to be repartitioned.
> 
> Could it be acceptable to accept the device without device tree support?

>From my point of view it's ok, but I'll leave that up to Daniel Mack,
since he has been doing all the work on PXA migration to DT lately.
I believe with his work it won't actually be a problem to do DT.

> If so, FPGA irqchip could remain in the machine source file. It is
> highly unlikely, it will ever be reused. In this case all fixed virtual
> address definitions could be moved to the machine source file. The file
> will be the only place where LP8X4X_FPGA_VIRT is used directly.

That sounds reasonable to me as well.

	Arnd

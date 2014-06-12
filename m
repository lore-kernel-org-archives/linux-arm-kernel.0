From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 17:30:06 +0200
Subject: [PATCH] drm: imx: use GENERIC_IRQ_CHIP
In-Reply-To: <20140612150418.GJ23430@n2100.arm.linux.org.uk>
References: <7367559.qEUUbIia3C@wuerfel> <18338077.DHE9A0xGC1@wuerfel>
 <20140612150418.GJ23430@n2100.arm.linux.org.uk>
Message-ID: <4447748.CqSILDNGQQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 16:04:19 Russell King - ARM Linux wrote:
> On Thu, Jun 12, 2014 at 04:51:26PM +0200, Arnd Bergmann wrote:
> > On Thursday 12 June 2014 15:23:54 Russell King - ARM Linux wrote:
> > > On Thu, Jun 12, 2014 at 04:05:32PM +0200, Arnd Bergmann wrote:
> > > > This driver defines its own irqchip using the generic chip
> > > > infrastructure, and hence needs the GENERIC_IRQ_CHIP Kconfig
> > > > symbol enabled, or get this build error:
> > > > 
> > > > drivers/built-in.o: In function `ipu_probe':
> > > > :(.text+0x49ea4c): undefined reference to `irq_generic_chip_ops'
> > > > :(.text+0x49ea5c): undefined reference to `irq_alloc_domain_generic_chips'
> > > > :(.text+0x49ea60): undefined reference to `irq_get_domain_generic_chip'
> > > > :(.text+0x49ea64): undefined reference to `irq_gc_ack_set_bit'
> > > > :(.text+0x49ea6c): undefined reference to `irq_gc_mask_clr_bit'
> > > > :(.text+0x49ea70): undefined reference to `irq_gc_mask_set_bit'
> > > 
> > > Let's take a step back, and ask the obvious question: is it reasonable
> > > to make use if GENERIC_IRQ_CHIP in this driver?
> > 
> > While I haven't looked at this driver in particular, I know that
> > Thomas Gleixner has been rather upset in the past when new irqchip
> > drivers got introduced that were reimplementing the generic irqchip
> > rather than using it.
> > 
> > You can argue over whether it should be an irqchip at all or not,
> > I don't know, and I simply had to assume that this part of the
> > code is ok.
> 
> The question was more whether "peripheral" drivers should register their
> own irqchips to split a single IRQ into multiple separate Linux IRQs.
> We don't have PCI devices behaving like that... and I don't think we
> should allow it as a general rule.

There are two cases I can think of where it makes sense for a driver
to register an irqchip: gpio extenders and multi-function-device (mfd).
It's quite common for both to do this.

For the IPU, it can be seen as a form of MFD, since there are multiple
real drivers in other subsystems that are part of the IPU. It doesn't
have to be done this way, but it seems like a reasonable way to me.

For architecture independent drivers (i.e. most PCI drivers), we
can't do it like this because not all architectures support IRQ
domains.

> > This seems more like a second bug in a related part of the code
> > to me. Looking at other generic irqchip users, it seems like
> > the same bug exists in gpio-dwapb.c, gpio-ml-ioh.c, gpio-pch.c
> > and possibly others, which are all loadable modules using a
> > generic irqchip that can't be freed.
> 
> Generally, that means either (a) the subsystem being used does not
> support the approach, or (b) the subsystem is being inappropriately
> used.
> 
> In the case of (a), it means a discussion whether support for it
> should be added.  If the answer to that is no, then we need these
> drivers to become modules which can only be loaded _and_ drivers
> which can never be unbound.
> 
> In the case of (b) it means that the real bug is that the driver is
> making use of the subsystem (irqchip in this case) that it should not
> be using.

Yes, makes sense. I believe this is just a missing feature in
the generic irqchip code. We keep extending this drive when needed,


	Arnd

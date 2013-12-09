From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 17:25:45 +0100
Subject: [PATCH 9/9] ARM: pxa27x: device tree support ICP DAS LP-8x4x
In-Reply-To: <1386602213.7152.180.camel@host5.omatika.ru>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <201312090247.24978.arnd@arndb.de>
 <1386602213.7152.180.camel@host5.omatika.ru>
Message-ID: <201312091725.46212.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, Sergei Ianovich wrote:
> On Mon, 2013-12-09 at 02:47 +0100, Arnd Bergmann wrote:
> > On Sunday 08 December 2013, Sergei Ianovich wrote:
> > > +
> > > +#ifdef CONFIG_PXA27x
> > > +extern void __init pxa27x_dt_init_irq(void);
> 
> > This is not the right place to put an 'extern' declaration, it should go into
> > a header file if it's really needed. Ideally you would not need it at all
> > and just add an IRQCHIP_DECLARE() line into the driver to automatically
> > probe it.
> 
> I thought I moved it to the header in patch 6/9. I'll just drop the
> line.

Ok.

> IRQCHIP_DECLARE isn't used on pxa_internal_irq_chip in
> arch/arm/mach-pxa/irq.c, probably for a reason.

Yes, you can only use it from drivers in drivers/irqchip/.

> > > +static void __init pxa27x_init_early(void)
> > > +{
> > > +     pxa27x_skip_init();
> > > +}
> > 
> > I would prefer not to have an init_early function at all, and instead
> > check "if (of_have_populated_dt())" in pxa27x_init, or to split
> > that function into two.
> 
> Device tree is populated in init_machine. However, pxa27x_init is
> executed before via postcore_initcall. 

The device tree is populated in unflatten_device_tree(), which gets
called before init_early.

> The only chance to run before is
> to use init_early. What's wrong with this function?

I generally dislike adding any platform specific hooks to "early"
functions, i.e. stuff that runs before init_machine, and I'm pretty
sure it's not necessary here.

> > static void pxa27x_restart(enum reboot_mode mode, const char *cmd)
> > {
> >         /* Switch off fast-bus and turbo mode */
> >         if (of_machine_is_compatible("marvell,lp8x4x"))
> >                 asm volatile("mcr       p14, 0, %0, c6, c0, 0" : : "r"(2));
> > 
> >         /* SDRAM hangs on watchdog reset on Marvell PXA270 (erratum 71) */
> >         if (of_machine_is_compatible("marvell,pxa270"))
> >                 pxa_restart(REBOOT_SOFT, cmd);
> > }
> 
> Nice tip, thanks. I've spent 30 minutes to find something like that.
> 
> If the device has fast SDRAM, which can reset itself in up to 8ms, the
> device is not affected by E71. So both checks are per-device.

Ok.

	Arnd

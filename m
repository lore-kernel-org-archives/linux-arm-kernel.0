From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 09 Dec 2013 19:16:53 +0400
Subject: [PATCH 9/9] ARM: pxa27x: device tree support ICP DAS LP-8x4x
In-Reply-To: <201312090247.24978.arnd@arndb.de>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-10-git-send-email-ynvich@gmail.com>
 <201312090247.24978.arnd@arndb.de>
Message-ID: <1386602213.7152.180.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-09 at 02:47 +0100, Arnd Bergmann wrote:
> On Sunday 08 December 2013, Sergei Ianovich wrote:
> > +
> > +#ifdef CONFIG_PXA27x
> > +extern void __init pxa27x_dt_init_irq(void);

> This is not the right place to put an 'extern' declaration, it should go into
> a header file if it's really needed. Ideally you would not need it at all
> and just add an IRQCHIP_DECLARE() line into the driver to automatically
> probe it.

I thought I moved it to the header in patch 6/9. I'll just drop the
line.

IRQCHIP_DECLARE isn't used on pxa_internal_irq_chip in
arch/arm/mach-pxa/irq.c, probably for a reason.

> > +static const struct of_dev_auxdata pxa27x_auxdata_lookup[] __initconst = {
> > +     OF_DEV_AUXDATA("mrvl,pxa-uart",         0x40100000, "pxa2xx-uart.0", NULL),
> > +     OF_DEV_AUXDATA("mrvl,pxa-uart",         0x40200000, "pxa2xx-uart.1", NULL),
> > +     OF_DEV_AUXDATA("mrvl,pxa-uart",         0x40700000, "pxa2xx-uart.2", NULL),
> > +     OF_DEV_AUXDATA("mrvl,pxa-uart",         0x41600000, "pxa2xx-uart.3", NULL),
> > +     OF_DEV_AUXDATA("marvell,pxa-mmc",       0x41100000, "pxa2xx-mci.0", NULL),
> > +     OF_DEV_AUXDATA("intel,pxa27x-gpio",     0x40e00000, "pxa27x-gpio", NULL),
> > +     OF_DEV_AUXDATA("marvell,pxa-ohci",      0x4c000000, "pxa27x-ohci", NULL),
> > +     OF_DEV_AUXDATA("mrvl,pxa-i2c",          0x40301680, "pxa2xx-i2c.0", NULL),
> > +     {}
> > +};
> 
> I guess these are needed only for clock management purposes at the moment?

Absolutely.

> > +static void __init pxa27x_init_early(void)
> > +{
> > +     pxa27x_skip_init();
> > +}
> 
> I would prefer not to have an init_early function at all, and instead
> check "if (of_have_populated_dt())" in pxa27x_init, or to split
> that function into two.

Device tree is populated in init_machine. However, pxa27x_init is
executed before via postcore_initcall. The only chance to run before is
to use init_early. What's wrong with this function?

> > +static const char *pxa27x_dt_board_compat[] __initdata = {
> > +     "marvell,pxa27x",
> > +     NULL,
> > +};
> > +
> > +#ifdef CONFIG_MACH_LP8X4X
> > +static const char *lp8x4x_dt_board_compat[] __initdata = {
> > +     "marvell,lp8x4x",
> > +     NULL,
> > +};
> 
> Note that you should not have wildcards in any "compatible" strings.
> Just list all the combinations here (pxa270, pxa271, pxa272, and whatever
> you need for lp8x4x).

Will do.

> > +static void lp8x4x_restart(enum reboot_mode mode, const char *cmd)
> > +{
> > +     /* Switch off fast-bus and turbo mode */
> > +     asm volatile("mcr       p14, 0, %0, c6, c0, 0" : :
> > +                     "r"(2));
> > +     /* SDRAM hangs on watchdog reset on Marvell PXA270 (erratum 71) */
> > +     pxa_restart(REBOOT_SOFT, cmd);
> > +}
> > +#endif
> > +#endif
> 
> Since the only difference here is the restart logic, I would prefer here to
> have only a single DT_MACHINE_START() and do
> 
> static void pxa27x_restart(enum reboot_mode mode, const char *cmd)
> {
>         /* Switch off fast-bus and turbo mode */
>         if (of_machine_is_compatible("marvell,lp8x4x"))
>                 asm volatile("mcr       p14, 0, %0, c6, c0, 0" : : "r"(2));
> 
>         /* SDRAM hangs on watchdog reset on Marvell PXA270 (erratum 71) */
>         if (of_machine_is_compatible("marvell,pxa270"))
>                 pxa_restart(REBOOT_SOFT, cmd);
> }

Nice tip, thanks. I've spent 30 minutes to find something like that.

If the device has fast SDRAM, which can reset itself in up to 8ms, the
device is not affected by E71. So both checks are per-device.

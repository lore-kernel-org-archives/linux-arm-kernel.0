From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Aug 2011 13:48:20 +0200
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4yMJo3oN90CLjktQaji8WUg2JRYu6JAghS=OAgLCWFXvw@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<201108121554.11316.arnd@arndb.de>
	<CAGsJ_4yMJo3oN90CLjktQaji8WUg2JRYu6JAghS=OAgLCWFXvw@mail.gmail.com>
Message-ID: <201108171348.20378.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2011, Barry Song wrote:
> 2011/8/12 Arnd Bergmann <arnd@arndb.de>:
> > On Friday 05 August 2011, Barry Song wrote:

> >>
> >>  extern void __init sirfsoc_of_irq_init(void);
> >>  extern void __init sirfsoc_of_clk_init(void);
> >> +extern void sirfsoc_l2x_init(void);
> >>
> >>  #ifndef CONFIG_DEBUG_LL
> >>  static inline void sirfsoc_map_lluart(void)  {}
> >
> > You now call the sirfsoc_l2x_init function from two different places,
> > which is very confusing. Better make sure that the idle code is
> > only inialized after all the other subsystems it relies on have been
> > activated.
> 
> anyway, after Rob Herring's patch "ARM: l2x0: Add OF based
> initialization" is merged, sirfsoc l2 cache codes can be compelety
> deleted.
> i am thinking whether we can move l2 suspend/resume entries to
> arch/arm/mm/cache-l2x0.c directly, maybe a syscore_ops:
> static struct syscore_ops l2x_pm_syscore_ops = {
>         .suspend        = l2x_pm_suspend,
>         .resume         = l2x_pm_resume,
> };
> 
> static void l2x_pm_init(void)
> {
>         register_syscore_ops(&l2x_pm_syscore_ops);
> }
> 
> or let cache l2x be a platform driver and add suspend/resume entries there?
> 
> if we move suspend/resume of L2 to arch/arm/mm/cache-l2x0.c, that can
> eliminate my reference to l2 from other places.

Ok, that sounds good.

> >> +{
> >> +        u32 pwr_trigger_en_reg;
> >> +        pwr_trigger_en_reg = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
> >> +             SIRFSOC_PWRC_TRIGGER_EN);
> >> +#define X_ON_KEY_B (1 << 0)
> >> +        sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B,
> >> +                        sirfsoc_pwrc_base + SIRFSOC_PWRC_TRIGGER_EN);
> >> +}
> >> +
> >> +static void sirfsoc_set_sleep_mode(u32 mode)
> >> +{
> >> +        u32 sleep_mode = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
> >> +             SIRFSOC_PWRC_PDN_CTRL);
> >> +        sleep_mode &= ~(SIRFSOC_SLEEP_MODE_MASK << 1);
> >> +        sleep_mode |= ((mode << 1));
> >> +        sirfsoc_rtc_iobrg_writel(sleep_mode, sirfsoc_pwrc_base +
> >> +             SIRFSOC_PWRC_PDN_CTRL);
> >> +}
> >
> > This again looks like a bad abstraction, and it gets the locking wrong,
> > since you need a spinlock around both the read and write of the register
> > to make the update atomic.
> 
> will there be two threads calling into pm_ops.enter() at the same
> time? seems not, let me check....

I would expect not, but that's not the main point:

> >
> > These functions therefore belong into the rtc_iobrg driver.
> 
> rtc_iobrg might only handle the read/write interfaces and let other
> modules call these interfaces to read/write what they want.

Every other module calling these interfaces will have the same
problem with locking. In cases like this, it's typically better
to export a high-level interface from the driver that accesses
the registers rather than exporting functions that directly
manipulate the registers.

> >> +static struct of_device_id pwrc_ids[] = {
> >> +     { .compatible = "sirf,prima2-pwrc" },
> >> +};
> >> +
> >> +static void __init sirfsoc_of_pwrc_init(void)
> >> +{
> >> +     struct device_node *np;
> >> +     const __be32    *addrp;
> >> +
> >> +     np = of_find_matching_node(NULL, pwrc_ids);
> >> +     if (!np)
> >> +             panic("unable to find compatible pwrc node in dtb\n");
> >
> > Don't use of_find_matching_node to look for stuff that is really more
> > a device that you want to talk to. Instead, register a platform
> > driver with that match_table and load a proper device driver for
> > it.
> 
> agree. how do you think about cache l2, will it be a platform too?

Probably not. Ideally every device like this would be a platform_device,
but some things have to be enabled way before the driver model is
up and cannot be platform_devices because of that. My impression
is that l2 falls into this category, while anything related to
power management does not: there is no need to suspend the device
before it is fully booted up.

> >> +
> >> +     addrp = of_get_property(np, "reg", NULL);
> >> +     if (!addrp)
> >> +             panic("unable to find base address of pwrc node in dtb\n");
> >> +
> >> +     sirfsoc_pwrc_base = be32_to_cpup(addrp);
> >> +
> >> +     of_node_put(np);
> >> +}
> >
> > Why do you store the physical base address here, instead doing an of_iomap?
> 
> i should have failed to use of_iomap, register space behind rtciobrg
> are not in memory space. it is accessed indirectly just like a NAND or
> a harddisk.

Ah, I see. That looks absolute correct then. I was confused by
the naming of the variable as sirfsoc_pwrc_base, which suggests
that it's a physical memory address. I can't think of a better
name either. Maybe you can add a comment in the code to clarify
that it's on a different bus.

	Arnd

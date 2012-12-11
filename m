From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Dec 2012 17:45:37 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <1355246519.19818.20.camel@hornet>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
 <201212111541.16479.arnd@arndb.de> <20121211163932.GC16071@arm.com>
 <1355246519.19818.20.camel@hornet>
Message-ID: <20121211174537.GD16071@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 05:21:59PM +0000, Pawel Moll wrote:
> On Tue, 2012-12-11 at 16:39 +0000, Catalin Marinas wrote:
> > > > diff --git a/arch/arm6
> > > > +static const char *vexpress_dt_match[] __initdata = {
> > > > +       "arm,vexpress",
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +static int __init vexpress_init(void)
> > > > +{
> > > > +       if (!of_flat_dt_match(of_get_flat_dt_root(), vexpress_dt_match))
> > > > +               return 0;
> > > > +
> > > > +       vexpress_sysreg_of_early_init();
> > > > +       vexpress_clk_of_init();
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +arch_initcall(vexpress_init);
> > > 
> > > I think it would be more appropriate for these two to check the presence of
> > > the individual devices, and move the caller into the actual device driver,
> > > rather than checking for the root node of the device tree.
> > > 
> > > There may be cases where we want to check the root node, but both the clock
> > > setup and the sysreg should both be detectable.
> > 
> > I cc'ed Pawel as well since it's touching his code. We've been through
> > several versions internally and didn't find a clear winner. Currently,
> > vexpress_clk_of_init() requires vexpress_sysreg_of_early_init() to be
> > called first. Pawel has a patch to allow sysreg self-initialisation when
> > called from vexpress_clk_of_init().
> > 
> > This leaves us with a way to call vexpress_clk_of_init() directly from
> > clk-vexpress.c. There are two ways:
> > 
> > 1. arch_initcall() in clk-vexpress.c, checking for the DT match.
> > 2. driver registration (arch_initcall) and later probing when
> >    of_platform_populate() is called from the arch/arm64 code.
> > 
> > The 2nd option above relies on the DT order since the clocks must be
> > registered before any AMBA device is registered, so I'm not too keen.
> > This leaves us with option 1 or any other suggestion you may have.
> 
> The idea I had was to associate the root of the device tree with the
> "platform" device, see below. This makes it possible to write a platform
> driver for the particular platform, so the code for the vexpress could
> look more or less like this...
> 
> static int __devinit vexpress_probe(struct platform_device *dev)
> {
>         vexpress_sysreg_of_early_init();
>         vexpress_clk_of_init();
> 
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> 
>         return 0;
> }

This changes the way vexpress_probe() is done. Either direct DT match
check or platform device probing work for me. But I think Arnd's
suggestion was to get rid of the platform file entirely and just get the
clocks register/probe themselves. Unfortunately, the clocks subsystem
doesn't really follow the device/driver model and they need to be
initialised before registering any AMBA device. I don't really have a
clean solution here.

-- 
Catalin

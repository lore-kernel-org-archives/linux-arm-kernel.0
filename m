From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Dec 2012 16:39:32 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <201212111541.16479.arnd@arndb.de>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
 <201212111541.16479.arnd@arndb.de>
Message-ID: <20121211163932.GC16071@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 03:41:15PM +0000, Arnd Bergmann wrote:
> On Friday 07 December 2012, Catalin Marinas wrote:
> > diff --git a/arch/arm64/platforms/Kconfig b/arch/arm64/platforms/Kconfig
> > index e69de29..3533d71 100644
> > --- a/arch/arm64/platforms/Kconfig
> > +++ b/arch/arm64/platforms/Kconfig
> > @@ -0,0 +1,11 @@
> > +config ARCH_VEXPRESS
> > +       bool "ARMv8 software model (Versatile Express)"
> > +       select ARCH_REQUIRE_GPIOLIB
> > +       select ARM_AMBA
> > +       select ARM_GIC
> > +       select COMMON_CLK_VERSATILE
> > +       select GENERIC_GPIO
> > +       select VEXPRESS_CONFIG
> 
> I would expect that we can always select ARCH_REQUIRE_GPIOLIB, ARM_AMBA,
> ARM_GIC and GENERIC_GPIO for ARM64. Do you expect to see systems that
> don't have all of those?

I'm not entirely sure about ARM_AMBA though we can probably leave it on.
As for the GIC, that's GICv2 and we'll get a new version with a new
driver (too different to share the same code).

So we can either select all GICs or allow interrupt controllers to be
selectable but I only see this useful if we don't have any ARCH_*
Kconfig entries, just defconfigs for various platforms. The latter would
be nice but current vexpress support defines ARCH_VEXPRESS under
arch/arm/.

> > diff --git a/arch/arm6
> > +static const char *vexpress_dt_match[] __initdata = {
> > +       "arm,vexpress",
> > +       NULL,
> > +};
> > +
> > +static int __init vexpress_init(void)
> > +{
> > +       if (!of_flat_dt_match(of_get_flat_dt_root(), vexpress_dt_match))
> > +               return 0;
> > +
> > +       vexpress_sysreg_of_early_init();
> > +       vexpress_clk_of_init();
> > +
> > +       return 0;
> > +}
> > +arch_initcall(vexpress_init);
> 
> I think it would be more appropriate for these two to check the presence of
> the individual devices, and move the caller into the actual device driver,
> rather than checking for the root node of the device tree.
> 
> There may be cases where we want to check the root node, but both the clock
> setup and the sysreg should both be detectable.

I cc'ed Pawel as well since it's touching his code. We've been through
several versions internally and didn't find a clear winner. Currently,
vexpress_clk_of_init() requires vexpress_sysreg_of_early_init() to be
called first. Pawel has a patch to allow sysreg self-initialisation when
called from vexpress_clk_of_init().

This leaves us with a way to call vexpress_clk_of_init() directly from
clk-vexpress.c. There are two ways:

1. arch_initcall() in clk-vexpress.c, checking for the DT match.
2. driver registration (arch_initcall) and later probing when
   of_platform_populate() is called from the arch/arm64 code.

The 2nd option above relies on the DT order since the clocks must be
registered before any AMBA device is registered, so I'm not too keen.
This leaves us with option 1 or any other suggestion you may have.

-- 
Catalin

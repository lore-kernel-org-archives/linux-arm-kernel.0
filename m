From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jun 2018 18:36:35 +0100
Subject: [PATCH 3/4] ARM: mach-omap2: omap5/dra7: Enable ACTLR[0] (Enable
 invalidates of BTB) to facilitate CVE_2017-5715 WA in OS
In-Reply-To: <780935f6-6506-0915-dfb2-b584c074b70d@gmail.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-4-nm@ti.com>
 <780935f6-6506-0915-dfb2-b584c074b70d@gmail.com>
Message-ID: <20180613173634.GC17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 01:06:13AM +0200, Marek Vasut wrote:
> On 06/12/2018 10:24 PM, Nishanth Menon wrote:
> > Enable CVE_2017_5715 and since we have our own v7_arch_cp15_set_acr
> > function to setup the bits, we are able to override the settings.
> > 
> > Without this enabled, Linux kernel reports:
> > CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
> > 
> > With this enabled, Linux kernel reports:
> > CPU0: Spectre v2: using ICIALLU workaround
> > 
> > NOTE: This by itself does not enable the workaround for CPU1 (on
> > OMAP5 and DRA72/AM572 SoCs) and may require additional kernel patches.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 3bb1ecb58de0..77820cc8d1e4 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -53,6 +53,7 @@ config OMAP54XX
> >  	bool "OMAP54XX SoC"
> >  	select ARM_ERRATA_798870
> >  	select SYS_THUMB_BUILD
> > +	select ARM_CORTEX_A15_CVE_2017_5715
> >  	imply NAND_OMAP_ELM
> >  	imply NAND_OMAP_GPMC
> >  	imply SPL_DISPLAY_PRINT
> > 
> 
> Can this be enabled for all CA15 systems somehow ? I am sure there are
> more that are vulnerable.

I think you're missing the point.

Spectre affects the _entire_ system.  Working around it in just the
kernel does not mean that the system is no longer vulnerable.

Fixing the "system" means implementing the fixes also in the secure
world, which on A15 and A8 also means setting the IBE bit there.  If
the IBE bit is set in the secure world, it will also be set in the
non-secure world.

The fact that the kernel is complaining is telling you that the
system as a whole does not have the workarounds in place to mitigate
against the vulnerability.  Merely setting the IBE bit via some
secure API doesn't "magically" fix the secure world.

So, even if you were to set the IBE bit via some magic secure API,
the fact still remains: even with these workarounds in place, as I
understand it, the _system as a whole_ remains vulnerable - you
might as well _not_ have the kernel workarounds.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

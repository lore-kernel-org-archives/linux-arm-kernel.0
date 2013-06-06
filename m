From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 6 Jun 2013 12:46:16 -0400 (EDT)
Subject: [PATCH] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <20130606154339.GH16794@mudshark.cambridge.arm.com>
References: <1370527112.3695.47.camel@linaro1.home>
 <20130606150156.GF16794@mudshark.cambridge.arm.com>
 <1370532888.3500.11.camel@computer5.home>
 <20130606154339.GH16794@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306061235530.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Will Deacon wrote:

> On Thu, Jun 06, 2013 at 04:34:48PM +0100, Jon Medhurst (Tixy) wrote:
> > On Thu, 2013-06-06 at 16:01 +0100, Will Deacon wrote:
> > > > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > > > index 5907e10..fe637e9 100644
> > > > --- a/arch/arm/mach-vexpress/Kconfig
> > > > +++ b/arch/arm/mach-vexpress/Kconfig
> > > > @@ -56,5 +56,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
> > > >  
> > > >  config ARCH_VEXPRESS_CA9X4
> > > >  	bool "Versatile Express Cortex-A9x4 tile"
> > > > +	select ARM_ERRATA_643719
> > > 
> > > We don't do this for any other workarounds, so I'd suggest either dropping
> > > this or having a separate patch adding all of those that are required.
> > 
> > Not quite sure by what you mean by 'all of those that are required'. All
> > the errata required for vexpress? Or all platforms which require the
> > errata workaround?
> 
> I mean, the A9 coretile on vexpress also has other errata, for which we have
> workarounds in the kernel. They aren't automatically selected (for example,
> ARM_ERRATA_720789) so if you want to do this, it's worth selecting all or
> none, rather than make it look like you're selecting all those that apply
> when you're not.

I think we _really_ should move towards selecting all the errata that 
apply on a per platform basis.  We simply cannot expect everyone to be 
aware of the actual errata list that apply for a given platform.  And as 
we move towards reducing the amount of defconfig files we need a 
reliable way to record which erratum applies to which platform.

Many platforms appear to do it already:

mach-bcm/Kconfig:       select ARM_ERRATA_754322
mach-bcm/Kconfig:       select ARM_ERRATA_764369 if SMP
mach-bcm2835/Kconfig:   select ARM_ERRATA_411920
mach-imx/Kconfig:       select ARM_ERRATA_754322
mach-imx/Kconfig:       select ARM_ERRATA_764369 if SMP
mach-imx/Kconfig:       select ARM_ERRATA_775420
mach-imx/Kconfig:       select PL310_ERRATA_588369 if CACHE_PL310
mach-imx/Kconfig:       select PL310_ERRATA_727915 if CACHE_PL310
mach-imx/Kconfig:       select PL310_ERRATA_769419 if CACHE_PL310
mach-omap2/Kconfig:     select ARM_ERRATA_720789
mach-omap2/Kconfig:     select PL310_ERRATA_588369
mach-omap2/Kconfig:     select PL310_ERRATA_727915
mach-omap2/Kconfig:     select ARM_ERRATA_754322
mach-omap2/Kconfig:     select ARM_ERRATA_775420
mach-tegra/Kconfig:     select ARM_ERRATA_720789
mach-tegra/Kconfig:     select ARM_ERRATA_754327 if SMP
mach-tegra/Kconfig:     select ARM_ERRATA_764369 if SMP
mach-tegra/Kconfig:     select PL310_ERRATA_727915 if CACHE_L2X0
mach-tegra/Kconfig:     select PL310_ERRATA_769419 if CACHE_L2X0
mach-tegra/Kconfig:     select ARM_ERRATA_754322
mach-tegra/Kconfig:     select ARM_ERRATA_764369 if SMP
mach-tegra/Kconfig:     select PL310_ERRATA_769419 if CACHE_L2X0
mach-ux500/Kconfig:     select ARM_ERRATA_754322
mach-ux500/Kconfig:     select ARM_ERRATA_764369 if SMP
mach-ux500/Kconfig:     select PL310_ERRATA_753970 if CACHE_PL310

So if someone knowledgeable about applicable errata for VExpress could 
do the same that would be great.  I agree that this should be a separate 
patch though.


Nicolas

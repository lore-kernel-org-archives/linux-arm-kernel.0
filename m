From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Jun 2011 18:47:31 +0200
Subject: [PATCH 5/8 v2] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <201106011724.26704.arnd@arndb.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
	<20110601132206.GF23771@pengutronix.de>
	<201106011724.26704.arnd@arndb.de>
Message-ID: <20110601164731.GI23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 05:24:26PM +0200, Arnd Bergmann wrote:
> On Wednesday 01 June 2011, Sascha Hauer wrote:
> > 
> > This allows for all armv4 and armv5 based i.MX systems to be compiled
> > together in one kernel. To accomplish this we need ARM_PATCH_PHYS_VIRT
> > and AUTO_ZRELADDR which is selected in Kconfig.
> > As compiling with ARM_PATCH_PHYS_VIRT breaks XIP support and different
> > PHYS_OFFSETs break uImage support the old way to integrate only one
> > of these SoCs is kept in place.
> 
> Great stuff!
> 
> My main concern is that it's really confusing to have so many symbols
> with slightly different scopes:
> 
> * SOC_SELECT_IMX1  HAVE_SOC_IMX1  ARCH_MX1  SOC_IMX1
> * SOC_SELECT_IMX21 HAVE_SOC_IMX21 ARCH_MX2  SOC_IMX21

The ARCH_MX* macros should be removed, but some driver Kconfig entries
still depend on them.

> 
> Are you sure that this is actually the minimum set that is required?

I'd love to remove some of these, but I think they are required.
SOC_SELECT_IMX1 and HAVE_SOC_IMX1 are only used to offer the right
Kconfig magic.

> 
> I assume that you have gone through all the uses of these symbols
> to check that there is no silent breakage if you enable more than
> one. The only ones that looks suspicious to me are
> arch/arm/plat-mxc/include/mach/timex.h

See An earlier patch in this series. The ifdefs are removed and
CLOCK_TICK_RATE is replaced with a bogus value. CLOCK_TICK_RATE
is unused but still required to compile the kernel.

> and
> arch/arm/plat-mxc/include/mach/debug-macro.S.

This can be used only when only one family is compiled in. Doing
otherwise should be catched with an error during comppilation.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

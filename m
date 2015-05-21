From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 17:40:03 +0200
Subject: [GIT PULL 2/2] omap1 sparse irq support for v4.2
In-Reply-To: <20150521145840.GQ10274@atomide.com>
References: <80194352.chs4cqVdmg@wuerfel> <20150521145840.GQ10274@atomide.com>
Message-ID: <2613552.WPU8qB3AF6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 07:58:41 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [150521 05:13]:
> > On Wednesday 20 May 2015 15:36:05 Tony Lindgren wrote:
> > > Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> > > to making omap1 support multiarch. After this series we still need to
> > > make omap1 use the common clock framework and fix up the drivers to not
> > > rely on includes from mach and plat directories.
> > > 
> > > Note that this branch depends on a GPIO driver fix in v4.1-rc3
> > > d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> > > 
> > 
> > I'm getting lots of build errors in linux-next, which I think are
> > caused by this series.
> 
> Hmm is this with make randconfig?

Yes, all sorts of randconfig builds hit different parts here

> What's the Kconfig option enabling these errors?

>From what I can tell, this is simply a result of enabling
CONFIG_SPARSE_IRQ, which results in linux/irq.h no longer
implicitly including  mach/hardware.h through mach/irqs.h.

You should be able to see these errors by just enabling
the respective drivers. The errors manifest as a long list
of undefined symbols like

/git/arm-soc/arch/arm/mach-omap1/io.c:33:28: error: 'OMAP1_IO_OFFSET' undeclared here (not in a function)
/git/arm-soc/arch/arm/mach-omap1/io.c:43:14: error: 'OMAP7XX_DSP_BASE' undeclared here (not in a function)
/git/arm-soc/arch/arm/mach-omap1/serial.c:114:33: note: each undeclared identifier is reported only once for each function it appears in
/git/arm-soc/arch/arm/mach-omap1/pm.c:217:23: error: 'ULPD_SOFT_DISABLE_REQ_REG' undeclared (first use in this function)
/git/arm-soc/drivers/video/fbdev/omap/sossi.c:608:17: error: 'MOD_CONF_CTRL_1' undeclared (first use in this function)

Then again, it is possible that I only see the errors because of
an interaction with another patch from my randconfig fixes
series.

	Arnd

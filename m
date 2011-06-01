From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Jun 2011 17:24:26 +0200
Subject: [PATCH 5/8 v2] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <20110601132206.GF23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
	<20110601132206.GF23771@pengutronix.de>
Message-ID: <201106011724.26704.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 June 2011, Sascha Hauer wrote:
> 
> This allows for all armv4 and armv5 based i.MX systems to be compiled
> together in one kernel. To accomplish this we need ARM_PATCH_PHYS_VIRT
> and AUTO_ZRELADDR which is selected in Kconfig.
> As compiling with ARM_PATCH_PHYS_VIRT breaks XIP support and different
> PHYS_OFFSETs break uImage support the old way to integrate only one
> of these SoCs is kept in place.

Great stuff!

My main concern is that it's really confusing to have so many symbols
with slightly different scopes:

* SOC_SELECT_IMX1  HAVE_SOC_IMX1  ARCH_MX1  SOC_IMX1
* SOC_SELECT_IMX21 HAVE_SOC_IMX21 ARCH_MX2  SOC_IMX21

Are you sure that this is actually the minimum set that is required?

I assume that you have gone through all the uses of these symbols
to check that there is no silent breakage if you enable more than
one. The only ones that looks suspicious to me are
arch/arm/plat-mxc/include/mach/timex.h and
arch/arm/plat-mxc/include/mach/debug-macro.S. The first one
is probably harmless, because we don't really use the CLOCK_TICK_RATE
any more, the second one I can't tell.

	Arnd

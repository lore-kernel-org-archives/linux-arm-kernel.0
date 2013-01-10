From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 10 Jan 2013 01:38:36 +0100
Subject: [RFC PATCH 5/7] ARM: s3c64xx: Add board file for boot using
 Device Tree
In-Reply-To: <00aa01cdeec8$e48ba7c0$ada2f740$@samsung.com>
References: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
 <1357774909-29938-6-git-send-email-tomasz.figa@gmail.com>
 <00aa01cdeec8$e48ba7c0$ada2f740$@samsung.com>
Message-ID: <2541046.aUZy19q6jk@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Wednesday 09 of January 2013 16:24:42 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > This patch adds board file that will be used to boot S3C64xx-based
> > boards using Device Tree.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> > 
> >  arch/arm/mach-s3c64xx/Kconfig           | 13 +++++
> >  arch/arm/mach-s3c64xx/Makefile          |  1 +
> >  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 93
> > 
> > +++++++++++++++++++++++++++++++++
> > 
> >  3 files changed, 107 insertions(+)
> >  create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
> > 
> > diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-
> > s3c64xx/Kconfig
> > index 131c862..a43b3f7 100644
> > --- a/arch/arm/mach-s3c64xx/Kconfig
> > +++ b/arch/arm/mach-s3c64xx/Kconfig
> > @@ -309,3 +309,16 @@ config MACH_WLF_CRAGG_6410
> > 
> >  	select SAMSUNG_GPIO_EXTRA128
> >  	help
> >  	
> >  	  Machine support for the Wolfson Cragganmore S3C6410 variant.
> > 
> > +
> > +config MACH_S3C64XX_DT
> > +	bool "Samsung S3C6400/S3C6410 machine using Device Tree"
> > +	select CPU_S3C6400
> > +	select CPU_S3C6410
> > +	select USE_OF
> > +	help
> > +	  Machine support for Samsung S3C6400/S3C6410 machines with
> > Device Tree
> > +	  enabled.
> > +	  Select this if a fdt blob is available for your S3C64XX SoC based
> > +	  board.
> > +	  Note: This is under development and not all peripherals can be
> > +	  supported with this machine file.
> > diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-
> > s3c64xx/Makefile
> > index f9ce1dc..59b3d06 100644
> > --- a/arch/arm/mach-s3c64xx/Makefile
> > +++ b/arch/arm/mach-s3c64xx/Makefile
> > @@ -58,3 +58,4 @@ obj-$(CONFIG_MACH_SMARTQ7)		+= mach-
> > smartq7.o
> > 
> >  obj-$(CONFIG_MACH_SMDK6400)		+= mach-smdk6400.o
> >  obj-$(CONFIG_MACH_SMDK6410)		+= mach-smdk6410.o
> >  obj-$(CONFIG_MACH_WLF_CRAGG_6410)	+= mach-crag6410.o mach-
> > 
> > crag6410-module.o
> > +obj-$(CONFIG_MACH_S3C64XX_DT)		+= mach-s3c64xx-dt.o
> > diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-
> > s3c64xx/mach-s3c64xx-dt.c
> > new file mode 100644
> > index 0000000..f5725ce
> > --- /dev/null
> > +++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
> > @@ -0,0 +1,93 @@
> > +/*
> > + * Samsung's S3C64XX flattened device tree enabled machine
> > + *
> > + * Copyright (c) 2012 Tomasz Figa <tomasz.figa@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify + * it under the terms of the GNU General Public License
> > version 2 as + * published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/of_platform.h>
> > +#include <linux/serial_core.h>
> > +
> > +#include <asm/mach/arch.h>
> > +#include <asm/hardware/vic.h>
> > +#include <mach/map.h>
> > +
> > +#include <plat/cpu.h>
> > +#include <plat/regs-serial.h>
> > +#include <plat/s5p-time.h>
> > +
> > +#include "common.h"
> > +
> > +/*
> > + * The following lookup table is used to override device names when
> > devices
> > + * are registered from device tree. This is temporarily added to
> > enable + * device tree support addition for the Exynos4 architecture.
> > + *
> > + * For drivers that require platform data to be provided from the
> > machine + * file, a platform data pointer can also be supplied along
> > with the + * devices names. Usually, the platform data elements that
> > cannot be parsed
> > + * from the device tree by the drivers (example: function pointers)
> > are + * supplied. But it should be noted that this is a temporary
> > mechanism
> and
> 
> > + * at some point, the drivers should be capable of parsing all the
> 
> platform
> 
> > + * data from the device tree.
> > + */
> > +static const struct of_dev_auxdata s3c64xx_auxdata_lookup[]
> > __initconst = {
> > +	OF_DEV_AUXDATA("samsung,s3c6400-uart", S3C_PA_UART0,
> > +				"s3c6400-uart.0", NULL),
> > +	OF_DEV_AUXDATA("samsung,s3c6400-uart", S3C_PA_UART1,
> > +				"s3c6400-uart.1", NULL),
> > +	OF_DEV_AUXDATA("samsung,s3c6400-uart", S3C_PA_UART2,
> > +				"s3c6400-uart.2", NULL),
> > +	OF_DEV_AUXDATA("samsung,s3c6400-uart", S3C_PA_UART3,
> > +				"s3c6400-uart.3", NULL),
> 
> I'd prefer to use 0x7F005000 instead of S3C_PA_UART0 so that we can
> remove the static definitions at the map.h

Ideally, I would like to completely get rid of this and start cleanly with 
common clock framework, but support for it would be probably based on 
Thomas Abraham's code for Exynos, which would have to be merged first.

So for now I will replace symbolic addresses with numeric ones, as you 
suggested.

> > +	{},
> > +};
> > +
> > +static void __init s3c64xx_dt_map_io(void)
> > +{
> > +	s3c64xx_init_io(NULL, 0);
> > +	s3c24xx_init_clocks(12000000);
> 
> The value of xtal clock for s3c24xx_init_clocks() should be defined via
> dt according to board condition _next_time_  because it can be
> different on each board, it's same on current s3c64xx boards though.

This is yet another issue that will be solved by using Common 
Clock Framework.

> > +}
> > +
> > +static void __init s3c64xx_dt_machine_init(void)
> > +{
> > +	of_platform_populate(NULL, of_default_bus_match_table,
> > +				s3c64xx_auxdata_lookup, NULL);
> > +}
> > +
> > +static char const *s3c6400_dt_compat[] __initdata = {
> > +	"samsung,s3c6400",
> > +	NULL
> > +};
> > +
> > +DT_MACHINE_START(S3C6400_DT, "Samsung S3C6400 (Flattened Device
> > Tree)")
> > +	/* Maintainer: Tomasz Figa <tomasz.figa@gmail.com> */
> > +	.init_irq	= s3c6400_init_irq,
> > +	.map_io		= s3c64xx_dt_map_io,
> > +	.handle_irq	= vic_handle_irq,
> > +	.init_machine	= s3c64xx_dt_machine_init,
> > +	.init_late	= s3c64xx_init_late,
> > +	.timer		= &s3c24xx_timer,
> > +	.dt_compat	= s3c6400_dt_compat,
> > +	.restart        = s3c64xx_restart,
> > +MACHINE_END
> > +
> > +static char const *s3c6410_dt_compat[] __initdata = {
> > +	"samsung,s3c6410",
> > +	NULL
> > +};
> 
> I think, we don't need separation.

These two differ in init_irq callback, but now as I look at it, all the 
data are already being parsed from device tree, so I will just add 
s3c64xx_of_init_irq and make just one DT machine.

Best regards,
Tomasz Figa

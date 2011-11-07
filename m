From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Nov 2011 23:06:42 +0100
Subject: [PATCH 2/3 RESEND] ARM: pxa: Add DT testing machine
In-Reply-To: <4EB854BC.8020203@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-3-git-send-email-marek.vasut@gmail.com>
 <4EB854BC.8020203@gmail.com>
Message-ID: <201111072306.43015.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 11/07/2011 03:31 PM, Marek Vasut wrote:
> > I use the Voipac PXA270 board for PXA DT conversion. This board is a
> > helper for the conversion to go smoothly and the testing to be easy.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <robherring2@gmail.com>
> > ---
> > 
> >  arch/arm/mach-pxa/Kconfig      |   15 +++++++
> >  arch/arm/mach-pxa/Makefile     |    3 +
> >  arch/arm/mach-pxa/vpac270-dt.c |   82
> >  ++++++++++++++++++++++++++++++++++++++++ arch/arm/mach-pxa/vpac270.c   
> >  |    2 +
> >  4 files changed, 102 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/vpac270-dt.c
> > 
> > diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> > index 61d3c72..a9bba3d 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -616,6 +616,21 @@ config MACH_ZIPIT2
> > 
> >  	bool "Zipit Z2 Handheld"
> >  	select PXA27x
> >  	select HAVE_PWM
> 
> Add a blank line.
> 
> > +config MACH_VPAC_DT
> > +	bool "PXA (Voipac270) FDT Machine"
> 
> This should be more generic to be all PXA DT machines.

I need an initial porting machine, isn't it explicit enough ... the description 
below I mean.

> 
> > +	select PXA27x
> > +	select OF
> > +	depends on !MACH_VPAC270 && EXPERIMENTAL
> 
> Drop these depends.

Nope
> 
> > +	help
> > +	  PXA Device Tree Machine.
> > +	  This is to be a generic machine which probes all of it's drivers
> > +	  using the Flattened Device Tree blob. This is work-in-progress
> > +	  so don't expect much yet. We selected the Voipac PXA270 device
> > +	  as a base device to test support along the way.
> > +
> > +	  NOTE: This platform is mutually exclusive with the original!
> 
> It shouldn't need to be.

I want it that way ... eventually, this will be renamed to PXA_DT, but not now.
> 
> > +	  NOTE: Use only if you know what you're doing!!
> > +
> > 
> >  endif
> >  endmenu
> > 
> > diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> > index be0f7df..2b80829 100644
> > --- a/arch/arm/mach-pxa/Makefile
> > +++ b/arch/arm/mach-pxa/Makefile
> > @@ -104,3 +104,6 @@ led-$(CONFIG_ARCH_PXA_IDP)	+= leds-idp.o
> > 
> >  obj-$(CONFIG_LEDS)		+= $(led-y)
> >  
> >  obj-$(CONFIG_TOSA_BT)		+= tosa-bt.o
> > 
> > +
> > +# PXA FDT board
> > +obj-$(CONFIG_MACH_VPAC_DT)	+= vpac270-dt.o
> > diff --git a/arch/arm/mach-pxa/vpac270-dt.c
> > b/arch/arm/mach-pxa/vpac270-dt.c new file mode 100644
> > index 0000000..dc9a6dd
> > --- /dev/null
> > +++ b/arch/arm/mach-pxa/vpac270-dt.c
> > @@ -0,0 +1,82 @@
> > +/*
> > + * Hardware definitions for Voipac PXA270 driven by FDT
> > + *
> > + * Copyright (C) 2011 Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * NOTE: This is an ongoing effort of preparing generic FDT-based board
> > + *       for PXA machines. This particular device allows us to test the
> > + *       support for breakage.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/of_platform.h>
> > +#include <linux/irqdomain.h>
> > +#include "vpac270.c"
> > +
> > +/***********************************************************************
> > ******* + * Machine init
> > +
> > ************************************************************************
> > ******/ +static const struct of_device_id pxairq_of_match[] __initconst =
> > { +	{ .compatible = "marvell,pxa-irq", },
> > +	{},
> > +};
> > +
> > +static void __init pxa_dt_init_irq(void)
> > +{
> > +	irq_domain_generate_simple(pxairq_of_match, 0x40d00000, 0);
> > +	pxa27x_init_irq();
> 
> Ideally the interrupt controller itself would be converted over to
> support domains and DT init.

That's the long-term plan.
> 
> > +}
> > +
> > +static struct of_device_id pxa_dt_match_table[] __initdata = {
> > +	{ .compatible = "simple-bus", },
> > +	{}
> > +};
> 
> Any reason you can't use the default table?

What default table?
> 
> > +
> > +static const struct of_dev_auxdata pxa_dt_auxdata_table[] __initconst =
> > { +	OF_DEV_AUXDATA("marvell,pxa2xx-uart", 0x40100000, "pxa2xx-uart.0",
> > NULL), +	OF_DEV_AUXDATA("marvell,pxa2xx-uart", 0x40200000,
> > "pxa2xx-uart.1", NULL), +	OF_DEV_AUXDATA("marvell,pxa2xx-uart",
> > 0x40700000, "pxa2xx-uart.2", NULL), +};
> 
> Is this for clkdev? If so, you can just add additional lookups using the
> DT device name.

What do you mean?
> 
> > +
> > +static void __init vpac270_dt_init(void)
> > +{
> > +	pxa2xx_mfp_config(ARRAY_AND_SIZE(vpac270_pin_config));
> > +
> > +	of_platform_populate(NULL, pxa_dt_match_table,
> > +				pxa_dt_auxdata_table, NULL);
> > +
> > +	pxa_set_i2c_info(NULL);
> > +	pxa27x_set_i2c_power_info(NULL);
> > +
> > +	vpac270_pmic_init();
> > +	vpac270_lcd_init();
> > +	vpac270_mmc_init();
> > +	vpac270_nor_init();
> > +	vpac270_onenand_init();
> > +	vpac270_leds_init();
> > +	vpac270_keys_init();
> > +	vpac270_uhc_init();
> > +	vpac270_udc_init();
> > +	vpac270_eth_init();
> > +	vpac270_ts_init();
> > +	vpac270_rtc_init();
> > +	vpac270_ide_init();
> 
> Generally, devices get added as they are converted to use DT.

Well the board won't boot purely from DT yet ... and to see it breaks nothing, 
I'm comparing it to non-dt implementation.
> 
> > +}
> > +
> > +static const char *vpac270_dt_board_compat[] __initdata = {
> > +	"voipac,vpac270",
> > +	NULL
> > +};
> > +
> > +DT_MACHINE_START(PXA_DT, "Marvell PXA2xx/PXA3xx (Flattened Device
> > Tree)") +	.map_io		= pxa27x_map_io,
> > +	.init_irq	= pxa_dt_init_irq,
> > +	.handle_irq	= pxa27x_handle_irq,
> > +	.timer		= &pxa_timer,
> > +	.init_machine	= vpac270_dt_init,
> > +	.dt_compat	= vpac270_dt_board_compat,
> > +MACHINE_END
> > diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> > index a7539a6..339ecdf 100644
> > --- a/arch/arm/mach-pxa/vpac270.c
> > +++ b/arch/arm/mach-pxa/vpac270.c
> > @@ -715,6 +715,7 @@ static void __init vpac270_init(void)
> > 
> >  	vpac270_ide_init();
> >  
> >  }
> > 
> > +#ifndef	CONFIG_MACH_VPAC_DT
> > 
> >  MACHINE_START(VPAC270, "Voipac PXA270")
> >  
> >  	.atag_offset	= 0x100,
> >  	.map_io		= pxa27x_map_io,
> > 
> > @@ -723,3 +724,4 @@ MACHINE_START(VPAC270, "Voipac PXA270")
> > 
> >  	.timer		= &pxa_timer,
> >  	.init_machine	= vpac270_init
> >  
> >  MACHINE_END
> > 
> > +#endif
> 
> You shouldn't need this ifndef.

For some reason, it refuses to boot if I do have both compiled in.

> 
> Rob

M

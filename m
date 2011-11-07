From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Nov 2011 23:24:25 +0100
Subject: [PATCH 2/3] ARM: pxa: Add DT testing machine
In-Reply-To: <20111107221805.GD28491@ponder.secretlab.ca>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320172354-3795-3-git-send-email-marek.vasut@gmail.com>
 <20111107221805.GD28491@ponder.secretlab.ca>
Message-ID: <201111072324.25796.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Nov 01, 2011 at 07:32:33PM +0100, Marek Vasut wrote:
> > I use the Voipac PXA270 board for PXA DT conversion. This board is a
> > helper for the conversion to go smoothly and the testing to be easy.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> >  arch/arm/mach-pxa/Kconfig      |   15 +++++++
> >  arch/arm/mach-pxa/Makefile     |    3 +
> >  arch/arm/mach-pxa/vpac270-dt.c |   82
> >  ++++++++++++++++++++++++++++++++++++++++ 3 files changed, 100
> >  insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/vpac270-dt.c
> > 
> > diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> > index cd19309..e152a9c 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -599,6 +599,21 @@ config MACH_ZIPIT2
> > 
> >  	select PXA27x
> >  	select HAVE_PWM
> > 
> > +config MACH_VPAC_DT
> > +	bool "PXA (Voipac270) FDT Machine"
> > +	select PXA27x
> > +	select OF
> > +	depends on !MACH_VPAC270 && EXPERIMENTAL
> > +	help
> > +	  PXA Device Tree Machine.
> > +	  This is to be a generic machine which probes all of it's drivers
> > +	  using the Flattened Device Tree blob. This is work-in-progress
> > +	  so don't expect much yet. We selected the Voipac PXA270 device
> > +	  as a base device to test support along the way.
> > +
> > +	  NOTE: This platform is mutually exclusive with the original!
> > +	  NOTE: Use only if you know what you're doing!!
> > +
> > 
> >  endmenu
> >  
> >  config PXA25x
> > 
> > diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> > index cc39d17..5f69281 100644
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
> 
> Rather that starting with a file named for a specific machine, I'd
> recommend something like pxa270-dt.c that will start with Voipac
> support only, but will grow support for other boards over time.

Hi Grant, well ok, I have no problem with that. Can you apply the rest of the 
patches (0001, 0003)?

> 
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
> > +}
> > +
> > +static struct of_device_id pxa_dt_match_table[] __initdata = {
> > +	{ .compatible = "simple-bus", },
> > +	{}
> > +};
> 
> You can use the stock of_default_bus_match_table[] instead of adding
> another one.

Thanks for explaining!
> 
> > +
> > +static const struct of_dev_auxdata pxa_dt_auxdata_table[] __initconst =
> > { +	OF_DEV_AUXDATA("marvell,pxa2xx-uart", 0x40100000, "pxa2xx-uart.0",
> > NULL), +	OF_DEV_AUXDATA("marvell,pxa2xx-uart", 0x40200000,
> > "pxa2xx-uart.1", NULL), +	OF_DEV_AUXDATA("marvell,pxa2xx-uart",
> > 0x40700000, "pxa2xx-uart.2", NULL), +};
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
> Ideally of course, all this stuff would be handled in device drivers
> based on platform_devices created by of_platform_populate(). 

Exactly

> In the
> short term, you could have one machine specific setup function for
> each supported machine and chose the one to execute based on the top
> level compatible property.

Yes, that's also true. This looks doable as a short-term solution (until DT for 
PXA is more complete).

> 
> Alternatively, you could make this new support file only support a
> subset of devices that can currently work with device tree, and then
> build it up as drivers gain DT support.  It will be easier to pull in
> additional board support that way.

That's a problem actually. The thing won't even boot without some of the stuff 
registered here :-/

The other option is for me to keep it out of tree and apply this one only when I 
have this device working cleanly with DT.
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

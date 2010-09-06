From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 6 Sep 2010 06:40:26 +0200
Subject: [PATCH 3/4] ARM: S5PC110: add common FIMC setup code
In-Reply-To: <4C846F54.6070406@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
	<201009060616.18100.marek.vasut@gmail.com>
	<4C846F54.6070406@samsung.com>
Message-ID: <201009060640.26462.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 6. z??? 2010 06:34:28 Marek Szyprowski napsal(a):
> Hello,
> 
> On 2010-09-06 13:16 Marek Vasut wrote:
> > Dne Po 6. z??? 2010 05:50:43 Marek Szyprowski napsal(a):
> >> Add common clocks setup code for FIMC devices on S5PV210 SoCs.
> >> 
> >> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> >> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> >> ---
> >> 
> >>   arch/arm/mach-s5pv210/Kconfig             |    6 ++++
> >>   arch/arm/mach-s5pv210/Makefile            |    1 +
> >>   arch/arm/mach-s5pv210/setup-fimc.c        |   46
> >> 
> >> +++++++++++++++++++++++++++++ arch/arm/plat-samsung/include/plat/fimc.h
> >> |
> >> 
> >>   24 +++++++++++++++
> >>   4 files changed, 77 insertions(+), 0 deletions(-)
> >>   create mode 100644 arch/arm/mach-s5pv210/setup-fimc.c
> >>   create mode 100644 arch/arm/plat-samsung/include/plat/fimc.h
> >> 
> >> diff --git a/arch/arm/mach-s5pv210/Kconfig
> >> b/arch/arm/mach-s5pv210/Kconfig index d3a3895..48489bb 100644
> >> --- a/arch/arm/mach-s5pv210/Kconfig
> >> +++ b/arch/arm/mach-s5pv210/Kconfig
> >> @@ -37,6 +37,12 @@ config S5PV210_SETUP_FB_24BPP
> >> 
> >>   	help
> >>   	
> >>             Common setup code for S5PV210 with an 24bpp RGB display
> >>             helper.
> >> 
> >> +config S5PV210_SETUP_FIMC
> >> +	bool
> >> +	help
> >> +	  Compile common code for S5PV210 based machines to setup correct
> >> +	  FIMC clock parameters.
> >> +
> >> 
> >>   config S5PV210_SETUP_KEYPAD
> >>   
> >>   	bool
> >>   	help
> >> 
> >> diff --git a/arch/arm/mach-s5pv210/Makefile
> >> b/arch/arm/mach-s5pv210/Makefile index 05048c5..c13aef1 100644
> >> --- a/arch/arm/mach-s5pv210/Makefile
> >> +++ b/arch/arm/mach-s5pv210/Makefile
> >> @@ -29,6 +29,7 @@ obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> >> 
> >>   obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
> >>   
> >>   obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
> >> 
> >> +obj-$(CONFIG_S5PV210_SETUP_FIMC)	+= setup-fimc.o
> >> 
> >>   obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
> >>   obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
> >>   obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
> >> 
> >> diff --git a/arch/arm/mach-s5pv210/setup-fimc.c
> >> b/arch/arm/mach-s5pv210/setup-fimc.c new file mode 100644
> >> index 0000000..80c1ffe
> >> --- /dev/null
> >> +++ b/arch/arm/mach-s5pv210/setup-fimc.c
> >> @@ -0,0 +1,46 @@
> >> +/*
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + *		http://www.samsung.com/
> >> + *
> >> + * S5PV210 clock setup code for FIMC devices
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +#include<linux/device.h>
> >> +#include<linux/clk.h>
> >> +#include<linux/err.h>
> >> +#include<plat/devs.h>
> >> +#include<plat/fimc.h>
> >> +
> >> +int __init s5pv210_fimc_setup_clks(void)
> >> +{
> >> +	int err = 0;
> >> +	int i;
> >> +	struct clk *clk_fimc, *parent;
> >> +
> >> +	struct device *fimc_devs[] = {
> >> +		&s5p_device_fimc0.dev,
> >> +		&s5p_device_fimc1.dev,
> >> +		&s5p_device_fimc2.dev
> >> +	};
> >> +
> >> +	parent = clk_get(NULL, "mout_epll");
> >> +	if (IS_ERR(parent))
> >> +		return PTR_ERR(parent);
> >> +
> >> +	for (i = 0; err == 0&&  i<  ARRAY_SIZE(fimc_devs); i++) {
> >> +		if (fimc_devs[i]) {
> >> +			clk_fimc = clk_get(fimc_devs[i], "sclk_fimc");
> >> +			if (IS_ERR(clk_fimc)) {
> >> +				err = PTR_ERR(clk_fimc);
> > 
> > I believe you should clk_put() the clocks that were already clk_get()-ed
> > here.

Ah, please ignore my stupid comment then, I missed this one.
> 
> They are, see clk_put after clk_set_parent.
> 
> > Cheers
> > 
> >> +				break;

btw. can the array fimc_devs[] be sparse ? So you'd replace this break; with 
continue; ?

Well ... it's ok :)

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

> >> +			}
> >> +			clk_set_parent(clk_fimc, parent);
> >> +			clk_put(clk_fimc);
> >> +		}
> >> +	}
> >> +	clk_put(parent);
> >> +	return err;
> >> +}
> >> diff --git a/arch/arm/plat-samsung/include/plat/fimc.h
> >> b/arch/arm/plat-samsung/include/plat/fimc.h new file mode 100644
> >> index 0000000..2c06f37
> >> --- /dev/null
> >> +++ b/arch/arm/plat-samsung/include/plat/fimc.h
> >> @@ -0,0 +1,24 @@
> >> +/*
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + *		http://www.samsung.com/
> >> + *
> >> + * Common FIMC devices definitions and helper functions
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +#ifndef __PLAT_SAMSUNG_FIMC_H
> >> +#define __PLAT_SAMSUNG_FIMC_H __FILE__
> >> +
> >> +/**
> >> + * s5pv210_fimc_setup_clks() - S5PV210/S5PC110 fimc clocks setup
> >> function + *
> >> + * Set correct parent clocks on machines which bootloaded did not
> >> configured + * fimc clocks correctly. FIMC devices works properly only
> >> if sourced from + * certain clock sources. "mout_epll" clock is the
> >> recommended one. + */
> >> +extern int s5pv210_fimc_setup_clks(void);
> >> +
> >> +#endif /* __PLAT_SAMSUNG_FIMC_H */
> 
> Best regards

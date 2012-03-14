From: sr@denx.de (Stefan Roese)
Date: Wed, 14 Mar 2012 08:20:18 +0100
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <4F604321.9000204@st.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <4F604321.9000204@st.com>
Message-ID: <201203140820.18461.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012 08:05:05 Viresh Kumar wrote:
> Other than Arnd's comments:
> 
> On 3/13/2012 8:17 PM, Stefan Roese wrote:
> > diff --git a/arch/arm/boot/dts/spear600-evb.dts
> > b/arch/arm/boot/dts/spear600-evb.dts new file mode 100644
> > index 0000000..f92d099
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/spear600-evb.dts
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> 
> Just for knowledge, why are above two here? Is including them suggested for
> all dts files?

I cloned this file from another dtsi file, where those copyright lines were 
present. Not sure if I need to preserve them in the new file.
 
> > + * Copyright 2012 Stefan Roese <sr@denx.de>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > 
> > 
> > diff --git a/arch/arm/mach-spear6xx/Kconfig
> > b/arch/arm/mach-spear6xx/Kconfig index ff4ae5b..7777f72 100644
> > --- a/arch/arm/mach-spear6xx/Kconfig
> > +++ b/arch/arm/mach-spear6xx/Kconfig
> > @@ -11,6 +11,13 @@ config BOARD_SPEAR600_EVB
> > 
> >  	help
> >  	
> >  	  Supports ST SPEAr600 Evaluation Board
> > 
> > +config BOARD_SPEAR600_DT
> > +	bool "SPEAr600 generic board configured via device-tree"
> > +	select MACH_SPEAR600
> > +	select USE_OF
> > +	help
> > +	  Supports ST SPEAr600 boards configured via the device-tree
> > +
> > 
> >  endmenu
> >  
> >  config MACH_SPEAR600
> > 
> > diff --git a/arch/arm/mach-spear6xx/Makefile
> > b/arch/arm/mach-spear6xx/Makefile index cc1a4d8..e2d79b8 100644
> > --- a/arch/arm/mach-spear6xx/Makefile
> > +++ b/arch/arm/mach-spear6xx/Makefile
> > @@ -10,3 +10,4 @@ obj-$(CONFIG_MACH_SPEAR600) += spear600.o
> > 
> >  # spear600 boards files
> >  obj-$(CONFIG_BOARD_SPEAR600_EVB) += spear600_evb.o
> > 
> > +obj-$(CONFIG_BOARD_SPEAR600_DT) += board-dt.o
> > diff --git a/arch/arm/mach-spear6xx/board-dt.c
> > b/arch/arm/mach-spear6xx/board-dt.c new file mode 100644
> > index 0000000..ee4ff33
> > --- /dev/null
> > +++ b/arch/arm/mach-spear6xx/board-dt.c
> > @@ -0,0 +1,75 @@
> > +/*
> > + * arch/arm/mach-spear6xx/board-dt.c
> > + *
> > + * Generic SPEAr600 platform support
> > + *
> > + * Copyright (C) 2009 ST Microelectronics
> > + * Viresh Kumar<viresh.kumar@st.com>
> 
>                   ^
> Thanks for this. Can add space here between r & <.

Okay.
 
> > + *
> > + * Copyright 2012 Stefan Roese <sr@denx.de>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> 
> keeping header files in alphabetical order makes life easy at
> later stages. :)

Yes.
 
> > +#include <asm/hardware/vic.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach-types.h>
> > +#include <mach/generic.h>
> > +#include <mach/hardware.h>
> > +
> > +static struct amba_device *amba_devs[] __initdata = {
> > +	&gpio_device[0],
> > +	&gpio_device[1],
> > +	&gpio_device[2],
> > +	&uart_device[0],
> > +	&uart_device[1],
> > +};
> > +
> > +static struct platform_device *plat_devs[] __initdata = {
> > +};
> > +
> > +static void __init spear600_dt_init(void)
> > +{
> > +	unsigned int i;
> > +
> > +	/* call spear600 machine init function */
> > +	spear600_init();
> > +
> > +	/* Add Platform Devices */
> > +	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
> > +
> > +	/* Add Amba Devices */
> > +	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
> > +		amba_device_register(amba_devs[i], &iomem_resource);
> > +}
> > +
> > +static const char *spear600_dt_board_compat[] = {
> > +	"st,spear600-evb",
> > +	NULL
> > +};
> > +
> > +static const struct of_device_id vic_of_match[] __initconst = {
> > +	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
> > +	{ /* Sentinel */ }
> > +};
> > +
> > +static void __init spear6xx_dt_init_irq(void)
> > +{
> > +	of_irq_init(vic_of_match);
> > +}
> > +
> 
> What about adding this routine in vic.c file, which can then be used
> by all platforms, instead of replicating this code.

Let me check this.
 
> > +DT_MACHINE_START(SPEAR600_DT, "ST-SPEAR600-DT")
> 
> It looks this is not a generic file for all boards, but for a
> single board? And that would be evb only?
> 
> If above is true, we may name this file and internal stuff more
> appropriately.

This file should be a generic SPEAr600 file. Not specific for the EVB. Future 
SPEAr600 board can also use this file. The differences between the boards 
should be encapsulated in the board specific dts files.
 
Thanks,
Stefan

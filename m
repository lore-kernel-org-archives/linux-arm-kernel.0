From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Mon, 27 Jul 2015 18:24:26 +0000
Subject: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <20150727132802.GK12927@tiger>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
 <20150727132802.GK12927@tiger>
Message-ID: <CY1PR0301MB084353EB59E199271D536F68838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?7?27? 8:28
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net; Huang
> Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
> 
> > ---
> >  arch/arm/mach-imx/Kconfig        |   1 +
> >  arch/arm/mach-imx/Makefile       |   2 +
> >  arch/arm/mach-imx/pm-imx7.c      | 765
> +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-imx/suspend-imx7.S | 529 +++++++++++++++++++++++++++
> >  4 files changed, 1297 insertions(+)
> >  create mode 100644 arch/arm/mach-imx/pm-imx7.c  create mode 100644
> > arch/arm/mach-imx/suspend-imx7.S
> >
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 5ccc9ea..4269c1e 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -552,6 +552,7 @@ config SOC_IMX7D
> >  	bool "i.MX7 Dual support"
> >  	select PINCTRL_IMX7D
> >  	select ARM_GIC
> > +	select IMX_GPCV2
> 
> Yes, the existing list is already a bit out of order, but please do not make it worse.
> Add it after HAVE_IMX_MMDC to keep them sort alphabetically.

Okay.
 
> >  	select HAVE_IMX_ANATOP
> >  	select HAVE_IMX_MMDC
> >  	help
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index 37c502a..b2ad476 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -87,6 +87,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> >
> >  ifeq ($(CONFIG_SUSPEND),y)
> >  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> > +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> > +obj-$(CONFIG_IMX_GPCV2)	+= suspend-imx7.o pm-imx7.o
> 
> Shouldn't it be controlled by CONFIG_SOC_IMX7D instead?

CONFIG_IMX_GPCV2 is more suitable here. As long as a SOC has the same GPCv2 block, the codes should be reused.
 

> >  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
> >  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o  endif diff --git
> > a/arch/arm/mach-imx/pm-imx7.c b/arch/arm/mach-imx/pm-imx7.c new file
> > mode 100644 index 0000000..50b9af4
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/pm-imx7.c
> > @@ -0,0 +1,765 @@
> > +
> 
> Drop this new line.
> 
> > +/*
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> 
> Ditto
> 
> > +#include <linux/suspend.h>
> > +#include <asm/suspend.h>
> > +#include <asm/fncpy.h>
> > +
> > +#include <soc/imx/gpcv2.h>
> > +
> > +extern struct imx_gpcv2_irq *gpcv2_irq_instance;
> 
> Will this give a checkpatch warning?

Yes. Any suggestion for that? Move it to a header file?

Thanks,
Shenwei

> > +static struct imx_gpcv2 *gpcv2_instance;
> 
> I stop right here, as I need to understand why we need to have header
> soc/imx/gpcv2.h shared between irqchip driver and pm code.
> 
> Shawn

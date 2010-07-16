From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Jul 2010 16:27:11 +0200
Subject: [PATCH 02/10 v2] ARM: Samsung: Add FIMC resource definition and
	FIMC driver platform helpers
In-Reply-To: <012301cb24ce$cc67aac0$65370040$%kim@samsung.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
	<1279185041-6004-3-git-send-email-s.nawrocki@samsung.com>
	<012301cb24ce$cc67aac0$65370040$%kim@samsung.com>
Message-ID: <000701cb24f2$fa81fea0$ef85fbe0$%nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> -----Original Message-----
> From: Kukjin Kim [mailto:kgene.kim at samsung.com]
> Sent: Friday, July 16, 2010 12:08 PM
> To: 'Sylwester Nawrocki'; linux-samsung-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Cc: p.osciak at samsung.com; m.szyprowski at samsung.com;
> kyungmin.park at samsung.com
> Subject: RE: [PATCH 02/10 v2] ARM: Samsung: Add FIMC resource
> definition and FIMC driver platform helpers
> 
> Sylwester Nawrocki wrote:
> >
> > Add camera interface SoC resource definitions and setup code
> > for FIMC/FB fifo links.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pc100/Kconfig                  |   15 ++++++
> >  arch/arm/mach-s5pc100/Makefile                 |    3 +
> >  arch/arm/mach-s5pc100/include/mach/map.h       |    8 +++
> >  arch/arm/mach-s5pc100/setup-fimc0.c            |   14 ++++++
> >  arch/arm/mach-s5pc100/setup-fimc1.c            |   14 ++++++
> >  arch/arm/mach-s5pc100/setup-fimc2.c            |   14 ++++++
> >  arch/arm/mach-s5pv210/Kconfig                  |   15 ++++++
> >  arch/arm/mach-s5pv210/Makefile                 |    3 +
> >  arch/arm/mach-s5pv210/cpu.c                    |    5 ++
> >  arch/arm/mach-s5pv210/include/mach/map.h       |    8 +++
> >  arch/arm/mach-s5pv210/setup-fimc0.c            |   14 ++++++
> >  arch/arm/mach-s5pv210/setup-fimc1.c            |   14 ++++++
> >  arch/arm/mach-s5pv210/setup-fimc2.c            |   14 ++++++
> >  arch/arm/plat-s5p/Kconfig                      |   16 +++++++
> >  arch/arm/plat-s5p/Makefile                     |    3 +
> >  arch/arm/plat-s5p/dev-fimc0.c                  |   56
> > ++++++++++++++++++++++++
> >  arch/arm/plat-s5p/dev-fimc1.c                  |   55
> > +++++++++++++++++++++++
> >  arch/arm/plat-s5p/dev-fimc2.c                  |   55
> > +++++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/fimc-core.h |   45
> +++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/fimc.h      |   12 +++++
> >  20 files changed, 383 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-s5pc100/setup-fimc0.c
> >  create mode 100644 arch/arm/mach-s5pc100/setup-fimc1.c
> >  create mode 100644 arch/arm/mach-s5pc100/setup-fimc2.c
> >  create mode 100644 arch/arm/mach-s5pv210/setup-fimc0.c
> >  create mode 100644 arch/arm/mach-s5pv210/setup-fimc1.c
> >  create mode 100644 arch/arm/mach-s5pv210/setup-fimc2.c
> >  create mode 100644 arch/arm/plat-s5p/dev-fimc0.c
> >  create mode 100644 arch/arm/plat-s5p/dev-fimc1.c
> >  create mode 100644 arch/arm/plat-s5p/dev-fimc2.c
> >  create mode 100644 arch/arm/plat-samsung/include/plat/fimc-core.h
> >

<snip>

> > +config S5P_DEV_FIMC2
> > +	bool
> > +	help
> > +	  Compile in platform device definitions for FIMC controller 2
> > +
> > +
> 
> 2 empty lines...

OK, will try to pay more attention to these.
 
> 
> >  config PLAT_S5P
> >  	bool
> >  	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 ||
> > ARCH_S5PV210)
> > diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> > index b56b4d3..a7d3c35 100644
> > --- a/arch/arm/plat-s5p/Makefile
> > +++ b/arch/arm/plat-s5p/Makefile
> > @@ -18,3 +18,6 @@ obj-y				+= clock.o
> >  obj-y				+= irq.o irq-gpioint.o
> >  obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
> >
> > +obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
> > +obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
> > +obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
> > diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-
> fimc0.c
> > new file mode 100644
> > index 0000000..cfa10f0
> > --- /dev/null
> > +++ b/arch/arm/plat-s5p/dev-fimc0.c
> > @@ -0,0 +1,56 @@
> > +/* linux/arch/arm/plat-s5p/dev-fimc0.c
> > + *
> > + * Copyright (c) 2010 Samsung Electronics
> > + *
> > + * Base S5P FIMC0 resource and device definitions
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <linux/platform_device.h>
> > +#include <mach/map.h>
> > +#include <mach/irqs.h>
> > +#include <plat/fimc.h>
> > +#include <plat/devs.h>
> > +#include <plat/cpu.h>
> > +
> > +
> 
> Same...2 empty lines...

Please see my comment to previous patch.

> 
> > +static struct resource s5p_fimc_resource[] = {
> > +	[0] = {
> > +		.start	= S5P_PA_FIMC0,
> > +		.end	= S5P_PA_FIMC0 + SZ_1M - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.start	= IRQ_FIMC0,
> > +		.end	= IRQ_FIMC0,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +struct platform_device s5p_device_fimc0 = {
> > +	.name		= "s5p-fimc",
> > +	.id		= 0,
> > +	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
> > +	.resource	= s5p_fimc_resource,
> > +};
> > +
> > +
> 
> 2 empty lines...
> 
> > +void __init s5p_fimc0_set_platdata(struct samsung_plat_fimc *pd)
> 
> Actually, we can use Ben's 's3c_set_platdata' which can replace a
> number of
> sites...
> 
> Please refer to below URL.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-
> May/016650.html
> 
> I think this method is better to us.

Thank you for pointing this out. I expected such changes, but I wanted
to move on with the development so I have done that similar to the other
devices. 
I will rework this part too.

> 
> > +{
> > +	struct samsung_plat_fimc *npd;
> > +
> > +	if (!pd)
> > +		pd = &s5p_fimc0_default_data;
> > +
> > +	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
> > +	if (!npd)
> > +		printk(KERN_ERR "%s: out of memory\n", __func__);
> > +
> > +	s5p_device_fimc0.dev.platform_data = npd;
> > +}
> > +
> 
> No need last empty line

Right, I will clean this up in the next patch version.

> 
> > diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-
> fimc1.c
> > new file mode 100644
> > index 0000000..7178477
> > --- /dev/null
> > +++ b/arch/arm/plat-s5p/dev-fimc1.c
> > @@ -0,0 +1,55 @@
> > +/* linux/arch/arm/plat-s5p/dev-fimc1.c
> > + *
> > + * Copyright (c) 2010 Samsung Electronics
> > + *
> > + * Base S5P FIMC1 resource and device definitions
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <linux/platform_device.h>
> > +#include <mach/map.h>
> > +#include <mach/irqs.h>
> > +#include <plat/fimc.h>
> > +#include <plat/devs.h>
> > +#include <plat/cpu.h>
> > +
> > +
> 2 empty lines..
> 
> > +static struct resource s5p_fimc_resource[] = {
> > +	[0] = {
> > +		.start	= S5P_PA_FIMC1,
> > +		.end	= S5P_PA_FIMC1 + SZ_1M - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.start	= IRQ_FIMC1,
> > +		.end	= IRQ_FIMC1,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +struct platform_device s5p_device_fimc1 = {
> > +	.name		= "s5p-fimc",
> > +	.id		= 1,
> > +	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
> > +	.resource	= s5p_fimc_resource,
> > +};
> > +
> > +void __init s5p_fimc1_set_platdata(struct samsung_plat_fimc *pd)
> > +{
> > +	struct samsung_plat_fimc *npd;
> > +
> > +	if (!pd)
> > +		pd = &s5p_fimc1_default_data;
> > +
> > +	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
> > +	if (!npd)
> > +		printk(KERN_ERR "%s: out of memory\n", __func__);
> > +
> > +	s5p_device_fimc1.dev.platform_data = npd;
> > +}
> > +
> 
> No need last empty line...
> 
> > diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-
> fimc2.c
> > new file mode 100644
> > index 0000000..fe1a6c0
> > --- /dev/null
> > +++ b/arch/arm/plat-s5p/dev-fimc2.c
> > @@ -0,0 +1,55 @@
> > +/* linux/arch/arm/plat-s5p/dev-fimc2.c
> > + *
> > + * Copyright (c) 2010 Samsung Electronics
> > + *
> > + * Base S5P FIMC2 resource and device definitions
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <linux/platform_device.h>
> > +#include <mach/map.h>
> > +#include <mach/irqs.h>
> > +#include <plat/fimc.h>
> > +#include <plat/devs.h>
> > +#include <plat/cpu.h>
> > +
> > +
> 
> Same...
> 
> > +static struct resource s5p_fimc_resource[] = {
> > +	[0] = {
> > +		.start	= S5P_PA_FIMC2,
> > +		.end	= S5P_PA_FIMC2 + SZ_1M - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.start	= IRQ_FIMC2,
> > +		.end	= IRQ_FIMC2,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +struct platform_device s5p_device_fimc2 = {
> > +	.name		= "s5p-fimc",
> > +	.id		= 2,
> > +	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
> > +	.resource	= s5p_fimc_resource,
> > +};
> > +
> > +void __init s5p_fimc2_set_platdata(struct samsung_plat_fimc *pd)
> > +{
> > +	struct samsung_plat_fimc *npd;
> > +
> > +	if (!pd)
> > +		pd = &s5p_fimc2_default_data;
> > +
> > +	npd = kmemdup(pd, sizeof(*npd), GFP_KERNEL);
> > +	if (!npd)
> > +		printk(KERN_ERR "%s: out of memory\n", __func__);
> > +
> > +	s5p_device_fimc2.dev.platform_data = npd;
> > +}
> > +
> 
> Same..
> 

<snip>

> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.

Regards,
Sylwester

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Oct 2011 20:28:32 +0900
Subject: [PATCH 1/2] ARM: Samsung: Add Exynos4 device tree enabled board
	file
In-Reply-To: <20111013175110.GJ18574@ponder.secretlab.ca>
References: <1318342396-26178-1-git-send-email-thomas.abraham@linaro.org>
	<1318342396-26178-2-git-send-email-thomas.abraham@linaro.org>
	<20111013175110.GJ18574@ponder.secretlab.ca>
Message-ID: <000201cc8a64$6775ae30$36610a90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> 
> On Tue, Oct 11, 2011 at 07:43:15PM +0530, Thomas Abraham wrote:
> > Add a new Exynos4 compatible device tree enabled board file. Boards
based on
> > the Exynos4 family of SoC's can use this as the machine/board file. When
using
> > this machine fike, a corresponding device tree blob which describes the
board's
> > properties should be supplied at boot time to the kernel.
> >
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
Thanks for your ack :)

And there are small comments......

> > ---
> >  .../devicetree/bindings/arm/insignal-boards.txt    |    8 ++
> >  .../devicetree/bindings/arm/samsung-boards.txt     |    8 ++
> >  arch/arm/mach-exynos4/Kconfig                      |   14 +++
> >  arch/arm/mach-exynos4/Makefile                     |    2 +
> >  arch/arm/mach-exynos4/mach-exynos4-dt.c            |   85
> ++++++++++++++++++++
> >  5 files changed, 117 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/insignal-
> boards.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung-
> boards.txt
> >  create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c
> >
> > diff --git a/Documentation/devicetree/bindings/arm/insignal-boards.txt
> b/Documentation/devicetree/bindings/arm/insignal-boards.txt
> > new file mode 100644
> > index 0000000..524c3dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/insignal-boards.txt
> > @@ -0,0 +1,8 @@
> > +* Insignal's Exynos4210 based Origen evaluation board
> > +
> > +Origen low-cost evaluation board is based on Samsung's Exynos4210 SoC.
> > +
> > +Required root node properties:
> > +    - compatible = should be one or more of the following.
> > +        (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
> > +        (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
> > diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > new file mode 100644
> > index 0000000..0bf68be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> > @@ -0,0 +1,8 @@
> > +* Samsung's Exynos4210 based SMDKV310 evaluation board
> > +
> > +SMDKV310 evaluation board is based on Samsung's Exynos4210 SoC.
> > +
> > +Required root node properties:
> > +    - compatible = should be one or more of the following.
> > +        (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
> > +        (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
> > diff --git a/arch/arm/mach-exynos4/Kconfig
b/arch/arm/mach-exynos4/Kconfig
> > index 0c5888a..39dc135 100644
> > --- a/arch/arm/mach-exynos4/Kconfig
> > +++ b/arch/arm/mach-exynos4/Kconfig
> > @@ -304,6 +304,20 @@ config MACH_SMDK4412
> >  	help
> >  	  Machine support for Samsung SMDK4412
> >
> > +comment "Flattened Device Tree based board for Exynos4 based SoC"
> > +
> > +config MACH_EXYNOS4_DT

I'm not sure we can use 'MACH_EXYNOS4_DT' here because there are other
EXYNOS4 SoCs such as EXYNOS4212 and EXYNOS4412. So if this cannot support
other SoCs' boards, SMDK4212 and SMDK4412, we need to change the name.

And I wonder whether there is no problem with selecting this and other
boards.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> > +	bool "Samsung Exynos4 Machine using device tree"
> > +	select CPU_EXYNOS4210
> > +	select USE_OF
> > +	select ARM_AMBA
> > +	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
> > +	help
> > +	  Machine support for Samsung Exynos4 machine with device tree
> enabled.
> > +	  Select this if a fdt blob is available for the Exynos4 SoC based
board.
> > +	  Note: This is under development and not all peripherals can be
> supported
> > +	  with this machine file.
> > +
> >  endmenu
> >
> >  comment "Configuration for HSMMC bus width"
> > diff --git a/arch/arm/mach-exynos4/Makefile
b/arch/arm/mach-exynos4/Makefile
> > index 8066538..4e302cb 100644
> > --- a/arch/arm/mach-exynos4/Makefile
> > +++ b/arch/arm/mach-exynos4/Makefile
> > @@ -37,6 +37,8 @@ obj-$(CONFIG_MACH_ORIGEN)		+= mach-
> origen.o
> >  obj-$(CONFIG_MACH_SMDK4212)		+= mach-smdk4x12.o
> >  obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
> >
> > +obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
> > +
> >  # device support
> >
> >  obj-y					+= dev-audio.o
> > diff --git a/arch/arm/mach-exynos4/mach-exynos4-dt.c b/arch/arm/mach-
> exynos4/mach-exynos4-dt.c
> > new file mode 100644
> > index 0000000..85fa027
> > --- /dev/null
> > +++ b/arch/arm/mach-exynos4/mach-exynos4-dt.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * Samsung's Exynos4210 flattened device tree enabled machine
> > + *
> > + * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + * Copyright (c) 2010-2011 Linaro Ltd.
> > + *		www.linaro.org
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/of_platform.h>
> > +#include <linux/serial_core.h>
> > +
> > +#include <asm/mach/arch.h>
> > +#include <mach/map.h>
> > +
> > +#include <plat/cpu.h>
> > +#include <plat/regs-serial.h>
> > +#include <plat/exynos4.h>
> > +
> > +/*
> > + * The following lookup table is used to override device names when
devices
> > + * are registered from device tree. This is temporarily added to enable
> > + * device tree support addition for the Exynos4 architecture.
> > + *
> > + * For drivers that require platform data to be provided from the
machine
> > + * file, a platform data pointer can also be supplied along with the
> > + * devices names. Usually, the platform data elements that cannot be
parsed
> > + * from the device tree by the drivers (example: function pointers) are
> > + * supplied. But it should be noted that this is a temporary mechanism
and
> > + * at some point, the drivers should be capable of parsing all the
platform
> > + * data from the device tree.
> > + */
> > +static const struct of_dev_auxdata exynos4210_auxdata_lookup[]
__initconst =
> {
> > +	OF_DEV_AUXDATA("samsung,exynos4210-uart", S5P_PA_UART0,
> > +				"exynos4210-uart.0", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-uart", S5P_PA_UART1,
> > +				"exynos4210-uart.1", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-uart", S5P_PA_UART2,
> > +				"exynos4210-uart.2", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-uart", S5P_PA_UART3,
> > +				"exynos4210-uart.3", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-sdhci",
> EXYNOS4_PA_HSMMC(0),
> > +				"exynos4-sdhci.0", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-sdhci",
> EXYNOS4_PA_HSMMC(1),
> > +				"exynos4-sdhci.1", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-sdhci",
> EXYNOS4_PA_HSMMC(2),
> > +				"exynos4-sdhci.2", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos4210-sdhci",
> EXYNOS4_PA_HSMMC(3),
> > +				"exynos4-sdhci.3", NULL),
> > +	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(0),
> > +				"s3c2440-i2c.0", NULL),
> > +	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA0, "dma-pl330.0",
> NULL),
> > +	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1",
> NULL),
> > +	{},
> > +};
> > +
> > +static void __init exynos4210_dt_map_io(void)
> > +{
> > +	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> > +	s3c24xx_init_clocks(24000000);
> > +}
> > +
> > +static void __init exynos4210_dt_machine_init(void)
> > +{
> > +	of_platform_populate(NULL, of_default_bus_match_table,
> > +				exynos4210_auxdata_lookup, NULL);
> > +}
> > +
> > +static char const *exynos4210_dt_compat[] __initdata = {
> > +	"samsung,exynos4210",
> > +	NULL
> > +};
> > +
> > +DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device
> Tree)")
> > +	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
> > +	.init_irq	= exynos4_init_irq,
> > +	.map_io		= exynos4210_dt_map_io,
> > +	.init_machine	= exynos4210_dt_machine_init,
> > +	.timer		= &exynos4_timer,
> > +	.dt_compat	= exynos4210_dt_compat,
> > +MACHINE_END
> > --
> > 1.6.6.rc2
> >

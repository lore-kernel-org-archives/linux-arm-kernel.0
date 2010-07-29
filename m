From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Jul 2010 09:30:16 +0900
Subject: [PATCH 1/6] S5PC110: Move OneNAND platform device to plat-s5p
In-Reply-To: <20100728101138.GA21329@july>
References: <20100728101138.GA21329@july>
Message-ID: <006f01cb2eb5$3a53cd80$aefb6880$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
Hi,

Cc'ed Ben Dooks.

> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> To share the same platform device for s5pc210
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig            |    5 ---
>  arch/arm/mach-s5pv210/Makefile           |    1 -
>  arch/arm/mach-s5pv210/dev-onenand.c      |   50
----------------------------
>  arch/arm/mach-s5pv210/include/mach/map.h |    3 --
>  arch/arm/plat-s5p/Kconfig                |    5 +++
>  arch/arm/plat-s5p/Makefile               |    5 ++-
>  arch/arm/plat-s5p/dev-onenand.c          |   53
> ++++++++++++++++++++++++++++++
>  7 files changed, 62 insertions(+), 60 deletions(-)
>  delete mode 100644 arch/arm/mach-s5pv210/dev-onenand.c
>  create mode 100644 arch/arm/plat-s5p/dev-onenand.c

In future, please check your git configuration so that can come out as
follows.
It's just 'rename(move)' not 'delete and create'...It can help to us that it
can see more easily whether something changed.

arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)
 rename arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c (91%)

diff --git a/arch/arm/mach-s5pv210/dev-onenand.c
b/arch/arm/plat-s5p/dev-onenand.c
similarity index 91%
rename from arch/arm/mach-s5pv210/dev-onenand.c
rename to arch/arm/plat-s5p/dev-onenand.c
index 34997b7..08b3a3f 100644
--- a/arch/arm/mach-s5pv210/dev-onenand.c
+++ b/arch/arm/plat-s5p/dev-onenand.c


> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 0761eac..96f4d9b 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -62,11 +62,6 @@ config MACH_GONI
>  	  Machine support for Samsung GONI board
>  	  S5PC110(MCP) is one of package option of S5PV210
> 
> -config S5PC110_DEV_ONENAND
> -	bool
> -	help
> -	  Compile in platform device definition for OneNAND1 controller
> -
>  config MACH_SMDKV210
>  	bool "SMDKV210"
>  	select CPU_S5PV210
> diff --git a/arch/arm/mach-s5pv210/Makefile
b/arch/arm/mach-s5pv210/Makefile
> index 30be9a6..6a6dea1 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -26,7 +26,6 @@ obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
> 
>  obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> -obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
> 
>  obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
>  obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
> diff --git a/arch/arm/mach-s5pv210/dev-onenand.c
b/arch/arm/mach-s5pv210/dev-
> onenand.c
> deleted file mode 100644
> index 34997b7..0000000
> --- a/arch/arm/mach-s5pv210/dev-onenand.c
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -/*
> - * linux/arch/arm/mach-s5pv210/dev-onenand.c
> - *
> - *  Copyright (c) 2008-2010 Samsung Electronics
> - *  Kyungmin Park <kyungmin.park@samsung.com>
> - *
> - * S5PC110 series device definition for OneNAND devices
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/onenand.h>
> -
> -#include <mach/irqs.h>
> -#include <mach/map.h>
> -
> -static struct resource s5pc110_onenand_resources[] = {
> -	[0] = {
> -		.start	= S5PC110_PA_ONENAND,
> -		.end	= S5PC110_PA_ONENAND + SZ_128K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= S5PC110_PA_ONENAND_DMA,
> -		.end	= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -struct platform_device s5pc110_device_onenand = {
> -	.name		= "s5pc110-onenand",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(s5pc110_onenand_resources),
> -	.resource	= s5pc110_onenand_resources,
> -};
> -
> -void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
> -{
> -	struct onenand_platform_data *pd;
> -
> -	pd = kmemdup(pdata, sizeof(struct onenand_platform_data),
> GFP_KERNEL);
> -	if (!pd)
> -		printk(KERN_ERR "%s: no memory for platform data\n",
> __func__);
> -	s5pc110_device_onenand.dev.platform_data = pd;
> -}
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index 34eb168..3a44e1e 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -16,9 +16,6 @@
>  #include <plat/map-base.h>
>  #include <plat/map-s5p.h>
> 
> -#define S5PC110_PA_ONENAND	(0xB0000000)
> -#define S5PC110_PA_ONENAND_DMA	(0xB0600000)
> -
>  #define S5PV210_PA_CHIPID	(0xE0000000)
>  #define S5P_PA_CHIPID		S5PV210_PA_CHIPID
> 
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 907ac63..314f7d1 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -31,3 +31,8 @@ config S5P_EXT_INT
>  	help
>  	  Use the external interrupts (other than GPIO interrupts.)
>  	  Note: Do not choose this for S5P6440.
> +
> +config S5PC110_DEV_ONENAND

As I said, S5P_DEV_ONENAND is better in here.

> +	bool
> +	help
> +	  Compile in platform device definition for OneNAND controller
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index 39c242b..c49617e 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -12,9 +12,12 @@ obj-				:=
> 
>  # Core files
> 
> -obj-y				+= dev-uart.o
>  obj-y				+= cpu.o
>  obj-y				+= clock.o
>  obj-y				+= irq.o
>  obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
> 
> +# Device files
> +
> +obj-y				+= dev-uart.o
> +obj-$(CONFIG_S5PC110_DEV_ONENAND)	+= dev-onenand.o
> diff --git a/arch/arm/plat-s5p/dev-onenand.c
b/arch/arm/plat-s5p/dev-onenand.c
> new file mode 100644
> index 0000000..08b3a3f
> --- /dev/null
> +++ b/arch/arm/plat-s5p/dev-onenand.c
> @@ -0,0 +1,53 @@
> +/*
> + * linux/arch/arm/plat-s5p/dev-onenand.c
> + *
> + *  Copyright (c) 2008-2010 Samsung Electronics
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * S5PC110 series device definition for OneNAND devices

I thinks...this is for S5P SoCs such as S5PC210 and S5PC110
...even though S5P6440 does not have OneNAND device...

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/onenand.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +#define S5PC110_PA_ONENAND		(0xB0000000)
> +#define S5PC110_PA_ONENAND_DMA		(0xB0600000)

Please move to mach/map.h for compatibilities with other SoCs.

#define S5PC110_PA_ONENAND		(0xB0000000)
...
#define S5P_PA_ONENAD		S5PC110_PA_ONENAND
...

> +
> +static struct resource s5pc110_onenand_resources[] = {

s5p_onenand_resources...

> +	[0] = {
> +		.start	= S5PC110_PA_ONENAND,
> +		.end	= S5PC110_PA_ONENAND + SZ_128K - 1,

Here, S5P_PA_xxx is better...

> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= S5PC110_PA_ONENAND_DMA,
> +		.end	= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +struct platform_device s5pc110_device_onenand = {
> +	.name		= "s5pc110-onenand",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(s5pc110_onenand_resources),
> +	.resource	= s5pc110_onenand_resources,
> +};
> +
> +void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
> +{
> +	struct onenand_platform_data *pd;
> +
> +	pd = kmemdup(pdata, sizeof(struct onenand_platform_data),
> GFP_KERNEL);
> +	if (!pd)
> +		printk(KERN_ERR "%s: no memory for platform data\n",
> __func__);
> +	s5pc110_device_onenand.dev.platform_data = pd;

s3c_set_platdata(pdata, sizeof(struct onenand_platform_data),
&s5p_device_onenand);

> +}
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

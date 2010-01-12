From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 01:06:57 +0000
Subject: [PATCH] Add S3C64XX RTC platform driver
In-Reply-To: <b2e8f9f71001111640y155d819es4187f4d9398fb956@mail.gmail.com>
References: <b2e8f9f71001111640y155d819es4187f4d9398fb956@mail.gmail.com>
Message-ID: <20100112010657.GW3738@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 01:40:14AM +0100, Maurus Cuelenaere wrote:
> Add S3C64XX RTC platform driver

thanks, applied.
 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c6400/include/mach/map.h |    1 +
>  arch/arm/plat-s3c64xx/Makefile           |    1 +
>  arch/arm/plat-s3c64xx/dev-rtc.c          |   43 ++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c64xx/dev-rtc.c
> 
> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
> b/arch/arm/mach-s3c6400/include/mach/map.h
> index 106ee13..793fb8b 100644
> --- a/arch/arm/mach-s3c6400/include/mach/map.h
> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
> @@ -42,6 +42,7 @@
>  #define S3C64XX_PA_FB		(0x77100000)
>  #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
>  #define S3C64XX_PA_WATCHDOG	(0x7E004000)
> +#define S3C64XX_PA_RTC		(0x7E005000)
>  #define S3C64XX_PA_SYSCON	(0x7E00F000)
>  #define S3C64XX_PA_AC97		(0x7F001000)
>  #define S3C64XX_PA_IIS0		(0x7F002000)
> diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
> index b85b435..e66dbd7 100644
> --- a/arch/arm/plat-s3c64xx/Makefile
> +++ b/arch/arm/plat-s3c64xx/Makefile
> @@ -13,6 +13,7 @@ obj-				:=
>  # Core files
> 
>  obj-y				+= dev-uart.o
> +obj-y				+= dev-rtc.o
>  obj-y				+= cpu.o
>  obj-y				+= irq.o
>  obj-y				+= irq-eint.o
> diff --git a/arch/arm/plat-s3c64xx/dev-rtc.c b/arch/arm/plat-s3c64xx/dev-rtc.c
> new file mode 100644
> index 0000000..b9e7a05
> --- /dev/null
> +++ b/arch/arm/plat-s3c64xx/dev-rtc.c
> @@ -0,0 +1,43 @@
> +/* linux/arch/arm/plat-s3c64xx/dev-rtc.c
> + *
> + * Copyright 2009 by Maurus Cuelenaere <mcuelenaere@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +
> +#include <plat/devs.h>
> +
> +static struct resource s3c_rtc_resource[] = {
> +	[0] = {
> +		.start = S3C64XX_PA_RTC,
> +		.end   = S3C64XX_PA_RTC + 0xff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_RTC_ALARM,
> +		.end   = IRQ_RTC_ALARM,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[2] = {
> +		.start = IRQ_RTC_TIC,
> +		.end   = IRQ_RTC_TIC,
> +		.flags = IORESOURCE_IRQ
> +	}
> +};
> +
> +struct platform_device s3c_device_rtc = {
> +	.name		  = "s3c64xx-rtc",
> +	.id		  = -1,
> +	.num_resources	  = ARRAY_SIZE(s3c_rtc_resource),
> +	.resource	  = s3c_rtc_resource,
> +};
> +EXPORT_SYMBOL(s3c_device_rtc);
> -- 
> 1.6.6

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

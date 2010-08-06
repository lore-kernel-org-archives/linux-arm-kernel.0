From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 Aug 2010 22:24:37 +0900
Subject: [PATCH 1/4] s3c: add support for mach-real6410
In-Reply-To: <20100806102041.2481.18980.stgit@darius-desktop>
References: <20100806101914.2481.67766.stgit@darius-desktop>
	<20100806102041.2481.18980.stgit@darius-desktop>
Message-ID: <00b001cb356a$ba158890$2e4099b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> Add support for CoreWind Real6410 board,
> based on Samsung s3c6410 processor.
> 
Hi,

Please make sure that your patch has no problem with scripts/checkpatch.pl before submitting.
I got the following result on this patch :-(
===
ERROR: Macros with complex values should be enclosed in parenthesis
#82: FILE: arch/arm/mach-s3c64xx/mach-real6410.c:30:
+#define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK

ERROR: Macros with complex values should be enclosed in parenthesis
#83: FILE: arch/arm/mach-s3c64xx/mach-real6410.c:31:
+#define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB

ERROR: Macros with complex values should be enclosed in parenthesis
#84: FILE: arch/arm/mach-s3c64xx/mach-real6410.c:32:
+#define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE

total: 3 errors, 1 warnings, 105 lines checked
===


> Changelog:
>  * It's renamed patch '[PATCH v2] Support for Real6410'
> 
This 'Changelog' should being next of "---", because if this is being here, merged into the commit when maintainer apply this in his tree.

> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> ---

If you want to add any comments or notes, please adding here.

>  arch/arm/mach-s3c64xx/Kconfig         |    6 ++
>  arch/arm/mach-s3c64xx/Makefile        |    1
>  arch/arm/mach-s3c64xx/mach-real6410.c |   86
> +++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/mach-real6410.c
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index f5a5972..0f9f2dd 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -88,6 +88,12 @@ config MACH_ANW6410
>  	help
>  	  Machine support for the A&W6410
> 
> +config MACH_REAL6410
> +	bool "REAL6410"
> +	select CPU_S3C6410
> +	help
> +	  Machine support for the CoreWind REAL6410
> +
>  config MACH_SMDK6410
>  	bool "SMDK6410"
>  	select CPU_S3C6410
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
> index 9d10069..6be3e5b 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_PM)		+= irq-pm.o
>  obj-$(CONFIG_MACH_ANW6410)	+= mach-anw6410.o
>  obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
>  obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
> +obj-$(CONFIG_MACH_REAL6410)     += mach-real6410.o
>  obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
>  obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
>  obj-$(CONFIG_MACH_SMARTQ)	+= mach-smartq.o
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-
> s3c64xx/mach-real6410.c
> new file mode 100644
> index 0000000..04a472a
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -0,0 +1,86 @@
> +/* linux/arch/arm/mach-s3c64xx/mach-real6410.c
> + *
> + * Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
> + * Copyright 2008 Openmoko, Inc.
> + * Copyright 2008 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *	http://armlinux.simtec.co.uk/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/init.h>
> +#include <linux/serial_core.h>
> +#include <linux/platform_device.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/map.h>
> +#include <mach/s3c6410.h>
> +#include <plat/cpu.h>
> +#include <plat/regs-serial.h>
> +
> +#define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
> +#define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE |
> S3C2410_LCON_STOPB
> +#define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
> +
> +static struct s3c2410_uartcfg real6410_uartcfgs[] __initdata = {
> +	[0] = {
> +		.hwport	     = 0,
                        ^^^^^
Please use tab here

> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,
> +	},
> +	[1] = {
> +		.hwport	     = 1,
> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,
> +	},
> +	[2] = {
> +		.hwport	     = 2,
> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,
> +	},
> +	[3] = {
> +		.hwport	     = 3,
> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,

Same...please use tab above between hwport, flags, ucon, ulcon, ufcon and '='.

> +	},
> +};
> +
> +static void __init real6410_map_io(void)
> +{
> +	s3c64xx_init_io(NULL, 0);
> +	s3c24xx_init_clocks(12000000);
> +	s3c24xx_init_uarts(real6410_uartcfgs, ARRAY_SIZE(real6410_uartcfgs));
> +}
> +
> +static void __init real6410_machine_init(void)
> +{
> +}
> +
> +MACHINE_START(REAL6410, "REAL6410")
> +	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
> +	.phys_io	= S3C_PA_UART & 0xfff00000,
> +	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
> +	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
> +
> +	.init_irq	= s3c6410_init_irq,
> +	.map_io		= real6410_map_io,
> +	.init_machine	= real6410_machine_init,
> +	.timer		= &s3c24xx_timer,
> +MACHINE_END

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 8 Mar 2011 13:30:07 +0100
Subject: [PATCH] [ARM] MX1: Add ARMadeus Systems APF9328 board support
In-Reply-To: <1299261002-9804-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1299261002-9804-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20110308123006.GE18351@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 04, 2011 at 05:50:02PM +0000, Gwenhael Goavec-Merou wrote:
> APF9328 is an i.MXL based SOM (System On Module) that can be plugged on 
> several docking/development boards. Here only basic module support 
> is added (Ethernet, Serial, NOR Flash).
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> Signed-off-by: Eric Jarrige <eric.jarrige@armadeus.org>
> Signed-off-by: Nicolas Colombain <nicolas.colombain@armadeus.com>
> Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
> ---
>  arch/arm/mach-imx/Kconfig        |    6 ++
>  arch/arm/mach-imx/Makefile       |    1 +
>  arch/arm/mach-imx/mach-apf9328.c |  172 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 179 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-imx/mach-apf9328.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 56684b5..863ed2c 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -51,6 +51,12 @@ config MACH_SCB9328
>  	help
>  	  Say Y here if you are using a Synertronixx scb9328 board
>  
> +config MACH_APF9328
> +	bool "APF9328"
> +	select IMX_HAVE_PLATFORM_IMX_UART
> +	help
> +	  Say Yes here if you are using the Armadeus APF9328 development board
> +
>  endif
>  
>  if ARCH_MX2
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 77100bf..444fdf7 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_MX1_VIDEO)	+= mx1-camera-fiq.o mx1-camera-fiq-ksym.o
>  
>  obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
>  obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
> +obj-$(CONFIG_MACH_APF9328) += mach-apf9328.o
>  
>  obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
>  
> diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
> new file mode 100644
> index 0000000..5c57f15b
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-apf9328.c
> @@ -0,0 +1,172 @@
> +/*
> + * linux/arch/arm/mach-imx/mach-apf9328.c
> + *
> + * Copyright (c) 2005-2011 ARMadeus systems <support@armadeus.com>
> + *
> + * This work is based on mach-scb9328.c which is:
> + * Copyright (c) 2004 Sascha Hauer <saschahauer@web.de>
> + * Copyright (c) 2006-2008 Juergen Beisert <jbeisert@netscape.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/dm9000.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/iomux-mx1.h>
> +
> +#include "devices-imx1.h"
> +
> +/*
> + * The APF9328 can have up to 32MB NOR Flash
> + */
> +static struct resource flash_resource = {
> +	.start	= MX1_CS0_PHYS,
> +	.end	= MX1_CS0_PHYS + (32 * 1024 * 1024) - 1,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static struct physmap_flash_data apf9328_flash_data = {
> +	.width  = 2,
> +};
> +
> +static struct platform_device apf9328_flash_device = {
> +	.name		= "physmap-flash",
> +	.id		= 0,
> +	.dev = {
> +		.platform_data = &apf9328_flash_data,
> +	},
> +	.resource = &flash_resource,
> +	.num_resources = 1,
> +};
> +
> +/*
> + * APF9328 has a DM9000 Ethernet controller
> + */
> +static struct dm9000_plat_data dm9000_setup = {
> +	.flags          = DM9000_PLATF_16BITONLY
> +};
> +
> +static struct resource dm9000_resources[] = {
> +	[0] = {
> +		.start  = (MX1_CS4_PHYS + 0x00C00000),
> +		.end    = (MX1_CS4_PHYS + 0x00C00001),
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = (MX1_CS4_PHYS + 0x00C00002),
> +		.end    = (MX1_CS4_PHYS + 0x00C00003),
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[2] = {
> +		.start  = (IRQ_GPIOB(14)),
> +		.end    = (IRQ_GPIOB(14)),
> +		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> +	},
> +};
> +
> +static struct platform_device dm9000x_device = {
> +	.name		= "dm9000",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(dm9000_resources),
> +	.resource	= dm9000_resources,
> +	.dev		= {
> +		.platform_data = &dm9000_setup,
> +	}
> +};
> +
> +/* --- SERIAL RESSOURCE --- */
> +static int mxc_uart0_pins[] = {
> +	PC9_PF_UART1_CTS,
> +	PC10_PF_UART1_RTS,
> +	PC11_PF_UART1_TXD,
> +	PC12_PF_UART1_RXD,
> +};

We normally do the pin setup in a single table which is used during
board initalization and not in init/exit driver callbacks. Can
you do the same here, please?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

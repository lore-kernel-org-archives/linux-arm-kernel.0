From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Apr 2011 15:20:33 +0200
Subject: [PATCH v3] [ARM] MX1: Add ARMadeus Systems APF9328 board support
In-Reply-To: <1302022268-42787-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1302022268-42787-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20110426132033.GT31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 04:51:08PM +0000, Gwenhael Goavec-Merou wrote:
> APF9328 is an i.MXL based SOM (System On Module) that can be plugged on 
> several docking/development boards. Here only basic module support 
> is added (Ethernet, Serial, NOR Flash).
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> Signed-off-by: Eric Jarrige <eric.jarrige@armadeus.org>
> Signed-off-by: Nicolas Colombain <nicolas.colombain@armadeus.com>
> Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
> ---
> 
> Changes since v2:
> 	- add const and __initconst attributes for platform_data and resource, 
> 	- suppress boot_params.
> 
> Changes since v1:
> 	- merge pins tables for UART
> 	- suppress init/exit driver callbacks for UART
> 
>  arch/arm/configs/mx1_defconfig   |    1 +
>  arch/arm/mach-imx/Kconfig        |    6 ++
>  arch/arm/mach-imx/Makefile       |    1 +
>  arch/arm/mach-imx/mach-apf9328.c |  145 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 153 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-imx/mach-apf9328.c
> 
> diff --git a/arch/arm/configs/mx1_defconfig b/arch/arm/configs/mx1_defconfig
> index b39b5ce..c9436d0 100644
> --- a/arch/arm/configs/mx1_defconfig
> +++ b/arch/arm/configs/mx1_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ARCH_MXC=y
>  CONFIG_ARCH_MX1=y
>  CONFIG_ARCH_MX1ADS=y
>  CONFIG_MACH_SCB9328=y
> +CONFIG_MACH_APF9328=y
>  CONFIG_MXC_IRQ_PRIOR=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
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
> index 0000000..72584e5
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-apf9328.c
> @@ -0,0 +1,145 @@
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
> +static const int apf9328_pins[] __initconst = {
> +	/* UART1 */
> +	PC9_PF_UART1_CTS,
> +	PC10_PF_UART1_RTS,
> +	PC11_PF_UART1_TXD,
> +	PC12_PF_UART1_RXD,
> +	/* UART2 */
> +	PB28_PF_UART2_CTS,
> +	PB29_PF_UART2_RTS,
> +	PB30_PF_UART2_TXD,
> +	PB31_PF_UART2_RXD,
> +};
> +
> +/*
> + * The APF9328 can have up to 32MB NOR Flash
> + */
> +static const struct resource flash_resource __initconst = {
> +	.start	= MX1_CS0_PHYS,
> +	.end	= MX1_CS0_PHYS + (32 * 1024 * 1024) - 1,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
> +static const struct physmap_flash_data apf9328_flash_data __initconst = {
> +	.width  = 2,
> +};
Doesn't this result in a compiler warning when being const? And I think
this must not be initdata. Try compiling the physmap-flash driver as a
module and load it after boot.

> +static struct platform_device apf9328_flash_device = {
> +	.name		= "physmap-flash",
> +	.id		= 0,
> +	.dev = {
> +		.platform_data = &apf9328_flash_data,
> +	},
> +	.resource = &flash_resource,
> +	.num_resources = 1,
ARRAY_SIZE(flash_resource) please

> +};
> +
> +/*
> + * APF9328 has a DM9000 Ethernet controller
> + */
> +static const struct dm9000_plat_data dm9000_setup __initconst = {
> +	.flags          = DM9000_PLATF_16BITONLY
> +};
ditto here (no init, no const)

> +
> +static const struct resource dm9000_resources[] __initconst = {
> +	[0] = {
> +		.start  = (MX1_CS4_PHYS + 0x00C00000),
> +		.end    = (MX1_CS4_PHYS + 0x00C00001),
hmm, are you sure about the sizes here? The parenthesis are not needed.

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
> +static const struct imxuart_platform_data uart0_pdata __initconst = {
> +	.flags = 0,
> +};
> +
> +static const struct imxuart_platform_data uart1_pdata __initconst = {
> +	.flags = IMXUART_HAVE_RTSCTS,
> +};
> +
> +static struct platform_device *devices[] __initdata = {
> +	&apf9328_flash_device,
> +	&dm9000x_device,
> +};
> +
> +static void __init apf9328_init(void)
> +{
> +	mxc_gpio_setup_multiple_pins(apf9328_pins,
> +			ARRAY_SIZE(apf9328_pins),
> +			"APF9328");
> +
> +	imx1_add_imx_uart0(&uart0_pdata);
> +	imx1_add_imx_uart1(&uart1_pdata);
> +
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +}
> +
> +static void __init apf9328_timer_init(void)
> +{
> +	mx1_clocks_init(32768);
> +}
> +
> +static struct sys_timer apf9328_timer = {
> +	.init	= apf9328_timer_init,
> +};
> +
> +MACHINE_START(APF9328, "Armadeus APF9328")
> +	/* Maintainer: <gwenhael.goavec-merou@armadeus.com> */
> +	.map_io       = mx1_map_io,
.init_early = imx1_init_early,

> +	.init_irq     = mx1_init_irq,
> +	.timer        = &apf9328_timer,
> +	.init_machine = apf9328_init,
> +MACHINE_END
> -- 
> 1.7.3.4
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

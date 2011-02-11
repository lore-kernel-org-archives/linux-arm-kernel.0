From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Feb 2011 22:33:48 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
References: <20110211081050.GD27982@pengutronix.de>
	<1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <20110211213348.GJ27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 10:06:28PM +0100, Denis 'GNUtoo' Carikli wrote:
> This work was based on bug-linux-2.6.30.patch that can be found
>   in buglabs's svn here:
>   svn://bugcamp.net/bug/branches/izzy/experimental
> 
> Note that the hardware schematics and documentations can be obtained
>   here: http://www.bugcommunity.com/wiki/index.php/BUGbase
> 
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> ---
>  arch/arm/mach-mx3/Kconfig                   |    9 +++
>  arch/arm/mach-mx3/Makefile                  |    1 +
>  arch/arm/mach-mx3/mach-mx31bugbase.c        |   75 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/uncompress.h |    4 ++
>  4 files changed, 89 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx3/mach-mx31bugbase.c
> 
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index de80d98..4f57f13 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -199,6 +199,15 @@ config MACH_KZM_ARM11_01
>  	  Include support for KZM-ARM11-01. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_BUG
> +	bool "Support Buglabs BUGBase platform"
> +	select SOC_IMX31
> +	select IMX_HAVE_PLATFORM_IMX_UART
> +	default y
> +	help
> +	  Include support for BUGBase 1.3 platform. This includes specific
> +	  configurations for the board and its peripherals.
> +
>  config MACH_EUKREA_CPUIMX35
>  	bool "Support Eukrea CPUIMX35 Platform"
>  	select SOC_IMX35
> diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
> index bc7294f..98e5eb3 100644
> --- a/arch/arm/mach-mx3/Makefile
> +++ b/arch/arm/mach-mx3/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
>  obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
>  obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
>  obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
> +obj-$(CONFIG_MACH_BUG)          += mach-mx31bugbase.o
I'd like to have the file name matching the MACH variable.  That is
mach-bug.c

>  obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
>  obj-$(CONFIG_MACH_VPR200)	+= mach-vpr200.o
> diff --git a/arch/arm/mach-mx3/mach-mx31bugbase.c b/arch/arm/mach-mx3/mach-mx31bugbase.c
> new file mode 100644
> index 0000000..1d8ca1c
> --- /dev/null
> +++ b/arch/arm/mach-mx3/mach-mx31bugbase.c
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright (C) 2000 Deep Blue Solutions Ltd
> + * Copyright (C) 2002 Shane Nay (shane at minirl.com)
> + * Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/iomux-mx3.h>
> +#include <mach/imx-uart.h>
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +
> +#include <asm/mach/time.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach-types.h>
> +
> +#include "devices-imx31.h"
> +
> +static struct imxuart_platform_data uart_pdata = {
> +	.flags = IMXUART_HAVE_RTSCTS,
> +};
can be const and __initconst and lacks a prefix

> +
> +static unsigned int uart5_pins[] = {
> +	MX31_PIN_PC_RST__CTS5,
> +	MX31_PIN_PC_VS2__RTS5,
> +	MX31_PIN_PC_BVD2__TXD5,
> +	MX31_PIN_PC_BVD1__RXD5,
> +};
can be const and __initconst and lacks a prefix, but see below.

> +
> +static inline void mx31bug_init_imx_uart(void)
> +{
> +	mxc_iomux_setup_multiple_pins(uart5_pins,
> +				ARRAY_SIZE(uart5_pins), "uart-4");
> +	imx31_add_imx_uart4(&uart_pdata);
> +}
can be __init. I'd prefer a prefix of bug, not mx31bug, because that
matches the machine id.

> +
> +/*!
no doxygen style comments in the kernel please

> + * Board specific initialization.
> + */
> +static void __init mx31bug_board_init(void)
> +{
> +	mx31bug_init_imx_uart();
I assume your machine doesn't only have an uart. If so, I'd suggest to
rename uart5_pins (which lacks a prefix btw) to mx31bug_pins and put the
mxc_iomux_setup_multiple_pins into mx31bug_board_init.  Then
mx31bug_init_imx_uart only has imx31_add_imx_uart4 which then can better
go directly into mx31bug_board_init, too.

> +}
> +
> +
You can remove one of these two empty lines.

> +static void __init mx31bug_timer_init(void)
> +{
> +	mx31_clocks_init(26000000);
> +}
> +
> +static struct sys_timer mx31bug_timer = {
> +	.init	= mx31bug_timer_init,
> +};
> +
> +MACHINE_START(BUG, "BugLabs BUGBase")
> +	.boot_params = MX3x_PHYS_OFFSET + 0x100,
BTW, if you have a decent bootloader, you don't need this line.

> +	.map_io = mx31_map_io,
> +        .init_early = imx31_init_early,
> +	.init_irq = mx31_init_irq,
> +        .timer = &mx31bug_timer,
> +	.init_machine = mx31bug_board_init,
please use tabs consistently for indention.  And if you use a single
space before the = here (which is totally ok, even prefered by me), then
do the same in mx31bug_timer, please.

> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
> index e634d6c..b45f534 100644
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -62,6 +62,7 @@ static inline void flush(void)
>  #define MX2X_UART1_BASE_ADDR	0x1000a000
>  #define MX3X_UART1_BASE_ADDR	0x43F90000
>  #define MX3X_UART2_BASE_ADDR	0x43F94000
> +#define MX3X_UART5_BASE_ADDR	0x43FB4000
>  #define MX51_UART1_BASE_ADDR	0x73fbc000
>  #define MX50_UART1_BASE_ADDR	0x53fbc000
>  #define MX53_UART1_BASE_ADDR	0x53fbc000
> @@ -102,6 +103,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
>  	case MACH_TYPE_MAGX_ZN5:
>  		uart_base = MX3X_UART2_BASE_ADDR;
>  		break;
> +	case MACH_TYPE_BUG:
> +		uart_base = MX3X_UART5_BASE_ADDR;
> +		break;
>  	case MACH_TYPE_MX51_BABBAGE:
>  	case MACH_TYPE_EUKREA_CPUIMX51SD:
>  	case MACH_TYPE_MX51_3DS:
> -- 
Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

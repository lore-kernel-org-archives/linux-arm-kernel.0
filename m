From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Jul 2010 15:31:41 +0200
Subject: [PATCH 3/3] i.MX51: add support for cpuimx51 module and its
	baseboard
In-Reply-To: <1279610174-6025-3-git-send-email-eric@eukrea.com>
References: <1279610174-6025-1-git-send-email-eric@eukrea.com>
	<1279610174-6025-2-git-send-email-eric@eukrea.com>
	<1279610174-6025-3-git-send-email-eric@eukrea.com>
Message-ID: <20100722133141.GL14113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

some comments inline...

> ---
> +
>  endif
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index c757c59..86c66e7 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -7,3 +7,5 @@ obj-y   := cpu.o mm.o clock-mx51.o devices.o
>  
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
>  obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
> +obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
> +obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c

[snip]

There are several occurences of the string "babbage" left in this file.

> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init mxc_board_init(void)
> +{
> +	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
> +					ARRAY_SIZE(mx51babbage_pads));
> +
> +	mxc_register_device(&mxc_uart_device0, &uart_pdata);
> +	gpio_request(CPUIMX51_QUARTA_GPIO, "quarta_irq");
> +	gpio_direction_input(CPUIMX51_QUARTA_GPIO);
> +	gpio_free(CPUIMX51_QUARTA_GPIO);
> +	set_irq_type(CPUIMX51_QUARTA_IRQ, IRQF_TRIGGER_HIGH);

struct plat_serial8250_port has the irqflags field which should be used
here.

> +	gpio_request(CPUIMX51_QUARTB_GPIO, "quartb_irq");
> +	gpio_direction_input(CPUIMX51_QUARTB_GPIO);
> +	gpio_free(CPUIMX51_QUARTB_GPIO);
> +	set_irq_type(CPUIMX51_QUARTB_IRQ, IRQF_TRIGGER_HIGH);
> +	gpio_request(CPUIMX51_QUARTC_GPIO, "quartc_irq");
> +	gpio_direction_input(CPUIMX51_QUARTC_GPIO);
> +	gpio_free(CPUIMX51_QUARTC_GPIO);
> +	set_irq_type(CPUIMX51_QUARTC_IRQ, IRQF_TRIGGER_HIGH);
> +	gpio_request(CPUIMX51_QUARTD_GPIO, "quartd_irq");
> +	gpio_direction_input(CPUIMX51_QUARTD_GPIO);
> +	gpio_free(CPUIMX51_QUARTD_GPIO);
> +	set_irq_type(CPUIMX51_QUARTD_IRQ, IRQF_TRIGGER_HIGH);
> +

[snip]

> diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h
> new file mode 100644
> index 0000000..73ce705
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2010 Eric Benard - eric at eukrea.com
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX51_H__
> +#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX51_H__
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * This CPU module needs a baseboard to work. After basic initializing
> + * its own devices, it calls the baseboard's init function.
> + * TODO: Add your own baseboard init function and call it from
> + * inside eukrea_cpuimx51_init().
> + *
> + * This example here is for the development board. Refer
> + * eukrea_mbimx51-baseboard.c
> + */
> +
> +extern void eukrea_mbimx51_baseboard_init(void);

I'm not entirely happy with this. I think this should be in a file with
"baseboard" in its file name rather than being named after the board. I
realized you have the prototype for the baseboard init function for
other eukrea boards in board specific header files aswell. How about
creating a single eukrea-baseboards.h file where all available eukrea
baseboards are combined?

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

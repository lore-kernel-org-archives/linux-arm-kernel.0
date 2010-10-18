From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 22:20:16 +0100
Subject: [PATCH 1/3] Add Mindspeed Comcerto platform support
In-Reply-To: <1287045489-1133-2-git-send-email-stanleymiao@gmail.com>
References: <1287045489-1133-1-git-send-email-stanleymiao@gmail.com>
	<1287045489-1133-2-git-send-email-stanleymiao@gmail.com>
Message-ID: <20101018212016.GC20376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 04:38:07PM +0800, stanleymiao at gmail.com wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 88c97bc..ca6ccf7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -334,6 +334,15 @@ config ARCH_EP93XX
>  	help
>  	  This enables support for the Cirrus EP93xx series of CPUs.
>  
> +config ARCH_COMCERTO
> +	bool "Mindspeed Comcerto"
> +	select ZONE_DMA
> +	select CPU_V6
> +	help
> +	  This enables support for Mindspeed's Comcerto development boards.
> +	  If you would like to build your kernel to run on one of these boards
> +	  then you must say 'Y' here. Otherwise say 'N'
> +

#
# The "ARM system type" choice list is ordered alphabetically by option
# text.  Please add new entries in the option alphabetic order.
#

Erm...

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 59c1ce8..2daad67 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -141,6 +141,7 @@ machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
>  machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
>  machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
>  machine-$(CONFIG_ARCH_IOP33X)		:= iop33x
> +machine-$(CONFIG_ARCH_COMCERTO)	:= comcerto

# Machine directory name.  This list is sorted alphanumerically
# by CONFIG_* macro name.

Erm...

> diff --git a/arch/arm/mach-comcerto/Kconfig b/arch/arm/mach-comcerto/Kconfig
> new file mode 100644
> index 0000000..a61a31a
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/Kconfig
> @@ -0,0 +1,32 @@
> +if ARCH_COMCERTO
> +
> +menu "Comcerto Implementation Options"
> +
> +choice
> +	prompt "Comcerto System Type"
> +	default ARCH_M83XXX
> +
> +config ARCH_M83XXX
> +	bool "M83xxx"
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS

Everyone should be using GENERIC_TIME and GENERIC_CLOCKEVENTS for new
code, so please move this to live with ARCH_COMCERTO.

> diff --git a/arch/arm/mach-comcerto/board-c1kmfcn_evm.c b/arch/arm/mach-comcerto/board-c1kmfcn_evm.c
> new file mode 100644
> index 0000000..74a7da3
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/board-c1kmfcn_evm.c
> @@ -0,0 +1,88 @@
> +/*
> + * linux/arch/arm/mach-comcerto/board-c1kmfcn_evm.c
> + *
> + *  Copyright (C) 2004,2008 Mindspeed Technologies, Inc.
> + *  Copyright (c) 2010 Wind River Systems, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#include <linux/sched.h>

Are there more appropriate includes rather than this one?

> +#include <linux/device.h>
> +#include <linux/serial_8250.h>
> +#include <asm/sizes.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/io.h>

linux/io.h

> +#include <asm/mach/arch.h>
> +#include <mach/hardware.h>
> +
> +/* --------------------------------------------------------------------
> + *  Serial interface
> + * -------------------------------------------------------------------- */
> +static struct plat_serial8250_port comcerto_uart_data[] = {
> +	{
> +		.mapbase	= COMCERTO_APB_UART0_BASE,
> +		.membase	= (void *)APB_VADDR(COMCERTO_APB_UART0_BASE),
> +		.irq		= IRQ_UART0,
> +		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
> +		.iotype		= UPIO_MEM,
> +		.regshift	= 2,
> +		.uartclk	= COMCERTO_DEFAULTAHBCLK * 1000000,
> +	},
> +	{
> +		.flags		= 0,
> +	},
> +};
> +
> +static struct platform_device comcerto_uart = {
> +	.name	= "serial8250",
> +	.id	= PLAT8250_DEV_PLATFORM,
> +	.dev	= {
> +		.platform_data	= comcerto_uart_data,
> +	},
> +};
> +
> +static struct platform_device *comcerto_devices[] __initdata = {
> +	&comcerto_uart,
> +};
> +
> +/************************************************************************
> + *  Machine definition
> + *
> + ************************************************************************/
> +static void __init platform_map_io(void)
> +{
> +	device_map_io();
> +}
> +
> +static void __init platform_irq_init(void)
> +{
> +}

If there's no IRQs then how do you get timer interrupts?

> +
> +static void __init platform_init(void)
> +{
> +	platform_add_devices(comcerto_devices, ARRAY_SIZE(comcerto_devices));
> +}
> +
> +MACHINE_START(COMCERTO, "Comcerto 1000 (Multifunction EVM)")
> +	/* Mindspeed Technologies Inc. */
> +	.phys_io	= COMCERTO_AHB_APB_BASE,
> +	.io_pg_offst	= ((COMCERTO_AHB_APB_BASE) >> 18) & 0xfffc,
> +	.boot_params	= COMCERTO_SDRAM_BASE + 0x100,
> +	.map_io		= platform_map_io,
> +	.init_irq	= platform_irq_init,
> +	.init_machine	= platform_init,
> +	.timer		= &comcerto_timer,
> +MACHINE_END
> diff --git a/arch/arm/mach-comcerto/comcerto-1000.c b/arch/arm/mach-comcerto/comcerto-1000.c
> new file mode 100644
> index 0000000..09032ea
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/comcerto-1000.c
> @@ -0,0 +1,146 @@
> +/*
> + *  linux/arch/arm/mach-comcerto/comcerto-1000.c
> + *
> + *  Copyright (C) 2004,2008 Mindspeed Technologies, Inc.
> + *  Copyright (c) 2010 Wind River Systems, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/io.h>

linux/io.h

> +#include <asm/sizes.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/hardware.h>

Most of the above looks like it was cut'n'pasted from the previous file.
Do you really need all these includes?

> diff --git a/arch/arm/mach-comcerto/include/mach/io.h b/arch/arm/mach-comcerto/include/mach/io.h
> new file mode 100644
> index 0000000..be3320f
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/include/mach/io.h
> @@ -0,0 +1,32 @@
> +/*
> + *  arch/arm/mach-comcerto/include/mach/io.h
> + *
> + *  Copyright (C) 2004,2005 Mindspeed Technologies, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#ifndef __ASM_ARCH_COMCERTO1000_IO_H
> +#define __ASM_ARCH_COMCERTO1000_IO_H
> +
> +#include <asm/io.h>

Err no.  This is a recipe for disaster.  linux/io.h includes asm/io.h
which includes mach/io.h.  If you want io definitions, include linux/io.h.
Do not include asm/io.h or mach/io.h directly.

> +
> +#if !defined(CONFIG_PCI)
> +
> +#define __io(a)		((void __iomem *)(a))

__typesafe_io() ?

> +#define __mem_pci(a)	(a)
> +
> +#endif
> +
> +#endif /* __ASM_ARCH_COMCERTO1000_IO_H */
> diff --git a/arch/arm/mach-comcerto/include/mach/memory.h b/arch/arm/mach-comcerto/include/mach/memory.h
> new file mode 100644
> index 0000000..6d42d06
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/include/mach/memory.h
> @@ -0,0 +1,33 @@
> +/*
> + *  arch/arm/mach-comcerto/include/mach/memory.h
> + *
> + *  Copyright (C) 2006 Mindspeed Technologies, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __ASM_ARCH_MEMORY_H
> +#define __ASM_ARCH_MEMORY_H
> +
> +#include <mach/hardware.h>
> +
> +#define PHYS_OFFSET		COMCERTO_SDRAM_BASE
> +
> +#define __virt_to_bus(x)	__virt_to_phys(x)
> +#define __bus_to_virt(x)	__phys_to_virt(x)
> +#define __pfn_to_bus(x)		__pfn_to_phys(x)
> +#define __bus_to_pfn(x)		__phys_to_pfn(x)
> +
> +#endif
> diff --git a/arch/arm/mach-comcerto/include/mach/system.h b/arch/arm/mach-comcerto/include/mach/system.h
> new file mode 100644
> index 0000000..364cc7e
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/include/mach/system.h
> @@ -0,0 +1,39 @@
> +/*
> + *  arch/arm/mach-comcerto/include/mach/system.h
> + *
> + *  Copyright (C) 2004,2005 Mindspeed Technologies, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#ifndef __ASM_ARCH_SYSTEM_H
> +#define __ASM_ARCH_SYSTEM_H
> +
> +#include <mach/hardware.h>
> +#include <asm/io.h>

Nothing in this file needs asm/io.h, nor I suspect mach/hardware.h either.

> +
> +static inline void arch_idle(void)
> +{
> +	/*
> +	 * This should do all the clock switching
> +	 * and wait for interrupt tricks
> +	 */
> +	cpu_do_idle();
> +}
> +
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +}
> +
> +#endif /* __ASM_ARCH_SYSTEM_H */
> diff --git a/arch/arm/mach-comcerto/include/mach/uncompress.h b/arch/arm/mach-comcerto/include/mach/uncompress.h
> new file mode 100644
> index 0000000..e3e6938
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/include/mach/uncompress.h
> @@ -0,0 +1,58 @@
> +/*
> + *  arch/arm/mach-comcerto/include/mach/uncompress.h
> + *
> + *  Copyright (C) 2004,2008 Mindspeed Technologies, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#ifndef __ASM_ARCH_UNCOMPRESS_H
> +#define __ASM_ARCH_UNCOMPRESS_H
> +
> +#define UART_DR		(*(volatile unsigned long *)0x10090000)
> +#define UART_LSR	(*(volatile unsigned long *)0x10090014)
> +
> +static inline void putc(int c)
> +{
> +	while (!(UART_LSR & 0x20))
> +		barrier();
> +
> +	UART_DR = c;
> +}
> +
> +static void flush(void)
> +{
> +}
> +static inline void puts(const char *ptr)
> +{
> +	char c;
> +
> +	while ((c = *ptr++) != '\0') {
> +		if (c == '\n')
> +			putc('\r');
> +		putc(c);
> +	}
> +
> +	flush();
> +
> +}
> +
> +/*
> + * nothing to do
> + */
> +#define arch_decomp_setup()
> +
> +#define arch_decomp_wdog()
> +
> +#endif /* __ASM_ARCH_UNCOMPRESS_H */
> diff --git a/arch/arm/mach-comcerto/include/mach/vmalloc.h b/arch/arm/mach-comcerto/include/mach/vmalloc.h
> new file mode 100644
> index 0000000..f807501
> --- /dev/null
> +++ b/arch/arm/mach-comcerto/include/mach/vmalloc.h
> @@ -0,0 +1,21 @@
> +/*
> + *  arch/arm/mach-comcerto/include/mach/vmalloc.h
> + *
> + *  Copyright (C) 2004,2005 Mindspeed Technologies, Inc.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#define VMALLOC_END       (0xF0000000)

Should be typed to be unsigned long.

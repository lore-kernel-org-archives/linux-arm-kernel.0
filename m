From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 12 Jul 2010 19:06:52 +0200
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <20100712165025.GA13818@alchark-u3s.alchark.ru>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
Message-ID: <201007121906.52483.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 12. ?ervence 2010 18:50:25 Alexey Charkov napsal(a):
> This adds basic support for machine initialization, interrupts, timers and
> serial console on VIA/WonderMedia VT8500 and WM8505 Systems-on-Chip.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> 
> These SoC's are used in quite many netbooks and tablets produced in China
> and sold online at relatively low prices (typically below 100 USD).
> 
> Support for WM8505 is known incomplete, while VT8500 is tested by me on the
> hardware and at least prints kernel messages to the serial console with
> timing information.
> 
> The code relies on recent additions to arch/arm/tools/mach-types not yet
> pulled in from the machine registry, a corresponding section is included in
> the following patch.
> 
> Please comment on the code, I'm eager to improve wherever possible.
> 
> The patch is based on Linus' master branch at commit 589643be6693c46fbc
> 
> Best regards,
> Alexey
> 

DISCLAIMER: I lack sleep (30 hours straight).

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 98922f7..0e171be 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -794,6 +794,17 @@ config PLAT_SPEAR
>  	help
>  	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
> 
> +config ARCH_VT8500
> +	bool "VIA/WonderMedia 85xx"
> +	select CPU_ARM926T
> +	select GENERIC_GPIO
> +	select ARCH_HAS_CPUFREQ
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select HAVE_CLK
> +	help
> +	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
>  endchoice
> 
>  #
> @@ -877,6 +888,8 @@ source "arch/arm/mach-realview/Kconfig"
> 
>  source "arch/arm/mach-sa1100/Kconfig"
> 
> +source "arch/arm/mach-vt8500/Kconfig"
> +

Possibly keep this sorted?
>  source "arch/arm/plat-samsung/Kconfig"
>  source "arch/arm/plat-s3c24xx/Kconfig"
>  source "arch/arm/plat-s5p/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 64ba313..dcb5b64 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -179,6 +179,7 @@ machine-$(CONFIG_ARCH_U300)		:= u300
>  machine-$(CONFIG_ARCH_U8500)		:= ux500
>  machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
>  machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
> +machine-$(CONFIG_ARCH_VT8500)		:= vt8500
>  machine-$(CONFIG_ARCH_W90X900)		:= w90x900
>  machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
>  machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
> diff --git a/arch/arm/boot/compressed/Makefile
> b/arch/arm/boot/compressed/Makefile index 53faa90..4f67531 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -32,6 +32,10 @@ ifeq ($(CONFIG_ARCH_SA1100),y)
>  OBJS		+= head-sa1100.o
>  endif
> 
> +ifeq ($(CONFIG_ARCH_VT8500),y)
> +OBJS		+= head-vt8500.o
> +endif
> +
>  ifeq ($(CONFIG_CPU_XSCALE),y)
>  OBJS		+= head-xscale.o
>  endif
> diff --git a/arch/arm/boot/compressed/head-vt8500.S
> b/arch/arm/boot/compressed/head-vt8500.S new file mode 100644
> index 0000000..2faa7d6
> --- /dev/null
> +++ b/arch/arm/boot/compressed/head-vt8500.S
> @@ -0,0 +1,23 @@
> +/*
> + * linux/arch/arm/boot/compressed/head-vt8500.S
> + *
> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + *
> + * VIA VT8500 specific tweaks. This is merged into head.S by the linker.
> + *
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/mach-types.h>
> +
> +		.section        ".start", "ax"
> +
> +__VT8500_start:
> +		/* Override the obscure machine id from bootloader */
> +#ifdef CONFIG_MACH_BV07
> +		mov	r7, #(MACH_TYPE_BV07 & ~0xf)
> +		orr	r7, r7, #(MACH_TYPE_BV07 & 0xf)
> +#elif defined CONFIG_MACH_WM8505_7IN_NETBOOK
> +		mov	r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & ~0xf)
> +		orr	r7, r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & 0xf)
> +#endif

Can't you replace the bootloader ?

> diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
> new file mode 100644
> index 0000000..bd75043
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/Kconfig
> @@ -0,0 +1,33 @@
> +if ARCH_VT8500
> +
> +choice
> +	prompt "VIA/WonderMedia System Type"
> +	default VTWM_VERSION_VT8500
> +
> +config VTWM_VERSION_VT8500
> +	bool "VIA VT8500"
> +
> +config VTWM_VERSION_WM8505
> +	bool "WonderMedia WM8505"
> +
> +endchoice
> +
> +config MACH_BV07
> +	bool "Benign BV07-8500 Mini Netbook"
> +	depends on ARCH_VT8500 && VTWM_VERSION_VT8500
> +	help
> +	  Add support for the inexpensive 7-inch netbooks sold by many
> +	  Chinese distributors under various names. Note that there are
> +	  many hardware implementations in identical exterior, make sure
> +	  that yours is indeed based on a VIA VT8500 chip.
> +
> +config MACH_WM8505_7IN_NETBOOK
> +	bool "WM8505 7-inch generic netbook"
> +	depends on ARCH_VT8500 && VTWM_VERSION_WM8505
> +	help
> +	  Add support for the inexpensive 7-inch netbooks sold by many
> +	  Chinese distributors under various names. Note that there are
> +	  many hardware implementations in identical exterior, make sure
> +	  that yours is indeed based on a WonderMedia WM8505 chip.
> +
> +endif
> diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
> new file mode 100644
> index 0000000..948f3c8
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/Makefile
> @@ -0,0 +1,3 @@
> +obj-y += devices.o irq.o timer.o
> +
> +obj-$(CONFIG_MACH_BV07) += bv07.o
> diff --git a/arch/arm/mach-vt8500/Makefile.boot
> b/arch/arm/mach-vt8500/Makefile.boot new file mode 100644
> index 0000000..a8acc4e
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/Makefile.boot
> @@ -0,0 +1,3 @@
> +   zreladdr-y	:= 0x00008000
> +params_phys-y	:= 0x00000100
> +initrd_phys-y	:= 0x01000000
> diff --git a/arch/arm/mach-vt8500/bv07.c b/arch/arm/mach-vt8500/bv07.c
> new file mode 100644
> index 0000000..b0f374c
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/bv07.c
> @@ -0,0 +1,43 @@
> +/*
> + *  arch/arm/mach-vt8500/bv07.c
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include "devices.h"
> +
> +static struct platform_device *devices[] __initdata = {
> +	&vt8500_device_uart0,
> +};
> +
> +void __init bv07_init(void)
> +{
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +}
> +
> +MACHINE_START(BV07, "Benign BV07 Mini Netbook")
> +	.phys_io	= 0xd8000000,
> +	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
> +	.boot_params	= 0x00000100,
> +	.map_io		= vt8500_map_io,
> +	.init_irq	= vt8500_init_irq,
> +	.timer		= &vt8500_timer,
> +	.init_machine	= bv07_init,
> +MACHINE_END
> diff --git a/arch/arm/mach-vt8500/devices.c
> b/arch/arm/mach-vt8500/devices.c new file mode 100644
> index 0000000..30bf8b5
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/devices.c
> @@ -0,0 +1,149 @@
> +/* linux/arch/arm/mach-vt8500/devices.c
> + *
> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/hardware.h>
> +#include <mach/vt8500.h>
> +#include "devices.h"
> +
> +static struct map_desc vt8500_io_desc[] __initdata = {
> +	{
> +		.virtual	=  IO_ADDRESS(VT8500_DDR_BASE),
> +		.pfn		= __phys_to_pfn(VT8500_DDR_BASE),
> +		.length		= SZ_16M,
> +		.type		= MT_DEVICE
> +	},
> +};
> +
> +void __init vt8500_map_io(void)
> +{
> +	iotable_init(vt8500_io_desc, ARRAY_SIZE(vt8500_io_desc));
> +}
> +
> +static struct resource resources_uart0[] = {
> +	{
> +		.start	= IRQ_UART0,
> +		.end	= IRQ_UART0,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= VT8500_UART0_BASE,
> +		.end	= VT8500_UART0_BASE + VT8500_UART_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct resource resources_uart1[] = {
> +	{
> +		.start	= IRQ_UART1,
> +		.end	= IRQ_UART1,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= VT8500_UART1_BASE,
> +		.end	= VT8500_UART1_BASE + VT8500_UART_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct resource resources_uart2[] = {
> +	{
> +		.start	= IRQ_UART2,
> +		.end	= IRQ_UART2,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= VT8500_UART2_BASE,
> +		.end	= VT8500_UART2_BASE + VT8500_UART_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct resource resources_uart3[] = {
> +	{
> +		.start	= IRQ_UART3,
> +		.end	= IRQ_UART3,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= VT8500_UART3_BASE,
> +		.end	= VT8500_UART3_BASE + VT8500_UART_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +#ifdef CONFIG_VTWM_VERSION_WM8505
> +static struct resource resources_uart4[] = {
> +	{
> +		.start	= IRQ_UART4,
> +		.end	= IRQ_UART4,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= VT8500_UART4_BASE,
> +		.end	= VT8500_UART4_BASE + VT8500_UART_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct resource resources_uart5[] = {
> +	{
> +		.start	= IRQ_UART5,
> +		.end	= IRQ_UART5,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.start	= VT8500_UART5_BASE,
> +		.end	= VT8500_UART5_BASE + VT8500_UART_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +#endif
> +
> +struct platform_device vt8500_device_uart0 = {
> +	.name		= "vt8500_serial",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(resources_uart0),
> +	.resource	= resources_uart0,
> +};
> +
> +struct platform_device vt8500_device_uart1 = {
> +	.name		= "vt8500_serial",
> +	.id		= 1,
> +	.num_resources	= ARRAY_SIZE(resources_uart1),
> +	.resource	= resources_uart1,
> +};
> +
> +struct platform_device vt8500_device_uart2 = {
> +	.name		= "vt8500_serial",
> +	.id		= 2,
> +	.num_resources	= ARRAY_SIZE(resources_uart2),
> +	.resource	= resources_uart2,
> +};
> +
> +struct platform_device vt8500_device_uart3 = {
> +	.name		= "vt8500_serial",
> +	.id		= 3,
> +	.num_resources	= ARRAY_SIZE(resources_uart3),
> +	.resource	= resources_uart3,
> +};
> diff --git a/arch/arm/mach-vt8500/devices.h
> b/arch/arm/mach-vt8500/devices.h new file mode 100644
> index 0000000..243ed0a
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/devices.h
> @@ -0,0 +1,34 @@
> +/* linux/arch/arm/mach-vt8500/devices.h
> + *
> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __ARCH_ARM_MACH_VT8500_DEVICES_H
> +#define __ARCH_ARM_MACH_VT8500_DEVICES_H
> +
> +#include <linux/platform_device.h>
> +
> +void __init vt8500_init_irq(void);
> +void __init vt8500_map_io(void);
> +extern struct sys_timer vt8500_timer;
> +
> +extern struct platform_device vt8500_device_uart0;
> +extern struct platform_device vt8500_device_uart1;
> +extern struct platform_device vt8500_device_uart2;
> +extern struct platform_device vt8500_device_uart3;
> +#ifdef CONFIG_VTWM_VERSION_WM8505
> +extern struct platform_device vt8500_device_uart4;
> +extern struct platform_device vt8500_device_uart5;
> +#endif
> +
> +#endif
> diff --git a/arch/arm/mach-vt8500/include/mach/debug-macro.S
> b/arch/arm/mach-vt8500/include/mach/debug-macro.S new file mode 100644
> index 0000000..264e0be
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/debug-macro.S
> @@ -0,0 +1,35 @@
> +/*
> + * arch/arm/mach-vt8500/include/mach/debug-macro.S
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + *
> + * Debugging macro include header
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> +*/
> +
> +#include <mach/vt8500.h>
> +
> +	.macro	addruart, rx, tmp
> +	mrc	p15, 0, \rx, c1, c0
> +	tst	\rx, #1			@ MMU enabled?
> +	moveq	\rx,      #0xd8000000
> +	movne	\rx,      #0xf8000000	@ virtual base
> +	orr	\rx, \rx, #0x00200000
> +	.endm
> +
> +	.macro	senduart,rd,rx
> +	strb	\rd, [\rx, #0]
> +	.endm
> +
> +	.macro	busyuart,rd,rx
> +1001:	ldr	\rd, [\rx, #0x1c]
> +	ands	\rd, \rd, #0x2
> +	bne	1001b
> +	.endm
> +
> +	.macro	waituart,rd,rx
> +	.endm
> diff --git a/arch/arm/mach-vt8500/include/mach/entry-macro.S
> b/arch/arm/mach-vt8500/include/mach/entry-macro.S new file mode 100644
> index 0000000..6b8a04e
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/entry-macro.S
> @@ -0,0 +1,41 @@
> +/*
> + * arch/arm/mach-vt8500/include/mach/entry-macro.S
> + *
> + * Low-level IRQ helper macros for VIA VT8500
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro  get_irqnr_preamble, base, tmp
> +	@ physical 0xd8140000 is virtual 0xf8140000
> +	mov	\base, #0xf8000000
> +	orr	\base, \base, #0x00140000
> +	.endm
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> +
> +	/* Reserved interrupts, to be masked off: 2, 4, 23 */
> +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	@ check low interrupts
> +	ldr	\irqstat, [\base, #0x80]
> +	mov	\tmp, #0x800000		@ 1 << 23
> +	orr	\tmp, \tmp, #0x14	@ (1 << 4) + (1 << 2)
> +	mov	\irqnr, #31
> +	bics	\irqstat, \irqstat, \tmp
> +
> +	@ if no low interrupts set, check high interrupts
> +	ldreq	\irqstat, [\base, #0x84]
> +	moveq	\irqnr, #63
> +	cmpeq	\irqstat, #0
> +
> +	@ find first active interrupt source
> +	clzne	\irqstat, \irqstat
> +	subne	\irqnr, \irqnr, \irqstat
> +	.endm
> +
> diff --git a/arch/arm/mach-vt8500/include/mach/gpio.h
> b/arch/arm/mach-vt8500/include/mach/gpio.h new file mode 100644
> index 0000000..94ff276
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/gpio.h
> @@ -0,0 +1,6 @@
> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value	__gpio_get_value
> +#define gpio_set_value	__gpio_set_value
> +#define gpio_cansleep	__gpio_cansleep
> +#define gpio_to_irq	__gpio_to_irq
> diff --git a/arch/arm/mach-vt8500/include/mach/hardware.h
> b/arch/arm/mach-vt8500/include/mach/hardware.h new file mode 100644
> index 0000000..4aae7d2
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/hardware.h
> @@ -0,0 +1,19 @@
> +/* arch/arm/mach-vt8500/include/mach/hardware.h
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifdef CONFIG_MMU
> +/* macro to get at IO space when running virtually */
> +#define IO_ADDRESS(x) ((x) | 0xf0000000)
> +#else
> +#define IO_ADDRESS(x) (x)
> +#endif
> diff --git a/arch/arm/mach-vt8500/include/mach/io.h
> b/arch/arm/mach-vt8500/include/mach/io.h new file mode 100644
> index 0000000..dc2181a
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/io.h
> @@ -0,0 +1,28 @@
> +/*
> + *  arch/arm/mach-vt8500/include/mach/io.h
> + *
> + *  Copyright (C) 2003 ARM Limited

Really? You just copied it ?

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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +#ifndef __ASM_ARM_ARCH_IO_H
> +#define __ASM_ARM_ARCH_IO_H
> +
> +#define IO_SPACE_LIMIT 0xffffffff
> +
> +#define __io(a)		__typesafe_io(a)
> +#define __mem_pci(a)	(a)
> +
> +#endif
> diff --git a/arch/arm/mach-vt8500/include/mach/irqs.h
> b/arch/arm/mach-vt8500/include/mach/irqs.h new file mode 100644
> index 0000000..4bfd673
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/irqs.h
> @@ -0,0 +1,87 @@
> +/*
> + *  arch/arm/mach-vt8500/include/mach/irqs.h
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#define IRQ_JPEGENC	0	/* JPEG Encoder */
> +#define IRQ_JPEGDEC	1	/* JPEG Decoder */
> +				/* Reserved */
> +#define IRQ_PATA	3	/* PATA Controller */
> +				/* Reserved */
> +#define IRQ_DMA		5	/* DMA Controller */
> +#define IRQ_EXT0	6	/* External Interrupt 0 */
> +#define IRQ_EXT1	7	/* External Interrupt 1 */
> +#define IRQ_GRAPH	8	/* Graphic Engine */
> +#define IRQ_GRAPH_OVER	9	/* Graphic Overlay Engine */
> +#define IRQ_ETHER	10	/* Ethernet MAC */
> +#define IRQ_MPEGTS	11	/* Transport Stream Interface */
> +#define IRQ_LCDC	12	/* LCD Controller */
> +#define IRQ_EXT2	13	/* External Interrupt 2 */
> +#define IRQ_EXT3	14	/* External Interrupt 3 */
> +#define IRQ_EXT4	15	/* External Interrupt 4 */
> +#define IRQ_CIPHER	16	/* Cipher */
> +#define IRQ_VPP		17	/* Video Post-Processor */
> +#define IRQ_I2C1	18	/* I2C 1 */
> +#define IRQ_I2C0	19	/* I2C 0 */
> +#define IRQ_SDMMC	20	/* SD/MMC Controller */
> +#define IRQ_SDMMC_DMA	21	/* SD/MMC Controller DMA */
> +#define IRQ_PMC_WU	22	/* Power Management Controller Wakeup */
> +				/* Reserved */
> +#define IRQ_SPI0	24	/* SPI 0 */
> +#define IRQ_SPI1	25	/* SPI 1 */
> +#define IRQ_SPI2	26	/* SPI 2 */
> +#define IRQ_LCDDF	27	/* LCD Data Formatter */
> +#define IRQ_NAND	28	/* NAND Flash Controller */
> +#define IRQ_NAND_DMA	29	/* NAND Flash Controller DMA */
> +#define IRQ_MS		30	/* MemoryStick Controller */
> +#define IRQ_MS_DMA	31	/* MemoryStick Controller DMA */
> +#define IRQ_UART0	32	/* UART 0 */
> +#define IRQ_UART1	33	/* UART 1 */
> +#define IRQ_I2S		34	/* I2S */
> +#define IRQ_PCM		35	/* PCM */
> +#define IRQ_PMCOS0	36	/* PMC OS Timer 0 */
> +#define IRQ_PMCOS1	37	/* PMC OS Timer 1 */
> +#define IRQ_PMCOS2	38	/* PMC OS Timer 2 */
> +#define IRQ_PMCOS3	39	/* PMC OS Timer 3 */
> +#define IRQ_VPU		40	/* Video Processing Unit */
> +#define IRQ_VDI		41	/* Video Digital Input Interface */
> +#define IRQ_AC97	42	/* AC97 Interface */
> +#define IRQ_USB		43	/* USB */
> +#define IRQ_NOR		44	/* NOR Flash Controller */
> +#define IRQ_PS2MOUSE	45	/* PS/2 Mouse */
> +#define IRQ_PS2KBD	46	/* PS/2 Keyboard */
> +#define IRQ_UART2	47	/* UART 2 */
> +#define IRQ_RTC		48	/* RTC Interrupt */
> +#define IRQ_RTCSM	49	/* RTC Second/Minute Update Interrupt */
> +#define IRQ_UART3	50	/* UART 3 */
> +#define IRQ_ADC		51	/* ADC */
> +#define IRQ_EXT5	52	/* External Interrupt 5 */
> +#define IRQ_EXT6	53	/* External Interrupt 6 */
> +#define IRQ_EXT7	54	/* External Interrupt 7 */
> +#define IRQ_CIR		55	/* CIR */
> +#define IRQ_DMA0	56	/* DMA Channel 0 */
> +#define IRQ_DMA1	57	/* DMA Channel 1 */
> +#define IRQ_DMA2	58	/* DMA Channel 2 */
> +#define IRQ_DMA3	59	/* DMA Channel 3 */
> +#define IRQ_DMA4	60	/* DMA Channel 4 */
> +#define IRQ_DMA5	61	/* DMA Channel 5 */
> +#define IRQ_DMA6	62	/* DMA Channel 6 */
> +#define IRQ_DMA7	63	/* DMA Channel 7 */
> +
> +
> +#define NR_IRQS		64
> diff --git a/arch/arm/mach-vt8500/include/mach/memory.h
> b/arch/arm/mach-vt8500/include/mach/memory.h new file mode 100644
> index 0000000..175f914
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/memory.h
> @@ -0,0 +1,28 @@
> +/*
> + *  arch/arm/mach-vt8500/include/mach/memory.h
> + *
> + *  Copyright (C) 2003 ARM Limited

DTTO ?

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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +#ifndef __ASM_ARCH_MEMORY_H
> +#define __ASM_ARCH_MEMORY_H
> +
> +/*
> + * Physical DRAM offset.
> + */
> +#define PHYS_OFFSET	UL(0x00000000)
> +
> +#endif
> diff --git a/arch/arm/mach-vt8500/include/mach/system.h
> b/arch/arm/mach-vt8500/include/mach/system.h new file mode 100644
> index 0000000..f3fac00
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/system.h
> @@ -0,0 +1,15 @@
> +/*
> + * arch/arm/mach-vt8500/include/mach/system.h
> + *
> + */
> +#include <mach/hardware.h>
> +
> +static inline void arch_idle(void)
> +{
> +	cpu_do_idle();
> +}
> +
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	cpu_reset(0);
> +}
> diff --git a/arch/arm/mach-vt8500/include/mach/timex.h
> b/arch/arm/mach-vt8500/include/mach/timex.h new file mode 100644
> index 0000000..ff209d8
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/timex.h
> @@ -0,0 +1,21 @@
> +/*
> + *  arch/arm/mach-vt8500/include/mach/timex.h
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +

#ifndef MACH_TIMEX
#define MACH_TIMEX

> +#define CLOCK_TICK_RATE		(3000000)

#endif

Maybe ?

> diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h
> b/arch/arm/mach-vt8500/include/mach/uncompress.h new file mode 100644
> index 0000000..3f14bf1
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
> @@ -0,0 +1,46 @@
> +/* arch/arm/mach-vt8500/include/mach/uncompress.h
> + *
> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + *
> + * Based on arch/arm/mach-dove/include/mach/uncompress.h
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <mach/vt8500.h>
> +
> +#define UART_THR ((volatile unsigned char *)(VT8500_UART0_BASE + 0x0))
> +#define UART_LSR ((volatile unsigned char *)(VT8500_UART0_BASE + 0x24))

Can't you use some better accessors here ?
> +
> +#define LSR_THRE	0x1f
> +
> +static void putc(const char c)
> +{
> +	int i;
> +
> +	for (i = 0; i < 0x1000; i++) {
> +		/* Transmit fifo not full? */
> +		if (*UART_LSR & LSR_THRE)
> +			break;
> +	}
> +
> +	*UART_THR = c;
> +}
> +
> +static void flush(void)
> +{
> +}
> +
> +/*
> + * nothing to do
> + */
> +#define arch_decomp_setup()
> +#define arch_decomp_wdog()
> diff --git a/arch/arm/mach-vt8500/include/mach/vmalloc.h
> b/arch/arm/mach-vt8500/include/mach/vmalloc.h new file mode 100644
> index 0000000..75a6912
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/vmalloc.h
> @@ -0,0 +1,20 @@
> +/*
> + *  arch/arm/mach-vt8500/include/mach/vmalloc.h
> + *
> + *  Copyright (C) 2000 Russell King.
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +#define VMALLOC_END		(PAGE_OFFSET + 0x10000000)
> diff --git a/arch/arm/mach-vt8500/include/mach/vt8500.h
> b/arch/arm/mach-vt8500/include/mach/vt8500.h new file mode 100644
> index 0000000..f419ab6
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/vt8500.h
> @@ -0,0 +1,145 @@
> +/*
> + *  arch/arm/mach-vt8500/include/mach/vt8500.h
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +#ifndef __ASM_ARM_ARCH_VT8500_H
> +#define __ASM_ARM_ARCH_VT8500_H
> +
> +#ifdef CONFIG_VTWM_VERSION_VT8500
> +/* VT8500 Registers Map */
> +
> +#define VT8500_DDR_BASE		0xd8000000	/* 1k	DDR/DDR2 Memory
> +							Controller */
> +#define VT8500_DMA_BASE		0xd8001000	/* 1k	DMA Controller 
*/
> +#define VT8500_SFLASH_BASE	0xd8002000	/* 1k	Serial Flash Memory
> +							Controller */
> +#define VT8500_ETHER_BASE	0xd8004000	/* 1k	Ethernet MAC 0 */
> +#define VT8500_CIPHER_BASE	0xd8006000	/* 4k	Cipher */
> +#define VT8500_USB_BASE		0xd8007800	/* 2k	USB OTG */
> +#define VT8500_PATA_BASE	0xd8008000	/* 512	PATA */
> +#define VT8500_PS2_BASE		0xd8008800	/* 1k	PS/2 */
> +#define VT8500_NAND_BASE	0xd8009000	/* 1k	NAND Controller */
> +#define VT8500_NOR_BASE		0xd8009400	/* 1k	NOR Controller 
*/
> +#define VT8500_SDMMC_BASE	0xd800a000	/* 1k	SD/MMC Controller */
> +#define VT8500_MS_BASE		0xd800b000	/* 1k	MS/MSPRO 
Controller */
> +#define VT8500_LCDC_BASE	0xd800e400	/* 1k	LCD Controller */
> +#define VT8500_VPU_BASE		0xd8050000	/* 256	VPU */
> +#define VT8500_GOV_BASE		0xd8050300	/* 256	GOV */
> +#define VT8500_GEGEA_BASE	0xd8050400	/* 768	GE/GE Alpha Mixing */
> +#define VT8500_LCDF_BASE	0xd8050900	/* 256	LCD Formatter */
> +#define VT8500_VID_BASE		0xd8050a00	/* 256	VID */
> +#define VT8500_VPP_BASE		0xd8050b00	/* 256	VPP */
> +#define VT8500_TSBK_BASE	0xd80f4000	/* 4k	TSBK */
> +#define VT8500_JPEGDEC_BASE	0xd80fe000	/* 4k	JPEG Decoder */
> +#define VT8500_JPEGENC_BASE	0xd80ff000	/* 4k	JPEG Encoder */
> +#define VT8500_RTC_BASE		0xd8100000	/* 64k	RTC */
> +#define VT8500_GPIO_BASE	0xd8110000	/* 64k	GPIO Configuration */
> +#define VT8500_SCC_BASE		0xd8120000	/* 64k	System 
Configuration*/
> +#define VT8500_PMC_BASE		0xd8130000	/* 64k	PMC 
Configuration */
> +#define VT8500_IC_BASE		0xd8140000	/* 64k	Interrupt 
Controller*/
> +#define VT8500_UART0_BASE	0xd8200000	/* 64k	UART 0 */
> +#define VT8500_UART2_BASE	0xd8210000	/* 64k	UART 2 */
> +#define VT8500_PWM_BASE		0xd8220000	/* 64k	PWM 
Configuration */
> +#define VT8500_SPI0_BASE	0xd8240000	/* 64k	SPI 0 */
> +#define VT8500_SPI1_BASE	0xd8250000	/* 64k	SPI 1 */
> +#define VT8500_CIR_BASE		0xd8270000	/* 64k	CIR */
> +#define VT8500_I2C0_BASE	0xd8280000	/* 64k	I2C 0 */
> +#define VT8500_AC97_BASE	0xd8290000	/* 64k	AC97 */
> +#define VT8500_SPI2_BASE	0xd82a0000	/* 64k	SPI 2 */
> +#define VT8500_UART1_BASE	0xd82b0000	/* 64k	UART 1 */
> +#define VT8500_UART3_BASE	0xd82c0000	/* 64k	UART 3 */
> +#define VT8500_PCM_BASE		0xd82d0000	/* 64k	PCM */
> +#define VT8500_I2C1_BASE	0xd8320000	/* 64k	I2C 1 */
> +#define VT8500_I2S_BASE		0xd8330000	/* 64k	I2S */
> +#define VT8500_ADC_BASE		0xd8340000	/* 64k	ADC */
> +
> +#elif defined CONFIG_VTWM_VERSION_WM8505
> +/* WM8500 Registers Map */
> +/* To be confirmed! */
> +
> +#define VT8500_DDR_BASE		0xd8000400	/* 1k	DDR/DDR2 Memory
> +							Controller */
> +#define VT8500_DMA_BASE		0xd8001800	/* 1k	DMA Controller 
*/
> +#define VT8500_VDMA_BASE	0xd8001c00	/* 1k	VDMA */
> +#define VT8500_SFLASH_BASE	0xd8002000	/* 1k	Serial Flash Memory
> +							Controller */
> +#define VT8500_ETHER_BASE	0xd8004000	/* 1k	Ethernet MAC 0 */
> +#define VT8500_CIPHER_BASE	0xd8006000	/* 4k	Cipher */
> +#define VT8500_USB_BASE		0xd8007000	/* 2k	USB 2.0 Host */
> +#define VT8500_PS2_BASE		0xd8008800	/* 1k	PS/2 */
> +#define VT8500_NAND_BASE	0xd8009000	/* 1k	NAND Controller */
> +#define VT8500_NOR_BASE		0xd8009400	/* 1k	NOR Controller 
*/
> +#define VT8500_SDMMC_BASE	0xd800a000	/* 1k	SD/MMC Controller */
> +#define VT8500_LCDC_BASE	0xd800e400	/* 1k	LCD Controller */
> +#define VT8500_VPU_BASE		0xd8050000	/* 256	VPU */
> +#define VT8500_GOV_BASE		0xd8050300	/* 256	GOV */
> +#define VT8500_GEGEA_BASE	0xd8050400	/* 768	GE/GE Alpha Mixing */
> +#define VT8500_LCDF_BASE	0xd8050900	/* 256	LCD Formatter */
> +#define VT8500_VID_BASE		0xd8050a00	/* 256	VID */
> +#define VT8500_VPP_BASE		0xd8050b00	/* 256	VPP */
> +#define VT8500_TSBK_BASE	0xd80f4000	/* 4k	TSBK */
> +#define VT8500_JPEGDEC_BASE	0xd80fe000	/* 4k	JPEG Decoder */
> +#define VT8500_JPEGENC_BASE	0xd80ff000	/* 4k	JPEG Encoder */
> +#define VT8500_RTC_BASE		0xd8100000	/* 64k	RTC */
> +#define VT8500_GPIO_BASE	0xd8110000	/* 64k	GPIO Configuration */
> +#define VT8500_SCC_BASE		0xd8120000	/* 64k	System 
Configuration*/
> +#define VT8500_PMC_BASE		0xd8130000	/* 64k	PMC 
Configuration */
> +#define VT8500_IC_BASE		0xd8140000	/* 64k	Interrupt 
Controller*/
> +#define VT8500_SIC_BASE		0xd8150000	/* 64k	Secondary IC */
> +#define VT8500_UART0_BASE	0xd8200000	/* 64k	UART 0 */
> +#define VT8500_UART2_BASE	0xd8210000	/* 64k	UART 2 */
> +#define VT8500_PWM_BASE		0xd8220000	/* 64k	PWM 
Configuration */
> +#define VT8500_SPI0_BASE	0xd8240000	/* 64k	SPI 0 */
> +#define VT8500_SPI1_BASE	0xd8250000	/* 64k	SPI 1 */
> +#define VT8500_CIR_BASE		0xd8270000	/* 64k	CIR */
> +#define VT8500_I2C0_BASE	0xd8280000	/* 64k	I2C 0 */
> +#define VT8500_AC97_BASE	0xd8290000	/* 64k	AC97 */
> +#define VT8500_SPI2_BASE	0xd82a0000	/* 64k	SPI 2 */
> +#define VT8500_UART1_BASE	0xd82b0000	/* 64k	UART 1 */
> +#define VT8500_UART3_BASE	0xd82c0000	/* 64k	UART 3 */
> +#define VT8500_PCM_BASE		0xd82d0000	/* 64k	PCM */
> +#define VT8500_I2C1_BASE	0xd8320000	/* 64k	I2C 1 */
> +#define VT8500_I2S_BASE		0xd8330000	/* 64k	I2S */
> +#define VT8500_ADC_BASE		0xd8340000	/* 64k	ADC */
> +#define VT8500_UART1_BASE	0xd8370000	/* 64k	UART 4 */
> +#define VT8500_UART3_BASE	0xd8380000	/* 64k	UART 5 */
> +
> +#endif
> +
> +/*
> + * UART Register offsets
> + */
> +
> +#define VT8500_URTDR		0x0000	/* Transmit data */
> +#define VT8500_URRDR		0x0004	/* Receive data */
> +#define VT8500_URDIV		0x0008	/* Clock/Baud rate divisor */
> +#define VT8500_URLCR		0x000C	/* Line control */
> +#define VT8500_URICR		0x0010	/* IrDA control */
> +#define VT8500_URIER		0x0014	/* Interrupt enable */
> +#define VT8500_URISR		0x0018	/* Interrupt status */
> +#define VT8500_URUSR		0x001c	/* UART status */
> +#define VT8500_URFCR		0x0020	/* FIFO control */
> +#define VT8500_URFIDX		0x0024	/* FIFO index */
> +#define VT8500_URBKR		0x0028	/* Break signal count */
> +#define VT8500_URTOD		0x002c	/* Time out divisor */
> +#define VT8500_TXFIFO		0x1000	/* Transmit FIFO (16x8) */
> +#define VT8500_RXFIFO		0x1020	/* Receive FIFO (16x10) */
> +
> +#define VT8500_UART_SIZE	0x1040
> +
> +#endif
> diff --git a/arch/arm/mach-vt8500/irq.c b/arch/arm/mach-vt8500/irq.c
> new file mode 100644
> index 0000000..9299693
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/irq.c
> @@ -0,0 +1,122 @@
> +/*
> + *  arch/arm/mach-vt8500/irq.c
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/vt8500.h>
> +
> +#define VT8500_IC_DCTR		0x40		/* Destination control
> +						register, 64*u8 */
> +#define VT8500_INT_ENABLE	(1 << 3)
> +#define VT8500_TRIGGER_HIGH	(0 << 4)
> +#define VT8500_TRIGGER_RISING	(1 << 4)
> +#define VT8500_TRIGGER_FALLING	(2 << 4)
> +#define VT8500_IC_STATUS	0x80		/* Interrupt status, 2*u32 */
> +
> +static void vt8500_irq_mask(unsigned int irq)
> +{
> +	u8 edge = readb(IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq) & (3 << 4);
> +	if (edge)
> +		writel(readl(IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_STATUS + (irq < 32 ? 0 : 4))
> +			| (1 << (irq & 0x1f)), IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_STATUS + (irq & 0x20 ? 4 : 0));
> +	else
> +		writeb(readb(IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq) & ~VT8500_INT_ENABLE,
> +			IO_ADDRESS(VT8500_IC_BASE) + VT8500_IC_DCTR + irq);
> +}
> +
> +static void vt8500_irq_unmask(unsigned int irq)
> +{
> +	writeb(readb(IO_ADDRESS(VT8500_IC_BASE)
> +		+ VT8500_IC_DCTR + irq) | VT8500_INT_ENABLE,
> +		IO_ADDRESS(VT8500_IC_BASE) + VT8500_IC_DCTR + irq);
> +}
> +
> +static int vt8500_irq_set_wake(unsigned int irq, unsigned int on)
> +{
> +	return -EINVAL;
> +}
> +
> +static int vt8500_irq_set_type(unsigned int irq, unsigned int flow_type)
> +{
> +	switch (flow_type) {
> +	case IRQF_TRIGGER_LOW:
> +		return -EINVAL;
> +	case IRQF_TRIGGER_HIGH:
> +		writeb((readb(IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq) & ~(3 << 4))
> +			| VT8500_TRIGGER_HIGH, IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq);
> +		set_irq_handler(irq, handle_level_irq);
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		writeb((readb(IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq) & ~(3 << 4))
> +			| VT8500_TRIGGER_FALLING, IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq);
> +		set_irq_handler(irq, handle_edge_irq);
> +		break;
> +	case IRQF_TRIGGER_RISING:
> +		writeb((readb(IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq) & ~(3 << 4))
> +			| VT8500_TRIGGER_RISING, IO_ADDRESS(VT8500_IC_BASE)
> +			+ VT8500_IC_DCTR + irq);
> +		set_irq_handler(irq, handle_edge_irq);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct irq_chip vt8500_irq_chip = {
> +	.name      = "vt8500",
> +	.ack       = vt8500_irq_mask,
> +	.mask      = vt8500_irq_mask,
> +	.unmask    = vt8500_irq_unmask,
> +	.set_wake  = vt8500_irq_set_wake,
> +	.set_type  = vt8500_irq_set_type,
> +};
> +
> +void __init vt8500_init_irq(void)
> +{
> +	unsigned int i;
> +
> +	/* Enable rotating priority for IRQ */
> +	writel((1 << 6), IO_ADDRESS(VT8500_IC_BASE) + 0x20);
> +	writel(0, IO_ADDRESS(VT8500_IC_BASE) + 0x24);
> +
> +	for (i = 0; i < NR_IRQS; i++) {
> +		/* Disable all interrupts and route them to IRQ */
> +		writeb(0x00, IO_ADDRESS(VT8500_IC_BASE) + VT8500_IC_DCTR + i);
> +
> +		set_irq_chip(i, &vt8500_irq_chip);
> +		set_irq_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +}
> diff --git a/arch/arm/mach-vt8500/timer.c b/arch/arm/mach-vt8500/timer.c
> new file mode 100644
> index 0000000..817edc8
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/timer.c
> @@ -0,0 +1,185 @@
> +/*
> + *  arch/arm/mach-vt8500/timer.c
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/cnt32_to_63.h>
> +
> +#include <asm/mach/time.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/vt8500.h>
> +
> +#define VT8500_TIMER_OFFSET	0x0100
> +#define TIMER_MATCH_VAL		0x0000
> +#define TIMER_COUNT_VAL		0x0010
> +#define TIMER_STATUS_VAL	0x0014
> +#define TIMER_IER_VAL		0x001c		/* interrupt enable */
> +#define TIMER_CTRL_VAL		0x0020
> +#define TIMER_AS_VAL		0x0024		/* access status */
> +#define TIMER_COUNT_R_ACTIVE	(1 << 5)	/* not ready for read */
> +#define TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write */
> +#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not ready for write */
> +#define VT8500_TIMER_HZ		3000000
> +void __iomem* regbase = (void __iomem *)(IO_ADDRESS(VT8500_PMC_BASE)
> +			+ VT8500_TIMER_OFFSET);
> +
> +unsigned long long sched_clock(void)
> +{
> +	unsigned long long v;
> +
> +	writel(0x3, regbase + TIMER_CTRL_VAL);
> +	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
> +		/* wait and poll */;
> +
> +	v = cnt32_to_63(readl(regbase + TIMER_COUNT_VAL));
> +
> +	/* the <<1 gets rid of the cnt_32_to_63 top bit saving on a bic insn*/
> +	v *= 1000<<1;		/* 3MHz timer tick implies 333ns resolution */
> +	do_div(v, 3<<1);

Did you run checkpatch here ... or on this patch ?

> +
> +	return v;
> +}
> +
> +static int vt8500_timer_set_next_event(unsigned long cycles,
> +				    struct clock_event_device *evt)
> +{
> +	unsigned long now, alarm;
> +	int late;
> +
> +	writel(3, regbase + TIMER_CTRL_VAL);
> +	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
> +		/* wait and poll */;
> +	now = readl(regbase + TIMER_COUNT_VAL);
> +	alarm = now + cycles;
> +	while (readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
> +		/* wait and poll */;
> +	writel(alarm, regbase + TIMER_MATCH_VAL);
> +
> +	writel(3, regbase + TIMER_CTRL_VAL);
> +	while (readl(regbase + TIMER_AS_VAL) & TIMER_COUNT_R_ACTIVE)
> +		/* wait and poll */;
> +	now = readl(regbase + TIMER_COUNT_VAL);
> +	late = now - alarm;
> +	if (late >= (-2) && late < VT8500_TIMER_HZ*5)
> +		return -ETIME;
> +
> +	writel(1, regbase + TIMER_IER_VAL);
> +
> +	return 0;
> +}
> +
> +static void vt8500_timer_set_mode(enum clock_event_mode mode,
> +			      struct clock_event_device *evt)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_RESUME:
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		writel(readl(regbase + TIMER_CTRL_VAL) | 1,
> +			regbase + TIMER_CTRL_VAL);
> +		writel(0, regbase + TIMER_IER_VAL);
> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		writel(readl(regbase + TIMER_CTRL_VAL) & ~1,
> +			regbase + TIMER_CTRL_VAL);
> +		break;
> +	}
> +}
> +
> +struct clock_event_device clockevent = {
> +	.name           = "vt8500_timer",
> +	.features       = CLOCK_EVT_FEAT_ONESHOT,
> +	.rating         = 200,
> +	.set_next_event = vt8500_timer_set_next_event,
> +	.set_mode       = vt8500_timer_set_mode,
> +};
> +
> +static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +	evt->event_handler(evt);
> +	writel(0xf, regbase + TIMER_STATUS_VAL);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static cycle_t vt8500_timer_read(struct clocksource *cs)
> +{
> +	writel(3, regbase + TIMER_CTRL_VAL);
> +	while (readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
> +		/* wait and poll */;
> +	return readl(regbase + TIMER_COUNT_VAL);
> +}
> +
> +struct clocksource clocksource = {
> +	.name           = "vt8500_timer",
> +	.rating         = 200,
> +	.read           = vt8500_timer_read,
> +	.mask           = CLOCKSOURCE_MASK(32),
> +	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +struct irqaction irq = {
> +	.name    = "vt8500_timer",
> +	.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler = vt8500_timer_interrupt,
> +	.dev_id  = &clockevent,
> +};
> +
> +static void __init vt8500_timer_init(void)
> +{
> +	int res;
> +
> +	struct clock_event_device *ce = &clockevent;
> +	struct clocksource *cs = &clocksource;
> +	writel(1, regbase + TIMER_CTRL_VAL);
> +	writel(0xf, regbase + TIMER_STATUS_VAL);
> +	writel(~0, regbase + TIMER_MATCH_VAL);
> +
> +	clockevents_calc_mult_shift(ce, VT8500_TIMER_HZ, 4);
> +	clocksource_calc_mult_shift(cs, VT8500_TIMER_HZ, 4);
> +
> +	/* copy-pasted from mach-msm; no idea */
> +	ce->max_delta_ns =
> +		clockevent_delta2ns(0xf0000000, ce);
> +	ce->min_delta_ns = clockevent_delta2ns(4, ce);
> +	ce->cpumask = cpumask_of(0);
> +
> +	res = clocksource_register(cs);
> +	if (res)
> +		printk(KERN_ERR "vt8500_timer_init: clocksource_register "
> +			"failed for %s\n", cs->name);
> +
> +	res = setup_irq(IRQ_PMCOS0, &irq);
> +
> +	if (res)
> +		printk(KERN_ERR "vt8500_timer_init: setup_irq "
> +			"failed for %s\n", cs->name);
> +	clockevents_register_device(ce);
> +}
> +
> +struct sys_timer vt8500_timer = {
> +	.init = vt8500_timer_init
> +};
> diff --git a/arch/arm/mach-vt8500/wm8505_7in.c
> b/arch/arm/mach-vt8500/wm8505_7in.c new file mode 100644
> index 0000000..71a0071
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/wm8505_7in.c
> @@ -0,0 +1,43 @@
> +/*
> + *  arch/arm/mach-vt8500/wm8505_7in.c
> + *
> + *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA + */
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include "devices.h"
> +
> +static struct platform_device *devices[] __initdata = {
> +	&vt8500_device_uart0,
> +};
> +
> +void __init wm8505_7in_init(void)
> +{
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +}
> +
> +MACHINE_START(WM8505_7IN_NETBOOK, "WM8505 7-inch generic netbook")
> +	.phys_io	= 0xd8000000,
> +	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
> +	.boot_params	= 0x00000100,
> +	.map_io		= vt8500_map_io,
> +	.init_irq	= vt8500_init_irq,
> +	.timer		= &vt8500_timer,
> +	.init_machine	= wm8505_7in_init,
> +MACHINE_END
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 8f10d24..f5745d1 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -12,7 +12,7 @@
>  #
>  #   http://www.arm.linux.org.uk/developer/machines/?action=new
>  #
> -# Last update: Sat May 1 10:36:42 2010
> +# Last update: Sat Jun 19 13:07:40 2010
>  #
>  # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
>  #
> @@ -1319,7 +1319,7 @@ mistral			MACH_MISTRAL		MISTRAL		
	1315
>  msm			MACH_MSM		MSM			1316
>  ct5910			MACH_CT5910		CT5910			
1317
>  ct5912			MACH_CT5912		CT5912			
1318
> -hynet_ine		MACH_HYNET_INE		HYNET_INE		1319
> +argonst_foundation	MACH_HYNET_INE		HYNET_INE		1319
>  hynet_app		MACH_HYNET_APP		HYNET_APP		1320
>  msm7200			MACH_MSM7200		MSM7200			
1321
>  msm7600			MACH_MSM7600		MSM7600			
1322
> @@ -1777,7 +1777,7 @@ wdg002			MACH_WDG002		WDG002		
	1785
>  sg560adsl		MACH_SG560ADSL		SG560ADSL		1786
>  nextio_n2800_ica	MACH_NEXTIO_N2800_ICA	NEXTIO_N2800_ICA	1787
>  dove_db			MACH_DOVE_DB		DOVE_DB			
1788
> -marvell_newdb		MACH_MARVELL_NEWDB	MARVELL_NEWDB		
1789
> +dove_avng		MACH_MARVELL_NEWDB	MARVELL_NEWDB		1789
>  vandihud		MACH_VANDIHUD		VANDIHUD		1790
>  magx_e8			MACH_MAGX_E8		MAGX_E8			
1791
>  magx_z6			MACH_MAGX_Z6		MAGX_Z6			
1792
> @@ -2308,7 +2308,7 @@ ecac2378		MACH_ECAC2378		ECAC2378	
	2319
>  tazkiosk		MACH_TAZKIOSK		TAZKIOSK		2320
>  whiterabbit_mch		MACH_WHITERABBIT_MCH	WHITERABBIT_MCH		
2321
>  sbox9263		MACH_SBOX9263		SBOX9263		2322
> -oreo			MACH_OREO		OREO			2323
> +oreo_camera		MACH_OREO		OREO			2323
>  smdk6442		MACH_SMDK6442		SMDK6442		2324
>  openrd_base		MACH_OPENRD_BASE	OPENRD_BASE		2325
>  incredible		MACH_INCREDIBLE		INCREDIBLE		2326
> @@ -2374,7 +2374,7 @@ sch_m490		MACH_SCH_M490		SCH_M490	
	2386
>  rbl01			MACH_RBL01		RBL01			
2387
>  omnifi			MACH_OMNIFI		OMNIFI			
2388
>  otavalo			MACH_OTAVALO		OTAVALO			
2389
> -sienna			MACH_SIENNA		SIENNA			
2390
> +siena			MACH_SIENNA		SIENNA			
2390
>  htc_excalibur_s620	MACH_HTC_EXCALIBUR_S620	HTC_EXCALIBUR_S620	2391
>  htc_opal		MACH_HTC_OPAL		HTC_OPAL		2392
>  touchbook		MACH_TOUCHBOOK		TOUCHBOOK		2393
> @@ -2498,7 +2498,7 @@ hiram			MACH_HIRAM		HIRAM		
	2510
>  phy3250			MACH_PHY3250		PHY3250			
2511
>  ea3250			MACH_EA3250		EA3250			
2512
>  fdi3250			MACH_FDI3250		FDI3250			
2513
> -whitestone		MACH_WHITESTONE		WHITESTONE		2514
> +htcwhitestone		MACH_WHITESTONE		WHITESTONE		
2514
>  at91sam9263nit		MACH_AT91SAM9263NIT	AT91SAM9263NIT		
2515
>  ccmx51			MACH_CCMX51		CCMX51			
2516
>  ccmx51js		MACH_CCMX51JS		CCMX51JS		2517
> @@ -2582,7 +2582,7 @@ omap3_bulldog		MACH_OMAP3_BULLDOG	
OMAP3_BULLDOG		2594
>  pca101			MACH_PCA101		PCA101			
2595
>  buzzc			MACH_BUZZC		BUZZC			
2596
>  sasie2			MACH_SASIE2		SASIE2			
2597
> -davinci_cio		MACH_DAVINCI_CIO	DAVINCI_CIO		2598
> +davinci_dm6467_cio	MACH_DAVINCI_CIO	DAVINCI_CIO		2598
>  smartmeter_dl		MACH_SMARTMETER_DL	SMARTMETER_DL		
2599
>  wzl6410			MACH_WZL6410		WZL6410			
2600
>  wzl6410m		MACH_WZL6410M		WZL6410M		2601
> @@ -2609,7 +2609,7 @@
> fujitsu_tvstbsoc1	MACH_FUJITSU_TVSTBSOC1	FUJITSU_TVSTBSOC1	2621
> lexikon			MACH_LEXIKON		LEXIKON			
2622
>  mini2440v2		MACH_MINI2440V2		MINI2440V2		2623
>  icontrol		MACH_ICONTROL		ICONTROL		2624
> -sheevad			MACH_SHEEVAD		SHEEVAD			
2625
> +gplugd			MACH_SHEEVAD		SHEEVAD			
2625
>  qsd8x50a_st1_1		MACH_QSD8X50A_ST1_1	QSD8X50A_ST1_1		
2626
>  qsd8x50a_st1_5		MACH_QSD8X50A_ST1_5	QSD8X50A_ST1_5		
2627
>  bee			MACH_BEE		BEE			2628
> @@ -2750,7 +2750,7 @@ h6053			MACH_H6053		H6053		
	2762
>  smint01			MACH_SMINT01		SMINT01			
2763
>  prtlvt2			MACH_PRTLVT2		PRTLVT2			
2764
>  ap420			MACH_AP420		AP420			
2765
> -htcshift		MACH_HTCSHIFT		HTCSHIFT		2766
> +htcclio			MACH_HTCSHIFT		HTCSHIFT		
2766
>  davinci_dm365_fc	MACH_DAVINCI_DM365_FC	DAVINCI_DM365_FC	2767
>  msm8x55_surf		MACH_MSM8X55_SURF	MSM8X55_SURF		2768
>  msm8x55_ffa		MACH_MSM8X55_FFA	MSM8X55_FFA		2769
> @@ -2761,7 +2761,7 @@
> oreo_controller		MACH_OREO_CONTROLLER	OREO_CONTROLLER		
2773
> kopin_models		MACH_KOPIN_MODELS	KOPIN_MODELS		2774
>  ttc_vision2		MACH_TTC_VISION2	TTC_VISION2		2775
>  cns3420vb		MACH_CNS3420VB		CNS3420VB		2776
> -lpc2			MACH_LPC2		LPC2			2777
> +lpc_evo			MACH_LPC2		LPC2			
2777
>  olympus			MACH_OLYMPUS		OLYMPUS			
2778
>  vortex			MACH_VORTEX		VORTEX			
2779
>  s5pc200			MACH_S5PC200		S5PC200			
2780
> @@ -2788,7 +2788,7 @@ ti8168evm		MACH_TI8168EVM		
TI8168EVM		2800
>  neocoreomap		MACH_NEOCOREOMAP	NEOCOREOMAP		2801
>  withings_wbp		MACH_WITHINGS_WBP	WITHINGS_WBP		2802
>  dbps			MACH_DBPS		DBPS			2803
> -sbc9261			MACH_SBC9261		SBC9261			
2804
> +at91sam9261		MACH_SBC9261		SBC9261			2804
>  pcbfp0001		MACH_PCBFP0001		PCBFP0001		2805
>  speedy			MACH_SPEEDY		SPEEDY			
2806
>  chrysaor		MACH_CHRYSAOR		CHRYSAOR		2807
> @@ -2804,3 +2804,112 @@ teton_bga		MACH_TETON_BGA		
TETON_BGA		2816
>  snapper9g45		MACH_SNAPPER9G45	SNAPPER9G45		2817
>  tam3517			MACH_TAM3517		TAM3517			
2818
>  pdc100			MACH_PDC100		PDC100			
2819
> +eukrea_cpuimx25sd	MACH_EUKREA_CPUIMX25	EUKREA_CPUIMX25		2820
> +eukrea_cpuimx35sd	MACH_EUKREA_CPUIMX35	EUKREA_CPUIMX35		2821
> +eukrea_cpuimx51sd	MACH_EUKREA_CPUIMX51SD	EUKREA_CPUIMX51SD	2822
> +eukrea_cpuimx51		MACH_EUKREA_CPUIMX51	EUKREA_CPUIMX51		
2823
> +p565			MACH_P565		P565			2824
> +acer_a4			MACH_ACER_A4		ACER_A4			
2825
> +davinci_dm368_bip	MACH_DAVINCI_DM368_BIP	DAVINCI_DM368_BIP	2826
> +eshare			MACH_ESHARE		ESHARE			
2827
> +hw_omapl138_europa	MACH_HW_OMAPL138_EUROPA	HW_OMAPL138_EUROPA	2828
> +wlbargn			MACH_WLBARGN		WLBARGN			
2829
> +bm170			MACH_BM170		BM170			
2830
> +netspace_mini_v2	MACH_NETSPACE_MINI_V2	NETSPACE_MINI_V2	2831
> +netspace_plug_v2	MACH_NETSPACE_PLUG_V2	NETSPACE_PLUG_V2	2832
> +siemens_l1		MACH_SIEMENS_L1		SIEMENS_L1		2833
> +elv_lcu1		MACH_ELV_LCU1		ELV_LCU1		2834
> +mcu1			MACH_MCU1		MCU1			2835
> +omap3_tao3530		MACH_OMAP3_TAO3530	OMAP3_TAO3530		
2836
> +omap3_pcutouch		MACH_OMAP3_PCUTOUCH	OMAP3_PCUTOUCH		
2837
> +smdkc210		MACH_SMDKC210		SMDKC210		2838
> +omap3_braillo		MACH_OMAP3_BRAILLO	OMAP3_BRAILLO		
2839
> +spyplug			MACH_SPYPLUG		SPYPLUG			
2840
> +ginger			MACH_GINGER		GINGER			
2841
> +tny_t3530		MACH_TNY_T3530		TNY_T3530		2842
> +pca102			MACH_PCA102		PCA102			
2843
> +spade			MACH_SPADE		SPADE			
2844
> +mxc25_topaz		MACH_MXC25_TOPAZ	MXC25_TOPAZ		2845
> +t5325			MACH_T5325		T5325			
2846
> +gw2361			MACH_GW2361		GW2361			
2847
> +elog			MACH_ELOG		ELOG			2848
> +income			MACH_INCOME		INCOME			
2849
> +bcm589x			MACH_BCM589X		BCM589X			
2850
> +etna			MACH_ETNA		ETNA			2851
> +hawks			MACH_HAWKS		HAWKS			
2852
> +meson			MACH_MESON		MESON			
2853
> +xsbase255		MACH_XSBASE255		XSBASE255		2854
> +pvm2030			MACH_PVM2030		PVM2030			
2855
> +mioa502			MACH_MIOA502		MIOA502			
2856
> +vvbox_sdorig2		MACH_VVBOX_SDORIG2	VVBOX_SDORIG2		
2857
> +vvbox_sdlite2		MACH_VVBOX_SDLITE2	VVBOX_SDLITE2		
2858
> +vvbox_sdpro4		MACH_VVBOX_SDPRO4	VVBOX_SDPRO4		2859
> +htc_spv_m700		MACH_HTC_SPV_M700	HTC_SPV_M700		2860
> +mx257sx			MACH_MX257SX		MX257SX			
2861
> +goni			MACH_GONI		GONI			2862
> +msm8x55_svlte_ffa	MACH_MSM8X55_SVLTE_FFA	MSM8X55_SVLTE_FFA	2863
> +msm8x55_svlte_surf	MACH_MSM8X55_SVLTE_SURF	MSM8X55_SVLTE_SURF	2864
> +quickstep		MACH_QUICKSTEP		QUICKSTEP		2865
> +dmw96			MACH_DMW96		DMW96			
2866
> +hammerhead		MACH_HAMMERHEAD		HAMMERHEAD		2867
> +trident			MACH_TRIDENT		TRIDENT			
2868
> +lightning		MACH_LIGHTNING		LIGHTNING		2869
> +iconnect		MACH_ICONNECT		ICONNECT		2870
> +autobot			MACH_AUTOBOT		AUTOBOT			
2871
> +coconut			MACH_COCONUT		COCONUT			
2872
> +durian			MACH_DURIAN		DURIAN			
2873
> +cayenne			MACH_CAYENNE		CAYENNE			
2874
> +fuji			MACH_FUJI		FUJI			2875
> +synology_6282		MACH_SYNOLOGY_6282	SYNOLOGY_6282		
2876
> +em1sy			MACH_EM1SY		EM1SY			
2877
> +m502			MACH_M502		M502			2878
> +matrix518		MACH_MATRIX518		MATRIX518		2879
> +tiny_gurnard		MACH_TINY_GURNARD	TINY_GURNARD		2880
> +spear1310		MACH_SPEAR1310		SPEAR1310		2881
> +bv07			MACH_BV07		BV07			2882
> +mxt_td61		MACH_MXT_TD61		MXT_TD61		2883
> +openrd_ultimate		MACH_OPENRD_ULTIMATE	OPENRD_ULTIMATE		
2884
> +devixp			MACH_DEVIXP		DEVIXP			
2885
> +miccpt			MACH_MICCPT		MICCPT			
2886
> +mic256			MACH_MIC256		MIC256			
2887
> +as1167			MACH_AS1167		AS1167			
2888
> +omap3_ibiza		MACH_OMAP3_IBIZA	OMAP3_IBIZA		2889
> +u5500			MACH_U5500		U5500			
2890
> +davinci_picto		MACH_DAVINCI_PICTO	DAVINCI_PICTO		
2891
> +mecha			MACH_MECHA		MECHA			
2892
> +bubba3			MACH_BUBBA3		BUBBA3			
2893
> +pupitre			MACH_PUPITRE		PUPITRE			
2894
> +tegra_harmony		MACH_TEGRA_HARMONY	TEGRA_HARMONY		
2895
> +tegra_vogue		MACH_TEGRA_VOGUE	TEGRA_VOGUE		2896
> +tegra_e1165		MACH_TEGRA_E1165	TEGRA_E1165		2897
> +simplenet		MACH_SIMPLENET		SIMPLENET		2898
> +ec4350tbm		MACH_EC4350TBM		EC4350TBM		2899
> +pec_tc			MACH_PEC_TC		PEC_TC			
2900
> +pec_hc2			MACH_PEC_HC2		PEC_HC2			
2901
> +esl_mobilis_a		MACH_ESL_MOBILIS_A	ESL_MOBILIS_A		
2902
> +esl_mobilis_b		MACH_ESL_MOBILIS_B	ESL_MOBILIS_B		
2903
> +esl_wave_a		MACH_ESL_WAVE_A		ESL_WAVE_A		2904
> +esl_wave_b		MACH_ESL_WAVE_B		ESL_WAVE_B		2905
> +unisense_mmm		MACH_UNISENSE_MMM	UNISENSE_MMM		2906
> +blueshark		MACH_BLUESHARK		BLUESHARK		2907
> +e10			MACH_E10		E10			2908
> +app3k_robin		MACH_APP3K_ROBIN	APP3K_ROBIN		2909
> +pov15hd			MACH_POV15HD		POV15HD			
2910
> +stella			MACH_STELLA		STELLA			
2911
> +htc_iolite		MACH_MACH_HTC_IOLITE	MACH_HTC_IOLITE		2912
> +linkstation_lschl	MACH_LINKSTATION_LSCHL	LINKSTATION_LSCHL	2913
> +netwalker		MACH_NETWALKER		NETWALKER		2914
> +acsx106			MACH_ACSX106		ACSX106			
2915
> +atlas5_c1		MACH_ATLAS5_C1		ATLAS5_C1		2916
> +nsb3ast			MACH_NSB3AST		NSB3AST			
2917
> +gnet_slc		MACH_GNET_SLC		GNET_SLC		2918
> +af4000			MACH_AF4000		AF4000			
2919
> +ark9431			MACH_ARK9431		ARK9431			
2920
> +fs_s5pc100		MACH_FS_S5PC100		FS_S5PC100		2921
> +omap3505nova8		MACH_OMAP3505NOVA8	OMAP3505NOVA8		
2922
> +omap3621_edp1		MACH_OMAP3621_EDP1	OMAP3621_EDP1		
2923
> +oratisaes		MACH_ORATISAES		ORATISAES		2924
> +smdkv310		MACH_SMDKV310		SMDKV310		2925
> +siemens_l0		MACH_SIEMENS_L0		SIEMENS_L0		2926
> +ventana			MACH_VENTANA		VENTANA			
2927
> +wm8505_7in_netbook	MACH_WM8505_7IN_NETBOOK	WM8505_7IN_NETBOOK	2928

This should be dropped but you probably know that :)

> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 8b23165..5993659 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1351,6 +1351,16 @@ config SERIAL_MSM_CONSOLE
>  	depends on SERIAL_MSM=y
>  	select SERIAL_CORE_CONSOLE
> 
> +config SERIAL_VT8500
> +	bool "VIA VT8500 on-chip serial port support"
> +	depends on ARM && ARCH_VT8500
> +	select SERIAL_CORE
> +
> +config SERIAL_VT8500_CONSOLE
> +	bool "VIA VT8500 serial console support"
> +	depends on SERIAL_VT8500=y
> +	select SERIAL_CORE_CONSOLE
> +
>  config SERIAL_NETX
>  	tristate "NetX serial port support"
>  	depends on ARM && ARCH_NETX
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 208a855..0e8f7b0 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
>  obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
>  obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
>  obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
> +obj-$(CONFIG_SERIAL_VT8500) += vt8500_serial.o

Possibly move the serial driver into another patch ... split this into patch 
series :)

> diff --git a/drivers/serial/vt8500_serial.c
> b/drivers/serial/vt8500_serial.c new file mode 100644
> index 0000000..21e0462
> --- /dev/null
> +++ b/drivers/serial/vt8500_serial.c
> @@ -0,0 +1,612 @@
> +/*
> + * drivers/serial/vt8500_serial.c
> + *
> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> + *
> + * Based on msm_serial.c, which is:
> + * Copyright (C) 2007 Google, Inc.
> + * Author: Robert Love <rlove@google.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#if defined(CONFIG_SERIAL_VT8500_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +# define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/hrtimer.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/vt8500.h>
> +
> +struct vt8500_port {
> +	struct uart_port	uart;
> +	char			name[16];
> +	struct clk		*clk;
> +	unsigned int		ier;
> +};
> +
> +#define UART_TO_VT8500(uart_port)	((struct vt8500_port *) uart_port)
> +
> +static inline void vt8500_write(struct uart_port *port, unsigned int val,
> +			     unsigned int off)
> +{
> +	__raw_writel(val, port->membase + off);
> +}
> +
> +static inline unsigned int vt8500_read(struct uart_port *port, unsigned
> int off) +{
> +	return __raw_readl(port->membase + off);
> +}
> +
> +static void vt8500_stop_tx(struct uart_port *port)
> +{
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +
> +	vt8500_port->ier &= ~1;
> +	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +}
> +
> +static void vt8500_start_tx(struct uart_port *port)
> +{
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +
> +	vt8500_port->ier |= 1;
> +	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +}
> +
> +static void vt8500_stop_rx(struct uart_port *port)
> +{
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +
> +	vt8500_port->ier &= ~2;
> +	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +}
> +
> +static void vt8500_enable_ms(struct uart_port *port)
> +{
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +
> +	vt8500_port->ier |= (1 << 10);
> +	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +}

Won't "inline" help here performance-wise?

> +
> +static void handle_rx(struct uart_port *port)
> +{
> +	struct tty_struct *tty = port->state->port.tty;
> +
> +	/*
> +	 * Handle overrun
> +	 */
> +	if ((vt8500_read(port, VT8500_URISR) & (1 << 7))) {
> +		port->icount.overrun++;
> +		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +	}
> +
> +	/* and now the main RX loop */
> +	while (vt8500_read(port, VT8500_URUSR) & (1 << 3)) {
> +		unsigned int c;
> +		char flag = TTY_NORMAL;
> +
> +		c = vt8500_read(port, VT8500_URRDR);
> +
> +		/* Mask conditions we're ignorning. */
> +		c &= ~port->read_status_mask;
> +
> +		if (c & (1 << 9)) {
> +			port->icount.frame++;
> +			flag = TTY_FRAME;
> +		} else if (c & (1 << 8)) {
> +			port->icount.parity++;
> +			flag = TTY_PARITY;
> +		} else
> +			port->icount.rx++;
> +
> +		if (!uart_handle_sysrq_char(port, c))
> +			tty_insert_flip_char(tty, c, flag);
> +	}
> +
> +	tty_flip_buffer_push(tty);
> +}
> +
> +static void handle_tx(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +	int sent_tx;
> +
> +	if (port->x_char) {
> +		vt8500_write(port, port->x_char, VT8500_URTDR);
> +		port->icount.tx++;
> +		port->x_char = 0;
> +	}
> +
> +	while (!(vt8500_read(port, VT8500_URUSR) & 2)) {
> +		if (uart_circ_empty(xmit)) {
> +			/* disable tx interrupts */
> +			vt8500_port->ier &= ~1;
> +			vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +			break;
> +		}
> +
> +		vt8500_write(port, xmit->buf[xmit->tail], VT8500_URTDR);
> +
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;
> +		sent_tx = 1;
> +	}
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +}
> +
> +static void handle_delta_cts(struct uart_port *port)
> +{
> +	port->icount.cts++;
> +	wake_up_interruptible(&port->state->port.delta_msr_wait);
> +}
> +
> +static irqreturn_t vt8500_irq(int irq, void *dev_id)
> +{
> +	struct uart_port *port = dev_id;
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +	unsigned int isr;
> +
> +	spin_lock(&port->lock);
> +	isr = vt8500_read(port, VT8500_URISR);
> +	vt8500_write(port, 0, VT8500_URIER); /* disable interrupt */
> +
> +	if (isr & 2)
> +		handle_rx(port);
> +	if (isr & 1)
> +		handle_tx(port);
> +	if (isr & (1 << 10))
> +		handle_delta_cts(port);
> +
> +	/* restore interrupt */
> +	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +	spin_unlock(&port->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static unsigned int vt8500_tx_empty(struct uart_port *port)
> +{
> +	return (vt8500_read(port, VT8500_URUSR) & 2) ? 0 : TIOCSER_TEMT;
> +}
> +
> +static unsigned int vt8500_get_mctrl(struct uart_port *port)
> +{
> +	return TIOCM_CTS | TIOCM_RTS;
> +}
> +
> +static void vt8500_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	unsigned int lcr;
> +
> +	lcr = vt8500_read(port, VT8500_URLCR);
> +
> +	if (!(mctrl & TIOCM_RTS)) {
> +		lcr &= ~(1 << 6);
> +		vt8500_write(port, lcr, VT8500_URLCR);
> +	} else {
> +		lcr |= (1 << 6);
> +		vt8500_write(port, lcr, VT8500_URLCR);
> +	}
> +}
> +
> +static void vt8500_break_ctl(struct uart_port *port, int break_ctl)
> +{
> +	if (break_ctl)
> +		vt8500_write(port, vt8500_read(port, VT8500_URLCR) | (1 << 9),
> +			     VT8500_URLCR);
> +}
> +
> +static int vt8500_set_baud_rate(struct uart_port *port, unsigned int baud)
> +{
> +	unsigned int div = vt8500_read(port, VT8500_URDIV) & ~(0x3ff);
> +
> +	if (unlikely((baud < 900) || (baud > 921600)))
> +		div |= 7;
> +	else
> +		div |= (921600 / baud) - 1;
> +
> +	while (vt8500_read(port, VT8500_URUSR) & (1 << 5))
> +		;
> +	vt8500_write(port, div, VT8500_URDIV);
> +
> +	return baud;
> +}
> +
> +static int vt8500_startup(struct uart_port *port)
> +{
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +	int ret;
> +
> +	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
> +		 "vt8500_serial%d", port->line);
> +
> +	ret = request_irq(port->irq, vt8500_irq, IRQF_TRIGGER_HIGH,
> +			  vt8500_port->name, port);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	vt8500_write(port, 0x03, VT8500_URLCR);	/* enable TX & RX */
> +
> +	/* turn on RX and CTS interrupts */
> +	vt8500_port->ier = (2) | (1 << 10);
> +	vt8500_write(port, vt8500_port->ier, VT8500_URIER);
> +
> +	return 0;
> +}
> +
> +static void vt8500_shutdown(struct uart_port *port)
> +{
> +	struct vt8500_port *vt8500_port = UART_TO_VT8500(port);
> +
> +	vt8500_port->ier = 0;
> +	vt8500_write(port, 0, VT8500_URIER); /* disable interrupts */
> +
> +	free_irq(port->irq, port);
> +}
> +
> +static void vt8500_set_termios(struct uart_port *port, struct ktermios
> *termios, +			    struct ktermios *old)
> +{
> +	unsigned long flags;
> +	unsigned int baud, lcr;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	/* calculate and set baud rate */
> +	baud = uart_get_baud_rate(port, termios, old, 900, 921600);
> +	baud = vt8500_set_baud_rate(port, baud);
> +	if (tty_termios_baud_rate(termios))
> +		tty_termios_encode_baud_rate(termios, baud, baud);
> +
> +	/* calculate parity */
> +	lcr = vt8500_read(port, VT8500_URLCR);
> +	lcr &= ~((1 << 5) | (1 << 4));
> +	if (termios->c_cflag & PARENB) {
> +		lcr |= (1 << 4);
> +		if (termios->c_cflag & PARODD)
> +			lcr |= (1 << 5);
> +	}
> +
> +	/* calculate bits per char */
> +	lcr &= ~(1 << 2);
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS7:
> +		break;
> +	case CS8:
> +	default:
> +		lcr |= (1 << 2);
> +		break;
> +	}
> +
> +	/* calculate stop bits */
> +	lcr &= ~(1 << 3);
> +	if (termios->c_cflag & CSTOPB)
> +		lcr |= (1 << 3);
> +
> +	/* set parity, bits per char, and stop bit */
> +	vt8500_write(port, lcr, VT8500_URLCR);
> +
> +	/* Configure status bits to ignore based on termio flags. */
> +	port->read_status_mask = 0;
> +	if (termios->c_iflag & INPCK)
> +		port->read_status_mask |= (1 << 9) | (1 << 8);
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static const char *vt8500_type(struct uart_port *port)
> +{
> +	return "VT8500";
> +}
> +
> +static void vt8500_release_port(struct uart_port *port)
> +{
> +	struct platform_device *pdev = to_platform_device(port->dev);
> +	struct resource *resource;
> +	resource_size_t size;
> +
> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!resource))
> +		return;
> +	size = resource->end - resource->start + 1;
> +
> +	release_mem_region(port->mapbase, size);
> +	iounmap(port->membase);
> +	port->membase = NULL;
> +}
> +
> +static int vt8500_request_port(struct uart_port *port)
> +{
> +	struct platform_device *pdev = to_platform_device(port->dev);
> +	struct resource *resource;
> +	resource_size_t size;
> +
> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!resource))
> +		return -ENXIO;
> +	size = resource->end - resource->start + 1;
> +
> +	if (unlikely(!request_mem_region(port->mapbase, size, "vt8500_serial")))
> +		return -EBUSY;
> +
> +	port->membase = ioremap(port->mapbase, size);
> +	if (!port->membase) {
> +		release_mem_region(port->mapbase, size);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vt8500_config_port(struct uart_port *port, int flags)
> +{
> +	if (flags & UART_CONFIG_TYPE) {
> +		port->type = PORT_VT8500;
> +		vt8500_request_port(port);
> +	}
> +}
> +
> +static int vt8500_verify_port(struct uart_port *port, struct serial_struct
> *ser) +{
> +	if (unlikely(ser->type != PORT_UNKNOWN && ser->type != PORT_VT8500))
> +		return -EINVAL;
> +	if (unlikely(port->irq != ser->irq))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static struct uart_ops vt8500_uart_pops = {
> +	.tx_empty = vt8500_tx_empty,
> +	.set_mctrl = vt8500_set_mctrl,
> +	.get_mctrl = vt8500_get_mctrl,
> +	.stop_tx = vt8500_stop_tx,
> +	.start_tx = vt8500_start_tx,
> +	.stop_rx = vt8500_stop_rx,
> +	.enable_ms = vt8500_enable_ms,
> +	.break_ctl = vt8500_break_ctl,
> +	.startup = vt8500_startup,
> +	.shutdown = vt8500_shutdown,
> +	.set_termios = vt8500_set_termios,
> +	.type = vt8500_type,
> +	.release_port = vt8500_release_port,
> +	.request_port = vt8500_request_port,
> +	.config_port = vt8500_config_port,
> +	.verify_port = vt8500_verify_port,
> +};
> +
> +static struct vt8500_port vt8500_uart_ports[] = {
> +	{
> +		.uart = {
> +			.iotype = UPIO_MEM,
> +			.ops = &vt8500_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.fifosize = 16,
> +			.line = 0,
> +		},
> +	},
> +	{
> +		.uart = {
> +			.iotype = UPIO_MEM,
> +			.ops = &vt8500_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.fifosize = 16,
> +			.line = 1,
> +		},
> +	},
> +	{
> +		.uart = {
> +			.iotype = UPIO_MEM,
> +			.ops = &vt8500_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.fifosize = 16,
> +			.line = 2,
> +		},
> +	},
> +	{
> +		.uart = {
> +			.iotype = UPIO_MEM,
> +			.ops = &vt8500_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.fifosize = 16,
> +			.line = 3,
> +		},
> +	},
> +};
> +
> +#define UART_NR	ARRAY_SIZE(vt8500_uart_ports)
> +
> +static inline struct uart_port *get_port_from_line(unsigned int line)
> +{
> +	return &vt8500_uart_ports[line].uart;
> +}
> +
> +#ifdef CONFIG_SERIAL_VT8500_CONSOLE
> +
> +static void vt8500_console_putchar(struct uart_port *port, int c)
> +{
> +	while (vt8500_read(port, VT8500_URUSR) & 2) /* Transmitter busy */
> +		;
> +	vt8500_write(port, c, VT8500_URTDR);
> +}
> +
> +static void vt8500_console_write(struct console *co, const char *s,
> +			      unsigned int count)
> +{
> +	struct uart_port *port;
> +	struct vt8500_port *vt8500_port;
> +
> +	BUG_ON(co->index < 0 || co->index >= UART_NR);
> +
> +	port = get_port_from_line(co->index);
> +	vt8500_port = UART_TO_VT8500(port);
> +
> +	spin_lock(&port->lock);
> +	uart_console_write(port, s, count, vt8500_console_putchar);
> +	spin_unlock(&port->lock);
> +}
> +
> +static int __init vt8500_console_setup(struct console *co, char *options)
> +{
> +	struct uart_port *port;
> +	int baud, flow, bits, parity;
> +	unsigned int tmp;
> +
> +	if (unlikely(co->index >= UART_NR || co->index < 0))
> +		return -ENXIO;
> +
> +	port = get_port_from_line(co->index);
> +
> +	if (unlikely(!port->membase))
> +		return -ENXIO;
> +
> +	port->cons = co;
> +
> +	if (options)
> +		uart_parse_options(options, &baud, &parity, &bits, &flow);
> +
> +	bits = 8;
> +	parity = 'n';
> +	flow = 'n';
> +	tmp = vt8500_read(port, VT8500_URLCR) & ~((1 << 5) | (1 << 4));
> +	vt8500_write(port, tmp, VT8500_URLCR);	/* 8N1 */
> +
> +	if (baud < 28800 || baud > 921600)
> +		baud = 115200;
> +	vt8500_set_baud_rate(port, baud);
> +
> +	printk(KERN_INFO "vt8500_serial: console setup on port #%d\n",
> +							port->line);
> +
> +	return uart_set_options(port, co, baud, parity, bits, flow);
> +}
> +
> +static struct uart_driver vt8500_uart_driver;
> +
> +static struct console vt8500_console = {
> +	.name = "ttyS",
> +	.write = vt8500_console_write,
> +	.device = uart_console_device,
> +	.setup = vt8500_console_setup,
> +	.flags = CON_PRINTBUFFER,
> +	.index = -1,
> +	.data = &vt8500_uart_driver,
> +};
> +
> +#define VT8500_CONSOLE	(&vt8500_console)
> +
> +#else
> +#define VT8500_CONSOLE	NULL
> +#endif
> +
> +static struct uart_driver vt8500_uart_driver = {
> +	.owner = THIS_MODULE,
> +	.driver_name = "vt8500_serial",
> +	.dev_name = "ttyS",
> +	.nr = UART_NR,
> +	.cons = VT8500_CONSOLE,
> +};
> +
> +static int __init vt8500_serial_probe(struct platform_device *pdev)
> +{
> +	struct vt8500_port *vt8500_port;
> +	struct resource *resource;
> +	struct uart_port *port;
> +	int irq;
> +
> +	if (unlikely(pdev->id < 0 || pdev->id >= UART_NR))
> +		return -ENXIO;
> +
> +	printk(KERN_INFO "vt8500_serial: detected port #%d\n", pdev->id);
> +
> +	port = get_port_from_line(pdev->id);
> +	port->dev = &pdev->dev;
> +	vt8500_port = UART_TO_VT8500(port);
> +
> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!resource))
> +		return -ENXIO;
> +	port->mapbase = resource->start;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (unlikely(irq < 0))
> +		return -ENXIO;
> +	port->irq = irq;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	return uart_add_one_port(&vt8500_uart_driver, port);
> +}
> +
> +static int __devexit vt8500_serial_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver vt8500_platform_driver = {
> +	.remove = vt8500_serial_remove,
> +	.driver = {
> +		.name = "vt8500_serial",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init vt8500_serial_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&vt8500_uart_driver);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	ret = platform_driver_probe(&vt8500_platform_driver,
> +						vt8500_serial_probe);
> +
> +	if (unlikely(ret))
> +		uart_unregister_driver(&vt8500_uart_driver);
> +
> +	printk(KERN_INFO "vt8500_serial: driver initialized\n");
> +
> +	return ret;
> +}
> +
> +static void __exit vt8500_serial_exit(void)
> +{
> +#ifdef CONFIG_SERIAL_VT8500_CONSOLE
> +	unregister_console(&vt8500_console);
> +#endif
> +	platform_driver_unregister(&vt8500_platform_driver);
> +	uart_unregister_driver(&vt8500_uart_driver);
> +}
> +
> +module_init(vt8500_serial_init);
> +module_exit(vt8500_serial_exit);
> +
> +MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
> +MODULE_DESCRIPTION("Driver for vt8500 serial device");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index f10db6e..20ba8c3 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -186,6 +186,9 @@
>  #define PORT_ALTERA_JTAGUART	91
>  #define PORT_ALTERA_UART	92
> 
> +/* VIA VT8500 SoC */
> +#define PORT_VT8500    93
> +
>  #ifdef __KERNEL__
> 
>  #include <linux/compiler.h>

This patch looks very good otherwise, good night ! :)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

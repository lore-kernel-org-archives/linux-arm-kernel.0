From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Feb 2011 16:43:25 +0000
Subject: [PATCH 4/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <a45cf64b-c91a-4f8b-a121-5a675daee4ca@VA3EHSMHS006.ehs.local>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-3-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-4-git-send-email-john.linn@xilinx.com>
	<a45cf64b-c91a-4f8b-a121-5a675daee4ca@VA3EHSMHS006.ehs.local>
Message-ID: <20110205164325.GE29411@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 09:08:44AM -0700, John Linn wrote:
> diff --git a/arch/arm/mach-xilinx/include/mach/entry-macro.S b/arch/arm/mach-xilinx/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..becb4cd
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/include/mach/entry-macro.S
> @@ -0,0 +1,87 @@
> +/*
> + * arch/arm/mach-xilinx/include/mach/entry-macro.S
> + *
> + * Low-level IRQ helper macros
> + *
> + *  Copyright (C) 2011 Xilinx
> + *
> + * based on arch/plat-mxc/include/mach/entry-macro.S
> + *
> + *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
> + *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#include <mach/hardware.h>
> +#include <asm/hardware/gic.h>
> +
> +		.macro	disable_fiq
> +		.endm
> +
> +		.macro  get_irqnr_preamble, base, tmp
> +		ldr	\base, =gic_cpu_base_addr
> +		ldr	\base, [\base]
> +		.endm
> +
> +		.macro  arch_ret_to_user, tmp1, tmp2
> +		.endm
> +
> +		/*
> +		 * The interrupt numbering scheme is defined in the
> +		 * interrupt controller spec.
> +		 *
> +		 * Interrupts 0-15 are SFI and are filtered
> +		 * Interrupts 31-1019 are normal and should be processed
> +		 * 1020-1021 are reserved and are filtered
> +		 * 1022 is not needed and filtered
> +		 * 1023 is "spurious" (no interrupt) and is filtered
> +		 *
> +		 * A simple read from the controller will tell us the number
> +		 * of the highest priority enabled interrupt.  We then just
> +		 * need to check whether it is in the valid range for an IRQ
> +		 * (16-1019 inclusive). If a valid interrupt, Z = 0 on return.
> +		 */
> +
> +		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +
> +		/* bits 12-10 = src CPU, 9-0 = int # */
> +
> +		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
> +		ldr	\tmp, =1020
> +
> +		bic     \irqnr, \irqstat, #0x1c00
> +
> +		cmp     \irqnr, #31
> +		cmpcc	\irqnr, \irqnr
> +		cmpne	\irqnr, \tmp
> +		cmpcs	\irqnr, \irqnr
> +
> +		.endm
> +
> +		.macro test_for_ipi, irqnr, irqstat, base, tmp
> +		bic	\irqnr, \irqstat, #0x1c00
> +		cmp	\irqnr, #16
> +		it	cc
> +		strcc	\irqstat, [\base, #GIC_CPU_EOI]
> +		it	cs
> +		cmpcs	\irqnr, \irqnr
> +		.endm
> +
> +		/* As above, this assumes irqstat and base are preserved */
> +
> +		.macro test_for_ltirq, irqnr, irqstat, base, tmp
> +		bic	\irqnr, \irqstat, #0x1c00
> +		mov 	\tmp, #0
> +		cmp	\irqnr, #29
> +		itt	eq
> +		moveq	\tmp, #1
> +		streq	\irqstat, [\base, #GIC_CPU_EOI]
> +		cmp	\tmp, #0
> +		.endm

Would arch/arm/include/asm/hardware/entry-macro-gic.S be suitable for
use here?

> diff --git a/arch/arm/mach-xilinx/include/mach/hardware.h b/arch/arm/mach-xilinx/include/mach/hardware.h
> new file mode 100644
> index 0000000..a635322
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/include/mach/hardware.h
> @@ -0,0 +1,44 @@
> +/* arch/arm/mach-xilinx/include/mach/hardware.h
> + *
> + *  Copyright (C) 2011 Xilinx
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __MACH_HARDWARE_H__
> +#define __MACH_HARDWARE_H__
> +
> +#include <mach/memory.h>
> +#include <mach/irqs.h>
> +
> +#define PERIPHERAL_CLOCK_RATE	2500000
> +
> +#define IO_BASE			0xE0000000
> +#define UART0_BASE		(IO_BASE)
> +
> +#define PERIPH_BASE		0xF8000000
> +#define TTC0_BASE		(PERIPH_BASE + 0x1000)
> +
> +#define SCU_PERIPH_BASE		0xF8F00000
> +#define SCU_GIC_CPU_BASE	(SCU_PERIPH_BASE + 0x100)
> +#define SCU_GLOBAL_TIMER_BASE	(SCU_PERIPH_BASE + 0x200)
> +#define SCU_CPU_TIMER_BASE	(SCU_PERIPH_BASE + 0x600)
> +#define SCU_WDT_BASE		(SCU_PERIPH_BASE + 0x620)
> +#define SCU_GIC_DIST_BASE	(SCU_PERIPH_BASE + 0x1000)
> +
> +#define PL310_L2CC_BASE		0xF8F02000
> +
> +/*
> + * Mandatory for CONFIG_LL_DEBUG, UART is mapped virtual = physical
> + */
> +#define LL_UART_PADDR	UART0_BASE
> +#define LL_UART_VADDR	UART0_BASE
> +
> +#endif

This file is included by much of the kernel build, so symbol conflicts
tend to be a concern.  It may be better to move most of this to a
private header instead.

You may also like to consider using something like this:

#ifndef __ASSEMBLER__
#define IOMEM(a)	((void __force __iomem *)(a))
#else
#define IOMEM(a)	a
#endif

#define SCU_PERIPH_BASE	IOMEM(0xF8F00000)

which means it's typed correctly for most of the kernel.  The only place
where you have to use casts is in the map_desc array - that's pretty
much unavoidable though.

> diff --git a/arch/arm/mach-xilinx/include/mach/io.h b/arch/arm/mach-xilinx/include/mach/io.h
> new file mode 100644
> index 0000000..2e69db7
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/include/mach/io.h
> @@ -0,0 +1,27 @@
> +/* arch/arm/mach-xilinx/include/mach/io.h
> + *
> + *  Copyright (C) 2011 Xilinx
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __MACH_IO_H__
> +#define __MACH_IO_H__
> +
> +/* Allow IO space to be anywhere in the memory */
> +
> +#define IO_SPACE_LIMIT 0xffffffff

Probably should be 0xffff as that's the standard PCI/ISA IO window.

> +
> +/* IO address mapping macros, nothing special at this time but required */
> +
> +#define __io(a)			((void __iomem *)(a))

#define io(a)			__typesafe_io(a)

gives a nice, simple, typesafe solution.

> diff --git a/arch/arm/mach-xilinx/include/mach/memory.h b/arch/arm/mach-xilinx/include/mach/memory.h
> new file mode 100644
> index 0000000..2b6d1eb
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/include/mach/memory.h
> @@ -0,0 +1,23 @@
> +/* arch/arm/mach-xilinx/include/mach/memory.h
> + *
> + *  Copyright (C) 2011 Xilinx
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __MACH_MEMORY_H__
> +#define __MACH_MEMORY_H__
> +
> +#include <mach/hardware.h>
> +
> +#define PHYS_OFFSET             0x0

Eventually this will need to become PLAT_PHYS_OFFSET during the next
merge window.

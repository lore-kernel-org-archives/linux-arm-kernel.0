From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 8 Dec 2010 09:24:28 +0100
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <19711.16572.458847.161711@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> Add Interrupt Collector (ICOLL) support for MXS-based.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v2:
>  - Get icoll base in get_irqnr_preamble
>  - Check the case of single SoC build and use hard-coding address if possible
> 
>  arch/arm/mach-mxs/icoll.c                    |   77 ++++++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/entry-macro.S |   44 +++++++++++++++
>  2 files changed, 121 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/icoll.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
> 
[...]
> diff --git a/arch/arm/mach-mxs/include/mach/entry-macro.S b/arch/arm/mach-mxs/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..2c7755b
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/entry-macro.S
> @@ -0,0 +1,44 @@
> +/*
> + * Low-level IRQ helper macros for Freescale MXS-based
> + *
> + * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <mach/hardware.h>
> +
> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	ldr	\irqnr, [\base, #0x70]
> +	cmp	\irqnr, #0x7F
> +	moveqs	\irqnr, #0
> +	.endm
> +
> +	.macro  get_irqnr_preamble, base, tmp
> +#if defined (CONFIG_SOC_IMX23) && defined (CONFIG_SOC_IMX28)
> +	ldr	\base, =icoll_base
> +	ldr	\base, [\base]
> +#elif defined (CONFIG_SOC_IMX23)
> +	ldr	\base, =MX23_ICOLL_BASE_ADDR
>
MX23_IO_ADDRESS(MX23_ICOLL_BASE_ADDR)

> +#else
> +	ldr	\base, =MX28_ICOLL_BASE_ADDR
>
MX28_IO_ADDRESS(MX28_ICOLL_BASE_ADDR)


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

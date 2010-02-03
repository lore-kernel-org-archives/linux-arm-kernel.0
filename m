From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 18:07:37 +0100
Subject: [PATCH 12/13] ARM: LPC32XX: architecture header files
In-Reply-To: <1264643011-17390-13-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-13-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203170737.GN11354@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Halle Kevin,

> +++ b/arch/arm/mach-lpc32xx/include/mach/hardware.h
> @@ -0,0 +1,41 @@
> +/*
> + * arch/arm/mach-lpc32xx/include/mach/hardware.h
> + *
> + * Copyright (c) 2005 MontaVista Software, Inc. <source@mvista.com>
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
> +#ifndef __ASM_ARCH_HARDWARE_H
> +#define __ASM_ARCH_HARDWARE_H
> +
> +#include <asm/sizes.h>
Where is that needed?
> +
> +/*
> + * Start of virtual addresses for IO devices
> + */
> +#define IO_BASE		0xF0000000
> +
> +#define io_p2v(x)	(IO_BASE | (((x) & 0xff000000) >> 4) |\
> +			 ((x) & 0x000fffff))
> +#define io_v2p(x)	((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
> +
> +/*
> + * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
> + */
> +#define IO_ADDRESS(x)	(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
> +			 IO_BASE)
#define IO_ADDRESS(x) io_p2v(x)

> +#define _SBF(f, v)			(((v)) << (f))
> +#define _BIT(n)				(1 << (n))
What about:

#define _SBF(f, v)	((v) << (f))
#define _BIT(n)		_SBF(n, 1)

?

> +#define VMALLOC_END	(PAGE_OFFSET + 0x10000000)
grepping shows that defining VMALLOC_END based on PAGE_OFFSET is usual,
but I wonder why you don't just

	#define VMALLOC_END 0xF0000000

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 14:56:23 +0100
Subject: [PATCH 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <1290754154-9428-5-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-5-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101130135623.GH20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Nov 26, 2010 at 02:49:03PM +0800, Shawn Guo wrote:
> Add Interrupt Collector (ICOLL) support for MXS-based.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/icoll.c                    |   77 ++++++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/entry-macro.S |   36 ++++++++++++
>  2 files changed, 113 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/icoll.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
> 
> diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
> new file mode 100644
> index 0000000..a7a7d4f
> --- /dev/null
> +++ b/arch/arm/mach-mxs/icoll.c
> @@ -0,0 +1,77 @@
> +/*
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
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +
> +#define HW_ICOLL_VECTOR				0x0000
> +#define HW_ICOLL_LEVELACK			0x0010
> +#define HW_ICOLL_CTRL				0x0020
> +#define HW_ICOLL_INTERRUPTn_SET(n)		(0x0124 + (n) * 0x10)
> +#define HW_ICOLL_INTERRUPTn_CLR(n)		(0x0128 + (n) * 0x10)
> +#define BM_ICOLL_INTERRUPTn_ENABLE		0x00000004
> +#define BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0	0x1
> +
> +void __iomem *icoll_base;
> +
> +static void icoll_ack_irq(unsigned int irq)
> +{
> +	__raw_writel(0, icoll_base + HW_ICOLL_VECTOR);
You need to write this before handling the irq, no?

> +
> +	/* ACK current interrupt (level 0) */
> +	__raw_writel(BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0,
> +			icoll_base + HW_ICOLL_LEVELACK);
> +}
> +
> +static void icoll_mask_irq(unsigned int irq)
> +{
> +	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
> +			icoll_base + HW_ICOLL_INTERRUPTn_CLR(irq));
> +}
> +
> +static void icoll_unmask_irq(unsigned int irq)
> +{
> +	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
> +			icoll_base + HW_ICOLL_INTERRUPTn_SET(irq));
> +}
> +
> +static struct irq_chip mxs_icoll_chip = {
> +	.ack = icoll_ack_irq,
> +	.mask = icoll_mask_irq,
> +	.unmask = icoll_unmask_irq,
> +};
> +
> +void __init icoll_init_irq(void __iomem *irqbase)
> +{
> +	int i;
> +
> +	icoll_base = irqbase;
> +
> +	/* Reset icoll */
> +	mxs_reset_block(irqbase + HW_ICOLL_CTRL);
> +
> +	for (i = 0; i < MXS_INTERNAL_IRQS; i++) {
> +		set_irq_chip(i, &mxs_icoll_chip);
> +		set_irq_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +}
> diff --git a/arch/arm/mach-mxs/include/mach/entry-macro.S b/arch/arm/mach-mxs/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..597948d
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/entry-macro.S
> @@ -0,0 +1,36 @@
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
> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	ldr	\base, =icoll_base
Maybe it's worth to hardcode the base address if only a single cpu is
compiled in?  And what about setting the base register in
get_irqnr_preamble?

> +	ldr	\base, [\base]
> +	ldr	\irqnr, [\base, #0x70]
> +	cmp	\irqnr, #0x7F
> +	moveqs	\irqnr, #0
Hmm, you only need that cmp+moveqs because you cannot be sure that an
irq is pending, right.  Maybe it would make sense not to check for irqs
in a loop?  (This is a arm-global thing, Russell?)  (BTW, you're lucky,
for your irq controller it's only ugly to check if there is an irq
pending.  IIRC ns9xxx has a race here.)

> +	.endm
> +
> +	.macro  get_irqnr_preamble, base, tmp
> +	.endm
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

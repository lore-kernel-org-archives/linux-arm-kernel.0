From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 22:03:52 +0100
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101207210352.GC14775@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 08, 2010 at 12:31:54AM +0800, Shawn Guo wrote:
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
You need to write this before handling the irq, no?  Note this question
is a repetition.  You answered "No need, indeed.  Will remove it."
According to MCIMX28RM a write to HW_ICOLL_VECTOR "indicates the
in-service state".  Are you sure this is not needed?  If no (i.e. it's
needed) the write should go into entry-macro.S.  As I don't have
hardware yet I cannot test that.  Maybe it's only needed when the
priority levels are used?!

> +
> +	/* ACK current interrupt (level 0) */
I suggest to extend this a bit, like:

	The Interrupt Collector is able to prioritize irqs.  Currently
	only level 0 is used.  So acking can use
	BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0 unconditionally.

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
I assume this initializes the priority for each irq to level 0.  Maybe
this should be documented here.

> +
> +	for (i = 0; i < MXS_INTERNAL_IRQS; i++) {
> +		set_irq_chip(i, &mxs_icoll_chip);
> +		set_irq_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +}
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
I think is isn't needed.  Only when you start to actually use the fiq.

> +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	ldr	\irqnr, [\base, #0x70]
> +	cmp	\irqnr, #0x7F
> +	moveqs	\irqnr, #0
> +	.endm
> +
> +	.macro  get_irqnr_preamble, base, tmp
> +#if defined (CONFIG_SOC_IMX23) && defined (CONFIG_SOC_IMX28)
no space between defined and ( please.

> +	ldr	\base, =icoll_base
> +	ldr	\base, [\base]
> +#elif defined (CONFIG_SOC_IMX23)
> +	ldr	\base, =MX23_ICOLL_BASE_ADDR
> +#else
> +	ldr	\base, =MX28_ICOLL_BASE_ADDR
> +#endif
Mhh, you said the base addresses are different.  Unless I'm mistaken
they are not.  So you can just remove icoll_base.

> +	.endm
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

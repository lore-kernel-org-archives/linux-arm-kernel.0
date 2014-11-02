From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 22:19:44 -0400
Subject: [PATCH v8 5/9] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <1413888020-8790-6-git-send-email-linux@rempel-privat.de>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <1413888020-8790-6-git-send-email-linux@rempel-privat.de>
Message-ID: <20141102021944.GR3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oleksij, Shawn, Sascha,

Top of thread is here:

  https://lkml.kernel.org/r/1413888020-8790-1-git-send-email-linux at rempel-privat.de

On Tue, Oct 21, 2014 at 12:40:16PM +0200, Oleksij Rempel wrote:
> Freescale iMX23/iMX28 and Alphascale ASM9260 have similar
> interrupt collectors. It makes easy to reuse irq-mxs code for ASM9260.
> Differences between this devices are fallowing:
> - different register offsets
> - different count of intterupt lines per register
> - ASM9260 don't provide reset bit
> - ASM9260 don't support FIQ.
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  drivers/irqchip/Kconfig                    |   9 +++
>  drivers/irqchip/Makefile                   |   2 +-
>  drivers/irqchip/alphascale_asm9260-icoll.h | 109 +++++++++++++++++++++++++++++
>  drivers/irqchip/irq-mxs.c                  | 105 ++++++++++++++++++++++++---
>  4 files changed, 216 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/irqchip/alphascale_asm9260-icoll.h
...
> diff --git a/drivers/irqchip/alphascale_asm9260-icoll.h b/drivers/irqchip/alphascale_asm9260-icoll.h
> new file mode 100644
> index 0000000..5cec108
> --- /dev/null
> +++ b/drivers/irqchip/alphascale_asm9260-icoll.h
> @@ -0,0 +1,109 @@
> +/*
> + * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _ALPHASCALE_ASM9260_ICOLL_H
> +#define _ALPHASCALE_ASM9260_ICOLL_H
> +
> +#define ASM9260_NUM_IRQS		64
> +/*
> + * this device provide 4 offsets for each register:
> + * 0x0 - plain read write mode
> + * 0x4 - set mode, OR logic.
> + * 0x8 - clr mode, XOR logic.
> + * 0xc - togle mode.
> + */
> +
> +#define ASM9260_HW_ICOLL_VECTOR				0x0000
> +/*
> + * bits 31:2
> + * This register presents the vector address for the interrupt currently
> + * active on the CPU IRQ input. Writing to this register notifies the
> + * interrupt collector that the interrupt service routine for the current
> + * interrupt has been entered.
> + * The exception trap should have a LDPC instruction from this address:
> + * LDPC ASM9260_HW_ICOLL_VECTOR_ADDR; IRQ exception at 0xffff0018
> + */
> +
> +/*
> + * The Interrupt Collector Level Acknowledge Register is used by software to
> + * indicate the completion of an interrupt on a specific level.
> + * This register is written at the very end of an interrupt service routine. If
> + * nesting is used then the CPU irq must be turned on before writing to this
> + * register to avoid a race condition in the CPU interrupt hardware.
> + */
> +#define ASM9260_HW_ICOLL_LEVELACK			0x0010
> +#define ASM9260_BM_LEVELn(nr)				BIT(nr)
> +
> +#define ASM9260_HW_ICOLL_CTRL				0x0020
> +/*
> + * ASM9260_BM_CTRL_SFTRST and ASM9260_BM_CTRL_CLKGATE are not available on
> + * asm9260.
> + */
> +#define ASM9260_BM_CTRL_SFTRST				BIT(31)
> +#define ASM9260_BM_CTRL_CLKGATE				BIT(30)
> +/* disable interrupt level nesting */
> +#define ASM9260_BM_CTRL_NO_NESTING			BIT(19)
> +/*
> + * Set this bit to one enable the RISC32-style read side effect associated with
> + * the vector address register. In this mode, interrupt in-service is signaled
> + * by the read of the ASM9260_HW_ICOLL_VECTOR register to acquire the interrupt
> + * vector address. Set this bit to zero for normal operation, in which the ISR
> + * signals in-service explicitly by means of a write to the
> + * ASM9260_HW_ICOLL_VECTOR register.
> + * 0 - Must Write to Vector register to go in-service.
> + * 1 - Go in-service as a read side effect
> + */
> +#define ASM9260_BM_CTRL_ARM_RSE_MODE			BIT(18)
> +#define ASM9260_BM_CTRL_IRQ_ENABLE			BIT(16)
> +
> +#define ASM9260_HW_ICOLL_STAT_OFFSET			0x0030
> +/*
> + * bits 5:0
> + * Vector number of current interrupt. Multiply by 4 and add to vector base
> + * address to obtain the value in ASM9260_HW_ICOLL_VECTOR.
> + */
> +
> +/*
> + * RAW0 and RAW1 provides a read-only view of the raw interrupt request lines
> + * coming from various parts of the chip. Its purpose is to improve diagnostic
> + * observability.
> + */
> +#define ASM9260_HW_ICOLL_RAW0				0x0040
> +#define ASM9260_HW_ICOLL_RAW1				0x0050
> +
> +#define ASM9260_HW_ICOLL_INTERRUPT0			0x0060
> +#define ASM9260_HW_ICOLL_INTERRUPTn(n)		(0x0060 + ((n) >> 2) * 0x10)
> +/*
> + * WARNING: Modifying the priority of an enabled interrupt may result in
> + * undefined behavior.
> + */
> +#define ASM9260_BM_INT_PRIORITY_MASK			0x3
> +#define ASM9260_BM_INT_ENABLE				BIT(2)
> +#define ASM9260_BM_INT_SOFTIRQ				BIT(3)
> +
> +#define ASM9260_BM_ICOLL_INTERRUPTn_SHIFT(n)		(((n) & 0x3) << 3)
> +#define ASM9260_BM_ICOLL_INTERRUPTn_ENABLE(n)		(1 << (2 + \
> +			ASM9260_BM_ICOLL_INTERRUPTn_SHIFT(n)))
> +
> +#define ASM9260_HW_ICOLL_VBASE				0x0160
> +/*
> + * bits 31:2
> + * This bitfield holds the upper 30 bits of the base address of the vector
> + * table.
> + */
> +
> +#define ASM9260_HW_ICOLL_CLEAR0				0x01d0
> +#define ASM9260_HW_ICOLL_CLEAR1				0x01e0
> +#define ASM9260_HW_ICOLL_CLEARn(n)			(((n >> 5) * 0x10) \
> +							+ SET_REG)
> +#define ASM9260_BM_CLEAR_BIT(n)				BIT(n & 0x1f)
> +
> +/* Scratchpad */
> +#define ASM9260_HW_ICOLL_UNDEF_VECTOR			0x01f0
> +#endif
> diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
> index 681125d..8c5c3d2 100644
> --- a/drivers/irqchip/irq-mxs.c
> +++ b/drivers/irqchip/irq-mxs.c
> @@ -1,5 +1,7 @@
>  /*
>   * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
> + *	Add Alphascale ASM9260 support.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -28,6 +30,7 @@
>  #include <asm/exception.h>
>  
>  #include "irqchip.h"
> +#include "alphascale_asm9260-icoll.h"
>  
>  /*
>   * this device provide 4 offsets for each register:
> @@ -63,6 +66,33 @@ struct icoll_priv {
>  
>  static struct icoll_priv icoll_priv;
>  static struct irq_domain *icoll_domain;
> +static DEFINE_RAW_SPINLOCK(icoll_lock);
> +
> +/* calculate bit offset depending on number of intterupt per register */
> +static u32 icoll_intr_bitshift(struct irq_data *d, u32 bit)
> +{
> +	/*
> +	 * We expect intr_per_reg to be 4 or 1, it means
> +	 * "n" will be 3 or 0.
> +	 */
> +	int n = icoll_priv.intr_per_reg - 1;
> +
> +	/*
> +	 * If n = 0, "bit" is never shifted.
> +	 * If n = 3, mask lower part of hwirq to convert it
> +	 * in 0, 1, 2 or 3 and then multiply it by 8 (or shift by 3)
> +	 */
> +	return bit << ((d->hwirq & n) << n);
> +}
> +
> +/* calculate mem offset depending on number of intterupt per register */
> +static void __iomem *icoll_intr_reg(struct irq_data *d)
> +{
> +	int n = icoll_priv.intr_per_reg >> 1;
> +
> +	/* offset = hwirq / intr_per_reg * 0x10 */
> +	return icoll_priv.intr + ((d->hwirq >> n) * 0x10);
> +}
>  
>  static void icoll_ack_irq(struct irq_data *d)
>  {
> @@ -77,14 +107,21 @@ static void icoll_ack_irq(struct irq_data *d)
>  
>  static void icoll_mask_irq(struct irq_data *d)
>  {
> -	__raw_writel(BM_ICOLL_INTR_ENABLE,
> -			icoll_priv.intr + CLR_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
> +	__raw_writel(icoll_intr_bitshift(d, BM_ICOLL_INTR_ENABLE),
> +			icoll_intr_reg(d) + CLR_REG);
>  }
>  
>  static void icoll_unmask_irq(struct irq_data *d)
>  {
> -	__raw_writel(BM_ICOLL_INTR_ENABLE,
> -			icoll_priv.intr + SET_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
> +	raw_spin_lock(&icoll_lock);
> +	if (icoll_priv.clear)
> +		__raw_writel(ASM9260_BM_CLEAR_BIT(d->hwirq),
> +				icoll_priv.clear +
> +				ASM9260_HW_ICOLL_CLEARn(d->hwirq));
> +
> +	__raw_writel(icoll_intr_bitshift(d, BM_ICOLL_INTR_ENABLE),
> +			icoll_intr_reg(d) + SET_REG);
> +	raw_spin_unlock(&icoll_lock);
>  }

Before I consider merging this, I'd like to see an Ack from the i.MX
maintainers that they're ok with these changes.  Particularly the blocks
I've quoted above.

thx,

Jason.

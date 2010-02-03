From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 17:50:25 +0100
Subject: [PATCH 11/13] ARM: LPC32XX: printascii() output and irq
	support functions
In-Reply-To: <1264643011-17390-12-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-12-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203165025.GM11354@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro  get_irqnr_preamble, base, tmp
> +	.endm
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> +
> +/*
> + * Return IRQ number in irqnr. Also return processor Z flag status in CPSR
> + * as set if an interrupt is pending.
> + */
> +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	/* Get MIC status first */
> +	ldr	\base, =IO_ADDRESS(MIC_BASE)
> +	ldr	\irqstat, [\base, #INTC_STAT]
> +	and	\irqstat, \irqstat, #0xFFFFFFFC
> +	mov	\tmp, #0
> +
> +	/* Drop through to SIC1 or SIC2 if MIC is not pending */
> +	cmp	\irqstat, #0
> +	bne	1000f
> +
> +	/* SIC1 interrupts start at offset 32 */
> +	ldr	\base, =IO_ADDRESS(SIC1_BASE)
> +	ldr	\irqstat, [\base, #INTC_STAT]
> +	mov	\tmp, #32
> +
> +	/* Drop through to SIC2 if SIC1 is not pending */
> +	cmp	\irqstat, #0
> +	bne	1000f
> +
> +	/* SIC2 interrupts start at offset 64 */
> +	ldr	\base, =IO_ADDRESS(SIC2_BASE)
> +	ldr	\irqstat, [\base, #INTC_STAT]
> +	mov	\tmp, #64
> +
> +	/* Safety check only, exit if no status on MIC, SIC1, SIC2 */
> +	cmp	\irqstat, #0
> +	beq	1001f
> +
> +1000:
> +	/* Returns an pending interrupt between 0 and 95 */
> +	clz	\irqnr, \irqstat
> +	rsb	\irqnr, \irqnr, #31
> +	add	\irqnr, \irqnr, \tmp
> +
> +1001:
> +	teq	\irqstat, #0
> +	.endm
> +
> +	.macro	irq_prio_table
> +	.endm

You could make this easier by only handling MIC(?) interrupts and make
SIC1 and SIC2 use a chained handler.  Then you can use
get_irqnr_preamble for microoptimisation.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

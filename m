From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 19:57:00 +0100
Subject: [PATCH 11/13] ARM: LPC32XX: printascii() output and irq	support
	functions
In-Reply-To: <20100203165025.GM11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-12-git-send-email-wellsk40@gmail.com>
	<20100203165025.GM11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B7879A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> > +	.macro	disable_fiq
> > +	.endm
> > +
> > +	.macro  get_irqnr_preamble, base, tmp
> > +	.endm
> > +
> > +	.macro  arch_ret_to_user, tmp1, tmp2
> > +	.endm
> > +
> > +/*
> > + * Return IRQ number in irqnr. Also return processor Z flag status in
> CPSR
> > + * as set if an interrupt is pending.
> > + */
> > +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> > +	/* Get MIC status first */
> > +	ldr	\base, =IO_ADDRESS(MIC_BASE)
> > +	ldr	\irqstat, [\base, #INTC_STAT]
> > +	and	\irqstat, \irqstat, #0xFFFFFFFC
> > +	mov	\tmp, #0
> > +
> > +	/* Drop through to SIC1 or SIC2 if MIC is not pending */
> > +	cmp	\irqstat, #0
> > +	bne	1000f
> > +
> > +	/* SIC1 interrupts start at offset 32 */
> > +	ldr	\base, =IO_ADDRESS(SIC1_BASE)
> > +	ldr	\irqstat, [\base, #INTC_STAT]
> > +	mov	\tmp, #32
> > +
> > +	/* Drop through to SIC2 if SIC1 is not pending */
> > +	cmp	\irqstat, #0
> > +	bne	1000f
> > +
> > +	/* SIC2 interrupts start at offset 64 */
> > +	ldr	\base, =IO_ADDRESS(SIC2_BASE)
> > +	ldr	\irqstat, [\base, #INTC_STAT]
> > +	mov	\tmp, #64
> > +
> > +	/* Safety check only, exit if no status on MIC, SIC1, SIC2 */
> > +	cmp	\irqstat, #0
> > +	beq	1001f
> > +
> > +1000:
> > +	/* Returns an pending interrupt between 0 and 95 */
> > +	clz	\irqnr, \irqstat
> > +	rsb	\irqnr, \irqnr, #31
> > +	add	\irqnr, \irqnr, \tmp
> > +
> > +1001:
> > +	teq	\irqstat, #0
> > +	.endm
> > +
> > +	.macro	irq_prio_table
> > +	.endm
> 
> You could make this easier by only handling MIC(?) interrupts and make
> SIC1 and SIC2 use a chained handler.  Then you can use
> get_irqnr_preamble for microoptimisation.
> 

I'll take a look at this. I'm not entirely sure it can be made more
optimal than how it's implemented now. Even SIC1 and SIC2 interrupts
need to be routed via the MIC (The MIC interrupt will always fire
when a SIC1 or SIC2 interrupt occur.) This code is very tight right
now.

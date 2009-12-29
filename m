From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 29 Dec 2009 11:49:47 +0800
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
Message-ID: <f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

Several suggestions:

1. entry-macro.S, could we simplify (and improve the performance a bit) to
something like (haven't tested yet - let me know the result):

	.macro	get_irqnr_preamble, base, tmp
	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
	mov	\tmp, \tmp, lsr #4
	and	\tmp, \tmp, #0xfff
	cmp	\tmp, #0x581			@ MMP2
	moveq	\base, #MMP2_ICU_PJ4_IRQ_SEL
	movne	\base, #ICU_AP_IRQ_SEL_INT_NUM
	.endm

	.macro	arch_ret_to_user, tmp1, tmp2
	.endm

	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
	ldr	\tmp, [\base, #0]
	and	\irqnr, \tmp, #0x3f		@ Interrupt Number
	tst	\tmp, #(1 << 6)			@ Interrupt Pending ?
	.endm

2. arch/arm/mach-mmp/irq.c

We could well separate irq.c to irq-pxa168.c and irq-mmp2.c since the
difference looks much.

3. ARMADA610 - I'd still prefer it being called MMP2

4. in timer_config()

would be nicer to have: ccr &= (cpu_is_mmp2()) ? TMR_CCR_CS_0(0) :
TMR_CCR_CS_0(3)

a little bit cleaner - but it is nit picking indeed :)

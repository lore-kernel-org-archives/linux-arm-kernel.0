From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Tue, 26 Aug 2014 13:37:14 +0900
Subject: [RFC] ARM: Refactoring of Low-level debug
Message-ID: <20140826133714.ED4B.AA925319@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM Linux developers,


I was thinking about refactoing low level debug functions.
Before I start to write a patch, I'd like to know experts' option.


In the current implementation, "addruart" gets both
phys addr and virt addr (if CONFIG_MMU=y),
but do we really need both?

We always pick up one of them and discard the other.
Moreover, we always know which one should be used
before calling "addruart".


The idea popped up in my mind was
to split "addruart" into "addruart_phys" and "addruart_virt"
and call the only appropriate one.


The patch will change the caller in arch/arm/kernel/debug.S
as follows:



[Before]

#ifdef CONFIG_MMU
		.macro	addruart_current, rx, tmp1, tmp2
		addruart	\tmp1, \tmp2, \rx
		mrc		p15, 0, \rx, c1, c0
		tst		\rx, #1
		moveq		\rx, \tmp1
		movne		\rx, \tmp2
		.endm

#else /* !CONFIG_MMU */
		.macro	addruart_current, rx, tmp1, tmp2
		addruart	\rx, \tmp1
		.endm

#endif /* CONFIG_MMU */




[After]

		.macro	addruart_current, rx, tmp
#ifdef CONFIG_MMU
		mrc		p15, 0, \tmp, c1, c0
		tst		\tmp, #1
		beq		10f
		addruart_virt	\rx, \tmp
		b		11f
#endif
10:		addruart_phys	\rx, \tmp
11:
		.endm




The callee in each machine  (arch/arm/include/debug/*.S)
will be changed as follows:


[Before]

		.macro	addruart, rp, rv, tmp
		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
		.endm



[After]

		.macro	addruart_phys, rx, tmp
		ldr	\rx, =CONFIG_DEBUG_UART_PHYS
		.endm

		.macro	addruart_virt, rx, tmp
		ldr	\rx, =CONFIG_DEBUG_UART_VIRT
		.endm





Pros of doing this
------------------

[1] In the current implementation, the interface of addruart
is defferent depending on CONFIG_MMU.

"addruart" takes three arguments for CONFIG_MMU=y, whereas
it takes two for CONFIG_MMU is not set.

This patch will introduce the consistency of the number of
arguments.


[2] We can save one scratch register.

For example, arch/arm/boot/compressed/debug.S
gets phys addr and virt addr (r1 = phys, r2 = virt),
but r2 is not used:

ENTRY(putc)
	addruart r1, r2, r3
	waituart r3, r1
	senduart r0, r1
	busyuart r3, r1
	mov	 pc, lr
ENDPROC(putc)



We can change this part as follows:

ENTRY(putc)
	addruart_phys r1, r3
	waituart r3, r1
	senduart r0, r1
	busyuart r3, r1
	mov	 pc, lr
ENDPROC(putc)





If the basic idea is OK, I will take a close look.
Comments are welcome.



Best Regards
Masahiro Yamada

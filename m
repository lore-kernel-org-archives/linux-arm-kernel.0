From: david.jander@protonic.nl (David Jander)
Date: Mon, 10 Sep 2012 17:16:54 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
Message-ID: <20120910171654.1d4972b2@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

This probably is a GCC problem, but I am not entirely sure, and since I
stumbled upon this issue while debugging a kernel driver, it may have
something to do with how linux handles io-memory.
The symptoms became apparent when compiling latest mainline linux kernel for
the Freescale i.MX28 SoC, building the flexcan driver
(drivers/net/can/flexcan.c), using OSELAS.Toolchain GCC-4.6.2 for arm5te.

In the function flexcan_chip_start(), at line 775:

...
	if (priv->devtype_data->hw_ver >= 10)
		flexcan_write(0x0, &regs->rxfgmask);
...

The if() argument is false, but the CPU nevertheless crashes on a bus-error
writing to register &regs->rxfgmask!! The catch is, that in assembly, this
register is being _read_ conditionally, and then written _always_. Since this
register does not exist on the i.MX28 (hw_ver == 3), the CPU crashes.

I have no idea why GCC thinks it can do such a thing to a volatile memory
address. I have been able to reduce the code to just this bit:

/* Structure of the hardware registers */
struct flexcan_regs {
	unsigned int mcr;
	unsigned int rxfgmask;
};

#define flexcan_read(a)	(*(volatile unsigned int *)(a))
#define flexcan_write(v,a)	(*(volatile unsigned int *)(a) = (v))

int flexcan_chip_start(int ver, struct flexcan_regs *regs)
{
	flexcan_write(0, &regs->mcr);

	if (ver >= 10)
		flexcan_write(0, &regs->rxfgmask);

	return 0;
}

With GCC 4.6.x, using just "-Os", this compiles to:

...
	.text
	.align	2
	.global	flexcan_chip_start
	.type	flexcan_chip_start, %function
flexcan_chip_start:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #0
	cmp	r0, #9
	str	r3, [r1, #0]
	ldrle	r3, [r1, #4]
	mov	r0, #0
	str	r3, [r1, #4]
	bx	lr
	.size	flexcan_chip_start, .-flexcan_chip_start
	.ident	"GCC: (OSELAS.Toolchain-2011.11.1) 4.6.2"
	.section	.note.GNU-stack,"",%progbits

Notice the ldrle instruction followed by str. The "str r3, [r1, #4]" is always
executed, which would do no harm if it was a regular piece of RAM, but in this
case it is a non-existent peripheral register!
Is there a new way to tell this to the compiler? Am I missing something? Or it
this a GCC bug, and should I spam their respective mailing lists with this?

Any hint appreciated.

Best regards,

-- 
David Jander
Protonic Holland.

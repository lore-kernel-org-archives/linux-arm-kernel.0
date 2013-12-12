From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 16:26:23 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212150027.GP4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
 <1386858504.22947.85.camel@sakura.staff.proxad.net>
 <yw1xd2l2jflc.fsf@unicorn.mansr.com>
 <1386859963.22947.95.camel@sakura.staff.proxad.net>
 <20131212150027.GP4360@n2100.arm.linux.org.uk>
Message-ID: <1386861983.25449.13.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-12-12 at 15:00 +0000, Russell King - ARM Linux wrote:

> This is different - the compiler has recognised in both cases that the
> addition od 42 to foo is useless as the result is not used, and
> therefore has optimised the addition away.  In the second case, it has
> realised that the narrowing cast used to then add 42 to is also not
> used, and it has also optimised that away.

I was just trying to show that in the inline case the generated code was
not the same (apparently there was a misunderstanding on what I was
arguing about).

Now if you want a more interesting/on topic example:

#include <stdint.h>

static __attribute__((noinline)) unsigned int set_bit_2(unsigned int foo)
{
        foo |= 0x4;
        return foo;
}

#define local_swab16(x) ((uint16_t)(                                    \
        (((uint16_t)(x) & (uint16_t)0x00ffU) << 8) |                  \
        (((uint16_t)(x) & (uint16_t)0xff00U) >> 8)))

int func(uint16_t a)
{
        a = set_bit_2(local_swab16(a));
        if ((a & 0xffff) == 0x1234)
                return 1;
        return 0;
}

00000000 <set_bit_2>:
   0:	e3800004 	orr	r0, r0, #4
   4:	e12fff1e 	bx	lr

00000008 <func>:
   8:	e92d4008 	push	{r3, lr}
   c:	e1a03420 	lsr	r3, r0, #8
  10:	e1830400 	orr	r0, r3, r0, lsl #8
  14:	e1a00800 	lsl	r0, r0, #16
  18:	e1a00820 	lsr	r0, r0, #16
  1c:	ebfffff7 	bl	0 <set_bit_2>
  20:	e3a03c12 	mov	r3, #4608	; 0x1200
  24:	e1a00800 	lsl	r0, r0, #16
  28:	e2833034 	add	r3, r3, #52	; 0x34
  2c:	e1530820 	cmp	r3, r0, lsr #16
  30:	03a00001 	moveq	r0, #1
  34:	13a00000 	movne	r0, #0
  38:	e8bd8008 	pop	{r3, pc}

you can see here the full swab16 code, with the narrowing before calling 
set_bit_2() per calling convention.


Now remove the noninline:

00000000 <func>:
   0:	e3a03c12 	mov	r3, #4608	; 0x1200
   4:	e1a02420 	lsr	r2, r0, #8
   8:	e1820400 	orr	r0, r2, r0, lsl #8
   c:	e3802004 	orr	r2, r0, #4
  10:	e1a02802 	lsl	r2, r2, #16
  14:	e2833034 	add	r3, r3, #52	; 0x34
  18:	e1530822 	cmp	r3, r2, lsr #16
  1c:	03a00001 	moveq	r0, #1
  20:	13a00000 	movne	r0, #0
  24:	e12fff1e 	bx	lr

and you see that the double shift is removed because gcc knows it is not
needed by the remaining code, which uses only the lower 16 bits.

This is IMO exactly what happen in the csum case, the inline assembly
rule (the one we are not aware of) must be that you cannot use the 16
higher bits of the register in the assembly code, and so gcc takes the
liberty not to zero extend the register.

-- 
Maxime

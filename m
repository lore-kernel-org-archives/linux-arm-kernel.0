From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Jul 2012 11:37:54 -0400 (EDT)
Subject: [PATCH 1/3] ARM: use generic version of identical asm headers
In-Reply-To: <201207161051.58878.arnd@arndb.de>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-2-git-send-email-robherring2@gmail.com>
 <201207161051.58878.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1207161052590.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2012, Arnd Bergmann wrote:

> On Monday 16 July 2012, Rob Herring wrote:
> > diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
> > deleted file mode 100644
> > index 44593a8..0000000
> > --- a/arch/arm/include/asm/unaligned.h
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -#ifndef _ASM_ARM_UNALIGNED_H
> > -#define _ASM_ARM_UNALIGNED_H
> > -
> > -#include <linux/unaligned/le_byteshift.h>
> > -#include <linux/unaligned/be_byteshift.h>
> > -#include <linux/unaligned/generic.h>
> > -
> > -/*
> > - * Select endianness
> > - */
> > -#ifndef __ARMEB__
> > -#define get_unaligned	__get_unaligned_le
> > -#define put_unaligned	__put_unaligned_le
> > -#else
> > -#define get_unaligned	__get_unaligned_be
> > -#define put_unaligned	__put_unaligned_be
> > -#endif
> > -
> > -#endif /* _ASM_ARM_UNALIGNED_H */
> 
> The asm-generic version uses the "struct" version for native-endian
> unaligned access and the "byteshift" version for the opposite endianess.
> The current ARM version however uses the "byteshift" implementation for
> both. I don't know what works better on ARM, but I'd say we should not
> change it unless we understand the effects.

Test case:

int foo (int *x) { return get_unaligned(x); }
long long bar (long long *x) { return get_unaligned(x); }

With the current ARM version:

foo:
	ldrb	r3, [r0, #2]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 2B], MEM[(const u8 *)x_1(D) + 2B]
	ldrb	r1, [r0, #1]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 1B], MEM[(const u8 *)x_1(D) + 1B]
	ldrb	r2, [r0, #0]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D)], MEM[(const u8 *)x_1(D)]
	mov	r3, r3, asl #16	@ tmp154, MEM[(const u8 *)x_1(D) + 2B],
	ldrb	r0, [r0, #3]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 3B], MEM[(const u8 *)x_1(D) + 3B]
	orr	r3, r3, r1, asl #8	@, tmp155, tmp154, MEM[(const u8 *)x_1(D) + 1B],
	orr	r3, r3, r2	@ tmp157, tmp155, MEM[(const u8 *)x_1(D)]
	orr	r0, r3, r0, asl #24	@,, tmp157, MEM[(const u8 *)x_1(D) + 3B],
	bx	lr	@

bar:
	stmfd	sp!, {r4, r5, r6, r7}	@,
	mov	r2, #0	@ tmp184,
	ldrb	r5, [r0, #6]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 6B], MEM[(const u8 *)x_1(D) + 6B]
	ldrb	r4, [r0, #5]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 5B], MEM[(const u8 *)x_1(D) + 5B]
	ldrb	ip, [r0, #2]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 2B], MEM[(const u8 *)x_1(D) + 2B]
	ldrb	r1, [r0, #4]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 4B], MEM[(const u8 *)x_1(D) + 4B]
	mov	r5, r5, asl #16	@ tmp175, MEM[(const u8 *)x_1(D) + 6B],
	ldrb	r7, [r0, #1]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 1B], MEM[(const u8 *)x_1(D) + 1B]
	orr	r5, r5, r4, asl #8	@, tmp176, tmp175, MEM[(const u8 *)x_1(D) + 5B],
	ldrb	r6, [r0, #7]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 7B], MEM[(const u8 *)x_1(D) + 7B]
	orr	r5, r5, r1	@ tmp178, tmp176, MEM[(const u8 *)x_1(D) + 4B]
	ldrb	r4, [r0, #0]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D)], MEM[(const u8 *)x_1(D)]
	mov	ip, ip, asl #16	@ tmp188, MEM[(const u8 *)x_1(D) + 2B],
	ldrb	r1, [r0, #3]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 3B], MEM[(const u8 *)x_1(D) + 3B]
	orr	ip, ip, r7, asl #8	@, tmp189, tmp188, MEM[(const u8 *)x_1(D) + 1B],
	orr	r3, r5, r6, asl #24	@,, tmp178, MEM[(const u8 *)x_1(D) + 7B],
	orr	ip, ip, r4	@ tmp191, tmp189, MEM[(const u8 *)x_1(D)]
	orr	ip, ip, r1, asl #24	@, tmp194, tmp191, MEM[(const u8 *)x_1(D) + 3B],
	mov	r1, r3	@,
	orr	r0, r2, ip	@ tmp171, tmp184, tmp194
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr

In both cases the code is slightly suboptimal.  One may wonder why 
wasting r2 with the constant 0 in the second case for example.  And all 
the mov's could be folded in subsequent orr's, etc.

Now with the asm-generic version:

foo:
	ldr	r0, [r0, #0]	@ unaligned	@,* x
	bx	lr	@

bar:
	mov	r3, r0	@ x, x
	ldr	r0, [r0, #0]	@ unaligned	@,* x
	ldr	r1, [r3, #4]	@ unaligned	@,
	bx	lr	@

This is way better of course, but only because this was compiled for 
ARMv7. In this case the compiler knows that the hardware can do 
unaligned word access.  This isn't that obvious for foo(), but if we 
remove the get_unaligned() from bar as follows:

long long bar (long long *x) {return *x; }

then the resulting code is:

bar:
	ldmia	r0, {r0, r1}	@ x,,
	bx	lr	@

So this proves that the presumed aligned vs unaligned cases does have 
influence on the instructions the compiler may use and that the above 
unaligned code results are not just an accident.

Still... this isn't fully conclusive without at least looking at the 
resulting assembly fron a pre ARMv6 compilation.  Let's see with an 
ARMv5 target:

foo:
	ldrb	r3, [r0, #0]	@ zero_extendqisi2	@ tmp139,* x
	ldrb	r1, [r0, #1]	@ zero_extendqisi2	@ tmp140,
	ldrb	r2, [r0, #2]	@ zero_extendqisi2	@ tmp143,
	ldrb	r0, [r0, #3]	@ zero_extendqisi2	@ tmp146,
	orr	r3, r3, r1, asl #8	@, tmp142, tmp139, tmp140,
	orr	r3, r3, r2, asl #16	@, tmp145, tmp142, tmp143,
	orr	r0, r3, r0, asl #24	@,, tmp145, tmp146,
	bx	lr	@

bar:
	stmfd	sp!, {r4, r5, r6, r7}	@,
	ldrb	r2, [r0, #0]	@ zero_extendqisi2	@ tmp139,* x
	ldrb	r7, [r0, #1]	@ zero_extendqisi2	@ tmp140,
	ldrb	r3, [r0, #4]	@ zero_extendqisi2	@ tmp149,
	ldrb	r6, [r0, #5]	@ zero_extendqisi2	@ tmp150,
	ldrb	r5, [r0, #2]	@ zero_extendqisi2	@ tmp143,
	ldrb	r4, [r0, #6]	@ zero_extendqisi2	@ tmp153,
	ldrb	r1, [r0, #7]	@ zero_extendqisi2	@ tmp156,
	ldrb	ip, [r0, #3]	@ zero_extendqisi2	@ tmp146,
	orr	r2, r2, r7, asl #8	@, tmp142, tmp139, tmp140,
	orr	r3, r3, r6, asl #8	@, tmp152, tmp149, tmp150,
	orr	r2, r2, r5, asl #16	@, tmp145, tmp142, tmp143,
	orr	r3, r3, r4, asl #16	@, tmp155, tmp152, tmp153,
	orr	r0, r2, ip, asl #24	@,, tmp145, tmp146,
	orr	r1, r3, r1, asl #24	@,, tmp155, tmp156,
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr

Compared to the initial results, this is really nicely optimized and I 
couldn't do much better if I were to hand code it myself.

Conclusion: Please go ahead with this change.  This is really 
beneficial, especially for ARMv6+.  However, given this does change the 
generated code (significantly for ARMv6+) I'd ask for this to be in a 
patch of its own to help bisect potential issues if they were to happen.

Then you can add:

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas

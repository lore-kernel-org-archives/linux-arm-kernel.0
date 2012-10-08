From: robherring2@gmail.com (Rob Herring)
Date: Mon, 08 Oct 2012 15:34:57 -0500
Subject: [PATCH v2 3/5] ARM: use generic unaligned.h
In-Reply-To: <20121008164353.GB6140@S2101-09.ap.freescale.net>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
 <1344129840-16447-4-git-send-email-robherring2@gmail.com>
 <20121008164353.GB6140@S2101-09.ap.freescale.net>
Message-ID: <507338F1.7030604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 11:43 AM, Shawn Guo wrote:
> This patch has been merged into mainline as commit below.
> 
>  d25c881 ARM: 7493/1: use generic unaligned.h
> 
> It introduces a regression for me.  Check out the commit on mainline,
> build a v7 only kernel (imx5/6) with imx_v6_v7_defconfig, the kernel
> halts in decompressor.  But v6/v7 kernel (imx3/5/6) works fine.  The
> kernel built on the parent commit below works all fine.

It actually fails in the decompressor or that's the last output you get?
I compared the decompressor disassembly of both cases and get the same
number of ldrb/strb instructions, so I don't think it is directly
related to alignment.

I tried the XY decompressor as that is one difference, but that works
fine for me on highbank.

Does it work with an empty uncompress.h functions? That should be the
only difference in our decompressor code.

Rob

>  ef1c209 ARM: 7492/1: add strstr declaration for decompressors
> 
> Shawn
> 
> On Sat, Aug 04, 2012 at 08:23:58PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This moves ARM over to the asm-generic/unaligned.h header. This has the
>> benefit of better code generated especially for ARMv7 on gcc 4.7+
>> compilers.
>>
>> As Arnd Bergmann, points out: The asm-generic version uses the "struct"
>> version for native-endian unaligned access and the "byteshift" version
>> for the opposite endianess. The current ARM version however uses the
>> "byteshift" implementation for both.
>>
>> Thanks to Nicolas Pitre for the excellent analysis:
>>
>> Test case:
>>
>> int foo (int *x) { return get_unaligned(x); }
>> long long bar (long long *x) { return get_unaligned(x); }
>>
>> With the current ARM version:
>>
>> foo:
>> 	ldrb	r3, [r0, #2]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 2B], MEM[(const u8 *)x_1(D) + 2B]
>> 	ldrb	r1, [r0, #1]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 1B], MEM[(const u8 *)x_1(D) + 1B]
>> 	ldrb	r2, [r0, #0]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D)], MEM[(const u8 *)x_1(D)]
>> 	mov	r3, r3, asl #16	@ tmp154, MEM[(const u8 *)x_1(D) + 2B],
>> 	ldrb	r0, [r0, #3]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 3B], MEM[(const u8 *)x_1(D) + 3B]
>> 	orr	r3, r3, r1, asl #8	@, tmp155, tmp154, MEM[(const u8 *)x_1(D) + 1B],
>> 	orr	r3, r3, r2	@ tmp157, tmp155, MEM[(const u8 *)x_1(D)]
>> 	orr	r0, r3, r0, asl #24	@,, tmp157, MEM[(const u8 *)x_1(D) + 3B],
>> 	bx	lr	@
>>
>> bar:
>> 	stmfd	sp!, {r4, r5, r6, r7}	@,
>> 	mov	r2, #0	@ tmp184,
>> 	ldrb	r5, [r0, #6]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 6B], MEM[(const u8 *)x_1(D) + 6B]
>> 	ldrb	r4, [r0, #5]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 5B], MEM[(const u8 *)x_1(D) + 5B]
>> 	ldrb	ip, [r0, #2]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 2B], MEM[(const u8 *)x_1(D) + 2B]
>> 	ldrb	r1, [r0, #4]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 4B], MEM[(const u8 *)x_1(D) + 4B]
>> 	mov	r5, r5, asl #16	@ tmp175, MEM[(const u8 *)x_1(D) + 6B],
>> 	ldrb	r7, [r0, #1]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 1B], MEM[(const u8 *)x_1(D) + 1B]
>> 	orr	r5, r5, r4, asl #8	@, tmp176, tmp175, MEM[(const u8 *)x_1(D) + 5B],
>> 	ldrb	r6, [r0, #7]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 7B], MEM[(const u8 *)x_1(D) + 7B]
>> 	orr	r5, r5, r1	@ tmp178, tmp176, MEM[(const u8 *)x_1(D) + 4B]
>> 	ldrb	r4, [r0, #0]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D)], MEM[(const u8 *)x_1(D)]
>> 	mov	ip, ip, asl #16	@ tmp188, MEM[(const u8 *)x_1(D) + 2B],
>> 	ldrb	r1, [r0, #3]	@ zero_extendqisi2	@ MEM[(const u8 *)x_1(D) + 3B], MEM[(const u8 *)x_1(D) + 3B]
>> 	orr	ip, ip, r7, asl #8	@, tmp189, tmp188, MEM[(const u8 *)x_1(D) + 1B],
>> 	orr	r3, r5, r6, asl #24	@,, tmp178, MEM[(const u8 *)x_1(D) + 7B],
>> 	orr	ip, ip, r4	@ tmp191, tmp189, MEM[(const u8 *)x_1(D)]
>> 	orr	ip, ip, r1, asl #24	@, tmp194, tmp191, MEM[(const u8 *)x_1(D) + 3B],
>> 	mov	r1, r3	@,
>> 	orr	r0, r2, ip	@ tmp171, tmp184, tmp194
>> 	ldmfd	sp!, {r4, r5, r6, r7}
>> 	bx	lr
>>
>> In both cases the code is slightly suboptimal.  One may wonder why
>> wasting r2 with the constant 0 in the second case for example.  And all
>> the mov's could be folded in subsequent orr's, etc.
>>
>> Now with the asm-generic version:
>>
>> foo:
>> 	ldr	r0, [r0, #0]	@ unaligned	@,* x
>> 	bx	lr	@
>>
>> bar:
>> 	mov	r3, r0	@ x, x
>> 	ldr	r0, [r0, #0]	@ unaligned	@,* x
>> 	ldr	r1, [r3, #4]	@ unaligned	@,
>> 	bx	lr	@
>>
>> This is way better of course, but only because this was compiled for
>> ARMv7. In this case the compiler knows that the hardware can do
>> unaligned word access.  This isn't that obvious for foo(), but if we
>> remove the get_unaligned() from bar as follows:
>>
>> long long bar (long long *x) {return *x; }
>>
>> then the resulting code is:
>>
>> bar:
>> 	ldmia	r0, {r0, r1}	@ x,,
>> 	bx	lr	@
>>
>> So this proves that the presumed aligned vs unaligned cases does have
>> influence on the instructions the compiler may use and that the above
>> unaligned code results are not just an accident.
>>
>> Still... this isn't fully conclusive without at least looking at the
>> resulting assembly fron a pre ARMv6 compilation.  Let's see with an
>> ARMv5 target:
>>
>> foo:
>> 	ldrb	r3, [r0, #0]	@ zero_extendqisi2	@ tmp139,* x
>> 	ldrb	r1, [r0, #1]	@ zero_extendqisi2	@ tmp140,
>> 	ldrb	r2, [r0, #2]	@ zero_extendqisi2	@ tmp143,
>> 	ldrb	r0, [r0, #3]	@ zero_extendqisi2	@ tmp146,
>> 	orr	r3, r3, r1, asl #8	@, tmp142, tmp139, tmp140,
>> 	orr	r3, r3, r2, asl #16	@, tmp145, tmp142, tmp143,
>> 	orr	r0, r3, r0, asl #24	@,, tmp145, tmp146,
>> 	bx	lr	@
>>
>> bar:
>> 	stmfd	sp!, {r4, r5, r6, r7}	@,
>> 	ldrb	r2, [r0, #0]	@ zero_extendqisi2	@ tmp139,* x
>> 	ldrb	r7, [r0, #1]	@ zero_extendqisi2	@ tmp140,
>> 	ldrb	r3, [r0, #4]	@ zero_extendqisi2	@ tmp149,
>> 	ldrb	r6, [r0, #5]	@ zero_extendqisi2	@ tmp150,
>> 	ldrb	r5, [r0, #2]	@ zero_extendqisi2	@ tmp143,
>> 	ldrb	r4, [r0, #6]	@ zero_extendqisi2	@ tmp153,
>> 	ldrb	r1, [r0, #7]	@ zero_extendqisi2	@ tmp156,
>> 	ldrb	ip, [r0, #3]	@ zero_extendqisi2	@ tmp146,
>> 	orr	r2, r2, r7, asl #8	@, tmp142, tmp139, tmp140,
>> 	orr	r3, r3, r6, asl #8	@, tmp152, tmp149, tmp150,
>> 	orr	r2, r2, r5, asl #16	@, tmp145, tmp142, tmp143,
>> 	orr	r3, r3, r4, asl #16	@, tmp155, tmp152, tmp153,
>> 	orr	r0, r2, ip, asl #24	@,, tmp145, tmp146,
>> 	orr	r1, r3, r1, asl #24	@,, tmp155, tmp156,
>> 	ldmfd	sp!, {r4, r5, r6, r7}
>> 	bx	lr
>>
>> Compared to the initial results, this is really nicely optimized and I
>> couldn't do much better if I were to hand code it myself.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>> ---
>>  arch/arm/include/asm/Kbuild      |    1 +
>>  arch/arm/include/asm/unaligned.h |   19 -------------------
>>  2 files changed, 1 insertion(+), 19 deletions(-)
>>  delete mode 100644 arch/arm/include/asm/unaligned.h
>>
>> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
>> index 6cc8a13..a86cabf 100644
>> --- a/arch/arm/include/asm/Kbuild
>> +++ b/arch/arm/include/asm/Kbuild
>> @@ -33,3 +33,4 @@ generic-y += sockios.h
>>  generic-y += termbits.h
>>  generic-y += timex.h
>>  generic-y += types.h
>> +generic-y += unaligned.h
>> diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
>> deleted file mode 100644
>> index 44593a8..0000000
>> --- a/arch/arm/include/asm/unaligned.h
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -#ifndef _ASM_ARM_UNALIGNED_H
>> -#define _ASM_ARM_UNALIGNED_H
>> -
>> -#include <linux/unaligned/le_byteshift.h>
>> -#include <linux/unaligned/be_byteshift.h>
>> -#include <linux/unaligned/generic.h>
>> -
>> -/*
>> - * Select endianness
>> - */
>> -#ifndef __ARMEB__
>> -#define get_unaligned	__get_unaligned_le
>> -#define put_unaligned	__put_unaligned_le
>> -#else
>> -#define get_unaligned	__get_unaligned_be
>> -#define put_unaligned	__put_unaligned_be
>> -#endif
>> -
>> -#endif /* _ASM_ARM_UNALIGNED_H */
>> -- 
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

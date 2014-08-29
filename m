From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 28 Aug 2014 22:51:05 -0700
Subject: [PATCH V3] arm: fix get_user BE behavior for target variable with
 size of 8 bytes
Message-ID: <1409291466-4064-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is non-RFC proposal to fix get_user for 8 bytes target variable
in BE v7 images. Patch follows this cover letter. Changes compared 
with previous RFC v2 version are very minor.

Note for LE image it is no change in resulting generated code diff,
i.e it affects only v7 BE code.

Will wait a bit more for folk's feedback before posting it into
Russell's patch system.

Changelog:

v3: - dropped RFC from proposed patch
    - addressed Daniel's comments
    - edited commit message to be more appropriate for final commit log,
    i.e moving history info and example into this cover letter

v2: this version: uses __get_user_64t_(124) special function of BE
sizeof(__r2) == 64 case

v1: first variant, that used different types for __r2 depending on brach
in switch statement, has problem of generating multiple warnings in case
of incorrect but single get_user usage.

The issue was discovered during 3.17-rc1 V7 BE KVM testing. Simple test case 
follows. Note it works in LE case because r2 in LE case is still least 
significant word.

Tested on TC2 for BE/LE and ARM/Thumb2 combinations.

Small test case C code

char gut_lower_v64_p32 (int *ptr) {
       long long value = 0;
       get_user(value, ptr);
       return 0xff & value;
}

the following code in BE V7 image will be generated. Note uxtb access to
r3 register, but __get_user_4 retrieves data into r2.

(gdb) disassemble gut_lower_v64_p32
Dump of assembler code for function gut_lower_v64_p32:
   0xc0022ec8 <+0>:	push	{lr}		; (str lr, [sp, #-4]!)
   0xc0022ecc <+4>:	mov	r2, sp
   0xc0022ed0 <+8>:	bic	r3, r2, #8128	; 0x1fc0
   0xc0022ed4 <+12>:	bic	r3, r3, #63	; 0x3f
   0xc0022ed8 <+16>:	ldr	r1, [r3, #8]
   0xc0022edc <+20>:	sub	r1, r1, #1
   0xc0022ee0 <+24>:	bl	0xc03792ac <__get_user_4>
   0xc0022ee4 <+28>:	uxtb	r0, r3
   0xc0022ee8 <+32>:	pop	{pc}		; (ldr pc, [sp], #4)
End of assembler dump.
(gdb) disassemble __get_user_4
Dump of assembler code for function __get_user_4:
   0xc03792ac <+0>:	adds	r2, r0, #3
   0xc03792b0 <+4>:	sbcscc	r2, r2, r1
   0xc03792b4 <+8>:	bcs	0xc03792fc <__get_user_bad>
   0xc03792b8 <+12>:	ldr	r2, [r0]
   0xc03792bc <+16>:	mov	r0, #0
   0xc03792c0 <+20>:	bx	lr
End of assembler dump.

Victor Kamensky (1):
  arm: fix get_user BE behavior for target variable with size of 8 bytes

 arch/arm/include/asm/uaccess.h | 48 ++++++++++++++++++++++++++++++++++--------
 arch/arm/lib/getuser.S         | 38 +++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 11 deletions(-)

-- 
1.8.1.4

From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 20 Aug 2014 22:29:09 -0700
Subject: [RFC PATCH] arm: fix get_user BE behavior for target variable with
 size of 8 bytes
Message-ID: <1408598949-23050-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

e38361d 'ARM: 8091/2: add get_user() support for 8 byte types' commit
broke V7 BE get_user call when target var size is 64 bit, but '*ptr' size
is 32 bit or smaller. e38361d changed type of __r2 from 'register
unsigned long' to 'register typeof(x) __r2 asm("r2")' i.e before the change
even when target variable size was 64 bit, __r2 was still 32 bit.
But after e38361d commit, for target var of 64 bit size, __r2 became 64
bit and now it should occupy 2 registers r2, and r3. The issue in BE case
that r3 register is least significant word of __r2 and r2 register is most
significant word of __r2. But __get_user_4 still copies result into r2 (most
significant word of __r2). Subsequent code copies from __r2 into x, but
for situation described it will pick up only garbage from r3 register.

It was discovered during 3.17-rc1 V7 BE KVM testing. Simple test case below.
Note it works in LE case because r2 in LE case is still least significant
word.

Proposed fix uninspiringly restores previous code but now in individual
branches of switch statement for '*(__p)' byte sizes 1, 2, 4 and have
newer code only for sizeof(*(__p)) == 8. Looking for may be better ideas
how to fix the issue.

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

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/include/asm/uaccess.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index a4cd7af..69b9292 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -141,28 +141,42 @@ extern int __get_user_8(void *);
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
 		register const typeof(*(p)) __user *__p asm("r0") = (p);\
-		register typeof(x) __r2 asm("r2");			\
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
 		switch (sizeof(*(__p))) {				\
 		case 1:							\
+		{							\
+			register unsigned long __r2 asm("r2");		\
 			__get_user_x(__r2, __p, __e, __l, 1);		\
+			x = (typeof(*(p))) __r2;			\
 			break;						\
+		}							\
 		case 2:							\
+		{							\
+			register unsigned long __r2 asm("r2");		\
 			__get_user_x(__r2, __p, __e, __l, 2);		\
+			x = (typeof(*(p))) __r2;			\
 			break;						\
+		}							\
 		case 4:							\
+		{							\
+			register unsigned long __r2 asm("r2");		\
 			__get_user_x(__r2, __p, __e, __l, 4);		\
+			x = (typeof(*(p))) __r2;			\
 			break;						\
+		}							\
 		case 8:							\
+		{							\
+			register typeof(x) __r2 asm("r2");		\
 			if (sizeof((x)) < 8)				\
 				__get_user_xb(__r2, __p, __e, __l, 4);	\
 			else						\
 				__get_user_x(__r2, __p, __e, __l, 8);	\
+			x = (typeof(*(p))) __r2;			\
 			break;						\
+		}							\
 		default: __e = __get_user_bad(); break;			\
 		}							\
-		x = (typeof(*(p))) __r2;				\
 		__e;							\
 	})
 
-- 
1.8.1.4

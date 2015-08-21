From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:48:15 +0100
Subject: [PATCH 1/4] ARM: uaccess: simplify user access assembly
In-Reply-To: <20150821134630.GW7557@n2100.arm.linux.org.uk>
References: <20150821134630.GW7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmg3-00044O-6s@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The user assembly for byte and word accesses was virtually identical.
Rather than duplicating this, use a macro instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/uaccess.h | 47 +++++++++++-------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 74b17d09ef7a..4cf54ebe408a 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -311,9 +311,9 @@ do {									\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
 } while (0)
 
-#define __get_user_asm_byte(x, addr, err)			\
+#define __get_user_asm(x, addr, err, instr)			\
 	__asm__ __volatile__(					\
-	"1:	" TUSER(ldrb) "	%1,[%2],#0\n"			\
+	"1:	" TUSER(instr) " %1, [%2], #0\n"		\
 	"2:\n"							\
 	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
@@ -329,6 +329,9 @@ do {									\
 	: "r" (addr), "i" (-EFAULT)				\
 	: "cc")
 
+#define __get_user_asm_byte(x, addr, err)			\
+	__get_user_asm(x, addr, err, ldrb)
+
 #ifndef __ARMEB__
 #define __get_user_asm_half(x, __gu_addr, err)			\
 ({								\
@@ -348,22 +351,7 @@ do {									\
 #endif
 
 #define __get_user_asm_word(x, addr, err)			\
-	__asm__ __volatile__(					\
-	"1:	" TUSER(ldr) "	%1,[%2],#0\n"			\
-	"2:\n"							\
-	"	.pushsection .text.fixup,\"ax\"\n"		\
-	"	.align	2\n"					\
-	"3:	mov	%0, %3\n"				\
-	"	mov	%1, #0\n"				\
-	"	b	2b\n"					\
-	"	.popsection\n"					\
-	"	.pushsection __ex_table,\"a\"\n"		\
-	"	.align	3\n"					\
-	"	.long	1b, 3b\n"				\
-	"	.popsection"					\
-	: "+r" (err), "=&r" (x)					\
-	: "r" (addr), "i" (-EFAULT)				\
-	: "cc")
+	__get_user_asm(x, addr, err, ldr)
 
 #define __put_user(x, ptr)						\
 ({									\
@@ -393,9 +381,9 @@ do {									\
 	}								\
 } while (0)
 
-#define __put_user_asm_byte(x, __pu_addr, err)			\
+#define __put_user_asm(x, __pu_addr, err, instr)		\
 	__asm__ __volatile__(					\
-	"1:	" TUSER(strb) "	%1,[%2],#0\n"			\
+	"1:	" TUSER(instr) " %1, [%2], #0\n"		\
 	"2:\n"							\
 	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
@@ -410,6 +398,9 @@ do {									\
 	: "r" (x), "r" (__pu_addr), "i" (-EFAULT)		\
 	: "cc")
 
+#define __put_user_asm_byte(x, __pu_addr, err)			\
+	__put_user_asm(x, __pu_addr, err, strb)
+
 #ifndef __ARMEB__
 #define __put_user_asm_half(x, __pu_addr, err)			\
 ({								\
@@ -427,21 +418,7 @@ do {									\
 #endif
 
 #define __put_user_asm_word(x, __pu_addr, err)			\
-	__asm__ __volatile__(					\
-	"1:	" TUSER(str) "	%1,[%2],#0\n"			\
-	"2:\n"							\
-	"	.pushsection .text.fixup,\"ax\"\n"		\
-	"	.align	2\n"					\
-	"3:	mov	%0, %3\n"				\
-	"	b	2b\n"					\
-	"	.popsection\n"					\
-	"	.pushsection __ex_table,\"a\"\n"		\
-	"	.align	3\n"					\
-	"	.long	1b, 3b\n"				\
-	"	.popsection"					\
-	: "+r" (err)						\
-	: "r" (x), "r" (__pu_addr), "i" (-EFAULT)		\
-	: "cc")
+	__put_user_asm(x, __pu_addr, err, str)
 
 #ifndef __ARMEB__
 #define	__reg_oper0	"%R2"
-- 
2.1.0

From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 6 Mar 2015 12:58:33 +0000
Subject: [PATCHv6 1/3] arm: make __get_user() work for 8 byte values
In-Reply-To: <1425646715-20834-1-git-send-email-david.vrabel@citrix.com>
References: <1425646715-20834-1-git-send-email-david.vrabel@citrix.com>
Message-ID: <1425646715-20834-2-git-send-email-david.vrabel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_user(), __put_user(), and put_user() all worked with 8-byte values
but __get_user() did not.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/uaccess.h |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index ce0786e..d8f535b 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -306,6 +306,7 @@ do {									\
 	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err);	break;	\
 	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err);	break;	\
 	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err);	break;	\
+	case 8:	__get_user_asm_dword(__gu_val, __gu_addr, err);	break;	\
 	default: (__gu_val) = __get_user_bad();				\
 	}								\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
@@ -365,6 +366,37 @@ do {									\
 	: "r" (addr), "i" (-EFAULT)				\
 	: "cc")
 
+#ifndef __ARMEB__
+#define	__reg_get0	"%R1"
+#define	__reg_get1	"%Q1"
+#else
+#define	__reg_get0	"%Q1"
+#define	__reg_get1	"%R1"
+#endif
+
+#define __get_user_asm_dword(x, addr, err)			\
+	__asm__ __volatile__(					\
+ ARM(	"1:	" TUSER(ldr) "	" __reg_get1 ", [%2], #4\n"	) \
+ ARM(	"2:	" TUSER(ldr) "	" __reg_get0 ", [%2]\n"	) \
+ THUMB(	"1:	" TUSER(ldr) "	" __reg_get1 ", [%2]\n"	) \
+ THUMB(	"2:	" TUSER(ldr) "	" __reg_get0 ", [%2, #4]\n"	) \
+	"3:\n"							\
+	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
+	"4:	mov	%0, %3\n"				\
+	"	mov	" __reg_get1 ", #0\n"			\
+	"	mov	" __reg_get0 ", #0\n"			\
+	"	b	3b\n"					\
+	"	.popsection\n"					\
+	"	.pushsection __ex_table,\"a\"\n"		\
+	"	.align	3\n"					\
+	"	.long	1b, 4b\n"				\
+	"	.long	2b, 4b\n"				\
+	"	.popsection"					\
+	: "+r" (err), "=&r" (x)					\
+	: "r" (addr), "i" (-EFAULT)				\
+	: "cc")
+
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
-- 
1.7.10.4

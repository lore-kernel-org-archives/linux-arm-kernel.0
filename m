From: liuxiaodong@nudt.edu.cn (=?GBK?B?wfXP/rar?=)
Date: Wed, 24 Jun 2015 15:00:30 +0800 (GMT+08:00)
Subject: [PATCH] XOR implementation for ARMv8
Message-ID: <463b2fe9.7d02.14e245e3541.Coremail.liuxiaodong@nudt.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the 128-bit SIMD registers and SIMD arithmetic instructions for XOR calculation in assembly language. 
Experimental results show that LDP/STP is more effective than LD1/ST1 for loading/restoring the operand, and we get better performance when using 16 SIMD registers than 32 registers. The result of xor speed test (measured by do_xor_speed) are as follows:
		32regs    	: 4352.000 MB/sec
		8regs     	: 4435.200 MB/sec
		ARM64-LD1-regs32: 38886.400 MB/sec
		ARM64-LD1-regs16: 45280.000 MB/sec
		ARM64-LDP-regs32: 44608.000 MB/sec
		ARM64-LDP-regs16: 53625.600 MB/sec
Iozone tests on disk array of RAID 5 show that the speed of of write operation can be improved by 15%~30%. 
This patch is currently against a linux 4.0.5 kernel for the arm64 architecture.

Please review, any input welcome.

Signed-off-by: Xiaodong Liu <liuxiaodong@nudt.edu.cn>
---

 include/asm/xor.h   |   34 +++++++
 kernel/arm64ksyms.c |   13 ++
 lib/Makefile        |    2 
 lib/xor.S           |  228 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 276 insertions(+), 1 deletion(-)

--------------------------------------------------------------------------------
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/include/asm/xor.h linux-4.0.5-mod/arch/arm64/include/asm/xor.h
--- linux-4.0.5-orig/arch/arm64/include/asm/xor.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/include/asm/xor.h	2015-06-24 09:23:59.853261131 +0800
@@ -0,0 +1,34 @@
+/*
+ * arch/arm64/include/asm/xor.h
+ *
+ * Copyright (C) Xiaodong Liu <liuxiaodong@nudt.edu.cn>, Changsha, P.R. China
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm-generic/xor.h>
+extern void xor_arm64ldpregs16_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_3(unsigned long, unsigned long *, unsigned long *,
+	unsigned long *);
+extern void xor_arm64ldpregs16_4(unsigned long, unsigned long *, unsigned long *,
+	unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_5(unsigned long, unsigned long *, unsigned long *,
+	unsigned long *, unsigned long *, unsigned long *);
+
+static struct xor_block_template xor_block_arm64ldpregs16 = {
+	.name   = "ARM64LDPregs16",
+	.do_2   = xor_arm64ldpregs16_2,
+	.do_3   = xor_arm64ldpregs16_3,
+	.do_4   = xor_arm64ldpregs16_4,
+	.do_5   = xor_arm64ldpregs16_5,
+};
+
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES			\
+	do {					\
+		xor_speed(&xor_block_arm64ldpregs16);	\
+		xor_speed(&xor_block_32regs);	\
+		xor_speed(&xor_block_8regs);	\
+	} while (0)
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/kernel/arm64ksyms.c linux-4.0.5-mod/arch/arm64/kernel/arm64ksyms.c
--- linux-4.0.5-orig/arch/arm64/kernel/arm64ksyms.c	2015-06-06 23:21:22.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/kernel/arm64ksyms.c	2015-06-24 09:24:32.389259774 +0800
@@ -65,3 +65,16 @@ EXPORT_SYMBOL(test_and_change_bit);
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 #endif
+
+	/* xor ops */
+extern void xor_arm64ldpregs16_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_3(unsigned long, unsigned long *, unsigned long *,
+	unsigned long *);
+extern void xor_arm64ldpregs16_4(unsigned long, unsigned long *, unsigned long *,
+	unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_5(unsigned long, unsigned long *, unsigned long *,
+	unsigned long *, unsigned long *, unsigned long *);
+EXPORT_SYMBOL(xor_arm64ldpregs16_2);
+EXPORT_SYMBOL(xor_arm64ldpregs16_3);
+EXPORT_SYMBOL(xor_arm64ldpregs16_4);
+EXPORT_SYMBOL(xor_arm64ldpregs16_5);
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/lib/Makefile linux-4.0.5-mod/arch/arm64/lib/Makefile
--- linux-4.0.5-orig/arch/arm64/lib/Makefile	2015-06-06 23:21:22.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/lib/Makefile	2015-06-23 17:25:02.172909343 +0800
@@ -2,4 +2,4 @@ lib-y		:= bitops.o clear_user.o delay.o
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
-		   strchr.o strrchr.o
+		   strchr.o strrchr.o xor.o
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/lib/xor.S linux-4.0.5-mod/arch/arm64/lib/xor.S
--- linux-4.0.5-orig/arch/arm64/lib/xor.S	1970-01-01 08:00:00.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/lib/xor.S	2015-06-24 09:25:49.969256540 +0800
@@ -0,0 +1,228 @@
+/*
+ * arch/arm64/lib/xor.S
+ *
+ * Copyright (C) Xiaodong Liu <liuxiaodong@nudt.edu.cn>, Changsha, P.R. China
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+.macro xor_vectorregs16
+    eor v24.16b, v24.16b, v16.16b
+    eor v25.16b, v25.16b, v17.16b
+    eor v26.16b, v26.16b, v18.16b
+    eor v27.16b, v27.16b, v19.16b
+    eor v28.16b, v28.16b, v20.16b
+    eor v29.16b, v29.16b, v21.16b
+    eor v30.16b, v30.16b, v22.16b
+    eor v31.16b, v31.16b, v23.16b
+.endm
+
+.align 4
+
+/*
+ * void xor_arm64ldpregs16_2(unsigned long size, unsigned long * dst, unsigned long *src);
+ *
+ * Parameters:
+ *	x0 - size
+ *	x1 - dst
+ *	x2 - src
+ */
+ENTRY(xor_arm64ldpregs16_2)
+
+    lsr x0, x0, #10
+
+.p2align 4
+Loop23:
+    ldp q16, q17, [x2], #32
+    ldp q18, q19, [x2], #32
+    ldp q20, q21, [x2], #32
+    ldp q22, q23, [x2], #32
+
+    mov x3,x1
+
+    ldp q24, q25, [x1], #32
+    ldp q26, q27, [x1], #32
+    ldp q27, q29, [x1], #32
+    ldp q30, q31, [x1], #32
+
+    xor_vectorregs16
+
+    stp q24, q25, [x3], #32
+    stp q26, q27, [x3], #32
+    stp q27, q29, [x3], #32
+    stp q30, q31, [x3], #32
+
+    subs x0, x0, #1
+    cbnz x0, Loop23
+
+    ret
+ENDPROC(xor_arm64ldpregs16_2)
+
+/*
+ * void xor_arm64ldpregs16_3(unsigned long size, unsigned long *dst, unsigned long *src0, unsigned long *src1);
+ *
+ * Parameters:
+ *	x0 - size
+ *	x1 - dst
+ *	x2 - src0
+ *	x3 - src1
+ */
+ENTRY(xor_arm64ldpregs16_3)
+
+    lsr x0, x0, #10
+
+.p2align 4
+Loop33:
+    ldp q16, q17, [x2], #32
+    ldp q18, q19, [x2], #32
+    ldp q20, q21, [x2], #32
+    ldp q22, q23, [x2], #32
+
+    mov x4,x1
+
+    ldp q24, q25, [x1], #32
+    ldp q26, q27, [x1], #32
+    ldp q27, q29, [x1], #32
+    ldp q30, q31, [x1], #32
+
+    xor_vectorregs16
+
+    ldp q16, q17, [x3], #32
+    ldp q18, q19, [x3], #32
+    ldp q20, q21, [x3], #32
+    ldp q22, q23, [x3], #32
+
+    xor_vectorregs16
+
+    stp q24, q25, [x4], #32
+    stp q26, q27, [x4], #32
+    stp q27, q29, [x4], #32
+    stp q30, q31, [x4], #32
+
+    subs x0, x0, #1
+    cbnz x0, Loop33
+
+    ret
+ENDPROC(xor_arm64ldpregs16_3)
+
+/*
+ * void xor_arm64ldpregs16_4(unsigned long size, unsigned long *dst, unsigned long *src0, unsigned long *src1, unsigned long *src2);
+ *
+ * Parameters:
+ *	x0 - size
+ *	x1 - dst
+ *	x2 - src0
+ *	x3 - src1
+ *	x4 - src2
+ */
+ENTRY(xor_arm64ldpregs16_4)
+
+    lsr x0, x0, #10
+
+.p2align 4
+Loop43:
+    ldp q16, q17, [x2], #32
+    ldp q18, q19, [x2], #32
+    ldp q20, q21, [x2], #32
+    ldp q22, q23, [x2], #32
+
+    mov x5,x1
+
+    ldp q24, q25, [x1], #32
+    ldp q26, q27, [x1], #32
+    ldp q27, q29, [x1], #32
+    ldp q30, q31, [x1], #32
+
+    xor_vectorregs16
+
+    ldp q16, q17, [x3], #32
+    ldp q18, q19, [x3], #32
+    ldp q20, q21, [x3], #32
+    ldp q22, q23, [x3], #32
+
+    xor_vectorregs16
+
+    ldp q16, q17, [x4], #32
+    ldp q18, q19, [x4], #32
+    ldp q20, q21, [x4], #32
+    ldp q22, q23, [x4], #32
+
+    xor_vectorregs16
+
+    stp q24, q25, [x5], #32
+    stp q26, q27, [x5], #32
+    stp q27, q29, [x5], #32
+    stp q30, q31, [x5], #32
+
+    subs x0, x0, #1
+    cbnz x0, Loop43
+
+    ret
+ENDPROC(xor_arm64ldpregs16_4)
+
+/*
+ * void xor_arm64ldpregs16_5(unsigned long size, unsigned long *dst, unsigned long *src0, unsigned long *src1, unsigned long *src2, unsigned long *src3);
+ *
+ * Parameters:
+ *	x0 - size
+ *	x1 - dst
+ *	x2 - src0
+ *	x3 - src1
+ *	x4 - src2
+ *	x5 - src3
+ */
+ENTRY(xor_arm64ldpregs16_5)
+
+    lsr x0, x0, #10
+
+.p2align 4
+Loop53:
+    ldp q16, q17, [x2], #32
+    ldp q18, q19, [x2], #32
+    ldp q20, q21, [x2], #32
+    ldp q22, q23, [x2], #32
+
+    mov x6,x1
+
+    ldp q24, q25, [x1], #32
+    ldp q26, q27, [x1], #32
+    ldp q27, q29, [x1], #32
+    ldp q30, q31, [x1], #32
+
+    xor_vectorregs16
+
+    ldp q16, q17, [x3], #32
+    ldp q18, q19, [x3], #32
+    ldp q20, q21, [x3], #32
+    ldp q22, q23, [x3], #32
+
+    xor_vectorregs16
+
+    ldp q16, q17, [x4], #32
+    ldp q18, q19, [x4], #32
+    ldp q20, q21, [x4], #32
+    ldp q22, q23, [x4], #32
+
+    xor_vectorregs16
+
+    ldp q16, q17, [x5], #32
+    ldp q18, q19, [x5], #32
+    ldp q20, q21, [x5], #32
+    ldp q22, q23, [x5], #32
+
+    xor_vectorregs16
+
+    stp q24, q25, [x6], #32
+    stp q26, q27, [x6], #32
+    stp q27, q29, [x6], #32
+    stp q30, q31, [x6], #32
+
+    subs x0, x0, #1
+    cbnz x0, Loop53
+
+    ret
+ENDPROC(xor_arm64ldpregs16_5)

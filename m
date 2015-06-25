From: liuxiaodong@nudt.edu.cn (=?UTF-8?B?5YiY5pmT5Lic?=)
Date: Thu, 25 Jun 2015 17:22:27 +0800 (GMT+08:00)
Subject: [PATCH] XOR implementation for ARMv8
In-Reply-To: <CALW4P+KSQ_KD7FKFVs4CKovxe-91qRWPR+=-kxaDxKsVqH1j4w@mail.gmail.com>
References: <CALW4P+KSQ_KD7FKFVs4CKovxe-91qRWPR+=-kxaDxKsVqH1j4w@mail.gmail.com>
Message-ID: <34d966c7.7ec3.14e2a0685e0.Coremail.liuxiaodong@nudt.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Jun 24, 2015 at 11:51 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 24 June 2015 at 10:29, J?r?me Forissier <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >> On 06/24/2015 09:00 AM, ??? wrote:
> >>> Use the 128-bit SIMD registers and SIMD arithmetic instructions for XOR calculation in assembly language.
> >>
> >> Don't you need kernel_neon_begin()/kernel_neon_end() somewhere? (see
> >> Documentation/arm/kernel_mode_neon.txt).
> >>
> >
> > Jerome is right: use of this driver will corrupt the FP/SIMD state of
> > arbitrary userland tasks if you don't explicitly claim the NEON for
> > in-kernel use by calling kernel_neon_begin)_ and end()
> >
> > Since XOR may be called in interrupt context, this could add a fixed
> > overhead to each call, even if you are calling the function many times
> > in a row. This means you may be better off using even fewer registers,
> > and use kernel_neon_begin_partial() instead.
> >
> > May I ask what kind of core you tested this on?
> 
> And if Xiaodong Liu isn't subscribed to linux arm mail list then he will not get this email chain.
> It was removed by Jerome from to/cc list. Please don't do that.
> 
> (restoring back Xiaodong Liu email)
> 
> -- 
> Best regards, Klimov Alexey

According to your suggestion, I have revised the code by using kernel_neon_begin and kernel_neon_end to avoid contaminating the SIMD registers in interrupt context. 
BTW, I use  Phytium FT-1500A SoC which is armv8 compatible for tests. 

Regards,
Xiaodong Liu
---
 include/asm/xor.h   |  197 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/arm64ksyms.c |   13 ++
 lib/Makefile        |    4 
 lib/xor-neon.c      |   30 ++++++
 lib/xor.S           |  228 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 472 insertions(+)
---
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/include/asm/xor.h linux-4.0.5-mod/arch/arm64/include/asm/xor.h
--- linux-4.0.5-orig/arch/arm64/include/asm/xor.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/include/asm/xor.h	2015-06-25 16:59:19.527197817 +0800
@@ -0,0 +1,197 @@
+/*
+ * arch/arm64/include/asm/xor.h
+ *
+ * Copyright (C) Xiaodong Liu <liuxiaodong@nudt.edu.cn>, Changsha, P.R. China
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/hardirq.h>
+#include <asm-generic/xor.h>
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+
+#define __XOR(a1, a2) a1 ^= a2
+
+#define GET_BLOCK_8(dst) \
+	__asm__("ldp %1, %2, [%0], #16;\n\t" \
+			"ldp %3, %4, [%0], #16;\n\t" \
+			"ldp %5, %6, [%0], #16;\n\t" \
+			"ldp %7, %8, [%0], #16;\n\t" \
+    : "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4), "=r" (a5), "=r" (a6), "=r" (a7), "=r" (a8) \
+    : "0" (dst))
+
+#define XOR_BLOCK_8(src) \
+    __asm__("ldp %1, %2, [%0], #16;\n\t" \
+            "ldp %3, %4, [%0], #16;\n\t" \
+            "ldp %5, %6, [%0], #16;\n\t" \
+            "ldp %7, %8, [%0], #16;\n\t"  \
+    : "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4), "=r" (b5), "=r" (b6), "=r" (b7), "=r" (b8) \
+    : "0" (src)); \
+    __XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4); __XOR(a5, b5); __XOR(a6, b6); __XOR(a7, b7); __XOR(a8, b8)
+
+#define PUT_BLOCK_8(dst) \
+    __asm__ __volatile__("stp %1, %2, [%0], #16;\n\t" \
+                        "stp %3, %4, [%0], #16;\n\t" \
+                        "stp %5, %6, [%0], #16;\n\t" \
+                        "stp %7, %8, [%0], #16;\n\t" \
+    : "=r" (dst) \
+    : "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7), "r" (a8));
+
+#define INIT_REGISTER() \
+    register unsigned long a1 __asm__("x4"); \
+    register unsigned long a2 __asm__("x5"); \
+    register unsigned long a3 __asm__("x6"); \
+    register unsigned long a4 __asm__("x7"); \
+    register unsigned long a5 __asm__("x8"); \
+    register unsigned long a6 __asm__("x9"); \
+    register unsigned long a7 __asm__("x10"); \
+    register unsigned long a8 __asm__("x11"); \
+    register unsigned long b1 __asm__("x12"); \
+    register unsigned long b2 __asm__("x13"); \
+    register unsigned long b3 __asm__("x14"); \
+    register unsigned long b4 __asm__("x15"); \
+    register unsigned long b5 __asm__("x16"); \
+    register unsigned long b6 __asm__("x17"); \
+    register unsigned long b7 __asm__("x18"); \
+    register unsigned long b8 __asm__("x19");
+
+static void 
+xor_arm8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+{
+	unsigned long lines = bytes / sizeof(unsigned long) / 8;
+	INIT_REGISTER();
+		
+	do {
+		GET_BLOCK_8(p1);
+		XOR_BLOCK_8(p2);
+		PUT_BLOCK_8(p1);
+	} while(--lines);
+}
+
+static void
+xor_arm8regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3)
+{
+	unsigned long lines = bytes / sizeof(unsigned long) / 8;
+	INIT_REGISTER();
+
+	do {
+		GET_BLOCK_8(p1);
+		XOR_BLOCK_8(p2);
+		XOR_BLOCK_8(p3);
+		PUT_BLOCK_8(p1);
+	} while(--lines);
+}
+
+static void
+xor_arm8regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+        unsigned long *p3, unsigned long *p4)
+{
+    unsigned long lines = bytes / sizeof(unsigned long) / 8;
+    INIT_REGISTER();
+
+    do {
+        GET_BLOCK_8(p1);
+        XOR_BLOCK_8(p2);
+        XOR_BLOCK_8(p3);
+        XOR_BLOCK_8(p4);
+        PUT_BLOCK_8(p1);
+    } while(--lines);
+}
+
+static void
+xor_arm8regs_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+        unsigned long *p3, unsigned long *p4, unsigned long *p5)
+{
+    unsigned long lines = bytes / sizeof(unsigned long) / 8;
+    INIT_REGISTER();
+
+    do {
+        GET_BLOCK_8(p1);
+        XOR_BLOCK_8(p2);
+        XOR_BLOCK_8(p3);
+        XOR_BLOCK_8(p4);
+        XOR_BLOCK_8(p5);
+        PUT_BLOCK_8(p1);
+    } while(--lines);
+}
+
+extern struct xor_block_template const xor_block_neon_arm64;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+{
+    if(in_interrupt()) {
+        xor_arm8regs_2(bytes, p1, p2);
+    } else {
+        kernel_neon_begin();
+		xor_block_neon_arm64.do_2(bytes, p1, p2);
+        kernel_neon_end();
+    }
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+        unsigned long *p3)
+{
+    if(in_interrupt()) {
+        xor_arm8regs_3(bytes, p1, p2, p3);
+    } else {
+        kernel_neon_begin();
+        xor_block_neon_arm64.do_3(bytes, p1, p2, p3);
+        kernel_neon_end();
+    }
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+        unsigned long *p3, unsigned long *p4)
+{
+    if(in_interrupt()) {
+        xor_arm8regs_4(bytes, p1, p2, p3, p4);
+    } else {
+        kernel_neon_begin();
+        xor_block_neon_arm64.do_4(bytes, p1, p2, p3, p4);
+        kernel_neon_end();
+    }
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+        unsigned long *p3, unsigned long *p4, unsigned long *p5)
+{
+    if(in_interrupt()) {
+        xor_arm8regs_5(bytes, p1, p2, p3, p4, p5);
+    } else {
+        kernel_neon_begin();
+        xor_block_neon_arm64.do_5(bytes, p1, p2, p3, p4, p5);
+        kernel_neon_end();
+    }
+}
+
+static struct xor_block_template xor_block_arm64regs8 = {
+    .name   = "arm64regs8",
+    .do_2   = xor_arm8regs_2,
+    .do_3   = xor_arm8regs_3,
+    .do_4   = xor_arm8regs_4,
+    .do_5   = xor_arm8regs_5
+};
+
+static struct xor_block_template xor_block_arm64 = {
+    .name   = "neon_arm64",
+    .do_2   = xor_neon_2,
+    .do_3   = xor_neon_3,
+    .do_4   = xor_neon_4,
+    .do_5   = xor_neon_5
+};
+
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES           \
+    do {        \
+        xor_speed(&xor_block_8regs);    \
+        xor_speed(&xor_block_32regs);    \
+        xor_speed(&xor_block_arm64regs8);   \
+        do { if (cpu_has_neon()) xor_speed(&xor_block_arm64); } while (0); \
+    } while(0)
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/kernel/arm64ksyms.c linux-4.0.5-mod/arch/arm64/kernel/arm64ksyms.c
--- linux-4.0.5-orig/arch/arm64/kernel/arm64ksyms.c	2015-06-06 23:21:22.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/kernel/arm64ksyms.c	2015-06-25 11:40:07.537692040 +0800
@@ -65,3 +65,16 @@ EXPORT_SYMBOL(test_and_change_bit);
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 #endif
+
+	/* xor ops */
+extern void xor_arm64ldpregs16_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_3(unsigned long, unsigned long *, unsigned long *,
+        unsigned long *);
+extern void xor_arm64ldpregs16_4(unsigned long, unsigned long *, unsigned long *,
+        unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_5(unsigned long, unsigned long *, unsigned long *,
+        unsigned long *, unsigned long *, unsigned long *);
+EXPORT_SYMBOL(xor_arm64ldpregs16_2);
+EXPORT_SYMBOL(xor_arm64ldpregs16_3);
+EXPORT_SYMBOL(xor_arm64ldpregs16_4);
+EXPORT_SYMBOL(xor_arm64ldpregs16_5);
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/lib/Makefile linux-4.0.5-mod/arch/arm64/lib/Makefile
--- linux-4.0.5-orig/arch/arm64/lib/Makefile	2015-06-06 23:21:22.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/lib/Makefile	2015-06-25 16:47:44.051223943 +0800
@@ -3,3 +3,7 @@ lib-y		:= bitops.o clear_user.o delay.o
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o
+
+ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
+  obj-$(CONFIG_XOR_BLOCKS)  += xor-neon.o xor.o
+endif
diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/lib/xor-neon.c linux-4.0.5-mod/arch/arm64/lib/xor-neon.c
--- linux-4.0.5-orig/arch/arm64/lib/xor-neon.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-4.0.5-mod/arch/arm64/lib/xor-neon.c	2015-06-25 16:53:36.319210709 +0800
@@ -0,0 +1,30 @@
+/*
+ * arch/arm64/lib/xor-neon.c
+ *
+ * Copyright (C) Xiaodong Liu <liuxiaodong@nudt.edu.cn>, Changsha, P.R. China
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/raid/xor.h>
+#include <linux/module.h>
+
+extern void xor_arm64ldpregs16_2(unsigned long, unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_3(unsigned long, unsigned long *, unsigned long *,
+              unsigned long *);
+extern void xor_arm64ldpregs16_4(unsigned long, unsigned long *, unsigned long *,
+              unsigned long *, unsigned long *);
+extern void xor_arm64ldpregs16_5(unsigned long, unsigned long *, unsigned long *,
+              unsigned long *, unsigned long *, unsigned long *);
+
+struct xor_block_template const xor_block_neon_arm64 = {
+        .name   = "ARM64LDPregs16",
+        .do_2   = xor_arm64ldpregs16_2,
+        .do_3   = xor_arm64ldpregs16_3,
+        .do_4   = xor_arm64ldpregs16_4,
+        .do_5   = xor_arm64ldpregs16_5,
+};
+
+EXPORT_SYMBOL(xor_block_neon_arm64);
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

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Mar 2015 10:01:29 +0100
Subject: [PATCH] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <CAKv+Gu9cU_cgD4AgndKKiFsCjkUyB9MKyP3kieZAY7y4t9kofw@mail.gmail.com>
References: <CAKv+Gu9cU_cgD4AgndKKiFsCjkUyB9MKyP3kieZAY7y4t9kofw@mail.gmail.com>
Message-ID: <1426755689-24220-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, so this is what I came up with in the end. I dropped b_abs/bl_abs as
they are not needed anymore, now that b_far/bl_far are emitted without
any explicit or implicit literals.

I updated the ARCH check so that movw/movt/ really only gets used on
v7 targeted builds. I also updated the v7 variant to use bx instead
of adding with the PC as destination register, as this is deprecated
by the ARM ARM.

--------------------8<-----------------------

These macros execute PC-relative branches, but with a larger
reach than the 24 bits that are available in the b and bl opcodes.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/assembler.h | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index f67fd3afebdf..1b9a630f93e0 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -88,6 +88,17 @@
 #endif
 
 /*
+ * The program counter is always ahead of the address of the currently
+ * executing instruction by PC_BIAS bytes, whose value differs depending
+ * on the execution mode.
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+#define PC_BIAS		4
+#else
+#define PC_BIAS		8
+#endif
+
+/*
  * Enable and disable interrupts
  */
 #if __LINUX_ARM_ARCH__ >= 6
@@ -108,6 +119,39 @@
 	.endm
 #endif
 
+	/*
+	 * Macros to emit relative conditional branches that may exceed the
+	 * range of the 24-bit immediate of the ordinary b/bl instructions.
+	 * NOTE: this doesn't work with locally defined symbols, as they
+	 * lack the ARM/Thumb annotation (even if they are annotated as
+	 * functions)
+	 */
+	.macro  b_far, target, r, c=, b=bx
+#if __LINUX_ARM_ARCH__ >= 7
+	movt\c	\r, #:upper16:(\target - (8888f + PC_BIAS))
+	movw\c	\r, #:lower16:(\target - (8888f + PC_BIAS))
+8888:	add\c	\r, \r, pc
+	\b\c	\r
+#else
+	/*
+	 * Compute the PC-relative offset of \target. We need to correct for
+	 * the bias when reading the PC at label 8888, and for the offset
+	 * between the place of the read and the place of the relocation.
+	 */
+8888:	add\c	\r, pc, #:pc_g0_nc:(\target - PC_BIAS + (. - 8888b))
+	add\c	\r, \r, #:pc_g1_nc:(\target - PC_BIAS + (. - 8888b))
+	add\c	pc, \r, #:pc_g2:(\target - PC_BIAS + (. - 8888b))
+#endif
+	.endm
+
+	.macro	bl_far, target, c=
+#if __LINUX_ARM_ARCH__ < 7
+	adr\c	lr, 8887f
+#endif
+	b_far	\target, ip, \c, blx
+8887:
+	.endm
+
 	.macro asm_trace_hardirqs_off
 #if defined(CONFIG_TRACE_IRQFLAGS)
 	stmdb   sp!, {r0-r3, ip, lr}
-- 
1.8.3.2

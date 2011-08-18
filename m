From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 18 Aug 2011 18:01:54 +0100
Subject: [PATCH v2 3/3] ARM: entry: Fix Thumb-2 undef handling for multi-CPU
	kernels
In-Reply-To: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
References: <1313686914-29481-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1313686914-29481-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When v6 and >=v7 boards are supported in the same kernel, the
__und_usr code currently makes a build-time assumption that Thumb-2
instructions occurring in userspace don't need to be supported.
Strictly speaking this is incorrect.

This patch fixes the above case by doing a run-time check on the
CPU architecture in these cases.  This only affects kernels which
support v6 and >=v7 CPUs together: plain v6 and plain v7 kernels
are unaffected.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Reviewed-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/entry-armv.S |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index b7236d4..9ad50c4 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -24,6 +24,7 @@
 #include <asm/unwind.h>
 #include <asm/unistd.h>
 #include <asm/tls.h>
+#include <asm/system.h>
 
 #include "entry-header.S"
 #include <asm/entry-macro-multi.S>
@@ -439,7 +440,27 @@ __und_usr:
 #endif
 	beq	call_fpe
 	@ Thumb instruction
-#if __LINUX_ARM_ARCH__ >= 7
+#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
+/*
+ * Thumb-2 instruction handling.  Note that because pre-v6 and >= v6 platforms
+ * can never be supported in a single kernel, this code is not applicable at
+ * all when __LINUX_ARM_ARCH__ < 6.  This allows simplifying assumptions to be
+ * made about .arch directives.
+ */
+#if __LINUX_ARM_ARCH__ < 7
+/* If the target CPU may not be Thumb-2-capable, a run-time check is needed: */
+#define NEED_CPU_ARCHITECTURE
+	ldr	r5, .LCcpu_architecture
+	ldr	r5, [r5]
+	cmp	r5, #CPU_ARCH_ARMv7
+	blo	__und_usr_unknown
+/*
+ * The following code won't get run unless the running CPU really is v7, so
+ * coding round the lack of ldrht on older arches is pointless.  Temporarily
+ * override the assembler target arch with the minimum required instead:
+ */
+	.arch	armv6t2
+#endif
 2:
  ARM(	ldrht	r5, [r4], #2	)
  THUMB(	ldrht	r5, [r4]	)
@@ -449,7 +470,16 @@ __und_usr:
 3:	ldrht	r0, [r4]
 	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
 	orr	r0, r0, r5, lsl #16
+
+#if __LINUX_ARM_ARCH__ < 7
+/* If the target arch was overridden, change it back: */
+#ifdef CONFIG_CPU_32v6K
+	.arch	armv6k
 #else
+	.arch	armv6
+#endif
+#endif /* __LINUX_ARM_ARCH__ < 7 */
+#else /* !(CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7) */
 	b	__und_usr_unknown
 #endif
  UNWIND(.fnend		)
@@ -576,6 +606,12 @@ call_fpe:
 	movw_pc	lr				@ CP#14 (Debug)
 	movw_pc	lr				@ CP#15 (Control)
 
+#ifdef NEED_CPU_ARCHITECTURE
+	.align	2
+.LCcpu_architecture:
+	.word	__cpu_architecture
+#endif
+
 #ifdef CONFIG_NEON
 	.align	6
 
-- 
1.7.4.1

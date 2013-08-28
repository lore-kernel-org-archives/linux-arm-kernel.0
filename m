From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Aug 2013 12:34:21 +0100
Subject: [PATCH 2/5] arm: Add {inc,dec}_preempt_count asm macros
In-Reply-To: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
References: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1377689664-27614-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds asm macros for inc_preempt_count and dec_preempt_count_ti
(which also gets the current thread_info) instead of open-coding them in
arch/arm/vfp/*.S files.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/assembler.h | 32 ++++++++++++++++++++++++++++++++
 arch/arm/vfp/entry.S             | 20 +++-----------------
 arch/arm/vfp/vfphw.S             | 14 ++------------
 3 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 8d4d50a..29ec0b6 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -23,6 +23,7 @@
 #include <asm/ptrace.h>
 #include <asm/domain.h>
 #include <asm/opcodes-virt.h>
+#include <asm/asm-offsets.h>
 
 #define IOMEM(x)	(x)
 
@@ -177,6 +178,37 @@
 	mov	\rd, \rd, lsl #13
 	.endm
 
+/*
+ * Increment/decrement the preempt count.
+ */
+#ifdef CONFIG_PREEMPT_COUNT
+	.macro	inc_preempt_count, ti, tmp
+	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
+	add	\tmp, \tmp, #1			@ increment it
+	str	\tmp, [\ti, #TI_PREEMPT]
+	.endm
+
+	.macro	dec_preempt_count, ti, tmp
+	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
+	sub	\tmp, \tmp, #1			@ decrement it
+	str	\tmp, [\ti, #TI_PREEMPT]
+	.endm
+
+	.macro	dec_preempt_count_ti, ti, tmp
+	get_thread_info \ti
+	dec_preempt_count \ti, \tmp
+	.endm
+#else
+	.macro	inc_preempt_count, ti, tmp
+	.endm
+
+	.macro	dec_preempt_count, ti, tmp
+	.endm
+
+	.macro	dec_preempt_count_ti, ti, tmp
+	.endm
+#endif
+
 #define USER(x...)				\
 9999:	x;					\
 	.pushsection __ex_table,"a";		\
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 9cc290a..f0759e7 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -25,11 +25,7 @@
 @  IRQs disabled.
 @
 ENTRY(do_vfp)
-#ifdef CONFIG_PREEMPT_COUNT
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	add	r11, r4, #1		@ increment it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	inc_preempt_count r10, r4
 	enable_irq
  	ldr	r4, .LCvfp
 	ldr	r11, [r10, #TI_CPU]	@ CPU number
@@ -38,12 +34,7 @@ ENTRY(do_vfp)
 ENDPROC(do_vfp)
 
 ENTRY(vfp_null_entry)
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	dec_preempt_count_ti r10, r4
 	mov	pc, lr
 ENDPROC(vfp_null_entry)
 
@@ -56,12 +47,7 @@ ENDPROC(vfp_null_entry)
 
 	__INIT
 ENTRY(vfp_testing_entry)
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	dec_preempt_count_ti r10, r4
 	ldr	r0, VFP_arch_address
 	str	r0, [r0]		@ set to non-zero value
 	mov	pc, r9			@ we have handled the fault
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 33d82aa..ee4c7b6 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -177,12 +177,7 @@ vfp_hw_state_valid:
 					@ else it's one 32-bit instruction, so
 					@ always subtract 4 from the following
 					@ instruction address.
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	dec_preempt_count_ti r10, r4
 	mov	pc, r9			@ we think we have handled things
 
 
@@ -201,12 +196,7 @@ look_for_VFP_exceptions:
 	@ not recognised by VFP
 
 	DBGSTR	"not VFP"
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	dec_preempt_count_ti r10, r4
 	mov	pc, lr
 
 process_exception:

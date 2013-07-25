From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 16:55:36 +0100
Subject: [PATCH v2 2/6] ARM: smp_on_up: move inline asm ALT_SMP patching macro
 out of spinlock.h
In-Reply-To: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
References: <1374767740-2068-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374767740-2068-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patching UP/SMP alternatives inside inline assembly blocks is useful
outside of the spinlock implementation, where it is used for sev and wfe.

This patch lifts the macro into processor.h and gives it a scarier name
to (a) avoid conflicts in the global namespace and (b) to try and deter
its usage unless you "know what you're doing". The W macro for generating
wide instructions when targetting Thumb-2 is also made available under
the name WASM, to reduce the potential for conflicts with other headers.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h | 12 ++++++++++++
 arch/arm/include/asm/spinlock.h  | 15 ++++-----------
 arch/arm/include/asm/unified.h   |  4 ++++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 91cfe08..cbdb130 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -22,6 +22,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
+#include <asm/unified.h>
 
 #ifdef __KERNEL__
 #define STACK_TOP	((current->personality & ADDR_LIMIT_32BIT) ? \
@@ -91,6 +92,17 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)	task_pt_regs(tsk)->ARM_pc
 #define KSTK_ESP(tsk)	task_pt_regs(tsk)->ARM_sp
 
+#ifdef CONFIG_SMP
+#define __ALT_SMP_ASM(smp, up)						\
+	"9998:	" smp "\n"						\
+	"	.pushsection \".alt.smp.init\", \"a\"\n"		\
+	"	.long	9998b\n"					\
+	"	" up "\n"						\
+	"	.popsection\n"
+#else
+#define __ALT_SMP_ASM(smp, up)	up
+#endif
+
 /*
  * Prefetching support - only ARMv5.
  */
diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index f8b8965..0de7bec 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -11,15 +11,7 @@
  * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
  * extensions, so when running on UP, we have to patch these instructions away.
  */
-#define ALT_SMP(smp, up)					\
-	"9998:	" smp "\n"					\
-	"	.pushsection \".alt.smp.init\", \"a\"\n"	\
-	"	.long	9998b\n"				\
-	"	" up "\n"					\
-	"	.popsection\n"
-
 #ifdef CONFIG_THUMB2_KERNEL
-#define SEV		ALT_SMP("sev.w", "nop.w")
 /*
  * For Thumb-2, special care is needed to ensure that the conditional WFE
  * instruction really does assemble to exactly 4 bytes (as required by
@@ -31,17 +23,18 @@
  * the assembler won't change IT instructions which are explicitly present
  * in the input.
  */
-#define WFE(cond)	ALT_SMP(		\
+#define WFE(cond)	__ALT_SMP_ASM(		\
 	"it " cond "\n\t"			\
 	"wfe" cond ".n",			\
 						\
 	"nop.w"					\
 )
 #else
-#define SEV		ALT_SMP("sev", "nop")
-#define WFE(cond)	ALT_SMP("wfe" cond, "nop")
+#define WFE(cond)	__ALT_SMP_ASM("wfe" cond, "nop")
 #endif
 
+#define SEV		__ALT_SMP_ASM(WASM(sev), WASM(nop))
+
 static inline void dsb_sev(void)
 {
 #if __LINUX_ARM_ARCH__ >= 7
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index f5989f4..b88beab 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -38,6 +38,8 @@
 #ifdef __ASSEMBLY__
 #define W(instr)	instr.w
 #define BSYM(sym)	sym + 1
+#else
+#define WASM(instr)	#instr ".w"
 #endif
 
 #else	/* !CONFIG_THUMB2_KERNEL */
@@ -50,6 +52,8 @@
 #ifdef __ASSEMBLY__
 #define W(instr)	instr
 #define BSYM(sym)	sym
+#else
+#define WASM(instr)	#instr
 #endif
 
 #endif	/* CONFIG_THUMB2_KERNEL */
-- 
1.8.2.2

From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 19 May 2011 14:59:38 +0100
Subject: [PATCH v2] ARM: fiq: Refactor {get,set}_fiq_regs() for Thumb-2
Message-ID: <1305813578-8113-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 * To remove the risk of inconvenient register allocation decisions
   by the compiler, these functions are separated out as pure
   assembler.

 * The apcs frame manipulation code is not applicable for Thumb-2
   (and also not easily compatible).  Since it's not essential to
   have a full frame on these leaf assembler functions, the frame
   manipulation is removed, in the interests of simplicity.

 * Split up ldm/stm instructions to be compatible with Thumb-2,
   as well as avoiding instruction forms deprecated on >= ARMv7.

Tested on omap4 using explicit calls to get_fiq_regs() and
set_fiq_regs().

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---

If anyone else feels able to test/ack this patch, it would be much
appreciated.

 arch/arm/include/asm/fiq.h |   16 ++++++++++++-
 arch/arm/kernel/Makefile   |    2 +-
 arch/arm/kernel/fiq.c      |   45 +--------------------------------------
 arch/arm/kernel/fiqasm.S   |   49 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/kernel/fiqasm.S

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index 2242ce2..45bb3ee 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -29,9 +29,21 @@ struct fiq_handler {
 extern int claim_fiq(struct fiq_handler *f);
 extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
-extern void set_fiq_regs(struct pt_regs *regs);
-extern void get_fiq_regs(struct pt_regs *regs);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
 
+/* helpers defined in fiqasm.S: */
+extern void __set_fiq_regs(unsigned long const *regs);
+extern void __get_fiq_regs(unsigned long *regs);
+
+static inline void set_fiq_regs(struct pt_regs const *regs)
+{
+	__set_fiq_regs(&regs->ARM_r8);
+}
+
+static inline void get_fiq_regs(struct pt_regs *regs)
+{
+	__get_fiq_regs(&regs->ARM_r8);
+}
+
 #endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 74554f1..689f4d9 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_OC_ETM)		+= etm.o
 
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_ARCH_ACORN)	+= ecard.o 
-obj-$(CONFIG_FIQ)		+= fiq.o
+obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
 obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index e72dc34..4c164ec 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -89,47 +89,6 @@ void set_fiq_handler(void *start, unsigned int length)
 		flush_icache_range(0x1c, 0x1c + length);
 }
 
-/*
- * Taking an interrupt in FIQ mode is death, so both these functions
- * disable irqs for the duration.  Note - these functions are almost
- * entirely coded in assembly.
- */
-void __naked set_fiq_regs(struct pt_regs *regs)
-{
-	register unsigned long tmp;
-	asm volatile (
-	"mov	ip, sp\n\
-	stmfd	sp!, {fp, ip, lr, pc}\n\
-	sub	fp, ip, #4\n\
-	mrs	%0, cpsr\n\
-	msr	cpsr_c, %2	@ select FIQ mode\n\
-	mov	r0, r0\n\
-	ldmia	%1, {r8 - r14}\n\
-	msr	cpsr_c, %0	@ return to SVC mode\n\
-	mov	r0, r0\n\
-	ldmfd	sp, {fp, sp, pc}"
-	: "=&r" (tmp)
-	: "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | FIQ_MODE));
-}
-
-void __naked get_fiq_regs(struct pt_regs *regs)
-{
-	register unsigned long tmp;
-	asm volatile (
-	"mov	ip, sp\n\
-	stmfd	sp!, {fp, ip, lr, pc}\n\
-	sub	fp, ip, #4\n\
-	mrs	%0, cpsr\n\
-	msr	cpsr_c, %2	@ select FIQ mode\n\
-	mov	r0, r0\n\
-	stmia	%1, {r8 - r14}\n\
-	msr	cpsr_c, %0	@ return to SVC mode\n\
-	mov	r0, r0\n\
-	ldmfd	sp, {fp, sp, pc}"
-	: "=&r" (tmp)
-	: "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | FIQ_MODE));
-}
-
 int claim_fiq(struct fiq_handler *f)
 {
 	int ret = 0;
@@ -174,8 +133,8 @@ void disable_fiq(int fiq)
 }
 
 EXPORT_SYMBOL(set_fiq_handler);
-EXPORT_SYMBOL(set_fiq_regs);
-EXPORT_SYMBOL(get_fiq_regs);
+EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
+EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(claim_fiq);
 EXPORT_SYMBOL(release_fiq);
 EXPORT_SYMBOL(enable_fiq);
diff --git a/arch/arm/kernel/fiqasm.S b/arch/arm/kernel/fiqasm.S
new file mode 100644
index 0000000..207f9d6
--- /dev/null
+++ b/arch/arm/kernel/fiqasm.S
@@ -0,0 +1,49 @@
+/*
+ *  linux/arch/arm/kernel/fiqasm.S
+ *
+ *  Derived from code originally in linux/arch/arm/kernel/fiq.c:
+ *
+ *  Copyright (C) 1998 Russell King
+ *  Copyright (C) 1998, 1999 Phil Blundell
+ *  Copyright (C) 2011, Linaro Limited
+ *
+ *  FIQ support written by Philip Blundell <philb@gnu.org>, 1998.
+ *
+ *  FIQ support re-written by Russell King to be more generic
+ *
+ *  v7/Thumb-2 compatibility modifications by Linaro Limited, 2011.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * Taking an interrupt in FIQ mode is death, so both these functions
+ * disable irqs for the duration.
+ */
+
+ENTRY(__set_fiq_regs)
+	mov	r2, #PSR_I_BIT | PSR_F_BIT | FIQ_MODE
+	mrs	r1, cpsr
+	msr	cpsr_c, r2	@ select FIQ mode
+	mov	r0, r0		@ avoid hazard prior to ARMv4
+	ldmia	r0!, {r8 - r12}
+	ldr	sp, [r0], #4
+	ldr	lr, [r0]
+	msr	cpsr_c, r1	@ return to SVC mode
+	mov	r0, r0		@ avoid hazard prior to ARMv4
+	mov	pc, lr
+ENDPROC(__set_fiq_regs)
+
+ENTRY(__get_fiq_regs)
+	mov	r2, #PSR_I_BIT | PSR_F_BIT | FIQ_MODE
+	mrs	r1, cpsr
+	msr	cpsr_c, r2	@ select FIQ mode
+	mov	r0, r0		@ avoid hazard prior to ARMv4
+	stmia	r0!, {r8 - r12}
+	str	sp, [r0], #4
+	str	lr, [r0]
+	msr	cpsr_c, r1	@ return to SVC mode
+	mov	r0, r0		@ avoid hazard prior to ARMv4
+	mov	pc, lr
+ENDPROC(__get_fiq_regs)
-- 
1.7.1

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:15:00 +0200
Subject: [RFC v3 PATCH 4/7] ARM64: add support for kernel mode NEON in atomic
 context
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies kernel_neon_begin() and kernel_neon_end(), so
they may be called from any context. To address the in_interrupt()
case, they now both take a parameter defined by DEFINE_NEON_REGSTACK()
or DEFINE_NEON_REGSTACK_PARTIAL() [in case only a few NEON registers
are in fact used]. The !in_interrupt() case is unchanged from before.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/fpsimd.h       | 17 +++++++++++++++++
 arch/arm64/include/asm/fpsimdmacros.h | 35 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/neon.h         | 31 +++++++++++++++++++++++++++++--
 arch/arm64/kernel/entry-fpsimd.S      | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/fpsimd.c            | 29 ++++++++++++++++++-----------
 5 files changed, 123 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index c43b4ac..755bdf1 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -39,6 +39,18 @@ struct fpsimd_state {
 	};
 };
 
+/*
+ * Variable sized struct for stacking the bottom 'n' FP/SIMD registers.
+ * Mainly intended for kernel use of v8 Crypto Extensions which only
+ * needs a few registers and may need to execute in atomic context.
+ */
+struct fpsimd_partial_state {
+	u32		fpsr;
+	u32		fpcr;
+	__uint128_t	vregs[] __aligned(16);
+} __aligned(16);
+
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
 #define VFP_FPSCR_STAT_MASK	0xf800009f
@@ -55,6 +67,11 @@ struct task_struct;
 extern void fpsimd_save_state(struct fpsimd_state *state);
 extern void fpsimd_load_state(struct fpsimd_state *state);
 
+extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state,
+				      u32 num_regs);
+extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state,
+				      u32 num_regs);
+
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index bbec599..f771b69 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -62,3 +62,38 @@
 	ldr	w\tmpnr, [\state, #16 * 2 + 4]
 	msr	fpcr, x\tmpnr
 .endm
+
+.altmacro
+.macro	q2op, op, q1, q2, state
+	\op	q\q1, q\q2, [\state, #-(16 * \q1) - 16]
+.endm
+
+.macro fpsimd_save_partial state, num, tmpnr1, tmpnr2
+	mrs	x\tmpnr1, fpsr
+	mrs	x\tmpnr2, fpcr
+	stp	w\tmpnr1, w\tmpnr2, [\state]
+	adr	x\tmpnr1, 0f
+	add	\state, \state, \num, lsl #4
+	sub	x\tmpnr1, x\tmpnr1, \num, lsl #1
+	br	x\tmpnr1
+	.irp	qa, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0
+		qb = \qa + 1
+	q2op	stp, \qa, %qb, \state
+	.endr
+0:
+.endm
+
+.macro fpsimd_restore_partial state, num, tmpnr1, tmpnr2
+	ldp	w\tmpnr1, w\tmpnr2, [\state]
+	msr	fpsr, x\tmpnr1
+	msr	fpcr, x\tmpnr2
+	adr	x\tmpnr1, 0f
+	add	\state, \state, \num, lsl #4
+	sub	x\tmpnr1, x\tmpnr1, \num, lsl #1
+	br	x\tmpnr1
+	.irp	qa, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0
+		qb = \qa + 1
+	q2op	ldp, \qa, %qb, \state
+	.endr
+0:
+.endm
diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
index b0cc58a9..e496dce 100644
--- a/arch/arm64/include/asm/neon.h
+++ b/arch/arm64/include/asm/neon.h
@@ -8,7 +8,34 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/hardirq.h>
+#include <linux/types.h>
+#include <asm/fpsimd.h>
+
 #define cpu_has_neon()		(1)
 
-void kernel_neon_begin(void);
-void kernel_neon_end(void);
+/*
+ * Avoid wasting stack space by making the size of the allocated area depend on
+ * whether we are currently running in process context. (If this is the case, we
+ * will use the normal preserve/restore mechanism, leaving the allocated stack
+ * space unused.)
+ */
+#define __VREG_SIZE(num)	\
+	((!in_interrupt()) ? 0 : (num) > 32 ? 512 : 32 * (((num) + 1) & ~1U))
+
+#define DEFINE_NEON_REGSTACK_PARTIAL(v, num)		\
+	struct {					\
+		struct fpsimd_partial_state regs;		\
+		u8 vregs[__VREG_SIZE(num)];		\
+	} v
+
+#define DEFINE_NEON_REGSTACK(name)	DEFINE_NEON_REGSTACK_PARTIAL(name, 32)
+
+#define kernel_neon_begin(p) \
+	__kernel_neon_begin(&(p).regs, sizeof((p).vregs)/16)
+
+#define kernel_neon_end(p) \
+	__kernel_neon_end(&(p).regs, sizeof((p).vregs)/16)
+
+void __kernel_neon_begin(struct fpsimd_partial_state *regs, u32 num_regs);
+void __kernel_neon_end(struct fpsimd_partial_state *regs, u32 num_regs);
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 6a27cd6..aa73ee9 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -41,3 +41,27 @@ ENTRY(fpsimd_load_state)
 	fpsimd_restore x0, 8
 	ret
 ENDPROC(fpsimd_load_state)
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+
+/*
+ * Save the bottom n FP registers.
+ *
+ * x0 - pointer to struct fpsimd_partial_state
+ */
+ENTRY(fpsimd_save_partial_state)
+	fpsimd_save_partial x0, x1, 8, 9
+	ret
+ENDPROC(fpsimd_load_partial_state)
+
+/*
+ * Load the bottom n FP registers.
+ *
+ * x0 - pointer to struct fpsimd_partial_state
+ */
+ENTRY(fpsimd_load_partial_state)
+	fpsimd_restore_partial x0, x1, 8, 9
+	ret
+ENDPROC(fpsimd_load_partial_state)
+
+#endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a52affd..34fa94b 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -89,22 +89,29 @@ void fpsimd_flush_thread(void)
 /*
  * Kernel-side NEON support functions
  */
-void kernel_neon_begin(void)
+void __kernel_neon_begin(struct fpsimd_partial_state *regs, u32 num_regs)
 {
-	/* Avoid using the NEON in interrupt context */
-	BUG_ON(in_interrupt());
-	preempt_disable();
-
-	if (current->mm && !test_and_set_thread_flag(TIF_RELOAD_FPSTATE))
-		fpsimd_save_state(&current->thread.fpsimd_state);
+	if (in_interrupt()) {
+		BUG_ON(!num_regs);
+		fpsimd_save_partial_state(regs, num_regs);
+	} else {
+		preempt_disable();
+		if (current->mm &&
+		    !test_and_set_thread_flag(TIF_RELOAD_FPSTATE))
+			fpsimd_save_state(&current->thread.fpsimd_state);
+	}
 }
-EXPORT_SYMBOL(kernel_neon_begin);
+EXPORT_SYMBOL(__kernel_neon_begin);
 
-void kernel_neon_end(void)
+void __kernel_neon_end(struct fpsimd_partial_state *regs, u32 num_regs)
 {
-	preempt_enable();
+	if (in_interrupt()) {
+		BUG_ON(!num_regs);
+		fpsimd_load_partial_state(regs, num_regs);
+	} else
+		preempt_enable();
 }
-EXPORT_SYMBOL(kernel_neon_end);
+EXPORT_SYMBOL(__kernel_neon_end);
 
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
-- 
1.8.1.2

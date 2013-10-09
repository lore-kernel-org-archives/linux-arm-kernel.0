From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  9 Oct 2013 20:50:32 +0200
Subject: [RFC v2 PATCH 2/4] ARM64: add support for kernel mode NEON in atomic
 context
In-Reply-To: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381344634-14917-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds kernel_neon_begin_atomic() and kernel_neon_end_atomic(),
which may be called from any context. In !in_interrupt() case, they
just call their non-_atomic counterparts. In atomic context, they
stack resp. unstack the number of NEON registers declared when setting
up the stack area using DEFINE_NEON_REG_STACK().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/fpsimd.h       | 16 +++++++++++++++
 arch/arm64/include/asm/fpsimdmacros.h | 37 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/neon.h         | 31 +++++++++++++++++++++++++++++
 arch/arm64/kernel/entry-fpsimd.S      | 24 +++++++++++++++++++++++
 arch/arm64/kernel/fpsimd.c            |  3 +++
 5 files changed, 111 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index c43b4ac..3a741b0 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -39,6 +39,19 @@ struct fpsimd_state {
 	};
 };
 
+/*
+ * Variable sized struct for stacking the bottom n FP/SIMD registers.
+ * Mainly intended for kernel use of v8 Crypto Extensions which only
+ * needs a few registers and may need to execute in atomic context.
+ */
+struct fpsimd_partial_state {
+	const u32	num_regs;
+	u32		fpsr;
+	u32		fpcr;
+	__uint128_t	vregs[] __aligned(16);
+} __aligned(16);
+
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
 #define VFP_FPSCR_STAT_MASK	0xf800009f
@@ -55,6 +68,9 @@ struct task_struct;
 extern void fpsimd_save_state(struct fpsimd_state *state);
 extern void fpsimd_load_state(struct fpsimd_state *state);
 
+extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state);
+extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
+
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index bbec599..1b47587 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -62,3 +62,40 @@
 	ldr	w\tmpnr, [\state, #16 * 2 + 4]
 	msr	fpcr, x\tmpnr
 .endm
+
+.altmacro
+.macro	q2op, op, q1, q2, state
+	\op	q\q1, q\q2, [\state, #-(16 * \q1) - 16]
+.endm
+
+.macro fpsimd_save_partial state, tmpnr1, tmpnr2
+	mrs	x\tmpnr1, fpsr
+	mrs	x\tmpnr2, fpcr
+	stp	w\tmpnr1, w\tmpnr2, [\state, #4]
+	adr	x\tmpnr1, 0f
+	ldr	w\tmpnr2, [\state]
+	add	\state, \state, x\tmpnr2, lsl #4
+	sub	x\tmpnr1, x\tmpnr1, x\tmpnr2, lsl #1
+	br	x\tmpnr1
+	.irp	qa, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0
+		qb = \qa + 1
+	q2op	stp, \qa, %qb, \state
+	.endr
+0:
+.endm
+
+.macro fpsimd_restore_partial state, tmpnr1, tmpnr2
+	ldp	w\tmpnr1, w\tmpnr2, [\state, #4]
+	msr	fpsr, x\tmpnr1
+	msr	fpcr, x\tmpnr2
+	adr	x\tmpnr1, 0f
+	ldr	w\tmpnr2, [\state]
+	add	\state, \state, x\tmpnr2, lsl #4
+	sub	x\tmpnr1, x\tmpnr1, x\tmpnr2, lsl #1
+	br	x\tmpnr1
+	.irp	qa, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 0
+		qb = \qa + 1
+	q2op	ldp, \qa, %qb, \state
+	.endr
+0:
+.endm
diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
index b0cc58a9..1c8600a 100644
--- a/arch/arm64/include/asm/neon.h
+++ b/arch/arm64/include/asm/neon.h
@@ -8,7 +8,38 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/hardirq.h>
+#include <linux/types.h>
+#include <asm/fpsimd.h>
+
 #define cpu_has_neon()		(1)
 
+#define DEFINE_NEON_STACK_REGS(a, num)					\
+	struct {							\
+		struct fpsimd_partial_state regs;			\
+		__uint128_t vregs[(num) > 32 ? 32 : ((num) + 1) & ~1U];	\
+	} a = { .regs.num_regs = sizeof(a.vregs) / sizeof(__uint128_t) }
+
+#define DEFINE_NEON_STACK_REGS_ALL(name)	DEFINE_NEON_STACK_REGS(name, 32)
+
 void kernel_neon_begin(void);
 void kernel_neon_end(void);
+
+static inline void __kernel_neon_begin_atomic(struct fpsimd_partial_state *regs)
+{
+	if (!in_interrupt())
+		kernel_neon_begin();
+	else
+		fpsimd_save_partial_state(regs);
+}
+
+static inline void __kernel_neon_end_atomic(struct fpsimd_partial_state *regs)
+{
+	if (!in_interrupt())
+		kernel_neon_end();
+	else
+		fpsimd_load_partial_state(regs);
+}
+
+#define kernel_neon_begin_atomic(a)	__kernel_neon_begin_atomic(&(a).regs)
+#define kernel_neon_end_atomic(a)	__kernel_neon_end_atomic(&(a).regs)
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 6a27cd6..82cf648 100644
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
+	fpsimd_save_partial x0, 8, 9
+	ret
+ENDPROC(fpsimd_load_partial_state)
+
+/*
+ * Load the bottom n FP registers.
+ *
+ * x0 - pointer to struct fpsimd_partial_state
+ */
+ENTRY(fpsimd_load_partial_state)
+	fpsimd_restore_partial x0, 8, 9
+	ret
+ENDPROC(fpsimd_load_partial_state)
+
+#endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1f2e4d5..69c7962 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -109,6 +109,9 @@ void kernel_neon_end(void)
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
+EXPORT_SYMBOL(fpsimd_load_partial_state);
+EXPORT_SYMBOL(fpsimd_save_partial_state);
+
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
 /*
-- 
1.8.1.2

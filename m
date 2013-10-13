From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:14:57 +0200
Subject: [RFC v3 PATCH 1/7] ARM: add support for kernel mode NEON in atomic
 context
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some applications, such as WPA CCMP encryption, do substantial
amounts of work in non-process context. In order to support
accelerated NEON implementations under these circumstances, we
need a way to preserve the NEON context that may
(a) belong to a completely unrelated userland process (if the
    NEON unit is turned off atm);
(b) belong to current userland;
(c) belong to current kernel mode in process context.

The best way to deal with this is to just stack whatever registers
we are going to use, and unstack them when we are done.

This patch modifies kernel_neon_begin() and kernel_neon_end(), so
they may be called from any context. To address the in_interrupt()
case, they now both take a parameter defined by DEFINE_NEON_REGSTACK()
or DEFINE_NEON_REGSTACK_PARTIAL() [in case only a few NEON registers
are in fact used]. The !in_interrupt() case is unchanged from before.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/fpstate.h | 12 +++++++++
 arch/arm/include/asm/neon.h    | 32 +++++++++++++++++++++---
 arch/arm/vfp/vfphw.S           | 45 ++++++++++++++++++++++++++++++++++
 arch/arm/vfp/vfpmodule.c       | 55 ++++++++++++++++++++++++------------------
 4 files changed, 118 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/fpstate.h b/arch/arm/include/asm/fpstate.h
index 3ad4c10..0471c36 100644
--- a/arch/arm/include/asm/fpstate.h
+++ b/arch/arm/include/asm/fpstate.h
@@ -52,6 +52,18 @@ union vfp_state {
 extern void vfp_flush_thread(union vfp_state *);
 extern void vfp_release_thread(union vfp_state *);
 
+/*
+ * Variable sized struct for stacking the bottom 'n' NEON registers.
+ */
+struct vfp_partial_state {
+	__u32		fpexc;
+	__u32		fpscr;
+	__u8		qregs[] __aligned(16);
+} __aligned(16);
+
+extern void vfp_load_partial_state(struct vfp_partial_state *, u32 num_regs);
+extern void vfp_save_partial_state(struct vfp_partial_state *, u32 num_regs);
+
 #define FP_HARD_SIZE 35
 
 struct fp_hard_struct {
diff --git a/arch/arm/include/asm/neon.h b/arch/arm/include/asm/neon.h
index 8f730fe..800d85c 100644
--- a/arch/arm/include/asm/neon.h
+++ b/arch/arm/include/asm/neon.h
@@ -8,10 +8,30 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/types.h>
+#include <linux/hardirq.h>
+#include <asm/fpstate.h>
 #include <asm/hwcap.h>
 
 #define cpu_has_neon()		(!!(elf_hwcap & HWCAP_NEON))
 
+/*
+ * Avoid wasting stack space by making the size of the allocated area depend on
+ * whether we are currently running in process context. (If this is the case, we
+ * will use the normal preserve/restore mechanism, leaving the allocated stack
+ * space unused.)
+ */
+#define __QREG_SIZE(num)	\
+	((!in_interrupt()) ? 0 : (num) > 16 ? 256 : 16 * (((num) + 1) & ~1U))
+
+#define DEFINE_NEON_REGSTACK_PARTIAL(v, num)		\
+	struct {					\
+		struct vfp_partial_state regs;		\
+		u8 qregs[__QREG_SIZE(num)];		\
+	} v
+
+#define DEFINE_NEON_REGSTACK(name)	DEFINE_NEON_REGSTACK_PARTIAL(name, 16)
+
 #ifdef __ARM_NEON__
 
 /*
@@ -27,10 +47,16 @@
  *     -mpfu=neon is set.
  */
 
-#define kernel_neon_begin() \
+#define kernel_neon_begin(p) \
 	BUILD_BUG_ON_MSG(1, "kernel_neon_begin() called from NEON code")
 
 #else
-void kernel_neon_begin(void);
+#define kernel_neon_begin(p) \
+	__kernel_neon_begin(&(p).regs, sizeof((p).qregs)/16)
 #endif
-void kernel_neon_end(void);
+
+#define kernel_neon_end(p) \
+	__kernel_neon_end(&(p).regs, sizeof((p).qregs)/16)
+
+void __kernel_neon_begin(struct vfp_partial_state *regs, u32 num_regs);
+void __kernel_neon_end(struct vfp_partial_state *regs, u32 num_regs);
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 3e5d311..28384a5 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -322,3 +322,48 @@ ENTRY(vfp_put_double)
 	.endr
 #endif
 ENDPROC(vfp_put_double)
+
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+
+	.fpu	neon
+ENTRY(vfp_save_partial_state)
+	VFPFMRX	r2, FPEXC			@ load the control registers
+	tst	r2, #FPEXC_EN
+	str	r2, [r0]			@ save to memory
+	bne	0f
+	orr	r2, r2, #FPEXC_EN		@ enable VFP if it was disabled
+	VFPFMXR	FPEXC, r2
+0:	VFPFMRX	r3, FPSCR
+	str	r3, [r0, #4]			@ save to memory
+	rsbs	r1, r1, #16
+	add	r2, r0, #16
+	beq	1f
+	adr	r3, 1f
+	add	r3, r3, r1, lsl #1
+THUMB(	orr	r3, r3, #1)
+	bx	r3
+1:	.irp	qq,q14-q15,q12-q13,q10-q11,q8-q9,q6-q7,q4-q5,q2-q3,q0-q1
+	vst1.8	{\qq}, [r2,:128]!
+	.endr
+	bx	lr
+ENDPROC(vfp_save_partial_state)
+
+ENTRY(vfp_load_partial_state)
+	rsbs	r1, r1, #16
+	add	r2, r0, #16
+	beq	0f
+	adr	r3, 0f
+	add	r3, r3, r1, lsl #1
+THUMB(	orr	r3, r3, #1)
+	bx	r3
+0:	.irp	qq,q14-q15,q12-q13,q10-q11,q8-q9,q6-q7,q4-q5,q2-q3,q0-q1
+	vld1.8	{\qq}, [r2,:128]!
+	.endr
+	ldrd	r2, r3, [r0]
+	VFPFMXR	FPSCR, r3
+	VFPFMXR	FPEXC, r2
+	bx	lr
+ENDPROC(vfp_load_partial_state)
+
+#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 52b8f40..b924a5b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -674,44 +674,53 @@ void vfp_kmode_exception(void)
 /*
  * Kernel-side NEON support functions
  */
-void kernel_neon_begin(void)
+void __kernel_neon_begin(struct vfp_partial_state *regs, u32 num_regs)
 {
 	struct thread_info *thread = current_thread_info();
 	unsigned int cpu;
 	u32 fpexc;
 
 	/*
-	 * Kernel mode NEON is only allowed outside of interrupt context
-	 * with preemption disabled. This will make sure that the kernel
-	 * mode NEON register contents never need to be preserved.
+	 * If running in non-process context, we just stack whatever registers
+	 * the caller has indicated he needs. Otherwise, do a regular preserve
+	 * of the userland context.
 	 */
-	BUG_ON(in_interrupt());
-	cpu = get_cpu();
+	if (in_interrupt()) {
+		BUG_ON(!num_regs);
+		vfp_save_partial_state(regs, num_regs);
+	} else {
+		cpu = get_cpu();
 
-	fpexc = fmrx(FPEXC) | FPEXC_EN;
-	fmxr(FPEXC, fpexc);
+		fpexc = fmrx(FPEXC) | FPEXC_EN;
+		fmxr(FPEXC, fpexc);
 
-	/*
-	 * Save the userland NEON/VFP state. Under UP,
-	 * the owner could be a task other than 'current'
-	 */
-	if (vfp_state_in_hw(cpu, thread))
-		vfp_save_state(&thread->vfpstate, fpexc);
+		/*
+		 * Save the userland NEON/VFP state. Under UP,
+		 * the owner could be a task other than 'current'
+		 */
+		if (vfp_state_in_hw(cpu, thread))
+			vfp_save_state(&thread->vfpstate, fpexc);
 #ifndef CONFIG_SMP
-	else if (vfp_current_hw_state[cpu] != NULL)
-		vfp_save_state(vfp_current_hw_state[cpu], fpexc);
+		else if (vfp_current_hw_state[cpu] != NULL)
+			vfp_save_state(vfp_current_hw_state[cpu], fpexc);
 #endif
-	vfp_current_hw_state[cpu] = NULL;
+		vfp_current_hw_state[cpu] = NULL;
+	}
 }
-EXPORT_SYMBOL(kernel_neon_begin);
+EXPORT_SYMBOL(__kernel_neon_begin);
 
-void kernel_neon_end(void)
+void __kernel_neon_end(struct vfp_partial_state *regs, u32 num_regs)
 {
-	/* Disable the NEON/VFP unit. */
-	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	put_cpu();
+	if (in_interrupt()) {
+		BUG_ON(!num_regs);
+		vfp_load_partial_state(regs, num_regs);
+	} else {
+		/* Disable the NEON/VFP unit. */
+		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+		put_cpu();
+	}
 }
-EXPORT_SYMBOL(kernel_neon_end);
+EXPORT_SYMBOL(__kernel_neon_end);
 
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
-- 
1.8.1.2

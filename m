From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  9 Oct 2013 20:50:31 +0200
Subject: [RFC v2 PATCH 1/4] ARM: add support for kernel mode NEON in atomic
 context
In-Reply-To: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381344634-14917-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381344634-14917-2-git-send-email-ard.biesheuvel@linaro.org>
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

This patch adds kernel_neon_begin_atomic() and kernel_neon_end_atomic(),
which may be called from any context. In !in_interrupt() case, they
just call their non-_atomic counterparts. In atomic context, they
stack resp. unstack the number of NEON registers declared when setting
up the stack area using DEFINE_NEON_REG_STACK().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/fpstate.h | 15 +++++++++++++-
 arch/arm/include/asm/neon.h    | 34 +++++++++++++++++++++++++++++++
 arch/arm/vfp/vfphw.S           | 46 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/vfp/vfpmodule.c       |  3 +++
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/fpstate.h b/arch/arm/include/asm/fpstate.h
index 3ad4c10..7a6e100 100644
--- a/arch/arm/include/asm/fpstate.h
+++ b/arch/arm/include/asm/fpstate.h
@@ -19,7 +19,7 @@
  *  - FPEXC, FPSCR, FPINST and FPINST2.
  *  - 16 or 32 double precision data registers
  *  - an implementation-dependent word of state for FLDMX/FSTMX (pre-ARMv6)
- * 
+ *
  *  FPEXC will always be non-zero once the VFP has been used in this process.
  */
 
@@ -52,6 +52,19 @@ union vfp_state {
 extern void vfp_flush_thread(union vfp_state *);
 extern void vfp_release_thread(union vfp_state *);
 
+/*
+ * Variable sized struct for stacking the bottom 'n' NEON registers.
+ */
+struct vfp_partial_state {
+	const __u32	num_regs;
+	__u32		fpexc;
+	__u32		fpscr;
+	__u8		qregs[] __aligned(16);
+} __aligned(16);
+
+extern void vfp_load_partial_state(struct vfp_partial_state *);
+extern void vfp_save_partial_state(struct vfp_partial_state *);
+
 #define FP_HARD_SIZE 35
 
 struct fp_hard_struct {
diff --git a/arch/arm/include/asm/neon.h b/arch/arm/include/asm/neon.h
index 8f730fe..1efd9fc 100644
--- a/arch/arm/include/asm/neon.h
+++ b/arch/arm/include/asm/neon.h
@@ -8,10 +8,21 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/types.h>
+#include <linux/hardirq.h>
+#include <asm/fpstate.h>
 #include <asm/hwcap.h>
 
 #define cpu_has_neon()		(!!(elf_hwcap & HWCAP_NEON))
 
+#define DEFINE_NEON_STACK_REGS(v, num)					\
+	struct {							\
+		struct vfp_partial_state regs;				\
+		u8 qregs[(num) > 16 ? 256 : 16 * (((num) + 1) & ~1U)];	\
+	} v = { .regs.num_regs = sizeof(v.qregs)/16 }
+
+#define DEFINE_NEON_STACK_REGS_ALL(name)	DEFINE_NEON_STACK_REGS(name,16)
+
 #ifdef __ARM_NEON__
 
 /*
@@ -30,7 +41,30 @@
 #define kernel_neon_begin() \
 	BUILD_BUG_ON_MSG(1, "kernel_neon_begin() called from NEON code")
 
+#define kernel_neon_begin_atomic(a) \
+	BUILD_BUG_ON_MSG(1, "kernel_neon_begin_atomic() called from NEON code")
+
 #else
 void kernel_neon_begin(void);
+#define kernel_neon_begin_atomic(name) __kernel_neon_begin_atomic(&(name).regs)
 #endif
+
+#define kernel_neon_end_atomic(name) __kernel_neon_end_atomic(&(name).regs)
+
 void kernel_neon_end(void);
+
+static inline void __kernel_neon_begin_atomic(struct vfp_partial_state *regs)
+{
+	if (!in_interrupt())
+		kernel_neon_begin();
+	else
+		vfp_save_partial_state(regs);
+}
+
+static inline void __kernel_neon_end_atomic(struct vfp_partial_state *regs)
+{
+	if (!in_interrupt())
+		kernel_neon_end();
+	else
+		vfp_load_partial_state(regs);
+}
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 3e5d311..747e782 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -322,3 +322,49 @@ ENTRY(vfp_put_double)
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
+	VFPFMRX	r3, FPSCR
+	strd	r2, r3, [r0, #4]		@ and save to memory
+	tst	r2, #FPEXC_EN
+	bne	0f
+	orr	r2, r2, #FPEXC_EN		@ enable VFP if it was disabled
+	VFPFMXR	FPEXC, r2
+0:	ldr	r1, [r0]			@ load # of regs to preserve
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
+	ldr	r2, [r0]			@ load # of regs to preserve
+	rsbs	r1, r2, #16
+	add	r2, r0, #16
+	beq	0f
+	adr	r3, 0f
+	add	r3, r3, r1, lsl #1
+THUMB(	orr	r3, r3, #1)
+	bx	r3
+0:	.irp	qq,q14-q15,q12-q13,q10-q11,q8-q9,q6-q7,q4-q5,q2-q3,q0-q1
+	vld1.8	{\qq}, [r2,:128]!
+	.endr
+	ldrd	r2, r3, [r0, #4]
+	VFPFMXR	FPSCR, r3
+	VFPFMXR	FPEXC, r2
+	bx	lr
+ENDPROC(vfp_load_partial_state)
+
+#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 52b8f40..3dea5ba 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -713,6 +713,9 @@ void kernel_neon_end(void)
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
+EXPORT_SYMBOL(vfp_save_partial_state);
+EXPORT_SYMBOL(vfp_load_partial_state);
+
 #endif /* CONFIG_KERNEL_MODE_NEON */
 
 /*
-- 
1.8.1.2

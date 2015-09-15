From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 12:36:37 +0100
Subject: [PATCH 2/2] arm64: compat: fix vfp save/restore across signal
 handlers in big-endian
In-Reply-To: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
References: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442316997-32282-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When saving/restoring the VFP registers from a compat (AArch32)
signal frame, we rely on the compat registers forming a prefix of the
native register file and therefore make use of copy_{to,from}_user to
transfer between the native fpsimd_state and the compat_vfp_sigframe.

Unfortunately, this doesn't work so well in a big-endian environment.
Our fpsimd save/restore code operates directly on 128-bit quantities
(Q registers) whereas the compat_vfp_sigframe represents the registers
as an array of 64-bit (D) registers. The architecture packs the compat D
registers into the Q registers, with the least significant bytes holding
the lower register. Consequently, we need to swap the 64-bit halves when
converting between these two representations on a big-endian machine.

This patch replaces the __copy_{to,from}_user invocations in our
compat VFP signal handling code with explicit __put_user loops that
operate on 64-bit values and swap them accordingly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal32.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index ae46ffad5aea..64e498e59f99 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -212,14 +212,32 @@ int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
 
 /*
  * VFP save/restore code.
+ *
+ * We have to be careful with endianness, since the fpsimd context-switch
+ * code operates on 128-bit (Q) register values whereas the compat ABI
+ * uses an array of 64-bit (D) registers. Consequently, we need to swap
+ * the two halves of each Q register when running on a big-endian CPU.
  */
+union __fpsimd_vreg {
+	__uint128_t	raw;
+	struct {
+#ifdef __AARCH64EB__
+		u64	hi;
+		u64	lo;
+#else
+		u64	lo;
+		u64	hi;
+#endif
+	};
+};
+
 static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 {
 	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
 	compat_ulong_t magic = VFP_MAGIC;
 	compat_ulong_t size = VFP_STORAGE_SIZE;
 	compat_ulong_t fpscr, fpexc;
-	int err = 0;
+	int i, err = 0;
 
 	/*
 	 * Save the hardware registers to the fpsimd_state structure.
@@ -235,10 +253,15 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	/*
 	 * Now copy the FP registers. Since the registers are packed,
 	 * we can copy the prefix we want (V0-V15) as it is.
-	 * FIXME: Won't work if big endian.
 	 */
-	err |= __copy_to_user(&frame->ufp.fpregs, fpsimd->vregs,
-			      sizeof(frame->ufp.fpregs));
+	for (i = 0; i < ARRAY_SIZE(frame->ufp.fpregs); i++) {
+		union __fpsimd_vreg vreg = {
+			.raw = fpsimd->vregs[i >> 1],
+		};
+
+		__put_user_error(vreg.lo, &frame->ufp.fpregs[i++], err);
+		__put_user_error(vreg.hi, &frame->ufp.fpregs[i], err);
+	}
 
 	/* Create an AArch32 fpscr from the fpsr and the fpcr. */
 	fpscr = (fpsimd->fpsr & VFP_FPSCR_STAT_MASK) |
@@ -263,7 +286,7 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	compat_ulong_t magic = VFP_MAGIC;
 	compat_ulong_t size = VFP_STORAGE_SIZE;
 	compat_ulong_t fpscr;
-	int err = 0;
+	int i, err = 0;
 
 	__get_user_error(magic, &frame->magic, err);
 	__get_user_error(size, &frame->size, err);
@@ -275,12 +298,14 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 
 	set_ti_thread_flag(current_thread_info(), TIF_FOREIGN_FPSTATE);
 
-	/*
-	 * Copy the FP registers into the start of the fpsimd_state.
-	 * FIXME: Won't work if big endian.
-	 */
-	err |= __copy_from_user(fpsimd.vregs, frame->ufp.fpregs,
-				sizeof(frame->ufp.fpregs));
+	/* Copy the FP registers into the start of the fpsimd_state. */
+	for (i = 0; i < ARRAY_SIZE(frame->ufp.fpregs); i++) {
+		union __fpsimd_vreg vreg;
+
+		__get_user_error(vreg.lo, &frame->ufp.fpregs[i++], err);
+		__get_user_error(vreg.hi, &frame->ufp.fpregs[i], err);
+		fpsimd.vregs[i >> 1] = vreg.raw;
+	}
 
 	/* Extract the fpsr and the fpcr from the fpscr */
 	__get_user_error(fpscr, &frame->ufp.fpscr, err);
-- 
2.1.4

From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:06 +0000
Subject: [RFC PATCH v2 36/41] arm64/sve: ptrace: Wire up vector length control
 and reporting
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-37-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for manipulating a task's vector length at
runtime via ptrace.

As a simplification, we turn the task back into an FPSIMD-only task
when changing the vector length.  If the register data is written
too, we then turn the task back into an SVE task, with changed
task_struct layout for the SVE data, before the actual data writing
is done.

Because the vector length is now variable, sve_get() now needs to
return the real maximum for user_sve_header.max_vl, since .vl may
be less than this (that's the whole point).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h      |  2 ++
 arch/arm64/include/uapi/asm/ptrace.h |  6 ++++++
 arch/arm64/kernel/ptrace.c           | 25 +++++++++++++++----------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 764da0f..385ef226 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -105,6 +105,8 @@ extern void *__sve_state(struct task_struct *task);
 
 #ifdef CONFIG_ARM64_SVE
 
+extern int sve_max_vl;
+
 extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
 extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index f26b68e..69a2700 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -64,6 +64,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/prctl.h>
+
 /*
  * User structures for general purpose, floating point and debug registers.
  */
@@ -108,6 +110,10 @@ struct user_sve_header {
 #define SVE_PT_REGS_FPSIMD		0
 #define SVE_PT_REGS_SVE			SVE_PT_REGS_MASK
 
+#define SVE_PT_VL_THREAD		PR_SVE_SET_VL_THREAD
+#define SVE_PT_VL_INHERIT		PR_SVE_SET_VL_INHERIT
+#define SVE_PT_VL_ONEXEC		PR_SVE_SET_VL_ONEXEC
+
 
 /*
  * The remainder of the SVE state follows struct user_sve_header.  The
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 72b922a..02d3265 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -751,14 +751,15 @@ static int sve_get(struct task_struct *target,
 	BUG_ON(!sve_vl_valid(header.vl));
 	vq = sve_vq_from_vl(header.vl);
 
-	/* Until runtime or per-task vector length changing is supported: */
-	header.max_vl = header.vl;
+	BUG_ON(!sve_vl_valid(sve_max_vl));
+	header.max_vl = sve_max_vl;
 
 	header.flags = test_tsk_thread_flag(target, TIF_SVE) ?
 		SVE_PT_REGS_SVE : SVE_PT_REGS_FPSIMD;
 
 	header.size = SVE_PT_SIZE(vq, header.flags);
-	header.max_size = SVE_PT_SIZE(vq, SVE_PT_REGS_SVE);
+	header.max_size = SVE_PT_SIZE(sve_vq_from_vl(header.max_vl),
+				      SVE_PT_REGS_SVE);
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &header,
 				  0, sizeof(header));
@@ -845,14 +846,18 @@ static int sve_set(struct task_struct *target,
 	if (ret)
 		goto out;
 
-	if (header.vl != target->thread.sve_vl)
-		return -EINVAL;
-
-	BUG_ON(!sve_vl_valid(header.vl));
-	vq = sve_vq_from_vl(header.vl);
+	/*
+	 * Apart from PT_SVE_REGS_MASK, all PT_SVE_* flags are consumed by
+	 * sve_set_vector_length(), which will also validate them for us:
+	 */
+	ret = sve_set_vector_length(target, header.vl,
+				    header.flags & ~SVE_PT_REGS_MASK);
+	if (ret)
+		goto out;
 
-	if (header.flags & ~SVE_PT_REGS_MASK)
-		return -EINVAL;
+	/* Actual VL set may be less than the user asked for: */
+	BUG_ON(!sve_vl_valid(target->thread.sve_vl));
+	vq = sve_vq_from_vl(target->thread.sve_vl);
 
 	/* Registers: FPSIMD-only case */
 
-- 
2.1.4

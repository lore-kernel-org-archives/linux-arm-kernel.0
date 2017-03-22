From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:57 +0000
Subject: [RFC PATCH v2 27/41] arm64/sve: ptrace support
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-28-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Hayward <alan.hayward@arm.com>

This patch adds support for accessing a task's SVE registers via
ptrace.

Some additional helpers are added in order to support the SVE/
FPSIMD register view synchronisation operations that are required
in order to make the NT_PRFPREG and NT_ARM_SVE regsets interact
correctly.

fpr_set()/fpr_get() are refactored into backend/frontend functions,
so that the core can be reused by sve_set()/sve_get() for the case
where no SVE registers are stored for a thread.

Signed-off-by: Alan Hayward <alan.hayward@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h          |  18 +++
 arch/arm64/include/uapi/asm/ptrace.h     | 124 +++++++++++++++
 arch/arm64/include/uapi/asm/sigcontext.h |   4 +
 arch/arm64/kernel/fpsimd.c               |  38 +++++
 arch/arm64/kernel/ptrace.c               | 252 ++++++++++++++++++++++++++++++-
 include/uapi/linux/elf.h                 |   1 +
 6 files changed, 430 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index be292c5..71b94ee 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -35,6 +35,10 @@ struct fpsimd_state {
 			__uint128_t vregs[32];
 			u32 fpsr;
 			u32 fpcr;
+			/*
+			 * For ptrace compatibility, pad to next 128-bit
+			 * boundary here if extending this struct.
+			 */
 		};
 	};
 	/* the id of the last cpu to have restored this state */
@@ -97,6 +101,20 @@ extern unsigned int sve_get_vl(void);
 extern void __init fpsimd_init_task_struct_size(void);
 extern void *__sve_state(struct task_struct *task);
 
+#ifdef CONFIG_ARM64_SVE
+
+extern void fpsimd_sync_to_sve(struct task_struct *task);
+extern void sve_sync_to_fpsimd(struct task_struct *task);
+extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
+
+#else /* ! CONFIG_ARM64_SVE */
+
+static void __maybe_unused sve_sync_to_fpsimd(struct task_struct *task) { }
+static void __maybe_unused sve_sync_from_fpsimd_zeropad(
+	struct task_struct *task) { }
+
+#endif /* ! CONFIG_ARM64_SVE */
+
 #endif
 
 #endif
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d1ff83d..f26b68e 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 
 #include <asm/hwcap.h>
+#include <asm/sigcontext.h>
 
 
 /*
@@ -90,6 +91,129 @@ struct user_hwdebug_state {
 	}		dbg_regs[16];
 };
 
+/* SVE/FP/SIMD state (NT_ARM_SVE) */
+
+struct user_sve_header {
+	__u32 size; /* total meaningful regset content in bytes */
+	__u32 max_size; /* maxmium possible size for this thread */
+	__u16 vl; /* current vector length */
+	__u16 max_vl; /* maximum possible vector length */
+	__u16 flags;
+	__u16 __reserved;
+};
+
+/* Definitions for user_sve_header.flags: */
+#define SVE_PT_REGS_MASK		(1 << 0)
+
+#define SVE_PT_REGS_FPSIMD		0
+#define SVE_PT_REGS_SVE			SVE_PT_REGS_MASK
+
+
+/*
+ * The remainder of the SVE state follows struct user_sve_header.  The
+ * total size of the SVE state (including header) depends on the
+ * metadata in the header:  SVE_PT_SIZE(vq, flags) gives the total size
+ * of the state in bytes, including the header.
+ *
+ * Refer to <asm/sigcontext.h> for details of how to pass the correct
+ * "vq" argument to these macros.
+ */
+
+/* Offset from the start of struct user_sve_header to the register data */
+#define SVE_PT_REGS_OFFSET	((sizeof(struct sve_context) + 15) / 16 * 16)
+
+/*
+ * The register data content and layout depends on the value of the
+ * flags field.
+ */
+
+/*
+ * (flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD case:
+ *
+ * The payload starts at offset SVE_PT_FPSIMD_OFFSET, and is of type
+ * struct user_fpsimd_state.  Additional data might be appended in the
+ * future: use SVE_PT_FPSIMD_SIZE(vq, flags) to compute the total size.
+ * SVE_PT_FPSIMD_SIZE(vq, flags) will never be less than
+ * sizeof(struct user_fpsimd_state).
+ */
+
+#define SVE_PT_FPSIMD_OFFSET		SVE_PT_REGS_OFFSET
+
+#define SVE_PT_FPSIMD_SIZE(vq, flags)	(sizeof(struct user_fpsimd_state))
+
+/*
+ * (flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE case:
+ *
+ * The payload starts at offset SVE_PT_SVE_OFFSET, and is of size
+ * SVE_PT_SVE_SIZE(vq, flags).
+ *
+ * Additional macros describe the contents and layout of the payload.
+ * For each, SVE_PT_SVE_x_OFFSET(args) is the start offset relative to
+ * the start of struct user_sve_header, and SVE_PT_SVE_x_SIZE(args) is
+ * the size in bytes:
+ *
+ *	x	type				description
+ *	-	----				-----------
+ *	ZREGS		\
+ *	ZREG		|
+ *	PREGS		| refer to <asm/sigcontext.h>
+ *	PREG		|
+ *	FFR		/
+ *
+ *	FPSR	uint32_t			FPSR
+ *	FPCR	uint32_t			FPCR
+ *
+ * Additional data might be appended in the future.
+ */
+
+#define SVE_PT_SVE_ZREG_SIZE(vq)	SVE_SIG_ZREG_SIZE(vq)
+#define SVE_PT_SVE_PREG_SIZE(vq)	SVE_SIG_PREG_SIZE(vq)
+#define SVE_PT_SVE_FFR_SIZE(vq)		SVE_SIG_FFR_SIZE(vq)
+#define SVE_PT_SVE_FPSR_SIZE		sizeof(__u32)
+#define SVE_PT_SVE_FPCR_SIZE		sizeof(__u32)
+
+#define __SVE_SIG_TO_PT(offset) \
+	((offset) - SVE_SIG_REGS_OFFSET + SVE_PT_REGS_OFFSET)
+
+#define SVE_PT_SVE_OFFSET		SVE_PT_REGS_OFFSET
+
+#define SVE_PT_SVE_ZREGS_OFFSET \
+	__SVE_SIG_TO_PT(SVE_SIG_ZREGS_OFFSET)
+#define SVE_PT_SVE_ZREG_OFFSET(vq, n) \
+	__SVE_SIG_TO_PT(SVE_SIG_ZREG_OFFSET(vq, n))
+#define SVE_PT_SVE_ZREGS_SIZE(vq) \
+	(SVE_PT_SVE_ZREG_OFFSET(vq, SVE_NUM_ZREGS) - SVE_PT_SVE_ZREGS_OFFSET)
+
+#define SVE_PT_SVE_PREGS_OFFSET(vq) \
+	__SVE_SIG_TO_PT(SVE_SIG_PREGS_OFFSET(vq))
+#define SVE_PT_SVE_PREG_OFFSET(vq, n) \
+	__SVE_SIG_TO_PT(SVE_SIG_PREG_OFFSET(vq, n))
+#define SVE_PT_SVE_PREGS_SIZE(vq) \
+	(SVE_PT_SVE_PREG_OFFSET(vq, SVE_NUM_PREGS) - \
+		SVE_PT_SVE_PREGS_OFFSET(vq))
+
+#define SVE_PT_SVE_FFR_OFFSET(vq) \
+	__SVE_SIG_TO_PT(SVE_SIG_FFR_OFFSET(vq))
+
+#define SVE_PT_SVE_FPSR_OFFSET(vq) \
+	((SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq) + 15) / 16 * 16)
+#define SVE_PT_SVE_FPCR_OFFSET(vq) \
+	(SVE_PT_SVE_FPSR_OFFSET(vq) + SVE_PT_SVE_FPSR_SIZE)
+
+/*
+ * Any future extension appended after FPCR must be aligned to the next
+ * 128-bit boundary.
+ */
+
+#define SVE_PT_SVE_SIZE(vq, flags)				\
+	((SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE -	\
+		SVE_PT_SVE_OFFSET + 15) / 16 * 16)
+
+#define SVE_PT_SIZE(vq, flags)						\
+	 (((flags) & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE ?		\
+		  SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, flags)	\
+		: SVE_PT_FPSIMD_OFFSET + SVE_PT_FPSIMD_SIZE(vq, flags))
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 11c915d..91e55de 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -16,6 +16,8 @@
 #ifndef _UAPI__ASM_SIGCONTEXT_H
 #define _UAPI__ASM_SIGCONTEXT_H
 
+#ifndef __ASSEMBLY__
+
 #include <linux/types.h>
 
 /*
@@ -96,6 +98,8 @@ struct sve_context {
 	__u16 __reserved[3];
 };
 
+#endif /* !__ASSEMBLY__ */
+
 /*
  * The SVE architecture leaves space for future expansion of the
  * vector length beyond its initial architectural limit of 2048 bits
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4e2d796..ee59325 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -153,6 +153,44 @@ static void sve_to_fpsimd(struct task_struct *task)
 	__sve_to_fpsimd(task, sve_vq_from_vl(vl));
 }
 
+void fpsimd_sync_to_sve(struct task_struct *task)
+{
+	if (!test_tsk_thread_flag(task, TIF_SVE))
+		fpsimd_to_sve(task);
+}
+
+void sve_sync_to_fpsimd(struct task_struct *task)
+{
+	if (test_tsk_thread_flag(task, TIF_SVE))
+		sve_to_fpsimd(task);
+}
+
+static void __sve_sync_from_fpsimd_zeropad(struct task_struct *task,
+					   unsigned int vq)
+{
+	struct sve_struct fpsimd_sve_state(vq) *sst = __sve_state(task);
+	struct fpsimd_state *fst = &task->thread.fpsimd_state;
+	unsigned int i;
+
+	BUG_ON(!test_tsk_thread_flag(task, TIF_SVE));
+
+	memset(sst->zregs, 0, sizeof(sst->zregs));
+
+	for (i = 0; i < 32; ++i)
+		sst->zregs[i][0] = fst->vregs[i];
+}
+
+void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
+{
+	unsigned int vl;
+
+	if (!test_tsk_thread_flag(task, TIF_SVE))
+		return;
+
+	vl = sve_get_vl();
+	__sve_sync_from_fpsimd_zeropad(task, sve_vq_from_vl(vl));
+}
+
 void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
 	BUG_ON(is_compat_task());
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c142459..3e97e16 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -31,7 +31,9 @@
 #include <linux/seccomp.h>
 #include <linux/security.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/signal.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
@@ -617,29 +619,62 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 /*
  * TODO: update fp accessors for lazy context switching (sync/flush hwstate)
  */
-static int fpr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
+static int __fpr_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf, unsigned int start_pos)
 {
 	struct user_fpsimd_state *uregs;
+
+	sve_sync_to_fpsimd(target);
+
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs,
+				   start_pos, start_pos + sizeof(*uregs));
 }
 
-static int fpr_set(struct task_struct *target, const struct user_regset *regset,
+static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
+		   void *kbuf, void __user *ubuf)
+{
+	return __fpr_get(target, regset, pos, count, kbuf, ubuf, 0);
+}
+
+static int __fpr_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf,
+		     unsigned int start_pos)
 {
 	int ret;
 	struct user_fpsimd_state newstate =
 		target->thread.fpsimd_state.user_fpsimd;
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0, -1);
+	sve_sync_to_fpsimd(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate,
+				 start_pos, start_pos + sizeof(newstate));
 	if (ret)
 		return ret;
 
 	target->thread.fpsimd_state.user_fpsimd = newstate;
+
+	return ret;
+}
+
+static int fpr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = __fpr_set(target, regset, pos, count, kbuf, ubuf, 0);
+	if (ret)
+		return ret;
+
+	sve_sync_from_fpsimd_zeropad(target);
 	fpsimd_flush_task_state(target);
+
 	return ret;
 }
 
@@ -693,6 +728,196 @@ static int system_call_set(struct task_struct *target,
 	return ret;
 }
 
+#ifdef CONFIG_ARM64_SVE
+
+static int sve_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
+{
+	int ret;
+	struct user_sve_header header;
+	unsigned int vq;
+	unsigned long start, end;
+
+	if (!(elf_hwcap & HWCAP_SVE))
+		return -EINVAL;
+
+	/* Header */
+	memset(&header, 0, sizeof(header));
+
+	header.vl = sve_get_vl();
+
+	BUG_ON(!sve_vl_valid(header.vl));
+	vq = sve_vq_from_vl(header.vl);
+
+	/* Until runtime or per-task vector length changing is supported: */
+	header.max_vl = header.vl;
+
+	header.flags = test_tsk_thread_flag(target, TIF_SVE) ?
+		SVE_PT_REGS_SVE : SVE_PT_REGS_FPSIMD;
+
+	header.size = SVE_PT_SIZE(vq, header.flags);
+	header.max_size = SVE_PT_SIZE(vq, SVE_PT_REGS_SVE);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &header,
+				  0, sizeof(header));
+	if (ret)
+		return ret;
+
+	/* Registers: FPSIMD-only case */
+
+	BUILD_BUG_ON(SVE_PT_FPSIMD_OFFSET != sizeof(header));
+
+	if ((header.flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD)
+		return __fpr_get(target, regset, pos, count, kbuf, ubuf,
+				 SVE_PT_FPSIMD_OFFSET);
+
+	/* Otherwise: full SVE case */
+
+	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
+
+	start = SVE_PT_SVE_OFFSET;
+	end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
+
+	BUG_ON((char *)__sve_state(target) < (char *)target);
+	BUG_ON(end < start);
+	BUG_ON(arch_task_struct_size < end - start);
+	BUG_ON((char *)__sve_state(target) - (char *)target >
+	       arch_task_struct_size - (end - start));
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  __sve_state(target),
+				  start, end);
+	if (ret)
+		return ret;
+
+	start = end;
+	end = SVE_PT_SVE_FPSR_OFFSET(vq);
+
+	BUG_ON(end < start);
+	ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+				       start, end);
+	if (ret)
+		return ret;
+
+	start = end;
+	end = SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE;
+
+	BUG_ON((char *)(&target->thread.fpsimd_state.fpcr + 1) <
+	       (char *)&target->thread.fpsimd_state.fpsr);
+	BUG_ON(end < start);
+	BUG_ON((char *)(&target->thread.fpsimd_state.fpcr + 1) -
+	       (char *)&target->thread.fpsimd_state.fpsr !=
+		end - start);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpsimd_state.fpsr,
+				  start, end);
+	if (ret)
+		return ret;
+
+	start = end;
+	end = (SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE) + 15) / 16 * 16;
+	BUG_ON(end < start);
+
+	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+					start, end);
+}
+
+static int sve_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct user_sve_header header;
+	unsigned int vq;
+	unsigned long start, end;
+
+	if (!(elf_hwcap & HWCAP_SVE))
+		return -EINVAL;
+
+	/* Header */
+	if (count < sizeof(header))
+		return -EINVAL;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &header,
+				 0, sizeof(header));
+	if (ret)
+		goto out;
+
+	if (header.vl != sve_get_vl())
+		return -EINVAL;
+
+	BUG_ON(!sve_vl_valid(header.vl));
+	vq = sve_vq_from_vl(header.vl);
+
+	if (header.flags & ~SVE_PT_REGS_MASK)
+		return -EINVAL;
+
+	/* Registers: FPSIMD-only case */
+
+	BUILD_BUG_ON(SVE_PT_FPSIMD_OFFSET != sizeof(header));
+
+	if ((header.flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD) {
+		sve_sync_to_fpsimd(target);
+
+		ret = __fpr_set(target, regset, pos, count, kbuf, ubuf,
+				SVE_PT_FPSIMD_OFFSET);
+		clear_tsk_thread_flag(target, TIF_SVE);
+		goto out;
+	}
+
+	/* Otherwise: full SVE case */
+
+	fpsimd_sync_to_sve(target);
+	set_tsk_thread_flag(target, TIF_SVE);
+
+	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
+
+	start = SVE_PT_SVE_OFFSET;
+	end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
+
+	BUG_ON((char *)__sve_state(target) < (char *)target);
+	BUG_ON(end < start);
+	BUG_ON(arch_task_struct_size < end - start);
+	BUG_ON((char *)__sve_state(target) - (char *)target >
+	       arch_task_struct_size - (end - start));
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 __sve_state(target),
+				 start, end);
+	if (ret)
+		goto out;
+
+	start = end;
+	end = SVE_PT_SVE_FPSR_OFFSET(vq);
+
+	BUG_ON(end < start);
+	ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+					start, end);
+	if (ret)
+		goto out;
+
+	start = end;
+	end = SVE_PT_SVE_FPCR_OFFSET(vq) + SVE_PT_SVE_FPCR_SIZE;
+
+	BUG_ON((char *)(&target->thread.fpsimd_state.fpcr + 1) <
+		(char *)&target->thread.fpsimd_state.fpsr);
+	BUG_ON(end < start);
+	BUG_ON((char *)(&target->thread.fpsimd_state.fpcr + 1) -
+	       (char *)&target->thread.fpsimd_state.fpsr !=
+		end - start);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &target->thread.fpsimd_state.fpsr,
+				 start, end);
+
+out:
+	fpsimd_flush_task_state(target);
+	return ret;
+}
+
+#endif /* CONFIG_ARM64_SVE */
+
 enum aarch64_regset {
 	REGSET_GPR,
 	REGSET_FPR,
@@ -702,6 +927,9 @@ enum aarch64_regset {
 	REGSET_HW_WATCH,
 #endif
 	REGSET_SYSTEM_CALL,
+#ifdef CONFIG_ARM64_SVE
+	REGSET_SVE,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -759,6 +987,16 @@ static const struct user_regset aarch64_regsets[] = {
 		.get = system_call_get,
 		.set = system_call_set,
 	},
+#ifdef CONFIG_ARM64_SVE
+	[REGSET_SVE] = { /* Scalable Vector Extension */
+		.core_note_type = NT_ARM_SVE,
+		.n = (SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE) + 15) / 16,
+		.size = 16,
+		.align = 16,
+		.get = sve_get,
+		.set = sve_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_aarch64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b59ee07..23c6585 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -414,6 +414,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
 #define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+#define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
 #define NT_METAG_CBUF	0x500		/* Metag catch buffer registers */
 #define NT_METAG_RPIPE	0x501		/* Metag read pipeline state */
 #define NT_METAG_TLS	0x502		/* Metag TLS pointer */
-- 
2.1.4

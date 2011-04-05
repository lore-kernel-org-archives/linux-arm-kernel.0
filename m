From: dave.martin@linaro.org (Dave Martin)
Date: Tue,  5 Apr 2011 09:59:34 +0100
Subject: [PATCH v4 2/2] ARM: ptrace: Migrate to regsets framework
In-Reply-To: <1301993974-2421-1-git-send-email-dave.martin@linaro.org>
References: <1301993974-2421-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1301993974-2421-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch migrates the implementation of the ptrace interface for
the core integer registers, legacy FPA registers and VFP registers
to use the regsets framework.

As an added bonus, all this stuff gets included in coredumps
at no extra cost.  Without this patch, coredumps contained no
VFP state.

Third-party extension register sets (iwmmx, crunch) are not migrated
by this patch, and continue to use the old implementation;
these should be migratable without much extra work.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Will Deacon <Will.Deacon@arm.com>
---
 arch/arm/include/asm/elf.h    |    1 +
 arch/arm/include/asm/ptrace.h |    6 +
 arch/arm/kernel/ptrace.c      |  348 ++++++++++++++++++++++++++++-------------
 3 files changed, 246 insertions(+), 109 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index c3cd875..0e9ce8d 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -108,6 +108,7 @@ struct task_struct;
 int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 #define ELF_CORE_COPY_TASK_REGS dump_task_regs
 
+#define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	4096
 
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index a8ff22b..312d108 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -128,6 +128,12 @@ struct pt_regs {
 #define ARM_r0		uregs[0]
 #define ARM_ORIG_r0	uregs[17]
 
+/*
+ * The size of the user-visible VFP state as seen by PTRACE_GET/SETVFPREGS
+ * and core dumps.
+ */
+#define ARM_VFPREGS_SIZE ( 32 * 8 /*fpregs*/ + 4 /*fpscr*/ )
+
 #ifdef __KERNEL__
 
 #define user_mode(regs)	\
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2bf27f3..4d79f49 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/regset.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -308,58 +309,6 @@ static int ptrace_write_user(struct task_struct *tsk, unsigned long off,
 	return put_user_reg(tsk, off >> 2, val);
 }
 
-/*
- * Get all user integer registers.
- */
-static int ptrace_getregs(struct task_struct *tsk, void __user *uregs)
-{
-	struct pt_regs *regs = task_pt_regs(tsk);
-
-	return copy_to_user(uregs, regs, sizeof(struct pt_regs)) ? -EFAULT : 0;
-}
-
-/*
- * Set all user integer registers.
- */
-static int ptrace_setregs(struct task_struct *tsk, void __user *uregs)
-{
-	struct pt_regs newregs;
-	int ret;
-
-	ret = -EFAULT;
-	if (copy_from_user(&newregs, uregs, sizeof(struct pt_regs)) == 0) {
-		struct pt_regs *regs = task_pt_regs(tsk);
-
-		ret = -EINVAL;
-		if (valid_user_regs(&newregs)) {
-			*regs = newregs;
-			ret = 0;
-		}
-	}
-
-	return ret;
-}
-
-/*
- * Get the child FPU state.
- */
-static int ptrace_getfpregs(struct task_struct *tsk, void __user *ufp)
-{
-	return copy_to_user(ufp, &task_thread_info(tsk)->fpstate,
-			    sizeof(struct user_fp)) ? -EFAULT : 0;
-}
-
-/*
- * Set the child FPU state.
- */
-static int ptrace_setfpregs(struct task_struct *tsk, void __user *ufp)
-{
-	struct thread_info *thread = task_thread_info(tsk);
-	thread->used_cp[1] = thread->used_cp[2] = 1;
-	return copy_from_user(&thread->fpstate, ufp,
-			      sizeof(struct user_fp)) ? -EFAULT : 0;
-}
-
 #ifdef CONFIG_IWMMXT
 
 /*
@@ -418,56 +367,6 @@ static int ptrace_setcrunchregs(struct task_struct *tsk, void __user *ufp)
 }
 #endif
 
-#ifdef CONFIG_VFP
-/*
- * Get the child VFP state.
- */
-static int ptrace_getvfpregs(struct task_struct *tsk, void __user *data)
-{
-	struct thread_info *thread = task_thread_info(tsk);
-	union vfp_state *vfp = &thread->vfpstate;
-	struct user_vfp __user *ufp = data;
-
-	vfp_sync_hwstate(thread);
-
-	/* copy the floating point registers */
-	if (copy_to_user(&ufp->fpregs, &vfp->hard.fpregs,
-			 sizeof(vfp->hard.fpregs)))
-		return -EFAULT;
-
-	/* copy the status and control register */
-	if (put_user(vfp->hard.fpscr, &ufp->fpscr))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
- * Set the child VFP state.
- */
-static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
-{
-	struct thread_info *thread = task_thread_info(tsk);
-	union vfp_state *vfp = &thread->vfpstate;
-	struct user_vfp __user *ufp = data;
-
-	vfp_sync_hwstate(thread);
-
-	/* copy the floating point registers */
-	if (copy_from_user(&vfp->hard.fpregs, &ufp->fpregs,
-			   sizeof(vfp->hard.fpregs)))
-		return -EFAULT;
-
-	/* copy the status and control register */
-	if (get_user(vfp->hard.fpscr, &ufp->fpscr))
-		return -EFAULT;
-
-	vfp_flush_hwstate(thread);
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 /*
  * Convert a virtual register number into an index for a thread_info
@@ -694,6 +593,219 @@ out:
 }
 #endif
 
+/* regset get/set implementations */
+
+static int gpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	struct pt_regs *regs = task_pt_regs(target);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   regs,
+				   0, sizeof(*regs));
+}
+
+static int gpr_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct pt_regs newregs;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &newregs,
+				 0, sizeof(newregs));
+	if (ret)
+		return ret;
+
+	if (!valid_user_regs(&newregs))
+		return -EINVAL;
+
+	*task_pt_regs(target) = newregs;
+	return 0;
+}
+
+static int fpa_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &task_thread_info(target)->fpstate,
+				   0, sizeof(struct user_fp));
+}
+
+static int fpa_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	struct thread_info *thread = task_thread_info(target);
+
+	thread->used_cp[1] = thread->used_cp[2] = 1;
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+		&thread->fpstate,
+		0, sizeof(struct user_fp));
+}
+
+#ifdef CONFIG_VFP
+/*
+ * VFP register get/set implementations.
+ *
+ * With respect to the kernel, struct user_fp is divided into three chunks:
+ * 16 or 32 real VFP registers (d0-d15 or d0-31)
+ *	These are transferred to/from the real registers in the task's
+ *	vfp_hard_struct.  The number of registers depends on the kernel
+ *	configuration.
+ *
+ * 16 or 0 fake VFP registers (d16-d31 or empty)
+ *	i.e., the user_vfp structure has space for 32 registers even if
+ *	the kernel doesn't have them all.
+ *
+ *	vfp_get() reads this chunk as zero where applicable
+ *	vfp_set() ignores this chunk
+ *
+ * 1 word for the FPSCR
+ *
+ * The bounds-checking logic built into user_regset_copyout and friends
+ * means that we can make a simple sequence of calls to map the relevant data
+ * to/from the specified slice of the user regset structure.
+ */
+static int vfp_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	int ret;
+	struct thread_info *thread = task_thread_info(target);
+	struct vfp_hard_struct const *vfp = &thread->vfpstate.hard;
+	const size_t user_fpregs_offset = offsetof(struct user_vfp, fpregs);
+	const size_t user_fpscr_offset = offsetof(struct user_vfp, fpscr);
+
+	vfp_sync_hwstate(thread);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &vfp->fpregs,
+				  user_fpregs_offset,
+				  user_fpregs_offset + sizeof(vfp->fpregs));
+	if (ret)
+		return ret;
+
+	ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+				       user_fpregs_offset + sizeof(vfp->fpregs),
+				       user_fpscr_offset);
+	if (ret)
+		return ret;
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &vfp->fpscr,
+				   user_fpscr_offset,
+				   user_fpscr_offset + sizeof(vfp->fpscr));
+}
+
+/*
+ * For vfp_set() a read-modify-write is done on the VFP registers,
+ * in order to avoid writing back a half-modified set of registers on
+ * failure.
+ */
+static int vfp_set(struct task_struct *target,
+			  const struct user_regset *regset,
+			  unsigned int pos, unsigned int count,
+			  const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct thread_info *thread = task_thread_info(target);
+	struct vfp_hard_struct new_vfp = thread->vfpstate.hard;
+	const size_t user_fpregs_offset = offsetof(struct user_vfp, fpregs);
+	const size_t user_fpscr_offset = offsetof(struct user_vfp, fpscr);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &new_vfp.fpregs,
+				  user_fpregs_offset,
+				  user_fpregs_offset + sizeof(new_vfp.fpregs));
+	if (ret)
+		return ret;
+
+	ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+				user_fpregs_offset + sizeof(new_vfp.fpregs),
+				user_fpscr_offset);
+	if (ret)
+		return ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &new_vfp.fpscr,
+				 user_fpscr_offset,
+				 user_fpscr_offset + sizeof(new_vfp.fpscr));
+	if (ret)
+		return ret;
+
+	vfp_sync_hwstate(thread);
+	thread->vfpstate.hard = new_vfp;
+	vfp_flush_hwstate(thread);
+
+	return 0;
+}
+#endif /* CONFIG_VFP */
+
+enum arm_regset {
+	REGSET_GPR,
+	REGSET_FPR,
+#ifdef CONFIG_VFP
+	REGSET_VFP,
+#endif
+};
+
+static const struct user_regset arm_regsets[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = gpr_get,
+		.set = gpr_set
+	},
+	[REGSET_FPR] = {
+		/*
+		 * For the FPA regs in fpstate, the real fields are a mixture
+		 * of sizes, so pretend that the registers are word-sized:
+		 */
+		.core_note_type = NT_PRFPREG,
+		.n = sizeof(struct user_fp) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = fpa_get,
+		.set = fpa_set
+	},
+#ifdef CONFIG_VFP
+	[REGSET_VFP] = {
+		/*
+		 * Pretend that the VFP regs are word-sized, since the FPSCR is
+		 * a single word dangling at the end of struct user_vfp:
+		 */
+		.core_note_type = NT_ARM_VFP,
+		.n = ARM_VFPREGS_SIZE / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = vfp_get,
+		.set = vfp_set
+	},
+#endif /* CONFIG_VFP */
+};
+
+static const struct user_regset_view user_arm_view = {
+	.name = "arm", .e_machine = ELF_ARCH, .ei_osabi = ELF_OSABI,
+	.regsets = arm_regsets, .n = ARRAY_SIZE(arm_regsets)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_arm_view;
+}
+
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
@@ -710,19 +822,31 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 
 		case PTRACE_GETREGS:
-			ret = ptrace_getregs(child, datap);
+			ret = copy_regset_to_user(child,
+						  &user_arm_view, REGSET_GPR,
+						  0, sizeof(struct pt_regs),
+						  datap);
 			break;
 
 		case PTRACE_SETREGS:
-			ret = ptrace_setregs(child, datap);
+			ret = copy_regset_from_user(child,
+						    &user_arm_view, REGSET_GPR,
+						    0, sizeof(struct pt_regs),
+						    datap);
 			break;
 
 		case PTRACE_GETFPREGS:
-			ret = ptrace_getfpregs(child, datap);
+			ret = copy_regset_to_user(child,
+						  &user_arm_view, REGSET_FPR,
+						  0, sizeof(union fp_state),
+						  datap);
 			break;
-		
+
 		case PTRACE_SETFPREGS:
-			ret = ptrace_setfpregs(child, datap);
+			ret = copy_regset_from_user(child,
+						    &user_arm_view, REGSET_FPR,
+						    0, sizeof(union fp_state),
+						    datap);
 			break;
 
 #ifdef CONFIG_IWMMXT
@@ -757,11 +881,17 @@ long arch_ptrace(struct task_struct *child, long request,
 
 #ifdef CONFIG_VFP
 		case PTRACE_GETVFPREGS:
-			ret = ptrace_getvfpregs(child, datap);
+			ret = copy_regset_to_user(child,
+						  &user_arm_view, REGSET_VFP,
+						  0, ARM_VFPREGS_SIZE,
+						  datap);
 			break;
 
 		case PTRACE_SETVFPREGS:
-			ret = ptrace_setvfpregs(child, datap);
+			ret = copy_regset_from_user(child,
+						    &user_arm_view, REGSET_VFP,
+						    0, ARM_VFPREGS_SIZE,
+						    datap);
 			break;
 #endif
 
-- 
1.7.1

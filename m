From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:05 +0000
Subject: [RFC PATCH v2 35/41] arm64/sve: Add vector length inheritance control
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-36-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the vector length is inherited across both fork() and
exec().

Inheritance across fork() is desirable both for creating a copy of
a process (traditional fork) or creating a thread (where we want
all threads to share the same VL by default).

Inheritance across exec() is less desirable, because of the ABI
impact of large vector lengths on the size of the signal frame --
when running a new binary, there is no guarantee that the new
binary is compatible with these ABI changes.

This flag makes the vector length non-inherited by default.
Instead, the vector length is reset to a system default value,
unless the THREAD_VL_INHERIT flag has been set for the thread.

In order to permit clean launching of a new binary with a different
vector length, this patch also adds a prctl flag
PR_SVE_SET_VL_ONEXEC which causes the effect of the change to be
deferred until the calling thread's next exec.  This behaviour is
implemented by storing a shadow vector length in
thread_struct.sve_vl_onexec, which gets activated at exec.

Subsequent vl changes by the thread (if any) before the exec will
override such a pending change.

Without PR_SVE_SET_VL_ONEXEC, the effect of the change will be
immediate.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  8 +++++
 arch/arm64/kernel/fpsimd.c         | 61 ++++++++++++++++++++++++++++++--------
 include/uapi/linux/prctl.h         |  6 ++++
 3 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 896e972..424fa5d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -27,6 +27,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/prctl.h>
 #include <linux/string.h>
 
 #include <asm/alternative.h>
@@ -84,11 +85,18 @@ struct thread_struct {
 #endif
 	struct fpsimd_state	fpsimd_state;
 	u16			sve_vl;		/* SVE vector length */
+	u16			sve_vl_onexec;	/* SVE vl after next exec */
+	u16			sve_flags;	/* SVE related flags */
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
 };
 
+/* Flags for sve_flags (intentionally defined to match the prctl flags) */
+
+/* Inherit sve_vl and sve_flags across execve(): */
+#define THREAD_VL_INHERIT	PR_SVE_SET_VL_INHERIT
+
 #ifdef CONFIG_COMPAT
 #define task_user_tls(t)						\
 ({									\
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ab00e9f..982b1d7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -234,10 +234,11 @@ int sve_set_vector_length(struct task_struct *task,
 	 */
 	if (!(flags & PR_SVE_SET_VL_THREAD) && get_nr_threads(task) != 1)
 		return -EINVAL;
-
 	flags &= ~(unsigned long)PR_SVE_SET_VL_THREAD;
-	if (flags)
-		return -EINVAL; /* No other flags defined yet */
+
+	if (flags & ~(unsigned long)(PR_SVE_SET_VL_INHERIT |
+				     PR_SVE_SET_VL_ONEXEC))
+		return -EINVAL;
 
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
@@ -247,6 +248,17 @@ int sve_set_vector_length(struct task_struct *task,
 		vl = sve_max_vl;
 	}
 
+	if (flags & (PR_SVE_SET_VL_ONEXEC |
+		     PR_SVE_SET_VL_INHERIT))
+		task->thread.sve_vl_onexec = vl;
+	else
+		/* Reset VL to system default on next exec: */
+		task->thread.sve_vl_onexec = 0;
+
+	/* Only actually set the VL if not deferred: */
+	if (flags & PR_SVE_SET_VL_ONEXEC)
+		goto out;
+
 	/*
 	 * To ensure the FPSIMD bits of the SVE vector registers are preserved,
 	 * write any live register state back to task_struct, and convert to a
@@ -272,9 +284,26 @@ int sve_set_vector_length(struct task_struct *task,
 
 	fpsimd_flush_task_state(task);
 
+out:
+	/* The THREAD_VL_* flag encodings match the relevant PR_* flags: */
+	task->thread.sve_flags = flags & PR_SVE_SET_VL_INHERIT;
+
 	return 0;
 }
 
+/*
+ * Encode the current vector length and flags for return.
+ * This is only required for prctl(): ptrace has separate fields
+ */
+static int sve_prctl_status(struct task_struct const *task)
+{
+	int ret = task->thread.sve_vl;
+
+	ret |= task->thread.sve_flags << 16;
+
+	return ret;
+}
+
 /* PR_SVE_SET_VL */
 int sve_set_task_vl(struct task_struct *task,
 		    unsigned long vector_length, unsigned long flags)
@@ -293,7 +322,7 @@ int sve_set_task_vl(struct task_struct *task,
 	if (ret)
 		return ret;
 
-	return task->thread.sve_vl;
+	return sve_prctl_status(task);
 }
 
 /* PR_SVE_GET_VL */
@@ -302,7 +331,7 @@ int sve_get_task_vl(struct task_struct *task)
 	if (!(elf_hwcap & HWCAP_SVE))
 		return -EINVAL;
 
-	return task->thread.sve_vl;
+	return sve_prctl_status(task);
 }
 
 #else /* ! CONFIG_ARM64_SVE */
@@ -459,17 +488,25 @@ void fpsimd_flush_thread(void)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
 		clear_sve_regs(current);
 
+		current->thread.sve_vl = current->thread.sve_vl_onexec ?
+			current->thread.sve_vl_onexec : sve_max_vl;
+
 		/*
 		 * User tasks must have a valid vector length set, but tasks
-		 * forked early (e.g., init) may not have one yet.
-		 * By now, we will know what the hardware supports, so set the
-		 * task vector length if it doesn't have one:
+		 * forked early (e.g., init) may not initially have one.
+		 * By now, we will know what the hardware supports, so
+		 * sve_max_vl should be valid, and thus the above
+		 * assignment should ensure a valid VL for the task.
+		 * If not, something went badly wrong.
 		 */
-		if (!current->thread.sve_vl) {
-			BUG_ON(!sve_vl_valid(sve_max_vl));
+		BUG_ON(!sve_vl_valid(current->thread.sve_vl));
 
-			current->thread.sve_vl = sve_max_vl;
-		}
+		/*
+		 * If the task is not set to inherit, ensure that the vector
+		 * length will be reset by a subsequent exec:
+		 */
+		if (!(current->thread.sve_flags & THREAD_VL_INHERIT))
+			current->thread.sve_vl_onexec = 0;
 	}
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c55530b..d56c447 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -200,6 +200,12 @@ struct prctl_mm_map {
 /* arm64 Scalable Vector Extension controls */
 #define PR_SVE_SET_VL			48	/* set task vector length */
 # define PR_SVE_SET_VL_THREAD		(1 << 1) /* set just this thread */
+# define PR_SVE_SET_VL_INHERIT		(1 << 2) /* inherit across exec */
+# define PR_SVE_SET_VL_ONEXEC		(1 << 3) /* defer effect until exec */
 #define PR_SVE_GET_VL			49	/* get task vector length */
+/* Decode helpers for the return value from PR_SVE_GET_VL: */
+# define PR_SVE_GET_VL_LEN(ret)		((ret) & 0x3fff) /* vector length */
+# define PR_SVE_GET_VL_INHERIT		(PR_SVE_SET_VL_INHERIT << 16)
+/* For conveinence, PR_SVE_SET_VL returns the result in the same encoding */
 
 #endif /* _LINUX_PRCTL_H */
-- 
2.1.4

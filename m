From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:59 +0000
Subject: [RFC PATCH v2 29/41] prctl: Add skeleton for PR_SVE_{SET,
 GET}_VL controls
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-30-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a do-nothing skeleton for the arm64 Scalable Vector
Extension control prctls.

These prctls are only avilable with

    CONFIG_ARM64=y
    CONFIG_ARM64_SVE=y

Otherwise they will compile out and return -EINVAL if attempted
from userspace.

The backend functions sve_{set,get}_task_vl() will be fleshed out
with actual functionality in subsequent patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h    | 16 ++++++++++++++++
 arch/arm64/include/asm/processor.h |  4 ++++
 arch/arm64/kernel/fpsimd.c         | 13 +++++++++++++
 include/uapi/linux/prctl.h         |  4 ++++
 kernel/sys.c                       | 12 ++++++++++++
 5 files changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 71b94ee..7dba890 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -17,6 +17,7 @@
 #define __ASM_FP_H
 
 #include <asm/ptrace.h>
+#include <asm/errno.h>
 
 #ifndef __ASSEMBLY__
 
@@ -107,12 +108,27 @@ extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
 extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
 
+extern int sve_set_task_vl(struct task_struct *task,
+			   unsigned long vector_length, unsigned long flags);
+extern int sve_get_task_vl(struct task_struct *task);
+
 #else /* ! CONFIG_ARM64_SVE */
 
 static void __maybe_unused sve_sync_to_fpsimd(struct task_struct *task) { }
 static void __maybe_unused sve_sync_from_fpsimd_zeropad(
 	struct task_struct *task) { }
 
+static int __maybe_unused sve_set_task_vl(struct task_struct *task,
+	unsigned long vector_length, unsigned long flags)
+{
+	return -EINVAL;
+}
+
+static int __maybe_unused sve_get_task_vl(struct task_struct *task)
+{
+	return -EINVAL;
+}
+
 #endif /* ! CONFIG_ARM64_SVE */
 
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index c97b8bd..865c279 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -189,4 +189,8 @@ static inline void spin_lock_prefetch(const void *ptr)
 int cpu_enable_pan(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
+#define SVE_SET_VL(task, vector_length, flags) \
+	sve_set_task_vl(task, vector_length, flags)
+#define SVE_GET_VL(task) sve_get_task_vl(task)
+
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ee59325..4102d13 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -204,6 +204,19 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	task_fpsimd_load(current);
 }
 
+/* PR_SVE_SET_VL */
+int sve_set_task_vl(struct task_struct *task,
+		    unsigned long vector_length, unsigned long flags)
+{
+	return -EINVAL;
+}
+
+/* PR_SVE_GET_VL */
+int sve_get_task_vl(struct task_struct *task)
+{
+	return -EINVAL;
+}
+
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a8d0759..e32e2da 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -197,4 +197,8 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/* arm64 Scalable Vector Extension controls */
+#define PR_SVE_SET_VL			48	/* set task vector length */
+#define PR_SVE_GET_VL			49	/* get task vector length */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 7ff6d1b..ea5d37e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -110,6 +110,12 @@
 #ifndef SET_FP_MODE
 # define SET_FP_MODE(a,b)	(-EINVAL)
 #endif
+#ifndef SVE_SET_VL
+# define SVE_SET_VL(a,b,c)	(-EINVAL)
+#endif
+#ifndef SVE_GET_VL
+# define SVE_GET_VL(a)		(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2290,6 +2296,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
+	case PR_SVE_SET_VL:
+		error = SVE_SET_VL(me, arg2, arg3);
+		break;
+	case PR_SVE_GET_VL:
+		error = SVE_GET_VL(me);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.1.4

From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2012 15:07:11 +0000
Subject: [PATCH v4 1/2] ARM: vfp: move user vfp state save/restore code out of
 signal.c
Message-ID: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The user VFP state must be preserved (subject to ucontext modifications)
across invocation of a signal handler and this is currently handled by
vfp_{preserve,restore}_context in signal.c

Since this code requires intimate low-level knowledge of the VFP state,
this patch moves it into vfpmodule.c.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v4: minor naming changes to appease Dave's dislike of the old ones.

 arch/arm/include/asm/thread_info.h |    7 +++
 arch/arm/kernel/signal.c           |   57 ++-----------------------
 arch/arm/vfp/vfpmodule.c           |   79 ++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index d4c24d4..0f04d84 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -118,6 +118,13 @@ extern void iwmmxt_task_switch(struct thread_info *);
 extern void vfp_sync_hwstate(struct thread_info *);
 extern void vfp_flush_hwstate(struct thread_info *);
 
+struct user_vfp;
+struct user_vfp_exc;
+
+extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
+					   struct user_vfp_exc __user *);
+extern int vfp_restore_user_hwstate(struct user_vfp __user *,
+				    struct user_vfp_exc __user *);
 #endif
 
 /*
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 9e617bd..b02ce1d 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -179,44 +179,23 @@ static int restore_iwmmxt_context(struct iwmmxt_sigframe *frame)
 
 static int preserve_vfp_context(struct vfp_sigframe __user *frame)
 {
-	struct thread_info *thread = current_thread_info();
-	struct vfp_hard_struct *h = &thread->vfpstate.hard;
 	const unsigned long magic = VFP_MAGIC;
 	const unsigned long size = VFP_STORAGE_SIZE;
 	int err = 0;
 
-	vfp_sync_hwstate(thread);
 	__put_user_error(magic, &frame->magic, err);
 	__put_user_error(size, &frame->size, err);
 
-	/*
-	 * Copy the floating point registers. There can be unused
-	 * registers see asm/hwcap.h for details.
-	 */
-	err |= __copy_to_user(&frame->ufp.fpregs, &h->fpregs,
-			      sizeof(h->fpregs));
-	/*
-	 * Copy the status and control register.
-	 */
-	__put_user_error(h->fpscr, &frame->ufp.fpscr, err);
-
-	/*
-	 * Copy the exception registers.
-	 */
-	__put_user_error(h->fpexc, &frame->ufp_exc.fpexc, err);
-	__put_user_error(h->fpinst, &frame->ufp_exc.fpinst, err);
-	__put_user_error(h->fpinst2, &frame->ufp_exc.fpinst2, err);
+	if (err)
+		return -EFAULT;
 
-	return err ? -EFAULT : 0;
+	return vfp_preserve_user_clear_hwstate(&frame->ufp, &frame->ufp_exc);
 }
 
 static int restore_vfp_context(struct vfp_sigframe __user *frame)
 {
-	struct thread_info *thread = current_thread_info();
-	struct vfp_hard_struct *h = &thread->vfpstate.hard;
 	unsigned long magic;
 	unsigned long size;
-	unsigned long fpexc;
 	int err = 0;
 
 	__get_user_error(magic, &frame->magic, err);
@@ -227,33 +206,7 @@ static int restore_vfp_context(struct vfp_sigframe __user *frame)
 	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
-	vfp_flush_hwstate(thread);
-
-	/*
-	 * Copy the floating point registers. There can be unused
-	 * registers see asm/hwcap.h for details.
-	 */
-	err |= __copy_from_user(&h->fpregs, &frame->ufp.fpregs,
-				sizeof(h->fpregs));
-	/*
-	 * Copy the status and control register.
-	 */
-	__get_user_error(h->fpscr, &frame->ufp.fpscr, err);
-
-	/*
-	 * Sanitise and restore the exception registers.
-	 */
-	__get_user_error(fpexc, &frame->ufp_exc.fpexc, err);
-	/* Ensure the VFP is enabled. */
-	fpexc |= FPEXC_EN;
-	/* Ensure FPINST2 is invalid and the exception flag is cleared. */
-	fpexc &= ~(FPEXC_EX | FPEXC_FP2V);
-	h->fpexc = fpexc;
-
-	__get_user_error(h->fpinst, &frame->ufp_exc.fpinst, err);
-	__get_user_error(h->fpinst2, &frame->ufp_exc.fpinst2, err);
-
-	return err ? -EFAULT : 0;
+	return vfp_restore_user_hwstate(&frame->ufp, &frame->ufp_exc);
 }
 
 #endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8f3ccdd..1dfe7d8 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -17,6 +17,8 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/uaccess.h>
+#include <linux/user.h>
 
 #include <asm/cputype.h>
 #include <asm/thread_notify.h>
@@ -527,6 +529,83 @@ void vfp_flush_hwstate(struct thread_info *thread)
 }
 
 /*
+ * Save the current VFP state into the provided structures and prepare
+ * for entry into a new function (signal handler).
+ */
+int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
+				    struct user_vfp_exc __user *ufp_exc)
+{
+	struct thread_info *thread = current_thread_info();
+	struct vfp_hard_struct *hwstate = &thread->vfpstate.hard;
+	int err = 0;
+
+	/* Ensure that the saved hwstate is up-to-date. */
+	vfp_sync_hwstate(thread);
+
+	/*
+	 * Copy the floating point registers. There can be unused
+	 * registers see asm/hwcap.h for details.
+	 */
+	err |= __copy_to_user(&ufp->fpregs, &hwstate->fpregs,
+			      sizeof(hwstate->fpregs));
+	/*
+	 * Copy the status and control register.
+	 */
+	__put_user_error(hwstate->fpscr, &ufp->fpscr, err);
+
+	/*
+	 * Copy the exception registers.
+	 */
+	__put_user_error(hwstate->fpexc, &ufp_exc->fpexc, err);
+	__put_user_error(hwstate->fpinst, &ufp_exc->fpinst, err);
+	__put_user_error(hwstate->fpinst2, &ufp_exc->fpinst2, err);
+
+	if (err)
+		return -EFAULT;
+	return 0;
+}
+
+/* Sanitise and restore the current VFP state from the provided structures. */
+int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
+			     struct user_vfp_exc __user *ufp_exc)
+{
+	struct thread_info *thread = current_thread_info();
+	struct vfp_hard_struct *hwstate = &thread->vfpstate.hard;
+	unsigned long fpexc;
+	int err = 0;
+
+	vfp_flush_hwstate(thread);
+
+	/*
+	 * Copy the floating point registers. There can be unused
+	 * registers see asm/hwcap.h for details.
+	 */
+	err |= __copy_from_user(&hwstate->fpregs, &ufp->fpregs,
+				sizeof(hwstate->fpregs));
+	/*
+	 * Copy the status and control register.
+	 */
+	__get_user_error(hwstate->fpscr, &ufp->fpscr, err);
+
+	/*
+	 * Sanitise and restore the exception registers.
+	 */
+	__get_user_error(fpexc, &ufp_exc->fpexc, err);
+
+	/* Ensure the VFP is enabled. */
+	fpexc |= FPEXC_EN;
+
+	/* Ensure FPINST2 is invalid and the exception flag is cleared. */
+	fpexc &= ~(FPEXC_EX | FPEXC_FP2V);
+	hwstate->fpexc = fpexc;
+
+	__get_user_error(hwstate->fpinst, &ufp_exc->fpinst, err);
+	__get_user_error(hwstate->fpinst2, &ufp_exc->fpinst2, err);
+
+	return err ? -EFAULT : 0;
+}
+
+/*
  * VFP hardware can lose all context when a CPU goes offline.
  * As we will be running in SMP mode with CPU hotplug, we will save the
  * hardware state at every thread switch.  We clear our held state when
-- 
1.7.4.1

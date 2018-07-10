From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 15:13:52 +0100
Subject: [PATCH 2/6] ARM: vfp: use __copy_from_user() when restoring VFP state
In-Reply-To: <20180710141322.GL17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
Message-ID: <E1fctOq-0005us-Ar@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use __copy_from_user() rather than __get_user_err() for individual
members when restoring VFP state.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/thread_info.h |  2 +-
 arch/arm/kernel/signal.c           | 20 ++++++++------------
 arch/arm/vfp/vfpmodule.c           | 16 +++++++---------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index e71cc35de163..341f6eb9b8be 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -123,7 +123,7 @@ struct user_vfp_exc;
 
 extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
 					   struct user_vfp_exc __user *);
-extern int vfp_restore_user_hwstate(struct user_vfp __user *,
+extern int vfp_restore_user_hwstate(struct user_vfp *,
 				    struct user_vfp_exc __user *);
 #endif
 
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 0ae74207e43e..db62c51250ad 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -150,22 +150,18 @@ static int preserve_vfp_context(struct vfp_sigframe __user *frame)
 
 static int restore_vfp_context(char __user **auxp)
 {
-	struct vfp_sigframe __user *frame =
-		(struct vfp_sigframe __user *)*auxp;
-	unsigned long magic;
-	unsigned long size;
-	int err = 0;
-
-	__get_user_error(magic, &frame->magic, err);
-	__get_user_error(size, &frame->size, err);
+	struct vfp_sigframe frame;
+	int err;
 
+	err = __copy_from_user(&frame, *auxp, sizeof(frame));
 	if (err)
-		return -EFAULT;
-	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
+		return err;
+
+	if (frame.magic != VFP_MAGIC || frame.size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
-	*auxp += size;
-	return vfp_restore_user_hwstate(&frame->ufp, &frame->ufp_exc);
+	*auxp += sizeof(frame);
+	return vfp_restore_user_hwstate(&frame.ufp, &frame.ufp_exc);
 }
 
 #endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 4c375e11ae95..9929f79a9e87 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -597,13 +597,12 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
 }
 
 /* Sanitise and restore the current VFP state from the provided structures. */
-int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
+int vfp_restore_user_hwstate(struct user_vfp *ufp,
 			     struct user_vfp_exc __user *ufp_exc)
 {
 	struct thread_info *thread = current_thread_info();
 	struct vfp_hard_struct *hwstate = &thread->vfpstate.hard;
 	unsigned long fpexc;
-	int err = 0;
 
 	/* Disable VFP to avoid corrupting the new thread state. */
 	vfp_flush_hwstate(thread);
@@ -612,17 +611,16 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
 	 * Copy the floating point registers. There can be unused
 	 * registers see asm/hwcap.h for details.
 	 */
-	err |= __copy_from_user(&hwstate->fpregs, &ufp->fpregs,
-				sizeof(hwstate->fpregs));
+	memcpy(&hwstate->fpregs, &ufp->fpregs, sizeof(hwstate->fpregs));
 	/*
 	 * Copy the status and control register.
 	 */
-	__get_user_error(hwstate->fpscr, &ufp->fpscr, err);
+	hwstate->fpscr = ufp->fpscr;
 
 	/*
 	 * Sanitise and restore the exception registers.
 	 */
-	__get_user_error(fpexc, &ufp_exc->fpexc, err);
+	fpexc = ufp_exc->fpexc;
 
 	/* Ensure the VFP is enabled. */
 	fpexc |= FPEXC_EN;
@@ -631,10 +629,10 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
 	fpexc &= ~(FPEXC_EX | FPEXC_FP2V);
 	hwstate->fpexc = fpexc;
 
-	__get_user_error(hwstate->fpinst, &ufp_exc->fpinst, err);
-	__get_user_error(hwstate->fpinst2, &ufp_exc->fpinst2, err);
+	hwstate->fpinst = ufp_exc->fpinst;
+	hwstate->fpinst2 = ufp_exc->fpinst2;
 
-	return err ? -EFAULT : 0;
+	return 0;
 }
 
 /*
-- 
2.7.4

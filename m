From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 27 Jun 2017 18:04:07 +0100
Subject: [RFC PATCH v2 2/2] ARM: signal: Fix unparseable iwmmxt_sigframe in
 uc_regspace[]
In-Reply-To: <1498583067-14178-1-git-send-email-Dave.Martin@arm.com>
References: <1498583067-14178-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498583067-14178-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kernels with CONFIG_IWMMXT=y running on non-iWMMXt hardware, the
signal frame can be left partially uninitialised in such a way
that userspace cannot parse uc_regspace[] safely.  In particular,
this means that the VFP registers cannot be located reliably in the
signal frame when a multi_v7_defconfig kernel is run on the
majority of platforms.

The cause is that the uc_regspace[] is laid out statically based on
the kernel config, but the decision of whether to save/restore the
iWMMXt registers must be a runtime decision.

To minimise breakage of software that may assume a fixed layout,
this patch emits a dummy block of the same size as iwmmxt_sigframe,
for non-iWMMXt threads.  However, the magic and size of this block
are now filled in to help parsers skip over it.  A new DUMMY_MAGIC
is defined for this purpose.

It is probably legitimate (if non-portable) for userspace to
manufacture its own sigframe for sigreturn, and there is no obvious
reason why userspace should be required to insert a DUMMY_MAGIC
block when running on non-iWMMXt hardware, when omitting it has
worked just fine forever in other configurations.  So in this case,
sigreturn does not require this block to be present.

Reported-by: Edmund Grimley-Evans <Edmund.Grimley-Evans@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/ucontext.h |  6 ++++
 arch/arm/kernel/signal.c        | 77 ++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/ucontext.h b/arch/arm/include/asm/ucontext.h
index 14749ae..921d827 100644
--- a/arch/arm/include/asm/ucontext.h
+++ b/arch/arm/include/asm/ucontext.h
@@ -35,6 +35,12 @@ struct ucontext {
  * bytes, to prevent unpredictable padding in the signal frame.
  */
 
+/*
+ * Dummy padding block: if this magic is encountered, the block should
+ * be skipped using the corresponding size field.
+ */
+#define DUMMY_MAGIC		0xb0d9ed01
+
 #ifdef CONFIG_CRUNCH
 #define CRUNCH_MAGIC		0x5065cf03
 #define CRUNCH_STORAGE_SIZE	(CRUNCH_SIZE + 8)
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 8f06480..adf5adf 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -40,8 +40,10 @@ static int preserve_crunch_context(struct crunch_sigframe __user *frame)
 	return __copy_to_user(frame, kframe, sizeof(*frame));
 }
 
-static int restore_crunch_context(struct crunch_sigframe __user *frame)
+static int restore_crunch_context(char __user **auxp)
 {
+	struct crunch_sigframe __user *frame =
+		(struct crunch_sigframe __user *)*auxp;
 	char kbuf[sizeof(*frame) + 8];
 	struct crunch_sigframe *kframe;
 
@@ -52,6 +54,7 @@ static int restore_crunch_context(struct crunch_sigframe __user *frame)
 	if (kframe->magic != CRUNCH_MAGIC ||
 	    kframe->size != CRUNCH_STORAGE_SIZE)
 		return -1;
+	*auxp = CRUNCH_STORAGE_SIZE;
 	crunch_task_restore(current_thread_info(), &kframe->storage);
 	return 0;
 }
@@ -63,17 +66,36 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 {
 	char kbuf[sizeof(*frame) + 8];
 	struct iwmmxt_sigframe *kframe;
+	int err = 0;
 
 	/* the iWMMXt context must be 64 bit aligned */
 	kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
-	kframe->magic = IWMMXT_MAGIC;
-	kframe->size = IWMMXT_STORAGE_SIZE;
-	iwmmxt_task_copy(current_thread_info(), &kframe->storage);
-	return __copy_to_user(frame, kframe, sizeof(*frame));
+
+	if (test_thread_flag(TIF_USING_IWMMXT)) {
+		kframe->magic = IWMMXT_MAGIC;
+		iwmmxt_task_copy(current_thread_info(), &kframe->storage);
+		kframe->size = IWMMXT_STORAGE_SIZE;
+
+		err = __copy_to_user(frame, kframe, sizeof(*frame));
+	} else {
+		/*
+		 * For bug-compatibility with older kernels, some space
+		 * has to be reserved for iWMMXt even if it's not used.
+		 * Set the magic and size appropriately so that properly
+		 * written userspace can skip it reliably:
+		 */
+		__put_user_error(DUMMY_MAGIC, &frame->magic, err);
+		__put_user_error(IWMMXT_STORAGE_SIZE, &frame->size, err);
+	}
+
+	return err;
+
 }
 
-static int restore_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
+static int restore_iwmmxt_context(char __user **auxp)
 {
+	struct iwmmxt_sigframe __user *frame =
+		(struct iwmmxt_sigframe __user *)*auxp;
 	char kbuf[sizeof(*frame) + 8];
 	struct iwmmxt_sigframe *kframe;
 
@@ -81,10 +103,28 @@ static int restore_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 	kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
 	if (__copy_from_user(kframe, frame, sizeof(*frame)))
 		return -1;
-	if (kframe->magic != IWMMXT_MAGIC ||
-	    kframe->size != IWMMXT_STORAGE_SIZE)
+
+	/*
+	 * For non-iWMMXt threads: a single iwmmxt_sigframe-sized dummy
+	 * block is discarded for compatibility with setup_sigframe() if
+	 * present, but we don't mandate its presence.  If some other
+	 * magic is here, it's not for us:
+	 */
+	if (!test_thread_flag(TIF_USING_IWMMXT) &&
+	    kframe->magic != DUMMY_MAGIC)
+		return 0;
+
+	if (kframe->size != IWMMXT_STORAGE_SIZE)
 		return -1;
-	iwmmxt_task_restore(current_thread_info(), &kframe->storage);
+
+	if (test_thread_flag(TIF_USING_IWMMXT)) {
+		if (kframe->magic != IWMMXT_MAGIC)
+			return -1;
+
+		iwmmxt_task_restore(current_thread_info(), &kframe->storage);
+	}
+
+	*auxp += IWMMXT_STORAGE_SIZE;
 	return 0;
 }
 
@@ -107,8 +147,10 @@ static int preserve_vfp_context(struct vfp_sigframe __user *frame)
 	return vfp_preserve_user_clear_hwstate(&frame->ufp, &frame->ufp_exc);
 }
 
-static int restore_vfp_context(struct vfp_sigframe __user *frame)
+static int restore_vfp_context(char __user **auxp)
 {
+	struct vfp_sigframe __user *frame =
+		(struct vfp_sigframe __user *)*auxp;
 	unsigned long magic;
 	unsigned long size;
 	int err = 0;
@@ -121,6 +163,7 @@ static int restore_vfp_context(struct vfp_sigframe __user *frame)
 	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
+	*auxp += size;
 	return vfp_restore_user_hwstate(&frame->ufp, &frame->ufp_exc);
 }
 
@@ -141,7 +184,7 @@ struct rt_sigframe {
 
 static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 {
-	struct aux_sigframe __user *aux;
+	char __user *aux;
 	sigset_t set;
 	int err;
 
@@ -169,18 +212,18 @@ static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 
 	err |= !valid_user_regs(regs);
 
-	aux = (struct aux_sigframe __user *) sf->uc.uc_regspace;
+	aux = (char __user *) sf->uc.uc_regspace;
 #ifdef CONFIG_CRUNCH
 	if (err == 0)
-		err |= restore_crunch_context(&aux->crunch);
+		err |= restore_crunch_context(&aux);
 #endif
 #ifdef CONFIG_IWMMXT
-	if (err == 0 && test_thread_flag(TIF_USING_IWMMXT))
-		err |= restore_iwmmxt_context(&aux->iwmmxt);
+	if (err == 0)
+		err |= restore_iwmmxt_context(&aux);
 #endif
 #ifdef CONFIG_VFP
 	if (err == 0)
-		err |= restore_vfp_context(&aux->vfp);
+		err |= restore_vfp_context(&aux);
 #endif
 
 	return err;
@@ -286,7 +329,7 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 		err |= preserve_crunch_context(&aux->crunch);
 #endif
 #ifdef CONFIG_IWMMXT
-	if (err == 0 && test_thread_flag(TIF_USING_IWMMXT))
+	if (err == 0)
 		err |= preserve_iwmmxt_context(&aux->iwmmxt);
 #endif
 #ifdef CONFIG_VFP
-- 
2.1.4

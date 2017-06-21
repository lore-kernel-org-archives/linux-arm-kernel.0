From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Jun 2017 16:46:03 +0100
Subject: [RFC PATCH 2/2] ARM: signal: Remove unparseable iwmmxt_sigframe from
 uc_regspace[]
In-Reply-To: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498059983-13438-3-git-send-email-Dave.Martin@arm.com>
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
iWMMXt registers must be a runtime decision.  There is no obvious
way to pad the hole left when the iWMMXt registers are not saved,
because there is no dummy record type that we can rely on userspace
to ignore, and no clear semantics for what an iwmmxt_sigframe
record is supposed to mean if the hardware doesn't support iXMMXt.

One option would be to write the magic and size for
iwmmxt_sigframe, and leave the body uninitialised or fill it with
zeros or deadc0de.  But this may confuse userspace if it is taken
as evidence that iWMMXt is present.

However, there seems to be a clear design intention that the
records in uc_regspace[] be parsed as a tagged list, with the
parser sequentially examining the magic number in each record and
using the size field to step to the next record until a record with
null magic is found.

So, instead of placing each record at a fixed offset in
uc_regspace[], this patch only advances the offset for a record
that is actually populated.  Later records following an unpopulated
record will shift to lower offsets in uc_regspace[] as a result.

This change causes the fixed-layout definition of struct
aux_sigframe to become useless.  Since it is not present in a uapi
header, this patch simply removes the definition.

These changes are not expected to break ABI except for VFP-aware
software that has been explicitly hacked to work around this issue
on CONFIG_IWMMXT=y kernels, which is unlikely to be a common case
and would obviously violate the design intent of the arm signal
frame.

There is no clear solution that definitely does not break ABI.

Reported-by: Edmund Grimley-Evans <Edmund.Grimley-Evans@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/ucontext.h | 20 ----------------
 arch/arm/kernel/signal.c        | 52 +++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/ucontext.h b/arch/arm/include/asm/ucontext.h
index 14749ae..664b611 100644
--- a/arch/arm/include/asm/ucontext.h
+++ b/arch/arm/include/asm/ucontext.h
@@ -77,26 +77,6 @@ struct vfp_sigframe
 
 #endif /* CONFIG_VFP */
 
-/*
- * Auxiliary signal frame.  This saves stuff like FP state.
- * The layout of this structure is not part of the user ABI,
- * because the config options aren't.  uc_regspace is really
- * one of these.
- */
-struct aux_sigframe {
-#ifdef CONFIG_CRUNCH
-	struct crunch_sigframe	crunch;
-#endif
-#ifdef CONFIG_IWMMXT
-	struct iwmmxt_sigframe	iwmmxt;
-#endif
-#ifdef CONFIG_VFP
-	struct vfp_sigframe	vfp;
-#endif
-	/* Something that isn't a valid magic number for any coprocessor.  */
-	unsigned long		end_magic;
-} __attribute__((__aligned__(8)));
-
 #endif
 
 #endif /* !_ASMARM_UCONTEXT_H */
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 8f06480..024d9aa 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -27,8 +27,10 @@ extern const unsigned long sigreturn_codes[7];
 static unsigned long signal_return_offset;
 
 #ifdef CONFIG_CRUNCH
-static int preserve_crunch_context(struct crunch_sigframe __user *frame)
+static int preserve_crunch_context(char __user **auxp)
 {
+	struct crunch_sigframe __user *frame =
+		(struct crunch_sigframe __user *)*auxp;
 	char kbuf[sizeof(*frame) + 8];
 	struct crunch_sigframe *kframe;
 
@@ -36,12 +38,15 @@ static int preserve_crunch_context(struct crunch_sigframe __user *frame)
 	kframe = (struct crunch_sigframe *)((unsigned long)(kbuf + 8) & ~7);
 	kframe->magic = CRUNCH_MAGIC;
 	kframe->size = CRUNCH_STORAGE_SIZE;
+	*auxp += CRUNCH_STORAGE_SIZE;
 	crunch_task_copy(current_thread_info(), &kframe->storage);
 	return __copy_to_user(frame, kframe, sizeof(*frame));
 }
 
-static int restore_crunch_context(struct crunch_sigframe __user *frame)
+static int restore_crunch_context(char __user **auxp)
 {
+	struct crunch_sigframe __user *frame =
+		(struct crunch_sigframe __user *)*auxp;
 	char kbuf[sizeof(*frame) + 8];
 	struct crunch_sigframe *kframe;
 
@@ -52,6 +57,7 @@ static int restore_crunch_context(struct crunch_sigframe __user *frame)
 	if (kframe->magic != CRUNCH_MAGIC ||
 	    kframe->size != CRUNCH_STORAGE_SIZE)
 		return -1;
+	*auxp = CRUNCH_STORAGE_SIZE;
 	crunch_task_restore(current_thread_info(), &kframe->storage);
 	return 0;
 }
@@ -59,8 +65,10 @@ static int restore_crunch_context(struct crunch_sigframe __user *frame)
 
 #ifdef CONFIG_IWMMXT
 
-static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
+static int preserve_iwmmxt_context(char __user **auxp)
 {
+	struct iwmmxt_sigframe __user *frame =
+		(struct iwmmxt_sigframe __user *)*auxp;
 	char kbuf[sizeof(*frame) + 8];
 	struct iwmmxt_sigframe *kframe;
 
@@ -68,12 +76,15 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 	kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
 	kframe->magic = IWMMXT_MAGIC;
 	kframe->size = IWMMXT_STORAGE_SIZE;
+	*auxp += IWMMXT_STORAGE_SIZE;
 	iwmmxt_task_copy(current_thread_info(), &kframe->storage);
 	return __copy_to_user(frame, kframe, sizeof(*frame));
 }
 
-static int restore_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
+static int restore_iwmmxt_context(char __user **auxp)
 {
+	struct iwmmxt_sigframe __user *frame =
+		(struct iwmmxt_sigframe __user *)*auxp;
 	char kbuf[sizeof(*frame) + 8];
 	struct iwmmxt_sigframe *kframe;
 
@@ -84,6 +95,7 @@ static int restore_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 	if (kframe->magic != IWMMXT_MAGIC ||
 	    kframe->size != IWMMXT_STORAGE_SIZE)
 		return -1;
+	*auxp += IWMMXT_STORAGE_SIZE;
 	iwmmxt_task_restore(current_thread_info(), &kframe->storage);
 	return 0;
 }
@@ -92,14 +104,17 @@ static int restore_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 
 #ifdef CONFIG_VFP
 
-static int preserve_vfp_context(struct vfp_sigframe __user *frame)
+static int preserve_vfp_context(char __user **auxp)
 {
+	struct vfp_sigframe __user *frame =
+		(struct vfp_sigframe __user *)*auxp;
 	const unsigned long magic = VFP_MAGIC;
 	const unsigned long size = VFP_STORAGE_SIZE;
 	int err = 0;
 
 	__put_user_error(magic, &frame->magic, err);
 	__put_user_error(size, &frame->size, err);
+	*auxp += size;
 
 	if (err)
 		return -EFAULT;
@@ -107,8 +122,10 @@ static int preserve_vfp_context(struct vfp_sigframe __user *frame)
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
@@ -121,6 +138,7 @@ static int restore_vfp_context(struct vfp_sigframe __user *frame)
 	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
+	*auxp += size;
 	return vfp_restore_user_hwstate(&frame->ufp, &frame->ufp_exc);
 }
 
@@ -141,7 +159,7 @@ struct rt_sigframe {
 
 static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 {
-	struct aux_sigframe __user *aux;
+	char __user *aux;
 	sigset_t set;
 	int err;
 
@@ -169,18 +187,18 @@ static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 
 	err |= !valid_user_regs(regs);
 
-	aux = (struct aux_sigframe __user *) sf->uc.uc_regspace;
+	aux = (char __user *) sf->uc.uc_regspace;
 #ifdef CONFIG_CRUNCH
 	if (err == 0)
-		err |= restore_crunch_context(&aux->crunch);
+		err |= restore_crunch_context(&aux);
 #endif
 #ifdef CONFIG_IWMMXT
 	if (err == 0 && test_thread_flag(TIF_USING_IWMMXT))
-		err |= restore_iwmmxt_context(&aux->iwmmxt);
+		err |= restore_iwmmxt_context(&aux);
 #endif
 #ifdef CONFIG_VFP
 	if (err == 0)
-		err |= restore_vfp_context(&aux->vfp);
+		err |= restore_vfp_context(&aux);
 #endif
 
 	return err;
@@ -252,7 +270,7 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
 static int
 setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 {
-	struct aux_sigframe __user *aux;
+	char __user *aux;
 	int err = 0;
 
 	__put_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
@@ -280,20 +298,20 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
 
-	aux = (struct aux_sigframe __user *) sf->uc.uc_regspace;
+	aux = (char __user *) sf->uc.uc_regspace;
 #ifdef CONFIG_CRUNCH
 	if (err == 0)
-		err |= preserve_crunch_context(&aux->crunch);
+		err |= preserve_crunch_context(&aux);
 #endif
 #ifdef CONFIG_IWMMXT
 	if (err == 0 && test_thread_flag(TIF_USING_IWMMXT))
-		err |= preserve_iwmmxt_context(&aux->iwmmxt);
+		err |= preserve_iwmmxt_context(&aux);
 #endif
 #ifdef CONFIG_VFP
 	if (err == 0)
-		err |= preserve_vfp_context(&aux->vfp);
+		err |= preserve_vfp_context(&aux);
 #endif
-	__put_user_error(0, &aux->end_magic, err);
+	__put_user_error(0, (unsigned long __user *)aux, err);
 
 	return err;
 }
-- 
2.1.4

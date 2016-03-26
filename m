From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 27 Mar 2016 01:46:16 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <56F69291.4050205@huawei.com>
References: <20160129170929.GA3543@yury-N73SV> <56AC38F1.2030608@huawei.com>
 <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de>
 <20160225202855.GD16123@yury-N73SV> <56EBD84D.2060009@huawei.com>
 <20160318154918.GA1595@yury-N73SV>
 <mvmoaa8dwre.fsf@hawking.suse.de>
 <20160321184012.GA26563@yury-N73SV> <56F69291.4050205@huawei.com>
Message-ID: <20160326224616.GA11603@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 26, 2016 at 09:45:53PM +0800, Zhangjian (Bamvor) wrote:
> Hi, guys

Hi,
> 
> Does any body test the bigendian? We found lots of failures in be in
> our arm64 hardware. E.g. the signal issue.

I'm afraid, nobody yet. Thank you for work on it.

> 
> IIUC, the signal of struct in ILP32 is align with the aarch32. If so,
> we need to revert the following patch wrote by Andrew in 2014 which
> align the kernel_sigaction of ilp32 to lp64:
> Revert "[AARCH64] Add kernel_sigaction.h for AARCH64 ILP32"
> 
> And we also need to handle the uc_stack properly in kernel. After
> apply these two patches, we could fix lots of failure in bigendian.
> 
> Regards
> 
> Bamvor

Andrew sent me similar patches yesterday. See 
https://github.com/apinski-cavium/linux (branch pin1)
https://github.com/norov/glibc.git (branch new-api)

There are also some other fixes, so my fail list is like this:
[Float tests skipped but fail too]
pipeio_1                       FAIL       5
pipeio_6                       FAIL       1
abort01                        FAIL       2
clone02                        FAIL       4
execve03                       FAIL       4
fcntl17                        FAIL       4
fcntl21                        FAIL       4
kill11                         FAIL       2
mmap16                         FAIL       6
open12                         FAIL       2
rename11                       FAIL       2
rmdir02                        FAIL       2
umount2_01                     FAIL       2
umount2_02                     FAIL       2
umount2_03                     FAIL       2
utime06                        FAIL       2
mtest06                        FAIL       11

Some tests fail both on lp64 and ilp32, so it seems, it's not a
problem of ilp32 itself.

Some tests fail only when run in scenario, so I cannot reproduce it.
I suspect it's because core dump fails. 

Also, Andrew told, there's an issue in unwind, and it is caused by GCC
bug, not kernel or glibc. To reproduce, run unwind from signal
handler (trigo does it). I think, at least float tests fail due to it.
Andrew is in vacation now, so he may answer longer than usual.

See Andrew's kernel signal patch:

>From b95c5250c5c869d8852886ed49e34fa11c29663e Mon Sep 17 00:00:00 2001
From: Andrew Pinski <apinski@cavium.com>
Date: Thu, 24 Mar 2016 23:10:08 -0700
Subject: [PATCH] Fix signals

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_common.h | 10 +----
 arch/arm64/kernel/signal.c             | 59 +++++++++++++++++--------
 arch/arm64/kernel/signal_ilp32.c       | 78 +++++++++++++++++++++++++++++++---
 3 files changed, 115 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/signal_common.h b/arch/arm64/include/asm/signal_common.h
index faa82c0..402e0c4 100644
--- a/arch/arm64/include/asm/signal_common.h
+++ b/arch/arm64/include/asm/signal_common.h
@@ -23,16 +23,10 @@
 #include <asm/ucontext.h>
 #include <asm/fpsimd.h>
 
-struct sigframe {
-	struct ucontext uc;
-	u64 fp;
-	u64 lr;
-};
-
 int preserve_fpsimd_context(struct fpsimd_context __user *ctx);
 int restore_fpsimd_context(struct fpsimd_context __user *ctx);
-int setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set);
-int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf);
+int setup_sigcontex(struct sigcontext __user *uc_mcontext, struct pt_regs *regs);
+int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sf);
 void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			void __user *frame, off_t sigframe_off, int usig);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0648aa5..5f2faf2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -37,6 +37,12 @@
 #include <asm/signal_common.h>
 #include <asm/signal_ilp32.h>
 
+struct sigframe {
+	struct ucontext uc;
+	u64 fp;
+	u64 lr;
+};
+
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
  */
@@ -92,23 +98,31 @@ int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-int restore_sigframe(struct pt_regs *regs,
+static int restore_sigframe(struct pt_regs *regs,
 			    struct sigframe __user *sf)
 {
 	sigset_t set;
-	int i, err;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-
+	int err;
 	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
 	if (err == 0)
 		set_current_blocked(&set);
 
+	err |= restore_sigcontext(regs, &sf->uc.uc_mcontext);
+	return err;
+}
+
+
+int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *uc_mcontext)
+{
+	int i, err = 0;
+	void *aux = uc_mcontext->__reserved;
+
 	for (i = 0; i < 31; i++)
-		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+		__get_user_error(regs->regs[i], &uc_mcontext->regs[i],
 				 err);
-	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+	__get_user_error(regs->sp, &uc_mcontext->sp, err);
+	__get_user_error(regs->pc, &uc_mcontext->pc, err);
+	__get_user_error(regs->pstate, &uc_mcontext->pstate, err);
 
 	/*
 	 * Avoid sys_rt_sigreturn() restarting.
@@ -162,27 +176,36 @@ badframe:
 	return 0;
 }
 
-int setup_sigframe(struct sigframe __user *sf,
+static int setup_sigframe(struct sigframe __user *sf,
 			  struct pt_regs *regs, sigset_t *set)
 {
-	int i, err = 0;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-	struct _aarch64_ctx *end;
+	int err = 0;
 
 	/* set up the stack frame for unwinding */
 	__put_user_error(regs->regs[29], &sf->fp, err);
 	__put_user_error(regs->regs[30], &sf->lr, err);
+	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+	err |= setup_sigcontex (&sf->uc.uc_mcontext, regs);
+
+	return err;
+}
+
+int setup_sigcontex(struct sigcontext __user *uc_mcontext,
+			struct pt_regs *regs)
+{
+	void *aux = uc_mcontext->__reserved;
+	struct _aarch64_ctx *end;
+	int i, err = 0;
 
 	for (i = 0; i < 31; i++)
-		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+		__put_user_error(regs->regs[i], &uc_mcontext->regs[i],
 				 err);
-	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
 
-	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
+	__put_user_error(regs->sp, &uc_mcontext->sp, err);
+	__put_user_error(regs->pc, &uc_mcontext->pc, err);
+	__put_user_error(regs->pstate, &uc_mcontext->pstate, err);
 
-	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+	__put_user_error(current->thread.fault_address, &uc_mcontext->fault_address, err);
 
 	if (err == 0) {
 		struct fpsimd_context *fpsimd_ctx =
diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
index 1bb0ea8..d399ed0 100644
--- a/arch/arm64/kernel/signal_ilp32.c
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -32,11 +32,76 @@
 #include <asm/unistd.h>
 #include <asm/ucontext.h>
 
+
+struct ilp32_ucontext {
+        u32		uc_flags;
+        u32		uc_link;
+        compat_stack_t  uc_stack;
+        compat_sigset_t uc_sigmask;
+        /* glibc uses a 1024-bit sigset_t */
+        __u8            __unused[1024 / 8 - sizeof(compat_sigset_t)];
+        /* last for future expansion */
+        struct sigcontext uc_mcontext;
+};
+
+struct ilp32_sigframe {
+	struct ilp32_ucontext uc;
+	u64 fp;
+	u64 lr;
+};
+
 struct ilp32_rt_sigframe {
 	struct compat_siginfo info;
-	struct sigframe sig;
+	struct ilp32_sigframe sig;
 };
 
+static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
+{
+	compat_sigset_t cset;
+
+	cset.sig[0] = set->sig[0] & 0xffffffffull;
+	cset.sig[1] = set->sig[0] >> 32;
+
+	return copy_to_user(uset, &cset, sizeof(*uset));
+}
+
+static inline int get_sigset_t(sigset_t *set,
+                               const compat_sigset_t __user *uset)
+{
+	compat_sigset_t s32;
+
+	if (copy_from_user(&s32, uset, sizeof(*uset)))
+		return -EFAULT;
+
+	set->sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
+	return 0;
+}
+
+static int restore_ilp32_sigframe(struct pt_regs *regs,
+                            struct ilp32_sigframe __user *sf)
+{
+	sigset_t set;
+	int err;
+	err = get_sigset_t(&set, &sf->uc.uc_sigmask);
+	if (err == 0)
+		set_current_blocked(&set);
+	err |= restore_sigcontext(regs, &sf->uc.uc_mcontext);
+	return err;
+}
+
+static int setup_ilp32_sigframe(struct ilp32_sigframe __user *sf,
+                          struct pt_regs *regs, sigset_t *set)
+{
+	int err = 0;
+	/* set up the stack frame for unwinding */
+	__put_user_error(regs->regs[29], &sf->fp, err);
+	__put_user_error(regs->regs[30], &sf->lr, err);
+
+	err |= put_sigset_t(&sf->uc.uc_sigmask, set);
+	err |= setup_sigcontex (&sf->uc.uc_mcontext, regs);
+	return err;
+}
+
 asmlinkage long ilp32_sys_rt_sigreturn(struct pt_regs *regs)
 {
 	struct ilp32_rt_sigframe __user *frame;
@@ -57,10 +122,10 @@ asmlinkage long ilp32_sys_rt_sigreturn(struct pt_regs *regs)
 	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 
-	if (restore_sigframe(regs, &frame->sig))
+	if (restore_ilp32_sigframe(regs, &frame->sig))
 		goto badframe;
 
-	if (restore_altstack(&frame->sig.uc.uc_stack))
+	if (compat_restore_altstack(&frame->sig.uc.uc_stack))
 		goto badframe;
 
 	return regs->regs[0];
@@ -107,13 +172,14 @@ int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
 
 	if (!frame)
 		return 1;
+
 	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
 
 	__put_user_error(0, &frame->sig.uc.uc_flags, err);
-	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+	__put_user_error(0, &frame->sig.uc.uc_link, err);
 
-	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->sp);
-	err |= setup_sigframe(&frame->sig, regs, set);
+	err |= __compat_save_altstack(&frame->sig.uc.uc_stack, regs->sp);
+	err |= setup_ilp32_sigframe(&frame->sig, regs, set);
 	if (err == 0) {
 		setup_return(regs, &ksig->ka, frame,
 				offsetof(struct ilp32_rt_sigframe, sig), usig);
-- 
2.5.0

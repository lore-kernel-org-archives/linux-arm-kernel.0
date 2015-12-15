From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:40 +0300
Subject: [PATCH v6 14/20] arm64: signal: wrap struct ucontext,
 fp and lr with struct sigframe
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-15-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It helps to move common code for lp64 and ilp32 to separated header.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/signal.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 65baaef..20dca65 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -35,14 +35,18 @@
 #include <asm/signal32.h>
 #include <asm/vdso.h>
 
+struct sigframe {
+	struct ucontext uc;
+	u64 fp;
+	u64 lr;
+};
+
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
  */
 struct rt_sigframe {
 	struct siginfo info;
-	struct ucontext uc;
-	u64 fp;
-	u64 lr;
+	struct sigframe sig;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -93,7 +97,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 }
 
 static int restore_sigframe(struct pt_regs *regs,
-			    struct rt_sigframe __user *sf)
+			    struct sigframe __user *sf)
 {
 	sigset_t set;
 	int i, err;
@@ -145,10 +149,10 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 
-	if (restore_sigframe(regs, frame))
+	if (restore_sigframe(regs, &frame->sig))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_altstack(&frame->sig.uc.uc_stack))
 		goto badframe;
 
 	return regs->regs[0];
@@ -162,7 +166,7 @@ badframe:
 	return 0;
 }
 
-static int setup_sigframe(struct rt_sigframe __user *sf,
+static int setup_sigframe(struct sigframe __user *sf,
 			  struct pt_regs *regs, sigset_t *set)
 {
 	int i, err = 0;
@@ -230,13 +234,13 @@ static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
 }
 
 static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
-			 void __user *frame, int usig)
+			 void __user *frame, off_t sigframe_off, int usig)
 {
 	__sigrestore_t sigtramp;
 
 	regs->regs[0] = usig;
 	regs->sp = (unsigned long)frame;
-	regs->regs[29] = regs->sp + offsetof(struct rt_sigframe, fp);
+	regs->regs[29] = regs->sp + sigframe_off + offsetof(struct sigframe, fp);
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
 	if (ka->sa.sa_flags & SA_RESTORER)
@@ -257,17 +261,18 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	if (!frame)
 		return 1;
 
-	__put_user_error(0, &frame->uc.uc_flags, err);
-	__put_user_error(NULL, &frame->uc.uc_link, err);
+	__put_user_error(0, &frame->sig.uc.uc_flags, err);
+	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
 
-	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= setup_sigframe(frame, regs, set);
+	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->sp);
+	err |= setup_sigframe(&frame->sig, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, frame, usig);
+		setup_return(regs, &ksig->ka, frame,
+			offsetof(struct rt_sigframe, sig), usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
-			regs->regs[2] = (unsigned long)&frame->uc;
+			regs->regs[2] = (unsigned long)&frame->sig.uc;
 		}
 	}
 
-- 
2.5.0

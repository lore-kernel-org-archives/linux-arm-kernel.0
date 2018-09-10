From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 10 Sep 2018 11:42:44 +0100
Subject: [PATCH v3 5/9] ARM: signal: replace __put_user_error with __put_user
In-Reply-To: <1536576168-40096-1-git-send-email-julien.thierry@arm.com>
References: <1536576168-40096-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1536576168-40096-6-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With Spectre-v1.1 mitigations, __put_user_error is pointless. In an attempt
to remove it, replace its references in frame setups with __put_user.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm/kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 1e2ecfe..b908382 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -336,7 +336,7 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
 	if (err == 0)
 		err |= preserve_vfp_context(&aux->vfp);
 #endif
-	__put_user_error(0, &aux->end_magic, err);
+	err |= __put_user(0, &aux->end_magic);
 
 	return err;
 }
@@ -499,7 +499,7 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
 	/*
 	 * Set uc.uc_flags to a value which sc.trap_no would never have.
 	 */
-	__put_user_error(0x5ac3c35a, &frame->uc.uc_flags, err);
+	err = __put_user(0x5ac3c35a, &frame->uc.uc_flags);
 
 	err |= setup_sigframe(frame, regs, set);
 	if (err == 0)
@@ -519,8 +519,8 @@ asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
 
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 
-	__put_user_error(0, &frame->sig.uc.uc_flags, err);
-	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+	err |= __put_user(0, &frame->sig.uc.uc_flags);
+	err |= __put_user(NULL, &frame->sig.uc.uc_link);
 
 	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->ARM_sp);
 	err |= setup_sigframe(&frame->sig, regs, set);
-- 
1.9.1

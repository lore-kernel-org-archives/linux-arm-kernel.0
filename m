From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:48 +0000
Subject: [RFC PATCH v2 18/41] arm64/sve: signal: Restore FPSIMD/SVE state in
 rt_sigreturn
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-19-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing logic to restore the SVE state in
rt_sigreturn.

Because the FPSIMD and SVE state alias, this code replaces the
existing fpsimd restore code when there is SVE state to restore.

For Zn[127:0], the saved FPSIMD state in Vn takes precedence.

Since __task_fpsimd_to_sve() is used to merge the FPSIMD and SVE
state back together, and only for this purpose, we don't want it to
zero out the SVE state -- hence delete the memset() from there.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c |  4 ---
 arch/arm64/kernel/signal.c | 87 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1bdf7f2..952dd20 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -113,7 +113,6 @@ static void __fpsimd_to_sve(struct task_struct *task, unsigned int vq)
 	struct fpsimd_state *fst = &task->thread.fpsimd_state;
 	unsigned int i;
 
-	memset(sst, 0, sizeof(*sst));
 	for (i = 0; i < 32; ++i)
 		sst->zregs[i][0] = fst->vregs[i];
 }
@@ -288,9 +287,6 @@ void fpsimd_preserve_current_state(void)
 
 void fpsimd_signal_preserve_current_state(void)
 {
-	WARN_ONCE(elf_hwcap & HWCAP_SVE,
-		  "SVE state save/restore around signals doesn't work properly, expect userspace corruption!\n");
-
 	fpsimd_preserve_current_state();
 	sve_to_fpsimd(current);
 }
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6b83917..9d4f7c8 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -211,6 +211,11 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 }
 
 
+struct user_ctxs {
+	struct fpsimd_context __user *fpsimd;
+	struct sve_context __user *sve;
+};
+
 #ifdef CONFIG_ARM64_SVE
 
 static int preserve_sve_context(struct sve_context __user *ctx)
@@ -240,19 +245,68 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
+static int __restore_sve_fpsimd_context(struct user_ctxs *user,
+					unsigned int vl, unsigned int vq)
+{
+	int err;
+	struct fpsimd_sve_state(vq) *task_sve_regs =
+		__sve_state(current);
+	struct fpsimd_state fpsimd;
+
+	if (vl != sve_get_vl())
+		return -EINVAL;
+
+	BUG_ON(SVE_SIG_REGS_SIZE(vq) > sizeof(*task_sve_regs));
+	BUG_ON(round_up(SVE_SIG_REGS_SIZE(vq), 16) < sizeof(*task_sve_regs));
+	BUG_ON(SVE_SIG_FFR_OFFSET(vq) - SVE_SIG_REGS_OFFSET !=
+	       (char *)&task_sve_regs->ffr - (char *)task_sve_regs);
+	err = __copy_from_user(task_sve_regs,
+			       (char __user const *)user->sve +
+					SVE_SIG_REGS_OFFSET,
+			       SVE_SIG_REGS_SIZE(vq));
+	if (err)
+		return err;
+
+	/* copy the FP and status/control registers */
+	/* restore_sigframe() already checked that user->fpsimd != NULL. */
+	err = __copy_from_user(fpsimd.vregs, user->fpsimd->vregs,
+			       sizeof(fpsimd.vregs));
+	__get_user_error(fpsimd.fpsr, &user->fpsimd->fpsr, err);
+	__get_user_error(fpsimd.fpcr, &user->fpsimd->fpcr, err);
+
+	/* load the hardware registers from the fpsimd_state structure */
+	if (!err)
+		fpsimd_update_current_state(&fpsimd);
+
+	return err;
+}
+
+static int restore_sve_fpsimd_context(struct user_ctxs *user)
+{
+	int err;
+	u16 vl, vq;
+
+	err = __get_user(vl, &user->sve->vl);
+	if (err)
+		return err;
+
+	if (!sve_vl_valid(vl))
+		return -EINVAL;
+
+	vq = sve_vq_from_vl(vl);
+
+	return __restore_sve_fpsimd_context(user, vl, vq);
+}
+
 #else /* ! CONFIG_ARM64_SVE */
 
-/* Turn any non-optimised out attempt to use this into a link error: */
+/* Turn any non-optimised out attempts to use these into a link error: */
 extern int preserve_sve_context(void __user *ctx);
+extern int restore_sve_fpsimd_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SVE */
 
 
-struct user_ctxs {
-	struct fpsimd_context __user *fpsimd;
-	struct sve_context __user *sve;
-};
-
 static int parse_user_sigframe(struct user_ctxs *user,
 			       struct rt_sigframe __user *sf)
 {
@@ -316,6 +370,9 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (!IS_ENABLED(CONFIG_ARM64_SVE))
 				goto invalid;
 
+			if (!(elf_hwcap & HWCAP_SVE))
+				goto invalid;
+
 			if (user->sve)
 				goto invalid;
 
@@ -375,9 +432,6 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	}
 
 done:
-	if (!user->fpsimd)
-		goto invalid;
-
 	return 0;
 
 invalid:
@@ -411,8 +465,19 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0)
 		err = parse_user_sigframe(&user, sf);
 
-	if (err == 0)
-		err = restore_fpsimd_context(user.fpsimd);
+	if (err == 0) {
+		if (!user.fpsimd)
+			return -EINVAL;
+
+		if (user.sve) {
+			if (!IS_ENABLED(CONFIG_ARM64_SVE) ||
+			    !(elf_hwcap & HWCAP_SVE))
+				return -EINVAL;
+
+			err = restore_sve_fpsimd_context(&user);
+		} else
+			err = restore_fpsimd_context(user.fpsimd);
+	}
 
 	return err;
 }
-- 
2.1.4

From: richard@sigma-star.at (Richard Weinberger)
Date: Mon, 21 Jul 2014 16:03:15 +0200
Subject: [PATCH 29/43] arm64: Use sigsp()
In-Reply-To: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
References: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Message-ID: <1405951409-16953-30-git-send-email-richard@sigma-star.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Weinberger <richard@nod.at>

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm64/kernel/signal.c   | 12 +++---------
 arch/arm64/kernel/signal32.c | 14 ++++----------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index b29f5da..6fa7921 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -209,19 +209,13 @@ static int setup_sigframe(struct rt_sigframe __user *sf,
 	return err;
 }
 
-static struct rt_sigframe __user *get_sigframe(struct k_sigaction *ka,
+static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
 					       struct pt_regs *regs)
 {
 	unsigned long sp, sp_top;
 	struct rt_sigframe __user *frame;
 
-	sp = sp_top = regs->sp;
-
-	/*
-	 * This is the X/Open sanctioned signal stack switching.
-	 */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(sp))
-		sp = sp_top = current->sas_ss_sp + current->sas_ss_size;
+	sp = sp_top = sigsp(regs->sp, ksig);
 
 	sp = (sp - sizeof(struct rt_sigframe)) & ~15;
 	frame = (struct rt_sigframe __user *)sp;
@@ -259,7 +253,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs);
+	frame = get_sigframe(ksig, regs);
 	if (!frame)
 		return 1;
 
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b69ee69..1a5c5bf 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -407,20 +407,14 @@ badframe:
 	return 0;
 }
 
-static void __user *compat_get_sigframe(struct k_sigaction *ka,
+static void __user *compat_get_sigframe(struct ksignal *ksig,
 					struct pt_regs *regs,
 					int framesize)
 {
-	compat_ulong_t sp = regs->compat_sp;
+	compat_ulong_t sp = sigsp(regs->compat_sp, ksig);
 	void __user *frame;
 
 	/*
-	 * This is the X/Open sanctioned signal stack switching.
-	 */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(sp))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-
-	/*
 	 * ATPCS B01 mandates 8-byte alignment
 	 */
 	frame = compat_ptr((compat_uptr_t)((sp - framesize) & ~7));
@@ -526,7 +520,7 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksig,
 	struct compat_rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = compat_get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!frame)
 		return 1;
@@ -555,7 +549,7 @@ int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	struct compat_sigframe __user *frame;
 	int err = 0;
 
-	frame = compat_get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
 
 	if (!frame)
 		return 1;
-- 
1.8.4.5

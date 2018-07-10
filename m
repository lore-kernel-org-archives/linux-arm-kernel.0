From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 15:13:47 +0100
Subject: [PATCH 1/6] ARM: signal: copy registers using __copy_from_user()
In-Reply-To: <20180710141322.GL17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
Message-ID: <E1fctOl-0005ul-69@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When restoring the ARM integer registers, use __copy_from_user() to
copy them into kernel space before restoring them, rather than
__get_user_error().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/signal.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index bd8810d4acb3..0ae74207e43e 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -176,6 +176,7 @@ static int restore_vfp_context(char __user **auxp)
 
 static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 {
+	struct sigcontext context;
 	char __user *aux;
 	sigset_t set;
 	int err;
@@ -184,23 +185,26 @@ static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 	if (err == 0)
 		set_current_blocked(&set);
 
-	__get_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
-	__get_user_error(regs->ARM_r1, &sf->uc.uc_mcontext.arm_r1, err);
-	__get_user_error(regs->ARM_r2, &sf->uc.uc_mcontext.arm_r2, err);
-	__get_user_error(regs->ARM_r3, &sf->uc.uc_mcontext.arm_r3, err);
-	__get_user_error(regs->ARM_r4, &sf->uc.uc_mcontext.arm_r4, err);
-	__get_user_error(regs->ARM_r5, &sf->uc.uc_mcontext.arm_r5, err);
-	__get_user_error(regs->ARM_r6, &sf->uc.uc_mcontext.arm_r6, err);
-	__get_user_error(regs->ARM_r7, &sf->uc.uc_mcontext.arm_r7, err);
-	__get_user_error(regs->ARM_r8, &sf->uc.uc_mcontext.arm_r8, err);
-	__get_user_error(regs->ARM_r9, &sf->uc.uc_mcontext.arm_r9, err);
-	__get_user_error(regs->ARM_r10, &sf->uc.uc_mcontext.arm_r10, err);
-	__get_user_error(regs->ARM_fp, &sf->uc.uc_mcontext.arm_fp, err);
-	__get_user_error(regs->ARM_ip, &sf->uc.uc_mcontext.arm_ip, err);
-	__get_user_error(regs->ARM_sp, &sf->uc.uc_mcontext.arm_sp, err);
-	__get_user_error(regs->ARM_lr, &sf->uc.uc_mcontext.arm_lr, err);
-	__get_user_error(regs->ARM_pc, &sf->uc.uc_mcontext.arm_pc, err);
-	__get_user_error(regs->ARM_cpsr, &sf->uc.uc_mcontext.arm_cpsr, err);
+	err |= __copy_from_user(&context, &sf->uc.uc_mcontext, sizeof(context));
+	if (err == 0) {
+		regs->ARM_r0 = context.arm_r0;
+		regs->ARM_r1 = context.arm_r1;
+		regs->ARM_r2 = context.arm_r2;
+		regs->ARM_r3 = context.arm_r3;
+		regs->ARM_r4 = context.arm_r4;
+		regs->ARM_r5 = context.arm_r5;
+		regs->ARM_r6 = context.arm_r6;
+		regs->ARM_r7 = context.arm_r7;
+		regs->ARM_r8 = context.arm_r8;
+		regs->ARM_r9 = context.arm_r9;
+		regs->ARM_r10 = context.arm_r10;
+		regs->ARM_fp = context.arm_fp;
+		regs->ARM_ip = context.arm_ip;
+		regs->ARM_sp = context.arm_sp;
+		regs->ARM_lr = context.arm_lr;
+		regs->ARM_pc = context.arm_pc;
+		regs->ARM_cpsr = context.arm_cpsr;
+	}
 
 	err |= !valid_user_regs(regs);
 
-- 
2.7.4

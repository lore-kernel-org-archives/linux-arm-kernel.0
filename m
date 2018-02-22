From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:55 +0000
Subject: [PATCH 7/9] arm64: signal: Call arm64_notify_segfault when failing to
 deliver signal
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to deliver a signal due to taking an unhandled fault on the
stackframe, we can all arm64_notify_segfault to deliver a SEGV can deal
with printing any unhandled signal messages for us, rather than roll our
own printing code.

A side-effect of this change is that we now deliver the frame address
in si_addr along with an si_code of SEGV_{ACC,MAP}ERR, rather than an
si_addr of 0 and an si_code of SI_KERNEL as before.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal.c   |  7 ++-----
 arch/arm64/kernel/signal32.c | 13 +++----------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f60c052e8d1c..e5c656d0e316 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -40,6 +40,7 @@
 #include <asm/fpsimd.h>
 #include <asm/ptrace.h>
 #include <asm/signal32.h>
+#include <asm/traps.h>
 #include <asm/vdso.h>
 
 /*
@@ -565,11 +566,7 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return regs->regs[0];
 
 badframe:
-	if (show_unhandled_signals)
-		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
-				    current->comm, task_pid_nr(current), __func__,
-				    regs->pc, regs->sp);
-	force_sig(SIGSEGV, current);
+	arm64_notify_segfault(regs->sp);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 79feb861929b..68f5e07b592b 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -26,6 +26,7 @@
 #include <asm/esr.h>
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
+#include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
@@ -307,11 +308,7 @@ asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
 	return regs->regs[0];
 
 badframe:
-	if (show_unhandled_signals)
-		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
-				    current->comm, task_pid_nr(current), __func__,
-				    regs->pc, regs->compat_sp);
-	force_sig(SIGSEGV, current);
+	arm64_notify_segfault(regs->compat_sp);
 	return 0;
 }
 
@@ -344,11 +341,7 @@ asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
 	return regs->regs[0];
 
 badframe:
-	if (show_unhandled_signals)
-		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
-				    current->comm, task_pid_nr(current), __func__,
-				    regs->pc, regs->compat_sp);
-	force_sig(SIGSEGV, current);
+	arm64_notify_segfault(regs->compat_sp);
 	return 0;
 }
 
-- 
2.1.4

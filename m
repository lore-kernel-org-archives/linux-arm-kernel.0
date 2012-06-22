From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:07:06 +0100
Subject: [RFC PATCH 8/8] Revert "Revert "arm: remove unused restart
 trampoline""
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377626-17075-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit b7913c74b230d2f4fbdb6928a099933bb15f8e49.

Now that we perform system call restarting in the kernel, we can safely
remove the OABI restart trampoline.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/signal.c |   13 -------------
 arch/arm/kernel/signal.h |    2 --
 arch/arm/kernel/traps.c  |    2 --
 3 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 8250475..19b899f 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -28,7 +28,6 @@
  */
 #define SWI_SYS_SIGRETURN	(0xef000000|(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
 #define SWI_SYS_RT_SIGRETURN	(0xef000000|(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
-#define SWI_SYS_RESTART		(0xef000000|__NR_restart_syscall|__NR_OABI_SYSCALL_BASE)
 
 /*
  * With EABI, the syscall number has to be loaded into r7.
@@ -49,18 +48,6 @@ const unsigned long sigreturn_codes[7] = {
 };
 
 /*
- * Either we support OABI only, or we have EABI with the OABI
- * compat layer enabled.  In the later case we don't know if
- * user space is EABI or not, and if not we must not clobber r7.
- * Always using the OABI syscall solves that issue and works for
- * all those cases.
- */
-const unsigned long syscall_restart_code[2] = {
-	SWI_SYS_RESTART,	/* swi	__NR_restart_syscall */
-	0xe49df004,		/* ldr	pc, [sp], #4 */
-};
-
-/*
  * atomically swap in the new signal mask, and wait for a signal.
  */
 asmlinkage int sys_sigsuspend(int restart, unsigned long oldmask, old_sigset_t mask)
diff --git a/arch/arm/kernel/signal.h b/arch/arm/kernel/signal.h
index 6fcfe83..5ff067b7 100644
--- a/arch/arm/kernel/signal.h
+++ b/arch/arm/kernel/signal.h
@@ -8,7 +8,5 @@
  * published by the Free Software Foundation.
  */
 #define KERN_SIGRETURN_CODE	(CONFIG_VECTORS_BASE + 0x00000500)
-#define KERN_RESTART_CODE	(KERN_SIGRETURN_CODE + sizeof(sigreturn_codes))
 
 extern const unsigned long sigreturn_codes[7];
-extern const unsigned long syscall_restart_code[2];
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3647170..4928d89 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -820,8 +820,6 @@ void __init early_trap_init(void *vectors_base)
 	 */
 	memcpy((void *)(vectors + KERN_SIGRETURN_CODE - CONFIG_VECTORS_BASE),
 	       sigreturn_codes, sizeof(sigreturn_codes));
-	memcpy((void *)(vectors + KERN_RESTART_CODE - CONFIG_VECTORS_BASE),
-	       syscall_restart_code, sizeof(syscall_restart_code));
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
-- 
1.7.4.1

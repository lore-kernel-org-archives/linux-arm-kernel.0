From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:06:59 +0100
Subject: [RFC PATCH 1/8] Revert "arm: remove unused restart trampoline"
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377626-17075-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit fa18484d0947b976a769d15c83c50617493c81c1.

We need the restart trampoline back so that we can revert a related
problematic patch 6b5c8045ecc7e726cdaa2a9d9c8e5008050e1252 ("arm: new
way of handling ERESTART_RESTARTBLOCK").

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/signal.c |   13 +++++++++++++
 arch/arm/kernel/signal.h |    2 ++
 arch/arm/kernel/traps.c  |    2 ++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index fd2392a..6d3bce5 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -27,6 +27,7 @@
  */
 #define SWI_SYS_SIGRETURN	(0xef000000|(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
 #define SWI_SYS_RT_SIGRETURN	(0xef000000|(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
+#define SWI_SYS_RESTART		(0xef000000|__NR_restart_syscall|__NR_OABI_SYSCALL_BASE)
 
 /*
  * With EABI, the syscall number has to be loaded into r7.
@@ -47,6 +48,18 @@ const unsigned long sigreturn_codes[7] = {
 };
 
 /*
+ * Either we support OABI only, or we have EABI with the OABI
+ * compat layer enabled.  In the later case we don't know if
+ * user space is EABI or not, and if not we must not clobber r7.
+ * Always using the OABI syscall solves that issue and works for
+ * all those cases.
+ */
+const unsigned long syscall_restart_code[2] = {
+	SWI_SYS_RESTART,	/* swi	__NR_restart_syscall */
+	0xe49df004,		/* ldr	pc, [sp], #4 */
+};
+
+/*
  * atomically swap in the new signal mask, and wait for a signal.
  */
 asmlinkage int sys_sigsuspend(int restart, unsigned long oldmask, old_sigset_t mask)
diff --git a/arch/arm/kernel/signal.h b/arch/arm/kernel/signal.h
index 5ff067b7..6fcfe83 100644
--- a/arch/arm/kernel/signal.h
+++ b/arch/arm/kernel/signal.h
@@ -8,5 +8,7 @@
  * published by the Free Software Foundation.
  */
 #define KERN_SIGRETURN_CODE	(CONFIG_VECTORS_BASE + 0x00000500)
+#define KERN_RESTART_CODE	(KERN_SIGRETURN_CODE + sizeof(sigreturn_codes))
 
 extern const unsigned long sigreturn_codes[7];
+extern const unsigned long syscall_restart_code[2];
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 4928d89..3647170 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -820,6 +820,8 @@ void __init early_trap_init(void *vectors_base)
 	 */
 	memcpy((void *)(vectors + KERN_SIGRETURN_CODE - CONFIG_VECTORS_BASE),
 	       sigreturn_codes, sizeof(sigreturn_codes));
+	memcpy((void *)(vectors + KERN_RESTART_CODE - CONFIG_VECTORS_BASE),
+	       syscall_restart_code, sizeof(syscall_restart_code));
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
-- 
1.7.4.1

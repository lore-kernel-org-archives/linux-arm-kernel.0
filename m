From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 23 Sep 2010 17:11:36 -0400 (EDT)
Subject: [PATCH] ARM: SECCOMP support
Message-ID: <alpine.LFD.2.00.1009231709230.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 553b7cf..09b890e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1438,6 +1438,20 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config SECCOMP
+	bool
+	prompt "Enable seccomp to safely compute untrusted bytecode"
+	---help---
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
 config CC_STACKPROTECTOR
 	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
 	help
diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
new file mode 100644
index 0000000..52b156b
--- /dev/null
+++ b/arch/arm/include/asm/seccomp.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_ARM_SECCOMP_H
+#define _ASM_ARM_SECCOMP_H
+
+#include <linux/unistd.h>
+
+#define __NR_seccomp_read __NR_read
+#define __NR_seccomp_write __NR_write
+#define __NR_seccomp_exit __NR_exit
+#define __NR_seccomp_sigreturn __NR_rt_sigreturn
+
+#endif /* _ASM_ARM_SECCOMP_H */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 763e29f..7b5cc8d 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -144,6 +144,7 @@ extern void vfp_flush_hwstate(struct thread_info *);
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
+#define TIF_SECCOMP		21
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -153,6 +154,7 @@ extern void vfp_flush_hwstate(struct thread_info *);
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
+#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 
 /*
  * Change these and you break ASM code in entry-common.S
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f05a35a..cdd0a88 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -314,6 +314,16 @@ ENTRY(vector_swi)
 	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
 	bne	__sys_trace
 
+#ifdef CONFIG_SECCOMP
+	tst	ip, #_TIF_SECCOMP
+	beq	1f
+	mov	r0, scno
+	bl	__secure_computing	
+	add	r0, sp, #S_R0 + S_OFF		@ pointer to regs
+	ldmia	r0, {r0 - r3}			@ have to reload r0 - r3
+1:
+#endif
+
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
 	adr	lr, BSYM(ret_fast_syscall)	@ return address
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
@@ -336,8 +346,15 @@ __sys_trace:
 	mov	r0, #0				@ trace entry [IP = 0]
 	bl	syscall_trace
 
-	adr	lr, BSYM(__sys_trace_return)	@ return address
 	mov	scno, r0			@ syscall number (possibly new)
+
+#ifdef CONFIG_SECCOMP
+	ldr	ip, [tsk, #TI_FLAGS]		@ check for syscall tracing
+	tst	ip, #_TIF_SECCOMP
+	blne	__secure_computing	
+#endif
+
+	adr	lr, BSYM(__sys_trace_return)	@ return address
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
 	ldmccia	r1, {r0 - r3}			@ have to reload r0 - r3

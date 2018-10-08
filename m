From: evgsyr@gmail.com (Eugene Syromyatnikov)
Date: Mon, 8 Oct 2018 13:00:52 +0200
Subject: ARM: Call syscall_trace_exit even when system call skipped
In-Reply-To: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
Message-ID: <20181008110047.GA3426@asgard.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>

On at least x86 and ARM64, and as documented in the ptrace man page
a skipped system call will still cause a syscall exit ptrace stop.

Previous to this commit 32-bit ARM did not, resulting in strace
being confused when seccomp skips system calls.

This change also impacts programs that use ptrace to skip system calls.

Fixes: ad75b51459ae ("ARM: 7579/1: arch/allow a scno of -1 to not cause a SIGILL")
Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Eugene Syromyatnikov <evgsyr@gmail.com>
---
KernelVersion: 4.19-rc7
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 746565a..0465d65 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -296,16 +296,15 @@ __sys_trace:
 	cmp	scno, #-1			@ skip the syscall?
 	bne	2b
 	add	sp, sp, #S_OFF			@ restore stack
-	b	ret_slow_syscall
 
-__sys_trace_return:
-	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+__sys_trace_return_nosave:
+	enable_irq_notrace
 	mov	r0, sp
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
 
-__sys_trace_return_nosave:
-	enable_irq_notrace
+__sys_trace_return:
+	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	mov	r0, sp
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
-- 
2.1.4

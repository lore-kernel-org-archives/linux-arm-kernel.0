From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 28 Nov 2014 14:26:35 +0900
Subject: [PATCH v10 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <1417152399-32717-1-git-send-email-takahiro.akashi@linaro.org>
References: <1417152399-32717-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1417152399-32717-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If tracer modifies a syscall number to -1, this traced system call should
be skipped with a return value specified in x0.
This patch implements this semantics.

Please note:
* syscall entry tracing and syscall exit tracing (ftrace tracepoint and
  audit) are always executed, if enabled, even when skipping a system call
  (that is, -1).
  In this way, we can avoid a potential bug where audit_syscall_entry()
  might be called without audit_syscall_exit() at the previous system call
  being called, that would cause OOPs in audit_syscall_entry().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/entry.S |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 726b910..5d6a399 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -668,8 +668,15 @@ ENDPROC(el0_svc)
 	 * switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	mov	x0, sp
+	mov	w0, #-1				// set default errno for
+	cmp     scno, x0			// user-issued syscall(-1)
+	b.ne	1f
+	mov	x0, #-ENOSYS
+	str	x0, [sp, #S_X0]
+1:	mov	x0, sp
 	bl	syscall_trace_enter
+	cmp	w0, #-1				// skip the syscall?
+	b.eq	__sys_trace_return_skipped
 	adr	lr, __sys_trace_return		// return address
 	uxtw	scno, w0			// syscall number (possibly new)
 	mov	x1, sp				// pointer to regs
@@ -683,7 +690,8 @@ __sys_trace:
 	br	x16				// call sys_* routine
 
 __sys_trace_return:
-	str	x0, [sp]			// save returned x0
+	str	x0, [sp, #S_X0]			// save returned x0
+__sys_trace_return_skipped:
 	mov	x0, sp
 	bl	syscall_trace_exit
 	b	ret_to_user
-- 
1.7.9.5

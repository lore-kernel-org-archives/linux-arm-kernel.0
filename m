From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:01:56 -0700
Subject: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-7-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves seccomp after ptrace on x86 to that seccomp can catch changes
made by ptrace. Emulation should skip the rest of processing too.

We can get rid of test_thread_flag because there's no longer any
opportunity for seccomp to mess with ptrace state before invoking
ptrace.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: x86 at kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index df56ca394877..81c0e12d831c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	struct thread_info *ti = pt_regs_to_thread_info(regs);
 	unsigned long ret = 0;
+	bool emulated = false;
 	u32 work;
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
@@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
 
+	if (unlikely(work & _TIF_SYSCALL_EMU))
+		emulated = true;
+
+	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
+	    tracehook_report_syscall_entry(regs))
+		return -1L;
+
+	if (emulated)
+		return -1L;
+
 #ifdef CONFIG_SECCOMP
 	/*
-	 * Do seccomp first -- it should minimize exposure of other
-	 * code, and keeping seccomp fast is probably more valuable
-	 * than the rest of this.
+	 * Do seccomp after ptrace, to catch any tracer changes.
 	 */
 	if (work & _TIF_SECCOMP) {
 		struct seccomp_data sd;
@@ -117,13 +126,6 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	}
 #endif
 
-	if (unlikely(work & _TIF_SYSCALL_EMU))
-		ret = -1L;
-
-	if ((ret || test_thread_flag(TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
-		ret = -1L;
-
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->orig_ax);
 
-- 
2.7.4

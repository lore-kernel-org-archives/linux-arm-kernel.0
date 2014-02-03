From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  3 Feb 2014 15:56:30 +0900
Subject: [PATCH v3 3/3] arm64: audit: Add audit hook in ptrace/syscall_trace
In-Reply-To: <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1391410590-4884-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds auditing functions on entry to or exit from
every system call invocation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/thread_info.h |    1 +
 arch/arm64/kernel/entry.S            |    3 +++
 arch/arm64/kernel/ptrace.c           |   10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 720e70b..7468388 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -101,6 +101,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
+#define TIF_SYSCALL_AUDIT	9
 #define TIF_POLLING_NRFLAG	16
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 827cbad..83c4b29 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -630,6 +630,9 @@ el0_svc_naked:					// compat entry point
 	get_thread_info tsk
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall tracing
 	tbnz	x16, #TIF_SYSCALL_TRACE, __sys_trace // are we tracing syscalls?
+#ifdef CONFIG_AUDITSYSCALL
+	tbnz	x16, #TIF_SYSCALL_AUDIT, __sys_trace // auditing syscalls?
+#endif
 	adr	lr, ret_fast_syscall		// return address
 	cmp     scno, sc_nr                     // check upper syscall limit
 	b.hs	ni_sys
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6777a21..75a3f23 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/audit.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -38,6 +39,7 @@
 #include <asm/compat.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
+#include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
 
@@ -1064,6 +1066,14 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 {
 	unsigned long saved_reg;
 
+	if (dir)
+		audit_syscall_exit(regs);
+	else
+		audit_syscall_entry(syscall_get_arch(current, regs),
+			(int)regs->syscallno,
+			regs->orig_x0, regs->regs[1],
+			regs->regs[2], regs->regs[3]);
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return regs->syscallno;
 
-- 
1.7.9.5

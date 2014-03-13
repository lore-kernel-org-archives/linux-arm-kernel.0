From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 13 Mar 2014 19:16:07 +0900
Subject: [PATCH v7 2/2] arm64: audit: Add audit hook in
 syscall_trace_enter/exit()
In-Reply-To: <1394705767-12423-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705767-12423-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1394705767-12423-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds auditing functions on entry to or exit from
every system call invocation.

Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/ptrace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9c52b3e..d10c637 100644
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
 
@@ -1091,6 +1093,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
 
+	audit_syscall_entry(syscall_get_arch(current, regs), regs->syscallno,
+		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
+
 	return regs->syscallno;
 }
 
@@ -1098,6 +1103,8 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 {
 	unsigned long saved_reg;
 
+	audit_syscall_exit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_exit(regs, regs_return_value(regs));
 
-- 
1.7.9.5

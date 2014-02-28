From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 28 Feb 2014 14:17:15 +0900
Subject: [PATCH v6 2/2] arm64: audit: Add audit hook in ptrace/syscall_trace
In-Reply-To: <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393319934-2810-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1393564635-3921-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds auditing functions on entry to or exit from
every system call invocation.

Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/ptrace.c |   54 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6a8928b..d4ce70e 100644
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
 
@@ -1062,31 +1064,39 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 {
 	unsigned long saved_reg;
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return regs->syscallno;
+	if (dir && test_thread_flag(TIF_SYSCALL_AUDIT))
+		audit_syscall_exit(regs);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (is_compat_task()) {
+			/* AArch32 uses ip (r12) for scratch */
+			saved_reg = regs->regs[12];
+			regs->regs[12] = dir;
+		} else {
+			/*
+			 * Save X7. X7 is used to denote syscall entry/exit:
+			 *   X7 = 0 -> entry, = 1 -> exit
+			 */
+			saved_reg = regs->regs[7];
+			regs->regs[7] = dir;
+		}
 
-	if (is_compat_task()) {
-		/* AArch32 uses ip (r12) for scratch */
-		saved_reg = regs->regs[12];
-		regs->regs[12] = dir;
-	} else {
-		/*
-		 * Save X7. X7 is used to denote syscall entry/exit:
-		 *   X7 = 0 -> entry, = 1 -> exit
-		 */
-		saved_reg = regs->regs[7];
-		regs->regs[7] = dir;
-	}
+		if (dir)
+			tracehook_report_syscall_exit(regs, 0);
+		else if (tracehook_report_syscall_entry(regs))
+			regs->syscallno = ~0UL;
 
-	if (dir)
-		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
-		regs->syscallno = ~0UL;
+		if (is_compat_task())
+			regs->regs[12] = saved_reg;
+		else
+			regs->regs[7] = saved_reg;
+	}
 
-	if (is_compat_task())
-		regs->regs[12] = saved_reg;
-	else
-		regs->regs[7] = saved_reg;
+	if (!dir && test_thread_flag(TIF_SYSCALL_AUDIT))
+		audit_syscall_entry(syscall_get_arch(current, regs),
+			(int)regs->syscallno,
+			regs->orig_x0, regs->regs[1],
+			regs->regs[2], regs->regs[3]);
 
 	return regs->syscallno;
 }
-- 
1.7.9.5

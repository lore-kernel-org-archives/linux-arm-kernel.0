From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  7 Feb 2014 19:10:03 +0900
Subject: [PATCH v4 3/3] arm64: audit: Add audit hook in ptrace/syscall_trace
In-Reply-To: <1391767803-5350-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767803-5350-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1391767803-5350-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds auditing functions on entry to or exit from
every system call invocation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/ptrace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 64ce39f..8cdba09 100644
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
 
@@ -1076,10 +1078,15 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 	}
 
 	if (dir) {
+		audit_syscall_exit(regs);
 		tracehook_report_syscall_exit(regs, 0);
 	} else {
 		if (tracehook_report_syscall_entry(regs))
 			regs->syscallno = ~0UL;
+		audit_syscall_entry(syscall_get_arch(current, regs),
+			(int)regs->syscallno,
+			regs->orig_x0, regs->regs[1],
+			regs->regs[2], regs->regs[3]);
 	}
 
 	if (is_compat_task())
-- 
1.7.9.5

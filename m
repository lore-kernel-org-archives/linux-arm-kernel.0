From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 25 Feb 2014 18:18:54 +0900
Subject: [PATCH v5 3/3] arm64: audit: Add audit hook in ptrace/syscall_trace
In-Reply-To: <1393319934-2810-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391767803-5350-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319934-2810-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1393319934-2810-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds auditing functions on entry to or exit from
every system call invocation.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Richard Guy Briggs <rgb@redhat.com>
---
 arch/arm64/kernel/ptrace.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c70133e..d4ce70e 100644
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
 
@@ -1062,6 +1064,9 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 {
 	unsigned long saved_reg;
 
+	if (dir && test_thread_flag(TIF_SYSCALL_AUDIT))
+		audit_syscall_exit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (is_compat_task()) {
 			/* AArch32 uses ip (r12) for scratch */
@@ -1087,5 +1092,11 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 			regs->regs[7] = saved_reg;
 	}
 
+	if (!dir && test_thread_flag(TIF_SYSCALL_AUDIT))
+		audit_syscall_entry(syscall_get_arch(current, regs),
+			(int)regs->syscallno,
+			regs->orig_x0, regs->regs[1],
+			regs->regs[2], regs->regs[3]);
+
 	return regs->syscallno;
 }
-- 
1.7.9.5

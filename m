From: james.morse@arm.com (James Morse)
Date: Tue, 18 Oct 2016 11:27:48 +0100
Subject: [PATCH 3/3] arm64: suspend: Reconfigure PSTATE after resume from idle
In-Reply-To: <1476786468-2173-1-git-send-email-james.morse@arm.com>
References: <1476786468-2173-1-git-send-email-james.morse@arm.com>
Message-ID: <1476786468-2173-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suspend/resume path in kernel/sleep.S, as used by cpu-idle, does not
save/restore PSTATE. As a result of this cpufeatures that were detected
and have bits in PSTATE get lost when we resume from idle.

UAO gets set appropriately on the next context switch. PAN will be
re-enabled next time we return from user-space, but on a preemptible
kernel we may run work accessing user space before this point.

Add code to re-enable theses two features in __cpu_suspend_exit().
We re-use uao_thread_switch() passing current.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
This patch applies to linux-stable v4.7.8, but with some fuzz...
but 'git am' rejects it.

asm/exec.h is my best guess at the appropriate header file. Contradictions
welcome.

 arch/arm64/include/asm/exec.h |  3 +++
 arch/arm64/kernel/process.c   |  3 ++-
 arch/arm64/kernel/suspend.c   | 11 +++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/exec.h b/arch/arm64/include/asm/exec.h
index db0563c23482..f7865dd9d868 100644
--- a/arch/arm64/include/asm/exec.h
+++ b/arch/arm64/include/asm/exec.h
@@ -18,6 +18,9 @@
 #ifndef __ASM_EXEC_H
 #define __ASM_EXEC_H
 
+#include <linux/sched.h>
+
 extern unsigned long arch_align_stack(unsigned long sp);
+void uao_thread_switch(struct task_struct *next);
 
 #endif	/* __ASM_EXEC_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 27b2f1387df4..4f186c56c5eb 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -49,6 +49,7 @@
 #include <asm/alternative.h>
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
+#include <asm/exec.h>
 #include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
@@ -301,7 +302,7 @@ static void tls_thread_switch(struct task_struct *next)
 }
 
 /* Restore the UAO state depending on next's addr_limit */
-static void uao_thread_switch(struct task_struct *next)
+void uao_thread_switch(struct task_struct *next)
 {
 	if (IS_ENABLED(CONFIG_ARM64_UAO)) {
 		if (task_thread_info(next)->addr_limit == KERNEL_DS)
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index ad734142070d..bb0cd787a9d3 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -1,8 +1,11 @@
 #include <linux/ftrace.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
+#include <asm/exec.h>
 #include <asm/pgtable.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
@@ -50,6 +53,14 @@ void notrace __cpu_suspend_exit(void)
 	set_my_cpu_offset(per_cpu_offset(cpu));
 
 	/*
+	 * PSTATE was not saved over suspend/resume, re-enable any detected
+	 * features that might not have been set correctly.
+	 */
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,
+			CONFIG_ARM64_PAN));
+	uao_thread_switch(current);
+
+	/*
 	 * Restore HW breakpoint registers to sane values
 	 * before debug exceptions are possibly reenabled
 	 * through local_dbg_restore.
-- 
2.8.0.rc3

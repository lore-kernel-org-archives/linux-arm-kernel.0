From: james.morse@arm.com (James Morse)
Date: Tue,  6 Dec 2016 19:04:54 +0000
Subject: [stable:PATCH 3/3] arm64: suspend: Reconfigure PSTATE after resume
 from idle [v4.8]
In-Reply-To: <20161206190454.19083-1-james.morse@arm.com>
References: <20161206190454.19083-1-james.morse@arm.com>
Message-ID: <20161206190454.19083-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d08544127d9fb4505635e3cb6871fd50a42947bd upstream.

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
Signed-off-by: Will Deacon <will.deacon@arm.com>

Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> # 4.8.12
---
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
index 6cd2612236dc..9cc8667212a6 100644
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
@@ -303,7 +304,7 @@ static void tls_thread_switch(struct task_struct *next)
 }
 
 /* Restore the UAO state depending on next's addr_limit */
-static void uao_thread_switch(struct task_struct *next)
+void uao_thread_switch(struct task_struct *next)
 {
 	if (IS_ENABLED(CONFIG_ARM64_UAO)) {
 		if (task_thread_info(next)->addr_limit == KERNEL_DS)
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index b616e365cee3..23ddf5500b09 100644
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
@@ -48,6 +51,14 @@ void notrace __cpu_suspend_exit(void)
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 
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
2.10.1

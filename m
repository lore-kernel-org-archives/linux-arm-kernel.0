From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 17 Nov 2015 11:50:51 +0000
Subject: [PATCH] arm64: kernel: pause/unpause function graph tracer in
 cpu_suspend()
Message-ID: <1447761051-811-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function graph tracer adds instrumentation that is required to trace
both entry and exit of a function. In particular the function graph
tracer updates the "return address" of a function in order to insert
a trace callback on function exit.

Kernel power management functions like cpu_suspend() are called
upon power down entry with functions called "finishers" that are in turn
called to trigger the power down sequence but they may not return to the
kernel through the normal return path.

When the core resumes from low-power it returns to the cpu_suspend()
function through the cpu_resume path, which leaves the trace stack frame
set-up by the function tracer in an incosistent state upon return to the
kernel when tracing is enabled.

This patch fixes the issue by pausing/resuming the function graph
tracer on the thread executing cpu_suspend() (ie the function call that
subsequently triggers the "suspend finishers"), so that the function graph
tracer state is kept consistent across functions that enter power down
states and never return by effectively disabling graph tracer while they
are executing.

Fixes: 819e50e25d0c ("arm64: Add ftrace support")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org> # 3.16+
---
 arch/arm64/kernel/suspend.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index fce95e1..521448d 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -1,3 +1,4 @@
+#include <linux/ftrace.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
@@ -71,6 +72,13 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	local_dbg_save(flags);
 
 	/*
+	 * Function graph tracer state gets incosistent when the kernel
+	 * calls functions that never return (aka suspend finishers) hence
+	 * disable graph tracing during their execution.
+	 */
+	pause_graph_tracing();
+
+	/*
 	 * mm context saved on the stack, it will be restored when
 	 * the cpu comes out of reset through the identity mapped
 	 * page tables, so that the thread address space is properly
@@ -111,6 +119,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 			hw_breakpoint_restore(NULL);
 	}
 
+	unpause_graph_tracing();
 	/*
 	 * Restore pstate flags. OS lock and mdscr have been already
 	 * restored, so from this point onwards, debugging is fully
-- 
2.5.1

From: james.morse@arm.com (James Morse)
Date: Thu,  3 Aug 2017 16:15:32 +0100
Subject: [PATCH 2/3] kernel: debug-monitors: Disable preemption
In-Reply-To: <20170803151533.29438-1-james.morse@arm.com>
References: <20170803151533.29438-1-james.morse@arm.com>
Message-ID: <20170803151533.29438-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The helpers kernel_{en,dis}able_single_step check that interrupts
are disabled when they are called as they are setting the per-cpu
MDSCR_EL1 register.

But we don't expect single step to have an effect until we ERET with
SPSR.SS set. We may ERET to a context that has interrupts unmasked,
take an interrupt and switch CPU. This leaves MDSCR_EL1.SS set on
one CPU, and SPSR.SS set on another.

Stop this by wrapping the MDSCR_EL1 writes in preempt_{en,dis}able().

Signed-off-by: James Morse <james.morse@arm.com>
CC: Pratyush Anand <panand@redhat.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>

---
 arch/arm64/kernel/debug-monitors.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index c7ef99904934..6ba315dc2935 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/preempt.h>
 #include <linux/ptrace.h>
 #include <linux/kprobes.h>
 #include <linux/stat.h>
@@ -399,7 +400,7 @@ void user_fastforward_single_step(struct task_struct *task)
 /* Kernel API */
 void kernel_enable_single_step(struct pt_regs *regs)
 {
-	WARN_ON(!irqs_disabled());
+	preempt_disable();
 	set_regs_spsr_ss(regs);
 	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
 	enable_debug_monitors(DBG_ACTIVE_EL1);
@@ -408,9 +409,9 @@ NOKPROBE_SYMBOL(kernel_enable_single_step);
 
 void kernel_disable_single_step(void)
 {
-	WARN_ON(!irqs_disabled());
 	mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
 	disable_debug_monitors(DBG_ACTIVE_EL1);
+	preempt_enable();
 }
 NOKPROBE_SYMBOL(kernel_disable_single_step);
 
-- 
2.13.3

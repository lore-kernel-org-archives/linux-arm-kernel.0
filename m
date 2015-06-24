From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jun 2015 13:14:18 -0700
Subject: [PATCH] ARM64: smp: Silence suspicious RCU usage with ipi tracepoints
Message-ID: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Stultz reported an RCU splat on ARM with ipi trace events
enabled. It looks like the same problem exists on ARM64.

At this point in the IPI handling path we haven't called
irq_enter() yet, so RCU doesn't know that we're about to exit
idle and properly warns that we're using RCU from an idle CPU.
Use trace_ipi_entry_rcuidle() instead of trace_ipi_entry() so
that RCU is informed about our exit from idle.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Fixes: 45ed695ac10a "ARM64: add IPI tracepoints"
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I haven't confirmed this, but it looks an awful lot like the same
problem exists on ARM64.

 arch/arm64/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4b2121bd7f9c..a1883bfdd9d6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -693,7 +693,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if ((unsigned)ipinr < NR_IPI) {
-		trace_ipi_entry(ipi_types[ipinr]);
+		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
 		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
 	}
 
@@ -736,7 +736,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit(ipi_types[ipinr]);
+		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
 	set_irq_regs(old_regs);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

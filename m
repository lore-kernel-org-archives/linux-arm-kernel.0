From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 17 Jan 2011 17:26:35 +0530
Subject: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
Message-ID: <1295265395-28485-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 'ad3b6993' converted ARM smp_cross_call() to take IPI number
as a parameter to handle more event than SGI and do_IPI was suppose
to recover SGI number. But the do_IPI doesn't consider it and it's
getting detected as 'Unknown IPI message 0x1' with ipi numbers are
moved to starts from 'IPI_TIMER=2"

There can be 16 different SGI but only SGI1 is used as IPI so
only that one is handled in do_IPI as IPI_CPU_START.

Added IPI_CPU_START because it wasn't used and thought it's
appropriate. Not sure whether its the right one.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h |    2 +-
 arch/arm/kernel/smp.c          |   11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 89ad180..2635c8b 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	5
+#define NR_IPI	6
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..f089e35 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -48,6 +48,7 @@
 struct secondary_data secondary_data;
 
 enum ipi_msg_type {
+	IPI_CPU_START = 1,
 	IPI_TIMER = 2,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
@@ -387,7 +388,8 @@ void arch_send_call_function_single_ipi(int cpu)
 }
 
 static const char *ipi_types[NR_IPI] = {
-#define S(x,s)	[x - IPI_TIMER] = s
+#define S(x, s)	[x - IPI_CPU_START] = s
+	S(IPI_CPU_START, "CPU start interrupts"),
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
 	S(IPI_CALL_FUNC, "Function call interrupts"),
@@ -552,10 +554,13 @@ asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
 	unsigned int cpu = smp_processor_id();
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	if (ipinr >= IPI_TIMER && ipinr < IPI_TIMER + NR_IPI)
-		__inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_TIMER]);
+	if (ipinr >= IPI_CPU_START && ipinr < IPI_TIMER + NR_IPI)
+		__inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_CPU_START]);
 
 	switch (ipinr) {
+	case IPI_CPU_START:
+		/* Wake up from WFI/WFE using SGI */
+		break;
 	case IPI_TIMER:
 		ipi_timer();
 		break;
-- 
1.6.0.4

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 17:58:34 +0000
Subject: [PATCH 4/9] ARM: include local timer irq stats only when local timers
	configured
In-Reply-To: <20101115175553.GC31421@n2100.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
Message-ID: <E1PI3K6-00029i-Oj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardirq.h |    2 ++
 arch/arm/kernel/irq.c          |    2 ++
 arch/arm/kernel/smp.c          |   24 ++++++++++++------------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 6d7485a..522fb23 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -7,7 +7,9 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#ifdef CONFIG_LOCAL_TIMERS
 	unsigned int local_timer_irqs;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 36ad3be..ea29721 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -93,6 +93,8 @@ unlock:
 #endif
 #ifdef CONFIG_SMP
 		show_ipi_list(p);
+#endif
+#ifdef CONFIG_LOCAL_TIMERS
 		show_local_irqs(p);
 #endif
 		seq_printf(p, "Err: %10lu\n", irq_err_count);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 78d55c6..b58b6c4 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -417,18 +417,6 @@ void show_ipi_list(struct seq_file *p)
 	seq_putc(p, '\n');
 }
 
-void show_local_irqs(struct seq_file *p)
-{
-	unsigned int cpu;
-
-	seq_printf(p, "LOC: ");
-
-	for_each_present_cpu(cpu)
-		seq_printf(p, "%10u ", irq_stat[cpu].local_timer_irqs);
-
-	seq_putc(p, '\n');
-}
-
 /*
  * Timer (local or broadcast) support
  */
@@ -455,6 +443,18 @@ asmlinkage void __exception do_local_timer(struct pt_regs *regs)
 
 	set_irq_regs(old_regs);
 }
+
+void show_local_irqs(struct seq_file *p)
+{
+	unsigned int cpu;
+
+	seq_printf(p, "LOC: ");
+
+	for_each_present_cpu(cpu)
+		seq_printf(p, "%10u ", irq_stat[cpu].local_timer_irqs);
+
+	seq_putc(p, '\n');
+}
 #endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-- 
1.6.2.5

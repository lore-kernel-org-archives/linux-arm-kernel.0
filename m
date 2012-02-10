From: bill4carson@gmail.com (Bill Carson)
Date: Fri, 10 Feb 2012 17:27:53 +0800
Subject: [PATCH] hotplug: eliminate warning "Unknown IPI message 0x1"
In-Reply-To: <1328866073-14769-1-git-send-email-bill4carson@gmail.com>
References: <1328866073-14769-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1328866073-14769-2-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When playing hotplug on vexpress board, a tiny warning pops out.

/sys/devices/system/cpu # echo 0 > cpu3/online
CPU3: shutdown
/sys/devices/system/cpu # echo 1 > cpu3/online
CPU3: Booted secondary processor
Calibrating delay loop (skipped) already calibrated this CPU
CPU3: Unknown IPI message 0x1
      ^^^^^^^
It's a phony warning caused by handle_IPI as a result of calling
gic_raise_softirq(cpumask_of(cpu), 1). Introducing a new ipi_msg_type
IPI_WAKEUP_CPU to make this warning go away.

with this patch, now hotplug looks like:

/sys/devices/system/cpu # echo 0 > cpu3/online ; echo 1 > cpu3/online \
cat /proc/interrupts
CPU3: shutdown
CPU3: Booted secondary processor
Calibrating delay loop (skipped) already calibrated this CPU
CPU3 got wake up!
           CPU0       CPU1       CPU2       CPU3
 29:       5743       5730       5721       5711       GIC  twd
 34:         27          0          0          0       GIC  timer
 36:          0          0          0          0       GIC  rtc-pl031
 37:        262          0          0          0       GIC  uart-pl011
 41:          0          0          0          0       GIC  mmci-pl18x (cmd)
 42:          0          0          0          0       GIC  mmci-pl18x (pio)
 44:          9          0          0          0       GIC  kmi-pl050
 45:        101          0          0          0       GIC  kmi-pl050
 47:          0          0          0          0       GIC  eth0
IPI0:          0          0          0          0  Timer broadcast interrupts
IPI1:        466        463         59         13  Rescheduling interrupts
IPI2:          0          2          2          2  Function call interrupts
IPI3:          0          0          0          6  Single function call interrupts
IPI4:          0          0          0          0  CPU stop interrupts
IPI5:          0          1          1          2  CPU wakeup interrupts
Err:          0

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/hardirq.h    |    2 +-
 arch/arm/kernel/smp.c             |    5 +++++
 arch/arm/plat-versatile/platsmp.c |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 436e60b..2740c2a 100644
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
index cdeb727..7418e13 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -56,6 +56,7 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
+	IPI_WAKEUP_CPU,
 };
 
 int __cpuinit __cpu_up(unsigned int cpu)
@@ -393,6 +394,7 @@ static const char *ipi_types[NR_IPI] = {
 	S(IPI_CALL_FUNC, "Function call interrupts"),
 	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
+	S(IPI_WAKEUP_CPU, "CPU wakeup interrupts"),
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -558,6 +560,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		ipi_cpu_stop(cpu);
 		irq_exit();
 		break;
+	case IPI_WAKEUP_CPU:
+		pr_info("CPU%u got wake up!\n", cpu);
+		break;
 
 	default:
 		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 49c7db4..7188034 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -85,7 +85,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 7 /* IPI_WAKEUP_CPU */);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.1

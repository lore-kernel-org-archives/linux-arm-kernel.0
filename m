From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:19:56 +0000
Subject: [PATCH 03/22] ARM: SMP: avoid using bitmasks and locks for IPIs,
	use hardware instead
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc6m-0007rB-K5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid using bitmasks and locks in the percpu area for IPIs, and instead
use individual software generated interrupts to identify the reason for
the IPI.  This avoids the problems of having spinlocks in the percpu
area.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   87 ++++++++++++++----------------------------------
 1 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7a236db..78d55c6 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -48,20 +48,15 @@ struct secondary_data secondary_data;
 
 /*
  * structures for inter-processor calls
- * - A collection of single bit ipi messages.
  */
 struct ipi_data {
-	spinlock_t lock;
 	unsigned long ipi_count;
-	unsigned long bits;
 };
 
-static DEFINE_PER_CPU(struct ipi_data, ipi_data) = {
-	.lock	= SPIN_LOCK_UNLOCKED,
-};
+static DEFINE_PER_CPU(struct ipi_data, ipi_data);
 
 enum ipi_msg_type {
-	IPI_TIMER,
+	IPI_TIMER = 2,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
@@ -389,22 +384,13 @@ void __init smp_prepare_boot_cpu(void)
 static void send_ipi_message(const struct cpumask *mask, enum ipi_msg_type msg)
 {
 	unsigned long flags;
-	unsigned int cpu;
 
 	local_irq_save(flags);
 
-	for_each_cpu(cpu, mask) {
-		struct ipi_data *ipi = &per_cpu(ipi_data, cpu);
-
-		spin_lock(&ipi->lock);
-		ipi->bits |= 1 << msg;
-		spin_unlock(&ipi->lock);
-	}
-
 	/*
 	 * Call the platform specific cross-CPU call function.
 	 */
-	smp_cross_call(mask, 1);
+	smp_cross_call(mask, msg);
 
 	local_irq_restore(flags);
 }
@@ -546,56 +532,35 @@ asmlinkage void __exception do_IPI(int ipinr, struct pt_regs *regs)
 
 	ipi->ipi_count++;
 
-	for (;;) {
-		unsigned long msgs;
-
-		spin_lock(&ipi->lock);
-		msgs = ipi->bits;
-		ipi->bits = 0;
-		spin_unlock(&ipi->lock);
-
-		if (!msgs)
-			break;
-
-		do {
-			unsigned nextmsg;
-
-			nextmsg = msgs & -msgs;
-			msgs &= ~nextmsg;
-			nextmsg = ffz(~nextmsg);
-
-			switch (nextmsg) {
-			case IPI_TIMER:
-				ipi_timer();
-				break;
+	switch (ipinr) {
+	case IPI_TIMER:
+		ipi_timer();
+		break;
 
-			case IPI_RESCHEDULE:
-				/*
-				 * nothing more to do - eveything is
-				 * done on the interrupt return path
-				 */
-				break;
+	case IPI_RESCHEDULE:
+		/*
+		 * nothing more to do - eveything is
+		 * done on the interrupt return path
+		 */
+		break;
 
-			case IPI_CALL_FUNC:
-				generic_smp_call_function_interrupt();
-				break;
+	case IPI_CALL_FUNC:
+		generic_smp_call_function_interrupt();
+		break;
 
-			case IPI_CALL_FUNC_SINGLE:
-				generic_smp_call_function_single_interrupt();
-				break;
+	case IPI_CALL_FUNC_SINGLE:
+		generic_smp_call_function_single_interrupt();
+		break;
 
-			case IPI_CPU_STOP:
-				ipi_cpu_stop(cpu);
-				break;
+	case IPI_CPU_STOP:
+		ipi_cpu_stop(cpu);
+		break;
 
-			default:
-				printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
-				       cpu, nextmsg);
-				break;
-			}
-		} while (msgs);
+	default:
+		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
+		       cpu, ipinr);
+		break;
 	}
-
 	set_irq_regs(old_regs);
 }
 
-- 
1.6.2.5

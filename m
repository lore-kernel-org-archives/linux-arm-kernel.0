From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:35:28 +0000
Subject: [PATCH 09/11] ARM: fix rcu stalls on SMP platforms
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rnu1Q-0002pr-2N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can stall RCU processing on SMP platforms if a CPU sits in its idle
loop for a long time.  This happens because we don't call irq_enter()
and irq_exit() around generic_smp_call_function_interrupt() and
friends.  Add the necessary calls, and remove the one from within
ipi_timer(), so that they're all in a common place.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57db122..26cdc49 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -443,9 +443,7 @@ static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
 static void ipi_timer(void)
 {
 	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
-	irq_enter();
 	evt->event_handler(evt);
-	irq_exit();
 }
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
@@ -548,7 +546,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	switch (ipinr) {
 	case IPI_TIMER:
+		irq_enter();
 		ipi_timer();
+		irq_exit();
 		break;
 
 	case IPI_RESCHEDULE:
@@ -556,15 +556,21 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
+		irq_enter();
 		generic_smp_call_function_interrupt();
+		irq_exit();
 		break;
 
 	case IPI_CALL_FUNC_SINGLE:
+		irq_enter();
 		generic_smp_call_function_single_interrupt();
+		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
+		irq_enter();
 		ipi_cpu_stop(cpu);
+		irq_exit();
 		break;
 
 	default:
-- 
1.7.4.4

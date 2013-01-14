From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Jan 2013 17:05:23 +0000
Subject: [PATCHv3 3/4] arm: Use generic timer broadcast receiver
In-Reply-To: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
References: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1358183124-28461-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the ARM backend must maintain a redundant list of timers for
the purpose of centralising timer broadcast functionality. This prevents
sharing timer drivers across architectures.

This patch moves the pain of dealing with timer broadcasts to the core
clockevents tick broadcast code, which already maintains its own list
of timers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/smp.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 84f4cbf..9308519 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -475,12 +475,6 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
  */
 static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
 
-static void ipi_timer(void)
-{
-	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
-	evt->event_handler(evt);
-}
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void smp_timer_broadcast(const struct cpumask *mask)
 {
@@ -596,11 +590,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 	case IPI_WAKEUP:
 		break;
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
 		irq_enter();
-		ipi_timer();
+		tick_receive_broadcast();
 		irq_exit();
 		break;
+#endif
 
 	case IPI_RESCHEDULE:
 		scheduler_ipi();
-- 
1.7.0.4

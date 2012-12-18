From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Dec 2012 12:06:56 +0000
Subject: [RFC PATCH 3/5] ARM: Use generic timer broadcast receive
In-Reply-To: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1355832418-31692-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the ARM backend must maintain a redundant list of timers for
the purpose of centralising timer broadcast functionality. This prevents
sharing timer drivers across architectures.

This patch moves the pain of dealing with timer broadcasts to the core
clockevents tick broadcast code, which already maintains its own list
of timers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/smp.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 21954bc..59bf6d5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -467,12 +467,6 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
  */
 static DEFINE_PER_CPU(struct clock_event_device, percpu_clockevent);
 
-static void ipi_timer(void)
-{
-	struct clock_event_device *evt = &__get_cpu_var(percpu_clockevent);
-	evt->event_handler(evt);
-}
-
 static void smp_timer_broadcast(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_TIMER);
@@ -586,7 +580,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_TIMER:
 		irq_enter();
-		ipi_timer();
+		tick_receive_broadcast();
 		irq_exit();
 		break;
 
-- 
1.7.0.4

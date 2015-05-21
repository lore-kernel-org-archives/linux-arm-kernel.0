From: dianders@chromium.org (Doug Anderson)
Date: Thu, 21 May 2015 16:53:53 -0700
Subject: [PATCH] RFC: ARM: Don't break affinity for non-balancable IRQs to fix
 perf
Message-ID: <1432252433-25206-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we don't ever try to break affinity for "per CPU" IRQs when
a CPU goes down.  We should apply this logic to all non-balancable
IRQs.

All non-balancable IRQs I've can find are supposed to be targeted at
a specific CPU and don't make sense on other CPUs.  From a "grep" the
list of interrupts possible on ARM devices that are non-balancable and
_not_ per CPU consists of at most things in these files:
- arch/arm/kernel/perf_event_cpu.c
- drivers/clocksource/*.c

It's "perf_event_cpu" that we're trying to fix here.  For
perf_event_cpu, we actually expect to have a single IRQ per CPU.  This
doesn't appear to be an "IRQ_PER_CPU IRQ" because each CPU has a
distinct IRQ number.  However, moving a perf event IRQ from one CPU to
another makes no sense since the IRQ can only be handled on the CPU
that they're destined for (we can't access the relevant CP15 registers
on the other CPUs).  While we could come up with a new concept just
for perf_event_cpu that indicates that we have an non "per cpu" IRQ
that also shoulnd't be migrated, simply using the already present
IRQF_NOBALANCING seems safe and should work just fine.

The clocksource files I've checked appear to use IRQF_NOBALANCING for
interrupts that are also supposed to be destined for a CPU.  For
instance:
- exynos_mct.c: Used for local (per CPU) timers
- qcom-timer.c: Also for local timer
- dw_apb_timer.c: Register function has "cpu" parameter indicating
  that IRQ is targeted at a certain CPU.

Note that without this change if you're doing perf recording across a
suspend/resume cycle (where CPUs go down and then come back up) you'll
get warnings about 'IRQX no longer affine to CPUn', then eventually
get warnings about 'irq X: nobody cared (try booting with the
"irqpoll" option)' and 'Disabling IRQ #X'.  When this happens
(obviously) perf recording stops.  After this change problems are
resolved.

A similar change ought to be made to arm64 and likely to other
architectures as well if this concept of "per cpu" interrupts with
unique irq numbers makes sense there too).

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 350f188..08399fe 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -145,10 +145,10 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	bool ret = false;
 
 	/*
-	 * If this is a per-CPU interrupt, or the affinity does not
+	 * If this is a non-balancable interrupt, or the affinity does not
 	 * include this CPU, then we have nothing to do.
 	 */
-	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
+	if (!irqd_can_balance(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
 		return false;
 
 	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-- 
2.2.0.rc0.207.ga3a616c

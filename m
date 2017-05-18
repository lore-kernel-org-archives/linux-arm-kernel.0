From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 10:07:39 +0200
Subject: [PATCH v3 3/4] irqchip: armada-370-xp: re-enable per-CPU interrupts
 at resume time
In-Reply-To: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1495094860-24709-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d17cab4451df1 ("irqchip: Kill off set_irq_flags usage") changed
the code of armada_370_xp_mpic_irq_map() from using set_irq_flags() to
irq_set_probe().

While the commit log seems to imply that there are no functional
changes, there are indeed functional changes introduced by this commit:
the IRQ_NOAUTOEN flag is no longer cleared. This functional change
caused a regression on Armada XP, which no longer works properly after
suspend/resume because per-CPU interrupts remain disabled. This
regression was temporarly worked around in commit
353d6d6c82e5d ("irqchip/armada-370-xp: Fix regression by clearing
IRQ_NOAUTOEN"), but it is not the most satisfying solution. This commit
implements the solution that was initially discussed with Thomas
Gleixner.

Due to how the hardware registers work, the irq-armada-370-xp cannot
simply save/restore a bunch of registers at suspend/resume to make sure
that the interrupts remain in the same state after resuming. Therefore,
it relies on the kernel to say whether the interrupt is disabled or not,
using the irqd_irq_disabled() function. This was all working fine while
the IRQ_NOAUTOEN flag was cleared.

With the change introduced by Rob Herring in d17cab4451df1, the
IRQ_NOAUTOEN flag is now set for all interrupts. irqd_irq_disabled()
returns false for per-CPU interrupts, and therefore our per-CPU
interrupts are no longer re-enabled after resume.

This commit fixes that by using irqd_irq_disabled() only for global
interrupts, and using the newly introduced irq_percpu_is_enabled() for
per-CPU interrupts.

Also, it fixes a related problems that per-CPU interrupts were only
re-enabled on the boot CPU and not other CPUs. Until now this wasn't a
problem since on this platform, only the local timers are using per-CPU
interrupts and the local timers of secondary CPUs are turned off/on
during CPU hotplug before suspend, after after resume. However, since
Linux 4.4, we are also be using per-CPU interrupts for the network
controller, so we need to properly restore the per-CPU interrupts on
secondary CPUs as well.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 46 ++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 1f7dea6..1d4de6e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -360,7 +360,6 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 		irq_set_percpu_devid(virq);
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_percpu_devid_irq);
-
 	} else {
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_level_irq);
@@ -424,16 +423,40 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
 		ARMADA_370_XP_SW_TRIG_INT_OFFS);
 }
 
+static void armada_xp_mpic_reenable_percpu(void)
+{
+	unsigned int irq;
+
+	/* Re-enable per-CPU interrupts that were enabled before suspend */
+	for (irq = 0; irq < ARMADA_370_XP_MAX_PER_CPU_IRQS; irq++) {
+		struct irq_data *data;
+		int virq;
+
+		virq = irq_linear_revmap(armada_370_xp_mpic_domain, irq);
+		if (virq == 0)
+			continue;
+
+		data = irq_get_irq_data(virq);
+
+		if (!irq_percpu_is_enabled(virq))
+			continue;
+
+		armada_370_xp_irq_unmask(data);
+	}
+}
+
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
 {
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
+	armada_xp_mpic_reenable_percpu();
 	return 0;
 }
 
 static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
 	armada_xp_mpic_perf_init();
+	armada_xp_mpic_reenable_percpu();
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
 	return 0;
 }
@@ -581,16 +604,27 @@ static void armada_370_xp_mpic_resume(void)
 		if (virq == 0)
 			continue;
 
-		if (!is_percpu_irq(irq))
+		data = irq_get_irq_data(virq);
+
+		if (!is_percpu_irq(irq)) {
+			/* Non per-CPU interrupts */
 			writel(irq, per_cpu_int_base +
 			       ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-		else
+			if (!irqd_irq_disabled(data))
+				armada_370_xp_irq_unmask(data);
+		} else {
+			/* Per-CPU interrupts */
 			writel(irq, main_int_base +
 			       ARMADA_370_XP_INT_SET_ENABLE_OFFS);
 
-		data = irq_get_irq_data(virq);
-		if (!irqd_irq_disabled(data))
-			armada_370_xp_irq_unmask(data);
+			/*
+			 * Re-enable on the current CPU,
+			 * armada_xp_mpic_reenable_percpu() will take
+			 * care of secondary CPUs when they come up.
+			 */
+			if (irq_percpu_is_enabled(virq))
+				armada_370_xp_irq_unmask(data);
+		}
 	}
 
 	/* Reconfigure doorbells for IPIs and MSIs */
-- 
2.7.4

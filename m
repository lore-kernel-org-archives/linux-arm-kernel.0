From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  9 May 2014 17:37:44 +0100
Subject: [PATCH] arm64: use cpu_online_mask when using forced irq_set_affinity
Message-ID: <1399653464-21410-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

Commit 01f8fa4f01d8("genirq: Allow forcing cpu affinity of interrupts")
enabled the forced irq_set_affinity which previously refused to route an
interrupt to an offline cpu.

Commit ffde1de64012("irqchip: Gic: Support forced affinity setting")
implements this force logic and disables the cpu online check for GIC
interrupt controller.

When __cpu_disable calls migrate_irqs, it disables the current cpu in
cpu_online_mask and uses forced irq_set_affinity to migrate the IRQs
away from the cpu but passes affinity mask with the cpu being offlined
also included in it.

When calling irq_set_affinity with force == true in a cpu hotplug path,
the caller must ensure that the cpu being offlined is not present in the
affinity mask or it may be selected as the target CPU, leading to the
interrupt not being migrated.

This patch uses cpu_online_mask when using forced irq_set_affinity so
that the IRQs are properly migrated away.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
Hi Catalin,

If you are fine with this change, can you pick up this fix ?

Regards,
Sudeep

 arch/arm64/kernel/irq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 473e5db..0f08dfd 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -97,11 +97,15 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
 		return false;
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-		affinity = cpu_online_mask;
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
 		ret = true;
-	}
 
+	/*
+	 * when using forced irq_set_affinity we must ensure that the cpu
+	 * being offlined is not present in the affinity mask, it may be
+	 * selected as the target CPU otherwise
+	 */
+	affinity = cpu_online_mask;
 	c = irq_data_get_irq_chip(d);
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-- 
1.8.3.2

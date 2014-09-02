From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  2 Sep 2014 11:35:24 +0100
Subject: [PATCH] arm64: use irq_set_affinity with force=false when migrating
 irqs
Message-ID: <1409654124-7358-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

The arm64 interrupt migration code on cpu offline calls
irqchip.irq_set_affinity() with the argument force=true. Originally
this argument had no effect because it was not used by any interrupt
chip driver and there was no semantics defined.

This changed with commit 01f8fa4f01d8 ("genirq: Allow forcing cpu
affinity of interrupts") which made the force argument useful to route
interrupts to not yet online cpus without checking the target cpu
against the cpu online mask. The following commit ffde1de64012
("irqchip: gic: Support forced affinity setting") implemented this for
the GIC interrupt controller.

As a consequence the cpu offline irq migration fails if CPU0 is
offlined, because CPU0 is still set in the affinity mask and the
validation against cpu online mask is skipped to the force argument
being true. The following first_cpu(mask) selection always selects
CPU0 as the target.

Commit 601c942176d8("arm64: use cpu_online_mask when using forced
irq_set_affinity") intended to fix the above mentioned issue but
introduced another issue where affinity can be migrated to a wrong
CPU due to unconditional copy of cpu_online_mask.

As with for arm, solve the issue by calling irq_set_affinity() with
force=false from the CPU offline irq migration code so the GIC driver
validates the affinity mask against CPU online mask and therefore
removes CPU0 from the possible target candidates. Also revert the
changes done in the commit 601c942176d8 as it's no longer needed.

Tested on Juno platform.

Fixes: 601c942176d8("arm64: use cpu_online_mask when using forced
	irq_set_affinity")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org> # 3.10.x
---
 arch/arm64/kernel/irq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Hi Will,

After both Russell and Thomas agreed on the fix for ARM[0][1], I have
similar fix for ARM64 with change log giving background as suggested
by Thomas. It would be good if you can take this for next -rc fix.

Regards,
Sudeep

[0] http://www.spinics.net/lists/arm-kernel/msg358336.html
[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8133/1

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 0f08dfd69ebc..dfa6e3e74fdd 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -97,19 +97,15 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
 		return false;
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+		affinity = cpu_online_mask;
 		ret = true;
+	}
 
-	/*
-	 * when using forced irq_set_affinity we must ensure that the cpu
-	 * being offlined is not present in the affinity mask, it may be
-	 * selected as the target CPU otherwise
-	 */
-	affinity = cpu_online_mask;
 	c = irq_data_get_irq_chip(d);
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
+	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
 		cpumask_copy(d->affinity, affinity);
 
 	return ret;
-- 
1.8.3.2

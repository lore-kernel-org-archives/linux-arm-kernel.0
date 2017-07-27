From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 27 Jul 2017 12:21:11 +0200 (CEST)
Subject: [PATCH] genirq/cpuhotplug: Revert "Set force affinity flag on hotplug
 migration"
Message-ID: <alpine.DEB.2.20.1707271217590.3109@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That commit was part of the changes moving x86 to the generic CPU hotplug
interrupt migration code. The force flag was required on x86 before the
hierarchical irqdomain rework, but invoking set_affinity() with force=true
stayed and had no side effects.

At some point in the past, the force flag got repurposed to support the
exynos timer interrupt affinity setting to a not yet online CPU, so the
interrupt controller callback does not verify the supplied affinity mask
against cpu_online_mask.

Setting the flag in the CPU hotplug code causes the cpu online masking to
be blocked on these irq controllers and results in potentially affining an
interrupt to the CPU which is unplugged, i.e. instead of moving it away,
it's just reassigned to it.

As the force flags is not longer needed on x86, it's safe to revert that
patch so the ARM irqchips which use the force flag work again.

Add comments to that effect, so this won't happen again.

Note: The online mask handling should be done in the generic code and the
force flag and the masking in the irq chips removed all together, but
that's not a change possible for 4.13. 

Fixes: 77f85e66aa8b ("genirq/cpuhotplug: Set force affinity flag on hotplug migration")
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h     |    7 ++++++-
 kernel/irq/cpuhotplug.c |    9 +++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -388,7 +388,12 @@ static inline irq_hw_number_t irqd_to_hw
  * @irq_mask_ack:	ack and mask an interrupt source
  * @irq_unmask:		unmask an interrupt source
  * @irq_eoi:		end of interrupt
- * @irq_set_affinity:	set the CPU affinity on SMP machines
+ * @irq_set_affinity:	Set the CPU affinity on SMP machines. If the force
+ *			argument is true, it tells the driver to
+ *			unconditionally apply the affinity setting. Sanity
+ *			checks against the supplied affinity mask are not
+ *			required. This is used for CPU hotplug where the
+ *			target CPU is not yet set in the cpu_online_mask.
  * @irq_retrigger:	resend an IRQ to the CPU
  * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -95,8 +95,13 @@ static bool migrate_one_irq(struct irq_d
 		affinity = cpu_online_mask;
 		brokeaff = true;
 	}
-
-	err = irq_do_set_affinity(d, affinity, true);
+	/*
+	 * Do not set the force argument of irq_do_set_affinity() as this
+	 * disables the masking of offline CPUs from the supplied affinity
+	 * mask and therefor might keep/reassign the irq to the outgoing
+	 * CPU.
+	 */
+	err = irq_do_set_affinity(d, affinity, false);
 	if (err) {
 		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 				    d->irq, err);

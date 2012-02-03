From: will.deacon@arm.com (Will Deacon)
Date: Fri,  3 Feb 2012 10:26:43 +0000
Subject: [PATCH v2] ARM: hotplug: copy the affinity mask when forcefully
 migrating IRQs
Message-ID: <1328264803-15062-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is hotplugged off, we migrate any IRQs currently affine to it
away and onto another online CPU by calling the irq_set_affinity
function of the relevant interrupt controller chip. This function
returns either IRQ_SET_MASK_OK or IRQ_SET_MASK_OK_NOCOPY, to indicate
whether irq_data.affinity was updated.

If we are forcefully migrating an interrupt (because the affinity mask
no longer identifies any online CPUs) then we should update the IRQ
affinity mask to reflect the new CPU set. Failure to do so can
potentially leave /proc/irq/n/smp_affinity identifying only offline
CPUs, which may confuse userspace IRQ balancing daemons.

This patch updates migrate_one_irq to copy the affinity mask when
the interrupt chip returns IRQ_SET_MASK_OK after forcefully changing the
affinity of an interrupt.

Reported-by: Leif Lindholm <leif.lindholm@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v2: Only update the affinity mask if we have to change the IRQ
    forcefully.

 arch/arm/kernel/irq.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 3f86ee1..0d8c17c 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -156,10 +156,10 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	}
 
 	c = irq_data_get_irq_chip(d);
-	if (c->irq_set_affinity)
-		c->irq_set_affinity(d, affinity, true);
-	else
+	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
+	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
+		cpumask_copy(d->affinity, affinity);
 
 	return ret;
 }
-- 
1.7.4.1

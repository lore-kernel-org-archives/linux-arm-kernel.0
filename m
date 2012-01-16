From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 15:41:47 +0000
Subject: [PATCH] ARM: hotplug: ensure that we copy the affinity mask when
 migrating IRQs
Message-ID: <1326728507-9916-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is hotplugged off, we migrate any IRQs currently affine to it
away and onto another online CPU by calling the irq_set_affinity function
of the relevant interrupt controller chip. This function returns either
IRQ_SET_MASK_OK or IRQ_SET_MASK_OK_NOCOPY, to indicate whether
irq_data.affinity was updated. In the case of the former, the migration
code should update the mask itself, as is done by irq_set_affinity.

The current code does not update affinity mask and potentially leaves
/proc/irq/n/smp_affinity identifying an offline CPU, which confuses
userspace IRQ balancing daemons.

This patch updates migrate_one_irq to copy the affinity mask when
the interrupt chip returns IRQ_SET_MASK_OK after changing the affinity
of an interrupt.

Reported-by: Leif Lindholm <leif.lindholm@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/irq.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 3efd82c..831435d 100644
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
+	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK)
+		cpumask_copy(d->affinity, affinity);
 
 	return ret;
 }
-- 
1.7.4.1

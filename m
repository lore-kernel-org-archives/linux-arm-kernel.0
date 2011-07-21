From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 16:24:55 +0100
Subject: [PATCH 2/4] ARM: GIC: avoid routing interrupts to offline CPUs
In-Reply-To: <20110721151413.GD28942@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
Message-ID: <E1Qjv7P-0003IW-0l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_set_affinity() method can be called with masks which include
offline CPUs.  This allows offline CPUs to have interrupts routed to
them by writing to /proc/irq/*/smp_affinity after hotplug has taken
a CPU offline.  Fix this by ensuring that we select a target CPU
present in both the required affinity and the online CPU mask.

Ensure that we return IRQ_SET_MASK_OK (which happens to be 0) on
success to ensure generic code copies the new mask into the irq_data
structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 635d985..7bdd917 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -179,10 +179,10 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
 	unsigned int shift = (d->irq % 4) * 8;
-	unsigned int cpu = cpumask_first(mask_val);
+	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
 	u32 val, mask, bit;
 
-	if (cpu >= 8)
+	if (cpu >= 8 || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
 	mask = 0xff << shift;
@@ -193,7 +193,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	writel_relaxed(val | bit, reg);
 	spin_unlock(&irq_controller_lock);
 
-	return 0;
+	return IRQ_SET_MASK_OK;
 }
 #endif
 
-- 
1.7.4.4

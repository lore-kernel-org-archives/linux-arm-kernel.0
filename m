From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 16:24:34 +0100
Subject: [PATCH 1/4] ARM: CPU hotplug: fix abuse of irqdesc->node
In-Reply-To: <20110721151413.GD28942@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
Message-ID: <E1Qjv74-0003IS-Qn@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irqdesc's node member is supposed to mark the numa node number for the
interrupt.  Our use of it is non-standard.  Remove this, replacing the
functionality with a test of the affinity mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c |    1 -
 arch/arm/kernel/irq.c |   10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4ddd0a6..635d985 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -189,7 +189,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	bit = 1 << (cpu + shift);
 
 	spin_lock(&irq_controller_lock);
-	d->node = cpu;
 	val = readl_relaxed(reg) & ~mask;
 	writel_relaxed(val | bit, reg);
 	spin_unlock(&irq_controller_lock);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 83bbad0..d7aa5c9 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -166,15 +166,9 @@ void migrate_irqs(void)
 		bool affinity_broken = false;
 
 		raw_spin_lock(&desc->lock);
-		do {
-			if (desc->action == NULL)
-				break;
-
-			if (d->node != cpu)
-				break;
-
+		if (desc->action != NULL &&
+		    cpumask_test_cpu(smp_processor_id(), d->affinity))
 			affinity_broken = migrate_one_irq(d);
-		} while (0);
 		raw_spin_unlock(&desc->lock);
 
 		if (affinity_broken && printk_ratelimit())
-- 
1.7.4.4

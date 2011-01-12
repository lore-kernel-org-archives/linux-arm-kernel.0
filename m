From: taohu@motorola.com (Tao Hu)
Date: Wed, 12 Jan 2011 10:10:16 -0500
Subject: [PATCH] [RFC]ARM:Let GIC to route IRQs to any allowed CPUs
Message-ID: <mailman.118.1294820339.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current logic will always route IRQs to the first allowed CPU
Following two commands have the same result (all IRQs to CPU0)
cmd1: $ echo 3 > proc/irq/xxx/smp_affinity
cmd2: $ echo 1 > proc/irq/xxx/smp_affinity
While below command will route all IRQs to CPU1
cmd3: $ echo 2 > proc/irq/xxx/smp_affinity

With this patch, cmd1 will route IRQs to both CPU0 and CPU1
Meanwhile, cmd2 and cmd3 will work as before

Change-Id: Ife8e466ded7c18b4b050a4bc64b62346c063a93b
Signed-off-by: Tao Hu <taohu@motorola.com>
---
 arch/arm/common/gic.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index bceb9cb..4904988 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -105,7 +105,11 @@ static int gic_set_cpu(unsigned int irq, const
struct cpumask *mask_val)
 	spin_lock(&irq_controller_lock);
 	irq_desc[irq].node = cpu;
 	val = readl(reg) & ~(0xff << shift);
-	val |= 1 << (cpu + shift);
+	do {
+		val |= 1 << (cpu + shift);
+		cpu = cpumask_next(cpu, mask_val);
+	} while (cpu < nr_cpu_ids);
+
 	writel(val, reg);
 	spin_unlock(&irq_controller_lock);

-- 
1.7.1

From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Wed, 31 Aug 2011 22:48:06 +0800
Subject: [PATCH] arm: gic: fix gic_set_affinity
Message-ID: <1314802086-26133-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <tom.leiming@gmail.com>

Current gic_set_affinity doesn't support to route irq to all cpu,
so fix it.

Also remove the unnecessary check for 'cpu' since cpu_online_mask
is already ADDed to produce correct one.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/common/gic.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 3227ca9..20890f4 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -173,14 +173,14 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 {
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
 	unsigned int shift = (d->irq % 4) * 8;
-	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
-	u32 val, mask, bit;
+	unsigned int cpu;
+	u32 val, mask, bit, cpuset = 0;
 
-	if (cpu >= 8 || cpu >= nr_cpu_ids)
-		return -EINVAL;
+	for_each_cpu_and(cpu, mask_val, cpu_online_mask)
+		cpuset |= 1 << cpu;
 
 	mask = 0xff << shift;
-	bit = 1 << (cpu + shift);
+	bit = cpuset << shift;
 
 	spin_lock(&irq_controller_lock);
 	val = readl_relaxed(reg) & ~mask;
-- 
1.7.4.1

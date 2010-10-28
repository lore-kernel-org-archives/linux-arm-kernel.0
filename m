From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 28 Oct 2010 14:03:54 +0900
Subject: [PATCH] arm: GIC: Use the irq_to_desc for SPARSE IRQ
Message-ID: <20101028050354.GA23284@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

When enable SPARSE_IRQ, there's compiler error at gic.c
Fix it by using the irq_to_desc to get the proper irq desc.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 7dfa9a8..1ca3c0d 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -158,15 +158,19 @@ static int gic_set_cpu(unsigned int irq, const struct cpumask *mask_val)
 {
 	void __iomem *reg = gic_dist_base(irq) + GIC_DIST_TARGET + (gic_irq(irq) & ~3);
 	unsigned int shift = (irq % 4) * 8;
-	unsigned int cpu = cpumask_first(mask_val);
+	unsigned int node = cpumask_first(mask_val);
+	struct irq_desc *desc;
 	u32 val;
 
-	spin_lock(&irq_controller_lock);
-	irq_desc[irq].node = cpu;
-	val = readl(reg) & ~(0xff << shift);
-	val |= 1 << (cpu + shift);
-	writel(val, reg);
-	spin_unlock(&irq_controller_lock);
+	desc = irq_to_desc(irq);
+	if (desc) {
+		spin_lock(&irq_controller_lock);
+		desc->node = node;
+		val = readl(reg) & ~(0xff << shift);
+		val |= 1 << (node + shift);
+		writel(val, reg);
+		spin_unlock(&irq_controller_lock);
+	}
 
 	return 0;
 }

From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Oct 2011 09:36:09 -0500
Subject: [PATCH v2] ARM: gic: fix irq_alloc_descs handling for sparse irq
In-Reply-To: <1319314808-27007-1-git-send-email-robherring2@gmail.com>
References: <1319314808-27007-1-git-send-email-robherring2@gmail.com>
Message-ID: <1319466969-5034-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Commit "ARM: gic: add irq_domain support" (2071a2a4b8ed5292) broke SPARSE_IRQ
on platforms with GIC. When SPARSE_IRQ is enabled, all NR_IRQS or
mach_desc->nr_irqs will be allocated by arch_probe_nr_irqs(). This caused
irq_alloc_descs to allocate irq_descs after the pre-allocated space.

Make irq_alloc_descs search for an exact irq range and assume it has
been pre-allocated on failure. For DT probing dynamic allocation is used.
DT enabled platforms should set their nr_irqs to NR_IRQ_LEGACY and have all
irq_chips allocate their irq_descs with irq_alloc_descs if SPARSE_IRQ is
enabled.

gic_init irq_start param is changed to be signed with negative meaning do
dynamic Linux irq assigment.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
v2:
 - make irq_start signed

 arch/arm/common/gic.c               |   15 +++++++++++----
 arch/arm/include/asm/hardware/gic.h |    2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 65cf39d..e9debd4 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -24,6 +24,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/err.h>
 #include <linux/list.h>
 #include <linux/smp.h>
 #include <linux/cpu_pm.h>
@@ -550,7 +551,7 @@ const struct irq_domain_ops gic_irq_domain_ops = {
 #endif
 };
 
-void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
+void __init gic_init(unsigned int gic_nr, int irq_start,
 	void __iomem *dist_base, void __iomem *cpu_base)
 {
 	struct gic_chip_data *gic;
@@ -571,7 +572,8 @@ void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	if (gic_nr == 0) {
 		gic_cpu_base_addr = cpu_base;
 		domain->hwirq_base = 16;
-		irq_start = (irq_start & ~31) + 16;
+		if (irq_start > 0)
+			irq_start = (irq_start & ~31) + 16;
 	} else
 		domain->hwirq_base = 32;
 
@@ -586,8 +588,13 @@ void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	gic->gic_irqs = gic_irqs;
 
 	domain->nr_irq = gic_irqs - domain->hwirq_base;
-	domain->irq_base = irq_alloc_descs(-1, irq_start, domain->nr_irq,
+	domain->irq_base = irq_alloc_descs(irq_start, 16, domain->nr_irq,
 					   numa_node_id());
+	if (IS_ERR_VALUE(domain->irq_base)) {
+		WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+		     irq_start);
+		domain->irq_base = irq_start;
+	}
 	domain->priv = gic;
 	domain->ops = &gic_irq_domain_ops;
 	irq_domain_add(domain);
@@ -657,7 +664,7 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 
 	domain->of_node = of_node_get(node);
 
-	gic_init(gic_cnt, 16, dist_base, cpu_base);
+	gic_init(gic_cnt, -1, dist_base, cpu_base);
 
 	if (parent) {
 		irq = irq_of_parse_and_map(node, 0);
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 1a776a1..0ea4122 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -38,7 +38,7 @@
 extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
-void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
+void gic_init(unsigned int, int, void __iomem *, void __iomem *);
 int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
-- 
1.7.5.4

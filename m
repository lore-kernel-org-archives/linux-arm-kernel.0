From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:11 +0800
Subject: [PATCH v3 5/8] irqchip / GICv3: Refactor gic_of_init() for GICv3
 driver
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-6-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Isolate hardware abstraction (FDT) code to gic_of_init().
Rest of the logic goes to gic_init_bases() and expects well
defined data to initialize GIC properly. The same solution
is used for GICv2 driver.

This is needed for ACPI initialization later.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 105 +++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c52f7ba..aeba1cc 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -766,17 +766,69 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.free = gic_irq_domain_free,
 };
 
+static int __init gic_init_bases(void __iomem *dist_base,
+			    struct redist_region *rdist_regs,
+			    u32 nr_redist_regions,
+			    u64 redist_stride,
+			    struct device_node *node)
+{
+	u32 typer;
+	int gic_irqs;
+	int err;
+
+	gic_data.dist_base = dist_base;
+	gic_data.redist_regions = rdist_regs;
+	gic_data.nr_redist_regions = nr_redist_regions;
+	gic_data.redist_stride = redist_stride;
+
+	/*
+	 * Find out how many interrupts are supported.
+	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
+	 */
+	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
+	gic_data.rdists.id_bits = GICD_TYPER_ID_BITS(typer);
+	gic_irqs = GICD_TYPER_IRQS(typer);
+	if (gic_irqs > 1020)
+		gic_irqs = 1020;
+	gic_data.irq_nr = gic_irqs;
+
+	gic_data.domain = irq_domain_add_tree(node, &gic_irq_domain_ops,
+					      &gic_data);
+	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
+
+	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	set_handle_irq(gic_handle_irq);
+
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+		its_init(node, &gic_data.rdists, gic_data.domain);
+
+	gic_smp_init();
+	gic_dist_init();
+	gic_cpu_init();
+	gic_cpu_pm_init();
+
+	return 0;
+
+out_free:
+	if (gic_data.domain)
+		irq_domain_remove(gic_data.domain);
+	free_percpu(gic_data.rdists.rdist);
+	return err;
+}
+
+#ifdef CONFIG_OF
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	u64 redist_stride;
 	u32 nr_redist_regions;
-	u32 typer;
 	u32 reg;
-	int gic_irqs;
-	int err;
-	int i;
+	int err, i;
 
 	dist_base = of_iomap(node, 0);
 	if (!dist_base) {
@@ -820,47 +872,11 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
 		redist_stride = 0;
 
-	gic_data.dist_base = dist_base;
-	gic_data.redist_regions = rdist_regs;
-	gic_data.nr_redist_regions = nr_redist_regions;
-	gic_data.redist_stride = redist_stride;
-
-	/*
-	 * Find out how many interrupts are supported.
-	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
-	 */
-	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
-	gic_data.rdists.id_bits = GICD_TYPER_ID_BITS(typer);
-	gic_irqs = GICD_TYPER_IRQS(typer);
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
-	gic_data.irq_nr = gic_irqs;
+	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
+			     redist_stride, node);
+	if (!err)
+		return 0;
 
-	gic_data.domain = irq_domain_add_tree(node, &gic_irq_domain_ops,
-					      &gic_data);
-	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
-
-	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-
-	set_handle_irq(gic_handle_irq);
-
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(node, &gic_data.rdists, gic_data.domain);
-
-	gic_smp_init();
-	gic_dist_init();
-	gic_cpu_init();
-	gic_cpu_pm_init();
-
-	return 0;
-
-out_free:
-	if (gic_data.domain)
-		irq_domain_remove(gic_data.domain);
-	free_percpu(gic_data.rdists.rdist);
 out_unmap_rdist:
 	for (i = 0; i < nr_redist_regions; i++)
 		if (rdist_regs[i].redist_base)
@@ -872,3 +888,4 @@ out_unmap_dist:
 }
 
 IRQCHIP_DECLARE(gic_v3, "arm,gic-v3", gic_of_init);
+#endif
-- 
1.9.1

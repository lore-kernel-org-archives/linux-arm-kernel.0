From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 16:05:10 +0200
Subject: [PATCH V1 01/10] irqchip / GICv3: Refactor gic_of_init() for GICv3
 driver
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Message-ID: <1444917919-21152-2-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Isolate hardware abstraction (FDT) code to gic_of_init().
Rest of the logic goes to gic_init_bases() and expects well
defined data to initialize GIC properly. The same solution
is used for GICv2 driver.

This is needed for ACPI initialization later.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 130 ++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 52 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 048f020c..e146e20 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -837,59 +837,16 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.free = gic_irq_domain_free,
 };
 
-static int __init gic_of_init(struct device_node *node, struct device_node *parent)
+static int __init gic_init_bases(void __iomem *dist_base,
+				 struct redist_region *rdist_regs,
+				 u32 nr_redist_regions,
+				 u64 redist_stride,
+				 struct fwnode_handle *handle)
 {
-	void __iomem *dist_base;
-	struct redist_region *rdist_regs;
-	u64 redist_stride;
-	u32 nr_redist_regions;
+	struct device_node *node;
 	u32 typer;
-	u32 reg;
 	int gic_irqs;
 	int err;
-	int i;
-
-	dist_base = of_iomap(node, 0);
-	if (!dist_base) {
-		pr_err("%s: unable to map gic dist registers\n",
-			node->full_name);
-		return -ENXIO;
-	}
-
-	reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
-	if (reg != GIC_PIDR2_ARCH_GICv3 && reg != GIC_PIDR2_ARCH_GICv4) {
-		pr_err("%s: no distributor detected, giving up\n",
-			node->full_name);
-		err = -ENODEV;
-		goto out_unmap_dist;
-	}
-
-	if (of_property_read_u32(node, "#redistributor-regions", &nr_redist_regions))
-		nr_redist_regions = 1;
-
-	rdist_regs = kzalloc(sizeof(*rdist_regs) * nr_redist_regions, GFP_KERNEL);
-	if (!rdist_regs) {
-		err = -ENOMEM;
-		goto out_unmap_dist;
-	}
-
-	for (i = 0; i < nr_redist_regions; i++) {
-		struct resource res;
-		int ret;
-
-		ret = of_address_to_resource(node, 1 + i, &res);
-		rdist_regs[i].redist_base = of_iomap(node, 1 + i);
-		if (ret || !rdist_regs[i].redist_base) {
-			pr_err("%s: couldn't map region %d\n",
-			       node->full_name, i);
-			err = -ENODEV;
-			goto out_unmap_rdist;
-		}
-		rdist_regs[i].phys_base = res.start;
-	}
-
-	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
-		redist_stride = 0;
 
 	if (!is_hyp_mode_available())
 		static_key_slow_dec(&supports_deactivate);
@@ -913,8 +870,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		gic_irqs = 1020;
 	gic_data.irq_nr = gic_irqs;
 
-	gic_data.domain = irq_domain_add_tree(node, &gic_irq_domain_ops,
-					      &gic_data);
+	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
+						 &gic_data);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
@@ -924,7 +881,9 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	set_handle_irq(gic_handle_irq);
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+	node = to_of_node(handle);
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
+	    node) /* Temp hack to prevent ITS init for ACPI */
 		its_init(node, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
@@ -938,6 +897,73 @@ out_free:
 	if (gic_data.domain)
 		irq_domain_remove(gic_data.domain);
 	free_percpu(gic_data.rdists.rdist);
+	return err;
+}
+
+static int __init gic_validate_dist_version(void __iomem *dist_base)
+{
+	u32 reg = readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
+
+	if (reg != GIC_PIDR2_ARCH_GICv3 && reg != GIC_PIDR2_ARCH_GICv4)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int __init gic_of_init(struct device_node *node, struct device_node *parent)
+{
+	void __iomem *dist_base;
+	struct redist_region *rdist_regs;
+	u64 redist_stride;
+	u32 nr_redist_regions;
+	int err, i;
+
+	dist_base = of_iomap(node, 0);
+	if (!dist_base) {
+		pr_err("%s: unable to map gic dist registers\n",
+			node->full_name);
+		return -ENXIO;
+	}
+
+	err = gic_validate_dist_version(dist_base);
+	if (err) {
+		pr_err("%s: no distributor detected, giving up\n",
+			node->full_name);
+		goto out_unmap_dist;
+	}
+
+	if (of_property_read_u32(node, "#redistributor-regions", &nr_redist_regions))
+		nr_redist_regions = 1;
+
+	rdist_regs = kzalloc(sizeof(*rdist_regs) * nr_redist_regions, GFP_KERNEL);
+	if (!rdist_regs) {
+		err = -ENOMEM;
+		goto out_unmap_dist;
+	}
+
+	for (i = 0; i < nr_redist_regions; i++) {
+		struct resource res;
+		int ret;
+
+		ret = of_address_to_resource(node, 1 + i, &res);
+		rdist_regs[i].redist_base = of_iomap(node, 1 + i);
+		if (ret || !rdist_regs[i].redist_base) {
+			pr_err("%s: couldn't map region %d\n",
+			       node->full_name, i);
+			err = -ENODEV;
+			goto out_unmap_rdist;
+		}
+		rdist_regs[i].phys_base = res.start;
+	}
+
+	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
+		redist_stride = 0;
+
+	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
+			     redist_stride, &node->fwnode);
+	if (!err)
+		return 0;
+
 out_unmap_rdist:
 	for (i = 0; i < nr_redist_regions; i++)
 		if (rdist_regs[i].redist_base)
-- 
1.9.1

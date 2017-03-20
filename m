From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Mar 2017 15:36:14 -0700
Subject: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility mode
Message-ID: <20170320223614.1351-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GIC configurations don't have an ITS or v2m frame, but they
want to support MSIs through the distributor's "v2m backwards
compatible" mode. This mode allows software written for the v2m
to treat the distributor as the only frame and support a limited
number of MSIs through a direct write to the same register offset
(0x40) as what exists in v2m.

Support this mode of operation by detecting if a gicv3 device
node has the "msi-controller" property, and then probe the v2m
frame code on top of the distributor base. Rely on existing v2m
DT properties to tell us about the number of SPIs and where they
start from because the GICD_TYPER register doesn't tell us this
information.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v2m.c          | 66 ++++++++++++++++++++++++----------
 drivers/irqchip/irq-gic-v3.c           |  4 +++
 include/linux/irqchip/arm-gic-common.h |  3 ++
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 863e073c6f7f..4e0d3493c510 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/arm-gic-common.h>
 
 /*
 * MSI_TYPER:
@@ -388,6 +389,36 @@ static struct of_device_id gicv2m_device_id[] = {
 	{},
 };
 
+static int __init giv2m_of_init_one(struct device_node *child, bool force)
+{
+	u32 spi_start = 0, nr_spis = 0;
+	struct resource res;
+	int ret;
+
+	if (!of_find_property(child, "msi-controller", NULL))
+		return force ? -EINVAL : 0;
+
+	ret = of_address_to_resource(child, 0, &res);
+	if (ret) {
+		pr_err("Failed to allocate v2m resource\n");
+		return ret;
+	}
+
+	if (!of_property_read_u32(child, "arm,msi-base-spi",
+				  &spi_start) &&
+	    !of_property_read_u32(child, "arm,msi-num-spis", &nr_spis))
+		if (!force)
+			pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+				spi_start, nr_spis);
+
+	if (force && !nr_spis) {
+		pr_err("Can't emulate v2m without num-spis\n");
+		return -EINVAL;
+	}
+
+	return gicv2m_init_one(&child->fwnode, spi_start, nr_spis, &res);
+}
+
 static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 				 struct irq_domain *parent)
 {
@@ -397,25 +428,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 	for (child = of_find_matching_node(node, gicv2m_device_id); child;
 	     child = of_find_matching_node(child, gicv2m_device_id)) {
-		u32 spi_start = 0, nr_spis = 0;
-		struct resource res;
-
-		if (!of_find_property(child, "msi-controller", NULL))
-			continue;
-
-		ret = of_address_to_resource(child, 0, &res);
-		if (ret) {
-			pr_err("Failed to allocate v2m resource.\n");
-			break;
-		}
-
-		if (!of_property_read_u32(child, "arm,msi-base-spi",
-					  &spi_start) &&
-		    !of_property_read_u32(child, "arm,msi-num-spis", &nr_spis))
-			pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
-				spi_start, nr_spis);
-
-		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis, &res);
+		ret = giv2m_of_init_one(child, false);
 		if (ret) {
 			of_node_put(child);
 			break;
@@ -518,6 +531,21 @@ static int __init gicv2m_acpi_init(struct irq_domain *parent)
 }
 #endif /* CONFIG_ACPI */
 
+int __init gicv2m_init_gicv3(struct fwnode_handle *handle,
+			     struct irq_domain *parent)
+{
+	int ret;
+	struct device_node *node = to_of_node(handle);
+
+	ret = giv2m_of_init_one(node, true);
+	if (!ret)
+		ret = gicv2m_allocate_domains(parent);
+	if (ret)
+		gicv2m_teardown();
+
+	return ret;
+}
+
 int __init gicv2m_init(struct fwnode_handle *parent_handle,
 		       struct irq_domain *parent)
 {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6c65eb917db6..9051d889c23e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1170,6 +1170,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_populate_ppi_partitions(node);
 	gic_of_setup_kvm_info(node);
+
+	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+		gicv2m_init_gicv3(&node->fwnode, gic_data.domain);
+
 	return 0;
 
 out_unmap_rdist:
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index c647b0547bcd..43207a0cbd39 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -31,4 +31,7 @@ struct gic_kvm_info {
 
 const struct gic_kvm_info *gic_get_kvm_info(void);
 
+int gicv2m_init_gicv3(struct fwnode_handle *parent_handle,
+		      struct irq_domain *parent);
+
 #endif /* __LINUX_IRQCHIP_ARM_GIC_COMMON_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

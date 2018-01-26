From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jan 2018 16:46:51 -0800
Subject: [PATCH/RESEND] irqchip/gic-v3: Support MSIs via aliases and
 distributor
Message-ID: <20180126004651.19400-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GIC configurations don't have an accessible ITS, but they
want to support MSIs through the distributor's SETSPI registers
or through the IMPLEMENTATION DEFINED message-based interrupt
request register region. This mode of operation is similar to the
v2m support on gic-400, but we don't necessarily know what
particular SPIs are supported as MSIs so we need some help from
firmware to know what to do.

Introduce an "arm,spi-ranges" property for this, similar to the
"marvell,spi-ranges" property, that indicates the base and size
of each MSI range. This property applies equally to the
distributor and alias registers. In either case, we detect this
mode of operation by looking for a node with the "msi-controller"
property and then probe the v2m frame code on top of it. Assume
these nodes will have the "arm,spi-ranges" property in them so
that the v2m code works mostly unmodified.

Cc: <devicetree@vger.kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Picked up acks/tested-by.

 .../bindings/interrupt-controller/arm,gic-v3.txt   |  48 +++++++++-
 drivers/irqchip/irq-gic-v2m.c                      | 102 ++++++++++++++++-----
 drivers/irqchip/irq-gic-v3.c                       |   4 +
 include/linux/irqchip/arm-gic-common.h             |   3 +
 4 files changed, 129 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..ef319ac41be3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -57,6 +57,11 @@ Optional
   occupied by the redistributors. Required if more than one such
   region is present.
 
+- msi-controller : Boolean property. Identifies the node as an MSI controller
+
+- arm,spi-ranges : Tuples of GIC SPI interrupt ranges (base, size) indicating
+  SPIs available for use as MSIs.
+
 Sub-nodes:
 
 PPI affinity can be expressed as a single "ppi-partitions" node,
@@ -75,14 +80,28 @@ These nodes must have the following properties:
 - reg: Specifies the base physical address and size of the ITS
   registers.
 
+GICv3 has an IMPLEMENTATION DEFINED set of aliases for message-based interrupt
+requests.
+
+These nodes must have the following properties:
+- compatible : Should at least contain one of
+			"qcom,gic-msi-aliases".
+- msi-controller : Boolean property. Identifies the node as an MSI controller
+- #msi-cells: Must be <1>. The single msi-cell is the DeviceID of the device
+  which will generate the MSI.
+- reg: Specifies the base physical address and size of the message-based
+  interrupt request registers.
+- arm,spi-ranges:  Tuples of GIC SPI interrupt ranges (base, size) indicating
+  SPIs available for use as MSIs.
+
+Note: The main GIC node must contain the appropriate #address-cells,
+#size-cells and ranges properties for the reg property of all ITS and
+alias message-based interrupt nodes.
+
 Optional:
 - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
   address and size of the pre-ITS window.
 
-The main GIC node must contain the appropriate #address-cells,
-#size-cells and ranges properties for the reg property of all ITS
-nodes.
-
 Examples:
 
 	gic: interrupt-controller at 2cf00000 {
@@ -149,6 +168,27 @@ Examples:
 		};
 	};
 
+	intc: interrupt-controller at 9bc0000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-controller;
+		#redistributor-regions = <1>;
+		redistributor-stride = <0x0 0x40000>;
+		reg = <0x09bc0000 0x10000>,
+		      <0x09c00000 0x100000>;
+		interrupts = <1 9 4>;
+
+		msi_alias0: interrupt-controller at 9bd0000 {
+			compatible = "qcom,gic-msi-aliases";
+			reg = <0x9bd0000 0x1000>;
+			msi-controller;
+			#msi-cells = <1>;
+			arm,spi-ranges = <544 96>;
+		};
+	};
 
 	device at 0 {
 		reg = <0 0 0 4>;
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 993a8426a453..a254c29dbe69 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/arm-gic-common.h>
 
 /*
 * MSI_TYPER:
@@ -383,13 +384,57 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
-	{	.compatible	= "arm,gic-v2m-frame",	},
-	{},
+static const struct of_device_id gicv2m_device_id[] = {
+	{ .compatible = "arm,gic-v2m-frame", },
+	{ .compatible = "qcom,gic-msi-aliases", },
+	{}
 };
 
-static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
-				 struct irq_domain *parent)
+static int __init gicv2m_of_init_one(struct device_node *child)
+{
+	u32 spi_start = 0, nr_spis = 0;
+	struct resource res;
+	int ret, i, cnt;
+	struct fwnode_handle *fwnode = &child->fwnode;
+
+	if (!of_find_property(child, "msi-controller", NULL))
+		return 0;
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
+		pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+			spi_start, nr_spis);
+
+	cnt = of_property_count_u32_elems(child, "arm,spi-ranges");
+	if (cnt < 0)
+		cnt = 0;
+	cnt /= 2;
+
+	if (!cnt)
+		return gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
+
+	/* Populate v2m for each SPI range */
+	for (i = 0; i < cnt; i++) {
+		of_property_read_u32_index(child, "arm,spi-ranges",
+					   i * 2, &spi_start);
+		of_property_read_u32_index(child, "arm,spi-ranges",
+					   i * 2 + 1, &nr_spis);
+		ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __init gicv2m_of_init_children(struct fwnode_handle *parent_handle)
 {
 	int ret = 0;
 	struct device_node *node = to_of_node(parent_handle);
@@ -397,35 +442,27 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
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
+		ret = gicv2m_of_init_one(child);
 		if (ret) {
 			of_node_put(child);
 			break;
 		}
 	}
 
+	return ret;
+}
+
+static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
+				 struct irq_domain *parent)
+{
+	int ret;
+
+	ret = gicv2m_of_init_children(parent_handle);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)
 		gicv2m_teardown();
+
 	return ret;
 }
 
@@ -518,6 +555,23 @@ static int __init gicv2m_acpi_init(struct irq_domain *parent)
 }
 #endif /* CONFIG_ACPI */
 
+int __init gicv2m_init_gicv3(struct fwnode_handle *handle,
+			     struct irq_domain *parent)
+{
+	int ret;
+	struct device_node *node = to_of_node(handle);
+
+	ret = gicv2m_of_init_children(handle);
+	if (!ret)
+		ret = gicv2m_of_init_one(node);
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
index 641b5109f5de..fda2755c4247 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1242,6 +1242,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	if (static_key_true(&supports_deactivate))
 		gic_of_setup_kvm_info(node);
+
+	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+		gicv2m_init_gicv3(&node->fwnode, gic_data.domain);
+
 	return 0;
 
 out_unmap_rdist:
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 0a83b4379f34..d2eea9539d37 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -33,4 +33,7 @@ struct gic_kvm_info {
 
 const struct gic_kvm_info *gic_get_kvm_info(void);
 
+int gicv2m_init_gicv3(struct fwnode_handle *parent_handle,
+		      struct irq_domain *parent);
+
 #endif /* __LINUX_IRQCHIP_ARM_GIC_COMMON_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

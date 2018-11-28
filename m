From: rrichter@cavium.com (Robert Richter)
Date: Wed, 28 Nov 2018 14:43:15 +0000
Subject: [PATCH v2 04/10] irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain
 init order dependencies
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
Message-ID: <20181128144240.28727-5-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new irq_domain_request_host_*() interface which allows independent
parent and child initialization using an irq domain request handler.
This makes it possible to move its initialization to a later point
during boot. All domains can be initialized in the same initcall level
then.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 47 ++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 606efa64adff..81dfc534ded8 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -66,11 +66,34 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
+static int __init its_fsl_create_irq_domain(struct irq_domain *parent,
+					void *priv)
+{
+	struct device_node *np = irq_domain_get_of_node(parent);
+	struct irq_domain *mc_msi_domain;
+
+	if (!msi_get_domain_info(parent)) {
+		pr_err("%pOF: unable to locate ITS domain\n", np);
+		return -ENXIO;
+	}
+
+	mc_msi_domain = fsl_mc_msi_create_irq_domain(parent->fwnode,
+						&its_fsl_mc_msi_domain_info,
+						parent);
+	if (!mc_msi_domain) {
+		pr_err("%pOF: unable to create fsl-mc domain\n", np);
+		return -ENOMEM;
+	}
+
+	pr_info("fsl-mc MSI: %pOF domain created\n", np);
+
+	return 0;
+}
+
 static int __init its_fsl_mc_msi_init(void)
 {
 	struct device_node *np;
-	struct irq_domain *parent;
-	struct irq_domain *mc_msi_domain;
+	int ret = 0;
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
@@ -79,22 +102,10 @@ static int __init its_fsl_mc_msi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
-		if (!parent || !msi_get_domain_info(parent)) {
-			pr_err("%pOF: unable to locate ITS domain\n", np);
-			continue;
-		}
-
-		mc_msi_domain = fsl_mc_msi_create_irq_domain(
-						 of_node_to_fwnode(np),
-						 &its_fsl_mc_msi_domain_info,
-						 parent);
-		if (!mc_msi_domain) {
-			pr_err("%pOF: unable to create fsl-mc domain\n", np);
-			continue;
-		}
-
-		pr_info("fsl-mc MSI: %pOF domain created\n", np);
+		ret = irq_domain_request_host(np, DOMAIN_BUS_NEXUS,
+					its_fsl_create_irq_domain, NULL);
+		if (ret)
+			pr_err("%pOF: unable to register ITS domain\n", np);
 	}
 
 	return 0;
-- 
2.11.0

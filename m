From: rrichter@cavium.com (Robert Richter)
Date: Wed, 7 Nov 2018 22:03:15 +0000
Subject: [PATCH 02/10] irqchip/gic-v3-its-platform-msi: Remove domain init
 order dependencies
In-Reply-To: <20181107220254.6116-1-rrichter@cavium.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
Message-ID: <20181107220254.6116-3-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new irq_domain_request_host_*() interface which allows independent
parent and child initialization using an irq domain request handler.
This makes it possible to move its initialization to a later point
during boot. All domains can be initialized in the same initcall level
then.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 54 +++++++++++++++++++++------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 7b8e87b493fe..1f2849bc58c4 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -94,25 +94,56 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
-				const char *name)
+static int __init its_pmsi_create_irq_domain(struct irq_domain *parent,
+					void *priv)
 {
-	struct irq_domain *parent;
+	const char *name = priv;
+	int err = 0;
 
-	parent = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: unable to locate ITS domain\n", name);
-		return -ENXIO;
+	if (!msi_get_domain_info(parent)) {
+		err = -ENODEV;
+		goto out;
 	}
 
-	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
+	if (!platform_msi_create_irq_domain(parent->fwnode, &its_pmsi_domain_info,
 					    parent)) {
-		pr_err("%s: unable to create platform domain\n", name);
-		return -ENXIO;
+		err = -ENXIO;
+		goto out;
 	}
 
 	pr_info("Platform MSI: %s domain created\n", name);
-	return 0;
+out:
+	if (err)
+		pr_err("Platform MSI: Failed to create %s domain\n", name);
+
+	kfree(name);
+	return err;
+}
+
+static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
+				const char *name)
+{
+	void *priv = kstrdup(name, GFP_KERNEL);
+	int err;
+
+	if (!name) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	if (!priv) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = irq_domain_request_fwnode(fwnode, DOMAIN_BUS_NEXUS,
+					its_pmsi_create_irq_domain, name, priv);
+	if (!err)
+		return 0;
+fail:
+	pr_err("Platform MSI: Failed to register %s domain\n", name);
+	kfree(priv);
+	return err;
 }
 
 #ifdef CONFIG_ACPI
@@ -135,7 +166,6 @@ its_pmsi_parse_madt(struct acpi_subtable_header *header,
 	}
 
 	err = its_pmsi_init_one(domain_handle, node_name);
-
 out:
 	kfree(node_name);
 	return err;
-- 
2.11.0

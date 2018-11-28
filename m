From: rrichter@cavium.com (Robert Richter)
Date: Wed, 28 Nov 2018 14:43:19 +0000
Subject: [PATCH v2 05/10] fsl-mc/dprc-driver: Remove domain init order
 dependencies
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
Message-ID: <20181128144240.28727-6-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new irq_domain_request_host_*() interface which allows independent
parent and child initialization using an irq domain request handler.
This makes it possible to move its initialization to a later point
during boot. All domains can be initialized in the same initcall level
then.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 41 ++++++++++++++++++++++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-msi.c  |  6 +-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 52c7e15143d6..2f41886c8e00 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -10,7 +10,9 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/of.h>
 #include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
@@ -575,6 +577,40 @@ static int dprc_setup_irq(struct fsl_mc_device *mc_dev)
 	return error;
 }
 
+static int dprc_probe(struct fsl_mc_device *mc_dev);
+
+static int dprc_probe_late(struct irq_domain *parent, void *priv)
+{
+	struct fsl_mc_device *mc_dev = priv;
+
+	of_node_put(mc_dev->dev.parent->of_node);
+	of_node_put(irq_domain_get_of_node(parent));
+
+	return dprc_probe(mc_dev);
+}
+
+static int dprc_register_msi_domain(struct fsl_mc_device *mc_dev)
+{
+	struct device_node *mc_of_node, *msi_np;
+	int err = -EINVAL;
+
+	mc_of_node = of_node_get(mc_dev->dev.parent->of_node);
+
+	msi_np = of_parse_phandle(mc_of_node, "msi-parent", 0);
+	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells"))
+		err = irq_domain_request_host(msi_np, DOMAIN_BUS_FSL_MC_MSI,
+			dprc_probe_late, mc_dev);
+
+	if (err) {
+		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
+			mc_of_node);
+		of_node_put(msi_np);
+		of_node_put(mc_of_node);
+	}
+
+	return err;
+}
+
 /**
  * dprc_probe - callback invoked when a DPRC is being bound to this driver
  *
@@ -641,6 +677,11 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 
 		error = fsl_mc_find_msi_domain(parent_dev,
 					       &mc_msi_domain);
+
+		if (error == -ENOENT)
+			/* initialize later */
+			return dprc_register_msi_domain(mc_dev);
+
 		if (error < 0) {
 			dev_warn(&mc_dev->dev,
 				 "WARNING: MC bus without interrupt support\n");
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8b9c66d7c4ff..550d2ed07f69 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -185,12 +185,8 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 
 	msi_domain = of_msi_get_domain(mc_platform_dev, mc_of_node,
 				       DOMAIN_BUS_FSL_MC_MSI);
-	if (!msi_domain) {
-		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
-		       mc_of_node);
-
+	if (!msi_domain)
 		return -ENOENT;
-	}
 
 	*mc_msi_domain = msi_domain;
 	return 0;
-- 
2.11.0

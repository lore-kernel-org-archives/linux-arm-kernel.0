From: kdinh@apm.com (Khuong Dinh)
Date: Tue, 26 Sep 2017 11:49:20 -0600
Subject: [PATCH v4 pci 1/2] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
In-Reply-To: <1506448161-30961-1-git-send-email-kdinh@apm.com>
References: <1506448161-30961-1-git-send-email-kdinh@apm.com>
Message-ID: <1506448161-30961-2-git-send-email-kdinh@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes pci-xgene-msi driver ACPI-aware and provides
MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.

Signed-off-by: Khuong Dinh <kdinh@apm.com>
        [Take over from Duc Dang]
---
 drivers/pci/host/pci-xgene-msi.c |   38 +++++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 1f42a20..d657248 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, Applied Micro Circuits Corporation
  * Author: Tanmay Inamdar <tinamdar@apm.com>
  *	   Duc Dang <dhdang@apm.com>
+ *	   Khuong Dinh <kdinh@apm.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -24,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/of_pci.h>
+#include <linux/acpi.h>
 
 #define MSI_IR0			0x000000
 #define MSI_INT0		0x800000
@@ -39,7 +41,7 @@ struct xgene_msi_group {
 };
 
 struct xgene_msi {
-	struct device_node	*node;
+	struct fwnode_handle	*fwnode;
 	struct irq_domain	*inner_domain;
 	struct irq_domain	*msi_domain;
 	u64			msi_addr;
@@ -249,6 +251,13 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
 	.free   = xgene_irq_domain_free,
 };
 
+#ifdef CONFIG_ACPI
+static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
+{
+	return xgene_msi_ctrl.fwnode;
+}
+#endif
+
 static int xgene_allocate_domains(struct xgene_msi *msi)
 {
 	msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
@@ -256,7 +265,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
+	msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
 						    &xgene_msi_domain_info,
 						    msi->inner_domain);
 
@@ -265,6 +274,9 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_ACPI
+	pci_msi_register_fwnode_provider(&xgene_msi_get_fwnode);
+#endif
 	return 0;
 }
 
@@ -449,6 +461,14 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
 	{},
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_msi_acpi_ids[] = {
+	{"APMC0D0E", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, xgene_msi_acpi_ids);
+#endif
+
 static int xgene_msi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -469,7 +489,18 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-	xgene_msi->node = pdev->dev.of_node;
+
+	xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
+	if (!xgene_msi->fwnode) {
+		xgene_msi->fwnode =
+			irq_domain_alloc_fwnode((void *)xgene_msi->msi_addr);
+		if (!xgene_msi->fwnode) {
+			dev_err(&pdev->dev, "Failed to create fwnode\n");
+			rc = ENOMEM;
+			goto error;
+		}
+	}
+
 	xgene_msi->num_cpus = num_possible_cpus();
 
 	rc = xgene_msi_init_allocator(xgene_msi);
@@ -540,6 +571,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "xgene-msi",
 		.of_match_table = xgene_msi_match_table,
+		.acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
 	},
 	.probe = xgene_msi_probe,
 	.remove = xgene_msi_remove,
-- 
1.7.1

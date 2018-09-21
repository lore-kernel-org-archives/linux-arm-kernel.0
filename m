From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:39 +0530
Subject: [RFC PATCH 24/40] PCI: keystone: Move initializations to appropriate
 places
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-25-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Move host specific platform_get_resource to
ks_add_pcie_port and the common platform_get_resource (applicable
to both host and endpoint) to probe. This is in preparation for
adding endpoint support to pci-keystone driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 75d007148804..13e865f82f96 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -646,11 +646,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct resource *res;
 	int ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pp->va_cfg0_base))
@@ -658,13 +653,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
-	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ks_pcie->va_app_base))
-		return PTR_ERR(ks_pcie->va_app_base);
-
-	ks_pcie->app = *res;
-
 	pp->ops = &ks_pcie_host_ops;
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -768,6 +756,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	struct resource *res;
+	void __iomem *base;
 	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
@@ -784,6 +774,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ks_pcie->va_app_base))
+		return PTR_ERR(ks_pcie->va_app_base);
+
+	ks_pcie->app = *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
+	base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pci->dbi_base = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
-- 
2.17.1

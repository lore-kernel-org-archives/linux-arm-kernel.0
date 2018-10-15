From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Oct 2018 18:37:13 +0530
Subject: [PATCH 11/19] PCI: keystone: Cleanup PHY handling
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
Message-ID: <20181015130721.5535-12-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup PHY handling by using devm_phy_optional_get to get PHYs if
the PHYs are optional, creating a device link between the PHY device
and the controller device and disable PHY on error cases here.
Also invoke phy_reset() as part of initializing PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 126 +++++++++++++++++++---
 1 file changed, 110 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e22328f89c84..bf37609ad75b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -105,6 +105,9 @@ struct keystone_pcie {
 
 	int			num_msi_host_irqs;
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			num_lanes;
+	struct phy		**phy;
+	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
@@ -880,22 +883,61 @@ static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
 	.link_up = ks_pcie_link_up,
 };
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static void ks_pcie_disable_phy(struct keystone_pcie *ks_pcie)
 {
-	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
+	int num_lanes = ks_pcie->num_lanes;
 
-	clk_disable_unprepare(ks_pcie->clk);
+	while (num_lanes--) {
+		phy_power_off(ks_pcie->phy[num_lanes]);
+		phy_exit(ks_pcie->phy[num_lanes]);
+	}
+}
+
+static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
+{
+	int i;
+	int ret;
+	int num_lanes = ks_pcie->num_lanes;
+
+	for (i = 0; i < num_lanes; i++) {
+		ret = phy_reset(ks_pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_init(ks_pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(ks_pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(ks_pcie->phy[i]);
+			goto err_phy;
+		}
+	}
 
 	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(ks_pcie->phy[i]);
+		phy_exit(ks_pcie->phy[i]);
+	}
+
+	return ret;
 }
 
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct phy *phy;
+	struct device_link **link;
+	struct phy **phy;
+	u32 num_lanes;
+	char name[10];
 	int ret;
+	int i;
 
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
@@ -908,29 +950,59 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
-	ks_pcie->pci = pci;
+	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
+	if (ret)
+		num_lanes = 1;
 
-	/* initialize SerDes Phy if present */
-	phy = devm_phy_get(dev, "pcie-phy");
-	if (PTR_ERR_OR_ZERO(phy) == -EPROBE_DEFER)
-		return PTR_ERR(phy);
+	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
 
-	if (!IS_ERR_OR_NULL(phy)) {
-		ret = phy_init(phy);
-		if (ret < 0)
-			return ret;
+	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i = 0; i < num_lanes; i++) {
+		snprintf(name, sizeof(name), "pcie-phy%d", i);
+		phy[i] = devm_phy_optional_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
+
+		if (!phy[i])
+			continue;
+
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			ret = -EINVAL;
+			goto err_link;
+		}
+	}
+
+	ks_pcie->np = np;
+	ks_pcie->pci = pci;
+	ks_pcie->link = link;
+	ks_pcie->num_lanes = num_lanes;
+	ks_pcie->phy = phy;
+
+	ret = ks_pcie_enable_phy(ks_pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		goto err_link;
 	}
 
-	ks_pcie->np = dev->of_node;
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(ks_pcie->clk)) {
 		dev_err(dev, "Failed to get pcie rc clock\n");
-		return PTR_ERR(ks_pcie->clk);
+		ret = PTR_ERR(ks_pcie->clk);
+		goto err_phy;
 	}
+
 	ret = clk_prepare_enable(ks_pcie->clk);
 	if (ret)
-		return ret;
+		goto err_phy;
 
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
@@ -940,9 +1012,31 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(ks_pcie->clk);
 
+err_phy:
+	ks_pcie_disable_phy(ks_pcie);
+
+err_link:
+	while (--i >= 0 && link[i])
+		device_link_del(link[i]);
+
 	return ret;
 }
 
+static int __exit ks_pcie_remove(struct platform_device *pdev)
+{
+	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
+	struct device_link **link = ks_pcie->link;
+	int num_lanes = ks_pcie->num_lanes;
+
+	clk_disable_unprepare(ks_pcie->clk);
+	ks_pcie_disable_phy(ks_pcie);
+
+	while (num_lanes--)
+		device_link_del(link[num_lanes]);
+
+	return 0;
+}
+
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
 	.remove = __exit_p(ks_pcie_remove),
-- 
2.17.1

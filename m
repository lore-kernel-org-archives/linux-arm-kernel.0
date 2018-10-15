From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Oct 2018 18:37:14 +0530
Subject: [PATCH 12/19] PCI: keystone: Invoke pm_runtime APIs to enable clock
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
Message-ID: <20181015130721.5535-13-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Invoke pm_runtime APIs to enable clocks and remove explicit
clock enabling using clk_prepare_enable().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 28 ++++++++++-------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index bf37609ad75b..891bdfc5921c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -96,7 +96,6 @@
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
-	struct	clk		*clk;
 	/* PCI Device ID */
 	u32			device_id;
 	int			num_legacy_host_irqs;
@@ -993,26 +992,22 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
-	ks_pcie->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ks_pcie->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		ret = PTR_ERR(ks_pcie->clk);
-		goto err_phy;
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
 	}
 
-	ret = clk_prepare_enable(ks_pcie->clk);
-	if (ret)
-		goto err_phy;
-
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
-		goto fail_clk;
+		goto err_get_sync;
 
 	return 0;
-fail_clk:
-	clk_disable_unprepare(ks_pcie->clk);
 
-err_phy:
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 
 err_link:
@@ -1027,10 +1022,11 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
 	int num_lanes = ks_pcie->num_lanes;
+	struct device *dev = &pdev->dev;
 
-	clk_disable_unprepare(ks_pcie->clk);
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-
 	while (num_lanes--)
 		device_link_del(link[num_lanes]);
 
-- 
2.17.1

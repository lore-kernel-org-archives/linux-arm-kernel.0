From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:31 +0530
Subject: [RFC PATCH 16/40] PCI: keystone: Invoke pm_runtime APIs to enable
 clock
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-17-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Invoke pm_runtime APIs to enable clocks and remove explicit
clock enabling using clk_prepare_enable().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 29 +++++++++++------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b013776d9256..f230344e1f4e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -95,7 +95,6 @@ static void ks_pcie_stop_link(struct dw_pcie *pci);
 
 struct keystone_pcie {
 	struct dw_pcie		*pci;
-	struct	clk		*clk;
 	int			num_lanes;
 	struct phy		**phy;
 	struct device_link	**link;
@@ -879,26 +878,25 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ks_pcie);
-	ks_pcie->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ks_pcie->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		ret = PTR_ERR(ks_pcie->clk);
-		goto err_get_irq;
-	}
 
-	ret = clk_prepare_enable(ks_pcie->clk);
-	if (ret)
-		goto err_get_irq;
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
+	}
 
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
-		goto fail_clk;
+		goto err_get_sync;
 
 	ks_pcie_enable_error_irq(ks_pcie);
 
 	return 0;
-fail_clk:
-	clk_disable_unprepare(ks_pcie->clk);
+
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 
 err_get_irq:
 	ks_pcie_disable_phy(ks_pcie);
@@ -915,10 +913,11 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
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

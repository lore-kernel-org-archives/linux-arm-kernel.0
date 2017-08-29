From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Tue, 29 Aug 2017 19:05:32 +0530
Subject: [PATCH] PCI: dwc: Use PTR_ERR_OR_ZERO
Message-ID: <1504013732-16112-1-git-send-email-himanshujha199640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/pci/dwc/pci-exynos.c |  5 +----
 drivers/pci/dwc/pcie-kirin.c | 10 ++--------
 drivers/pci/dwc/pcie-qcom.c  |  5 +----
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index f77f872..1880518 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -152,10 +152,7 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 	ep->mem_res->block_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ep->mem_res->block_base))
-		return PTR_ERR(ep->mem_res->block_base);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ep->mem_res->block_base);
 }
 
 static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index dc3033c..bf327eb 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -142,10 +142,7 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 		return PTR_ERR(kirin_pcie->apb_sys_clk);
 
 	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
-	if (IS_ERR(kirin_pcie->pcie_aclk))
-		return PTR_ERR(kirin_pcie->pcie_aclk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
 }
 
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
@@ -178,10 +175,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 
 	kirin_pcie->sysctrl =
 		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
-	if (IS_ERR(kirin_pcie->sysctrl))
-		return PTR_ERR(kirin_pcie->sysctrl);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(kirin_pcie->sysctrl);
 }
 
 static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 871e7d9..7ec92ef 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -679,10 +679,7 @@ static int qcom_pcie_get_resources_v3(struct qcom_pcie *pcie)
 		return PTR_ERR(res->ahb_reset);
 
 	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
-	if (IS_ERR(res->phy_ahb_reset))
-		return PTR_ERR(res->phy_ahb_reset);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(res->phy_ahb_reset);
 }
 
 static void qcom_pcie_deinit_v3(struct qcom_pcie *pcie)
-- 
2.7.4

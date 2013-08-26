From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 26 Aug 2013 11:11:09 +0200
Subject: [PATCH] PCI: tegra: replace devm_request_and_ioremap by
 devm_ioremap_resource
Message-ID: <1377508269-9664-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use devm_ioremap_resource instead of devm_request_and_ioremap.

This was done using the semantic patch
scripts/coccinelle/api/devm_ioremap_resource.cocci

Error-handling code was manually removed from the associated calls to
platform_get_resource.

Adjust the comment at the third platform_get_resource_byname to make clear
why ioremap is not done at this point.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Hi,

This is a small cleanup patch on top of the recently merged Tegra PCIe
driver. Can someone please apply this to the same branch that Tegra's
tegra-for-3.12-soc branch was merged? I think Kevin Hilman pulled it
into next/soc.

Thanks,
Thierry

 drivers/pci/host/pci-tegra.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 7356741..2e9888a 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1031,32 +1031,21 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		return err;
 	}
 
-	/* request and remap controller registers */
 	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
-	if (!pads) {
-		err = -EADDRNOTAVAIL;
+	pcie->pads = devm_ioremap_resource(&pdev->dev, pads);
+	if (IS_ERR(pcie->pads)) {
+		err = PTR_ERR(pcie->pads);
 		goto poweroff;
 	}
 
 	afi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "afi");
-	if (!afi) {
-		err = -EADDRNOTAVAIL;
-		goto poweroff;
-	}
-
-	pcie->pads = devm_request_and_ioremap(&pdev->dev, pads);
-	if (!pcie->pads) {
-		err = -EADDRNOTAVAIL;
-		goto poweroff;
-	}
-
-	pcie->afi = devm_request_and_ioremap(&pdev->dev, afi);
-	if (!pcie->afi) {
-		err = -EADDRNOTAVAIL;
+	pcie->afi = devm_ioremap_resource(&pdev->dev, afi);
+	if (IS_ERR(pcie->afi)) {
+		err = PTR_ERR(pcie->afi);
 		goto poweroff;
 	}
 
-	/* request and remap configuration space */
+	/* request configuration space, but remap later, on demand */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cs");
 	if (!res) {
 		err = -EADDRNOTAVAIL;
@@ -1492,9 +1481,9 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		rp->lanes = value;
 		rp->pcie = pcie;
 
-		rp->base = devm_request_and_ioremap(pcie->dev, &rp->regs);
-		if (!rp->base)
-			return -EADDRNOTAVAIL;
+		rp->base = devm_ioremap_resource(pcie->dev, &rp->regs);
+		if (IS_ERR(rp->base))
+			return PTR_ERR(rp->base);
 
 		list_add_tail(&rp->list, &pcie->ports);
 	}
-- 
1.8.4

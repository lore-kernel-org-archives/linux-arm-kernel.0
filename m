From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 31 Jan 2017 14:20:13 -0600
Subject: [PATCH 1 3/4] PCI: layerscape: Use of_device_get_match_data() to
 simplify probe
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170131202013.27605.44566.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only way to call ls_pcie_probe() is to match an entry in
ls_pcie_of_match[], so match cannot be NULL.

Use of_device_get_match_data() to retrieve the drvdata pointer.  No
functional change intended.

Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index ea789138531b..c1f06f8f05fd 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -239,23 +239,18 @@ static int __init ls_add_pcie_port(struct ls_pcie *pcie)
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct ls_pcie *pcie;
 	struct pcie_port *pp;
 	struct resource *dbi_base;
 	int ret;
 
-	match = of_match_device(ls_pcie_of_match, dev);
-	if (!match)
-		return -ENODEV;
-
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
 	pp = &pcie->pp;
 	pp->dev = dev;
-	pcie->drvdata = match->data;
+	pcie->drvdata = of_device_get_match_data(dev);
 	pp->ops = pcie->drvdata->ops;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");

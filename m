From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 31 Jan 2017 14:20:06 -0600
Subject: [PATCH 1 2/4] PCI: iproc: Use of_device_get_match_data() to
 simplify probe
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170131202006.27605.98823.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only way to call iproc_pcie_pltfm_probe() is to match an entry in
iproc_pcie_of_match_table[], so match cannot be NULL.

Use of_device_get_match_data() to retrieve the pcie->type.  No functional
change intended.

Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-platform.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 22d814a78a78..f4909bb0b2ad 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -47,7 +47,6 @@ MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
 static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct iproc_pcie *pcie;
 	struct device_node *np = dev->of_node;
 	struct resource reg;
@@ -55,16 +54,12 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	LIST_HEAD(res);
 	int ret;
 
-	of_id = of_match_device(iproc_pcie_of_match_table, dev);
-	if (!of_id)
-		return -EINVAL;
-
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
 	pcie->dev = dev;
-	pcie->type = (enum iproc_pcie_type)of_id->data;
+	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {

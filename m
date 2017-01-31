From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 31 Jan 2017 14:19:59 -0600
Subject: [PATCH 1 1/4] PCI: hisi: Use of_device_get_match_data() to simplify
 probe
In-Reply-To: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131201400.27605.56002.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170131201958.27605.54898.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shailendra Verma <shailendra.v@samsung.com>

The only way to call hisi_pcie_probe() is to match an entry in
hisi_pcie_of_match[], so match cannot be NULL.

Use of_device_get_match_data() to retrieve the soc_ops pointer.  No
functional change intended.

[bhelgaas: use of_device_get_match_data(), changelog]
Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index a301a7187b30..33c201afdbf1 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -139,7 +139,7 @@ struct hisi_pcie {
 	struct pcie_port pp;		/* pp.dbi_base is DT rc_dbi */
 	struct regmap *subctrl;
 	u32 port_id;
-	struct pcie_soc_ops *soc_ops;
+	const struct pcie_soc_ops *soc_ops;
 };
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -259,7 +259,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;
-	const struct of_device_id *match;
 	struct resource *reg;
 	struct device_driver *driver;
 	int ret;
@@ -272,11 +271,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	pp->dev = dev;
 	driver = dev->driver;
 
-	match = of_match_device(driver->of_match_table, dev);
-	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
+	hisi_pcie->soc_ops = of_device_get_match_data(dev);
 
 	hisi_pcie->subctrl =
-	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
+	    syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
 	if (IS_ERR(hisi_pcie->subctrl)) {
 		dev_err(dev, "cannot get subctrl base\n");
 		return PTR_ERR(hisi_pcie->subctrl);

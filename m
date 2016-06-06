From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:07:13 -0500
Subject: [PATCH v1 20/25] PCI: rcar: Request host bridge window resources
 with core function
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230713.20936.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_request_pci_bus_resources() to request host bridge window
resources instead of doing it by hand in the driver.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 3509218..ce096db 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -955,12 +955,15 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	if (err)
 		return err;
 
+	err = devm_request_pci_bus_resources(dev, &pci->resources);
+	if (err)
+		goto out_release_res;
+
 	resource_list_for_each_entry(win, &pci->resources) {
-		struct resource *parent, *res = win->res;
+		struct resource *res = win->res;
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
-			parent = &ioport_resource;
 			err = pci_remap_iospace(res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
@@ -969,17 +972,12 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 			}
 			break;
 		case IORESOURCE_MEM:
-			parent = &iomem_resource;
 			break;
 
 		case IORESOURCE_BUS:
 		default:
 			continue;
 		}
-
-		err = devm_request_resource(dev, parent, res);
-		if (err)
-			goto out_release_res;
 	}
 
 	return 0;

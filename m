From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:07:21 -0500
Subject: [PATCH v1 21/25] PCI: rcar: Simplify host bridge window iteration
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230721.20936.25605.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch is the only statement in the resource_list_for_each_entry()
loop, so remove unnecessary cases and "continue" statements in the switch.
Inline rcar_pcie_release_of_pci_ranges(), which is only called once.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index ce096db..6546ca7 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -938,11 +938,6 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
 
-static void rcar_pcie_release_of_pci_ranges(struct rcar_pcie *pci)
-{
-	pci_free_resource_list(&pci->resources);
-}
-
 static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 {
 	int err;
@@ -962,28 +957,18 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
 	resource_list_for_each_entry(win, &pci->resources) {
 		struct resource *res = win->res;
 
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
+		if (resource_type(res) == IORESOURCE_IO) {
 			err = pci_remap_iospace(res, iobase);
-			if (err) {
+			if (err)
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
-				continue;
-			}
-			break;
-		case IORESOURCE_MEM:
-			break;
-
-		case IORESOURCE_BUS:
-		default:
-			continue;
 		}
 	}
 
 	return 0;
 
 out_release_res:
-	rcar_pcie_release_of_pci_ranges(pci);
+	pci_free_resource_list(&pci->resources);
 	return err;
 }
 

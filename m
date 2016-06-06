From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:06:29 -0500
Subject: [PATCH v1 14/25] PCI: altera: Simplify host bridge window iteration
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230629.20936.61795.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch is the only statement in the resource_list_for_each_entry()
loop, so remove unnecessary "continue" statements in the switch.  Simplify
checking for the required non-prefetchable memory aperture.  Inline
altera_pcie_release_of_pci_ranges(), which is only called once.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b97abbc..cf20c67 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -415,11 +415,6 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void altera_pcie_release_of_pci_ranges(struct altera_pcie *pcie)
-{
-	pci_free_resource_list(&pcie->resources);
-}
-
 static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 {
 	int err, res_valid = 0;
@@ -439,25 +434,18 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 	resource_list_for_each_entry(win, &pcie->resources) {
 		struct resource *res = win->res;
 
-		switch (resource_type(res)) {
-		case IORESOURCE_MEM:
+		if (resource_type(res) == IORESOURCE_MEM)
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-			break;
-		default:
-			continue;
-		}
 	}
 
-	if (!res_valid) {
-		dev_err(dev, "non-prefetchable memory resource required\n");
-		err = -EINVAL;
-		goto out_release_res;
-	}
+	if (res_valid)
+		return 0;
 
-	return 0;
+	dev_err(dev, "non-prefetchable memory resource required\n");
+	err = -EINVAL;
 
 out_release_res:
-	altera_pcie_release_of_pci_ranges(pcie);
+	pci_free_resource_list(&pcie->resources);
 	return err;
 }
 

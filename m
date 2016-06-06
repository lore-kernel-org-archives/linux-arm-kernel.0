From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:07:44 -0500
Subject: [PATCH v1 24/25] PCI: versatile: Request host bridge window
 resources with core function
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230744.20936.46906.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_request_pci_bus_resources() to request host bridge window
resources instead of doing it by hand in the driver.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-versatile.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index f843a72..273edac 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -80,12 +80,15 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 	if (err)
 		return err;
 
+	err = devm_request_pci_bus_resources(dev, res);
+	if (err)
+		goto out_release_res;
+
 	resource_list_for_each_entry(win, res) {
-		struct resource *parent, *res = win->res;
+		struct resource *res = win->res;
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
-			parent = &ioport_resource;
 			err = pci_remap_iospace(res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
@@ -94,7 +97,6 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 			}
 			break;
 		case IORESOURCE_MEM:
-			parent = &iomem_resource;
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 
 			writel(res->start >> 28, PCI_IMAP(mem));
@@ -106,10 +108,6 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 		default:
 			continue;
 		}
-
-		err = devm_request_resource(dev, parent, res);
-		if (err)
-			goto out_release_res;
 	}
 
 	if (!res_valid) {

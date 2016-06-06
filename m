From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:06:51 -0500
Subject: [PATCH v1 17/25] PCI: generic: Simplify host bridge window iteration
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230651.20936.73053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch is the only statement in the resource_list_for_each_entry()
loop, so remove unnecessary "continue" statements in the switch.  Simplify
checking for the required non-prefetchable memory aperture.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-host-common.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index e7515fd..bb03120 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -46,29 +46,24 @@ static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 			err = pci_remap_iospace(res, iobase);
-			if (err) {
+			if (err)
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
-				continue;
-			}
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 			break;
 		case IORESOURCE_BUS:
 			*bus_range = res;
-		default:
-			continue;
+			break;
 		}
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
 	pci_free_resource_list(resources);

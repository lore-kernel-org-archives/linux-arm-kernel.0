From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 23 Mar 2015 20:40:27 +0800
Subject: [PATCH v7 01/31] xen/PCI: Don't use deprecated function
 pci_scan_bus_parented()
In-Reply-To: <1427114457-16687-1-git-send-email-wangyijing@huawei.com>
References: <1427114457-16687-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1427114457-16687-2-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Use pci_scan_root_bus() instead of deprecated function
pci_scan_bus_parented().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: xen-devel at lists.xenproject.org
---
 drivers/pci/xen-pcifront.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index b1ffebe..a69e529 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -446,9 +446,15 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
 	struct pci_bus *b;
+	LIST_HEAD(resources);
 	struct pcifront_sd *sd = NULL;
 	struct pci_bus_entry *bus_entry = NULL;
 	int err = 0;
+	static struct resource busn_res = {
+		.start = 0,
+		.end = 255,
+		.flags = IORESOURCE_BUS,
+	};
 
 #ifndef CONFIG_PCI_DOMAINS
 	if (domain != 0) {
@@ -470,17 +476,21 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 		err = -ENOMEM;
 		goto err_out;
 	}
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_res);
 	pcifront_init_sd(sd, domain, bus, pdev);
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_bus_parented(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd);
+	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
+				  &pcifront_bus_ops, sd, &resources);
 	if (!b) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
 		err = -ENOMEM;
 		pci_unlock_rescan_remove();
+		pci_free_resource_list(&resources);
 		goto err_out;
 	}
 
@@ -488,7 +498,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 
 	list_add(&bus_entry->list, &pdev->root_buses);
 
-	/* pci_scan_bus_parented skips devices which do not have a have
+	/* pci_scan_root_bus skips devices which do not have a
 	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
 	err = pcifront_scan_bus(pdev, domain, bus, b);
 
-- 
1.7.1

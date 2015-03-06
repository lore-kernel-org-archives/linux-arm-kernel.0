From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 6 Mar 2015 17:33:38 +0800
Subject: [PATCH v5 21/29] parisc/PCI: Use pci_scan_root_bus() for simplicity
In-Reply-To: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
References: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425634426-437-22-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yijing Wang <wangyijing0307@gmail.com>

Now pci_bus_add_devices() has been ripped out
from pci_scan_root_bus(), we could use pci_scan_root_bus()
instead of pci_create_root_bus() + pci_scan_child_bus()
for simplicity.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
CC: linux-parisc at vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/dino.c    |    8 +++-----
 drivers/parisc/lba_pci.c |    7 ++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index a0580af..eb76a9d 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -981,11 +981,12 @@ static int __init dino_probe(struct parisc_device *dev)
 	dino_dev->hba.bus_num.end = 255;
 	dino_dev->hba.bus_num.flags = IORESOURCE_BUS;
 	pci_add_resource(&resources, &dino_dev->hba.bus_num);
+
 	/*
 	** It's not used to avoid chicken/egg problems
 	** with configuration accessor functions.
 	*/
-	dino_dev->hba.hba_bus = bus = pci_create_root_bus(&dev->dev,
+	dino_dev->hba.hba_bus = bus = pci_scan_root_bus(&dev->dev,
 			 dino_current_bus, &dino_cfg_ops, NULL, &resources);
 	if (!bus) {
 		printk(KERN_ERR "ERROR: failed to scan PCI bus on %s (duplicate bus number %d?)\n",
@@ -996,13 +997,10 @@ static int __init dino_probe(struct parisc_device *dev)
 		return 0;
 	}
 
-	max = pci_scan_child_bus(bus);
-	pci_bus_update_busn_res_end(bus, max);
-
 	/* This code *depends* on scanning being single threaded
 	 * if it isn't, this global bus number count will fail
 	 */
-	dino_current_bus = max + 1;
+	dino_current_bus = bus->busn_res.end + 1;
 	pci_bus_assign_resources(bus);
 	pci_bus_add_devices(bus);
 	return 0;
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index dceb9dd..ba6daec 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1422,7 +1422,6 @@ lba_driver_probe(struct parisc_device *dev)
 	void *tmp_obj;
 	char *version;
 	void __iomem *addr = ioremap_nocache(dev->hpa.start, 4096);
-	int max;
 
 	/* Read HW Rev First */
 	func_class = READ_REG32(addr + LBA_FCLASS);
@@ -1563,15 +1562,13 @@ lba_driver_probe(struct parisc_device *dev)
 
 	dev->dev.platform_data = lba_dev;
 	lba_bus = lba_dev->hba.hba_bus =
-		pci_create_root_bus(&dev->dev, lba_dev->hba.bus_num.start,
+		pci_scan_root_bus(&dev->dev, lba_dev->hba.bus_num.start,
 				    cfg_ops, NULL, &resources);
 	if (!lba_bus) {
 		pci_free_resource_list(&resources);
 		return 0;
 	}
 
-	max = pci_scan_child_bus(lba_bus);
-
 	/* This is in lieu of calling pci_assign_unassigned_resources() */
 	if (is_pdc_pat()) {
 		/* assign resources to un-initialized devices */
@@ -1599,7 +1596,7 @@ lba_driver_probe(struct parisc_device *dev)
 		lba_dev->flags |= LBA_FLAG_SKIP_PROBE;
 	}
 
-	lba_next_bus = max + 1;
+	lba_next_bus = pci_bus_child_max_busnr(lba_bus) + 1;
 	pci_bus_add_devices(lba_bus);
 
 	/* Whew! Finally done! Tell services we got this one covered. */
-- 
1.7.1

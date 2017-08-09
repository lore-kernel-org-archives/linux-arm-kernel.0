From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  8 Aug 2017 20:57:24 -0400
Subject: [PATCH V9 1/2] PCI: handle CRS returned by device after FLR
Message-ID: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sporadic reset issues have been observed with Intel 750 NVMe drive by
writing to the reset file in sysfs in a loop. The sequence of events
observed is as follows:

- perform a Function Level Reset (FLR)
- sleep up to 1000ms total
- read ~0 from PCI_COMMAND
- warn that the device didn't return from FLR
- touch the device before it's ready

An endpoint is allowed to issue Configuration Request Retry Status (CRS)
following a FLR request to indicate that it is not ready to accept new
requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
and CRS usage in FLR context is mentioned in PCIe r3.1a, sec 6.6.2.
Function-Level Reset.

A CRS indication will only be given if the address to be read is vendor ID
register. pci_bus_read_dev_vendor_id() knows how to deal with CRS returned
0xFFFF0001 value and will continue polling until a value other than
0xFFFF0001 is returned within a given timeout.

Try to discover device presence via CRS first. If device is not found, fall
through to old behavior.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..4366299 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3821,17 +3821,39 @@ static void pci_flr_wait(struct pci_dev *dev)
 {
 	int i = 0;
 	u32 id;
+	bool ret;
+
+	/*
+	 * Don't touch the HW before waiting 100ms. HW has to finish
+	 * within 100ms according to PCI Express Base Specification
+	 * Revision 3.1 Section 6.6.2: Function-Level Reset (FLR).
+	 */
+	msleep(100);
+
+	/*
+	 * See if we can find a device via CRS first. Physical functions
+	 * return from here if found, Virtual functions fall through as
+	 * they return ~0 on vendor id read once CRS is completed.
+	 */
+	ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
+					 60000);
+	if (ret)
+		return;
+
+	pci_read_config_dword(dev, PCI_COMMAND, &id);
+	if (id != ~0)
+		return;
 
 	do {
 		msleep(100);
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	} while (i++ < 9 && id == ~0);
 
 	if (id == ~0)
 		dev_warn(&dev->dev, "Failed to return from FLR\n");
 	else if (i > 1)
 		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+			 i * 100);
 }
 
 /**
-- 
1.9.1

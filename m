From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun,  6 Aug 2017 22:09:51 -0400
Subject: [PATCH V8 1/2] PCI: handle CRS returned by device after FLR
Message-ID: <1502071792-15263-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An endpoint is allowed to issue Configuration Request Retry Status (CRS)
following a Function Level Reset (FLR) request to indicate that it is
not ready to accept new requests. CRS is defined in PCIe r3.1, sec 2.3.1.
Request Handling Rules and CRS usage in FLR context is mentioned in
PCIe r3.1, sec 6.6.2. Function-Level Reset.

A CRS indication will only be given if the address to be read is vendor ID
register. pci_bus_read_dev_vendor_id() knows how to deal with CRS returned
0xFFFF0001 value and will continue polling until a value other than
0xFFFF0001 is returned within a given timeout.

Try to discover device presence via CRS if supported. Otherwise, fall
through to old behavior.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..cc9f1c0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3819,8 +3819,26 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
  */
 static void pci_flr_wait(struct pci_dev *dev)
 {
+	u16 root_cap = 0;
 	int i = 0;
 	u32 id;
+	bool ret;
+
+	pcie_capability_read_word(dev, PCI_EXP_RTCAP, &root_cap);
+	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
+		/* don't touch the HW before waiting 100ms */
+		msleep(100);
+
+		/*
+		 * Physical functions return from here if found,
+		 * virtual functions fall through as they return ~0 on vendor
+		 * id read once CRS is completed.
+		 */
+		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
+						 60000);
+		if (ret)
+			return;
+	}
 
 	do {
 		msleep(100);
-- 
1.9.1

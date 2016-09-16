From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Sep 2016 16:06:33 -0400
Subject: [PATCH V2 4/5] PCI: add CRS support to error handling path
In-Reply-To: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1474056395-21843-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIE spec allows an endpoint device to extend the initialization time
beyond 1 second by issuing Configuration Request Retry Status (CRS) for a
vendor ID read request.

This basically means "I'm busy now, please call me back later".

There are two moving parts to CRS support from the SW perspective. One part
is to determine if CRS is supported or not. The second part is to set the
CRS visibility register.

As part of the probe, the Linux kernel sets the above two conditions in
pci_enable_crs function. The kernel is also honoring the returned CRS in
pci_bus_read_dev_vendor_id function if supported. The function will poll up
to specified amount of time while endpoint is returning CRS response.

The PCIe spec also allows CRS to be issued during cold, warm, hot and FLR
resets.

The hot reset is initiated by starting a secondary bus reset. This patch is
adding vendor ID read immediately after a bus reset so that the
initialization procedure can be extended by the amount of time endpoint
requires.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8aecab1..e913467 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3833,6 +3833,16 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+static int pci_dev_probe_crs(struct pci_dev *dev, void *data)
+{
+	u32 l;
+
+	pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &l,
+				   60 * 1000);
+
+	return 0;
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
@@ -3874,6 +3884,7 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
+	pci_walk_bus(dev->subordinate, pci_dev_probe_crs, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
-- 
1.9.1

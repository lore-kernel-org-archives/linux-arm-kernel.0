From: david.daney@cavium.com (David Daney)
Date: Mon, 15 May 2017 17:17:35 -0700
Subject: [PATCH 1/2] PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus
 device.
In-Reply-To: <20170516001736.4001-1-david.daney@cavium.com>
References: <20170516001736.4001-1-david.daney@cavium.com>
Message-ID: <20170516001736.4001-2-david.daney@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When checking to see if a PCI bus can safely be reset, we check to see
if any of the children have their PCI_DEV_FLAGS_NO_BUS_RESET flag set.
As these devices are know not to behave well after a bus reset.

Some PCIe root port bridges also do not behave well after a bus reset,
sometimes causing the devices behind the bridge to become unusable.

Add a check for the PCI_DEV_FLAGS_NO_BUS_RESET flag being set in the
bridge device to allow these bridges to be flagged, and prevent their
buses from being reset.

A follow on patch will add a quirk for this type of bridge.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5b..b64e4d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4318,6 +4318,10 @@ static bool pci_bus_resetable(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+
+	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+		return false;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
 		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
-- 
2.9.4

From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 17 Aug 2017 10:14:21 +0200
Subject: [PATCH v2 1/3] PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on
 bus device
In-Reply-To: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
Message-ID: <1502957663-5527-2-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

When checking to see if a PCI bus can safely be reset, we check to see
if any of the children have their PCI_DEV_FLAGS_NO_BUS_RESET flag set.
As these devices are known not to behave well after a bus reset.

Some PCIe root port bridges also do not behave well after a bus reset,
sometimes causing the devices behind the bridge to become unusable.

Add a check for the PCI_DEV_FLAGS_NO_BUS_RESET flag being set in the
bridge device to allow these bridges to be flagged, and prevent their
buses from being reset.

A follow on patch will add a quirk for this type of bridge.

Signed-off-by: David Daney <david.daney@cavium.com>
[jglauber at cavium.com: fixed typo]
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..d9abbc9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4290,6 +4290,10 @@ static bool pci_bus_resetable(struct pci_bus *bus)
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
2.9.0.rc0.21.g7777322

From: jglauber@cavium.com (Jan Glauber)
Date: Fri,  8 Sep 2017 10:10:33 +0200
Subject: [PATCH v4 3/3] PCI: Avoid slot reset if bus reset is not possible
In-Reply-To: <20170908081033.3025-1-jglauber@cavium.com>
References: <20170908081033.3025-1-jglauber@cavium.com>
Message-ID: <20170908081033.3025-4-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When checking to see if a PCI slot can safely be reset, we check to
see if any of the children have their PCI_DEV_FLAGS_NO_BUS_RESET flag
set.

Some PCIe root port bridges do not behave well after a slot reset,
and may cause the device in the slot to become unusable.

Add a check for the PCI_DEV_FLAGS_NO_BUS_RESET flag being set in the
bridge device to prevent the slot from being reset.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2a46ca7f133..45a086fc3592 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4393,6 +4393,10 @@ static bool pci_slot_resetable(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	if (slot->bus->self &&
+	    (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+		return false;
+
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-- 
2.9.0.rc0.21.g7777322

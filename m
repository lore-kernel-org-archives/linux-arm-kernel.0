From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Tue, 16 Oct 2018 18:44:43 +0800
Subject: [PATCH v9 2/9] PCI: Using PCI configuration space header type instead
 of class type to assign resource
In-Reply-To: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The PCI configuration space header type defines the layout of the rest
of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9) while the
resource assignment is based on the configuration space layout instead
of its class type. Using configuration space header type instead of
class type for the resource assignment.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/pci.c       |  3 +--
 drivers/pci/probe.c     |  3 ---
 drivers/pci/setup-bus.c | 20 ++++++++++----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff961..7d379ca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5908,8 +5908,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	 * to enable the kernel to reassign new resource
 	 * window later on.
 	 */
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
-	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
 			r = &dev->resource[i];
 			if (!(r->flags & IORESOURCE_MEM))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec78400..29a35c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1695,9 +1695,6 @@ int pci_setup_device(struct pci_dev *dev)
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
-		if (class != PCI_CLASS_BRIDGE_PCI)
-			goto bad;
-
 		/*
 		 * The PCI-to-PCI bridge spec requires that subtractive
 		 * decoding (i.e. transparent) bridge must have programming
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824..69f90f4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -182,7 +182,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
 	u16 class = dev->class >> 8;
 
 	/* Don't touch classless devices or host bridges or ioapics.  */
-	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
+	if (class == PCI_CLASS_NOT_DEFINED)
 		return;
 
 	/* Don't touch ioapic devices already enabled by firmware */
@@ -1221,12 +1221,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (!b)
 			continue;
 
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_CARDBUS:
+		switch (dev->hdr_type) {
+		case PCI_HEADER_TYPE_CARDBUS:
 			pci_bus_size_cardbus(b, realloc_head);
 			break;
 
-		case PCI_CLASS_BRIDGE_PCI:
+		case PCI_HEADER_TYPE_BRIDGE:
 		default:
 			__pci_bus_size_bridges(b, realloc_head);
 			break;
@@ -1237,12 +1237,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	if (pci_is_root_bus(bus))
 		return;
 
-	switch (bus->self->class >> 8) {
-	case PCI_CLASS_BRIDGE_CARDBUS:
+	switch (bus->self->hdr_type) {
+	case PCI_HEADER_TYPE_CARDBUS:
 		/* don't size cardbuses yet. */
 		break;
 
-	case PCI_CLASS_BRIDGE_PCI:
+	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
@@ -1391,13 +1391,13 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 		__pci_bus_assign_resources(b, realloc_head, fail_head);
 
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
+		switch (dev->hdr_type) {
+		case PCI_HEADER_TYPE_BRIDGE:
 			if (!pci_is_enabled(dev))
 				pci_setup_bridge(b);
 			break;
 
-		case PCI_CLASS_BRIDGE_CARDBUS:
+		case PCI_HEADER_TYPE_CARDBUS:
 			pci_setup_cardbus(b);
 			break;
 
-- 
2.6.4

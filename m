From: Andrew.Murray@arm.com (Andrew Murray)
Date: Fri, 18 Jan 2013 11:37:42 +0000
Subject: [PATCH RFC 1/2] Implementation of pci_fixup_irqs for descendants
 of a specified bus
Message-ID: <20130118113742.GA9006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Continuing from discussion with Thierry (lkml.org/lkml/2013/1/18/107) perhaps
this will be useful to fold into your patchset. 
---
This patch provides pci_bus_fixup_irqs which performs the same
function as pci_fixup_irqs but only to descendants of the specified
bus.

This can reduce unnecessary fixing up of device irqs when new buses
are added.

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/pci/setup-irq.c |   15 +++++++++++++++
 include/linux/pci.h     |    3 +++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index eb219a1..ea91874 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -62,3 +62,18 @@ pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 	for_each_pci_dev(dev)
 		pdev_fixup_irq(dev, swizzle, map_irq);
 }
+
+void __init
+pci_bus_fixup_irqs(struct pci_bus *bus,
+		u8 (*swizzle)(struct pci_dev *, u8 *),
+		int (*map_irq)(const struct pci_dev *, u8, u8))
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pdev_fixup_irq(dev, swizzle, map_irq);
+
+		if (dev->subordinate)
+			pci_bus_fixup_irqs(dev->subordinate, swizzle, map_irq);
+	}
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5faa831..1b3c2eb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -953,6 +953,9 @@ void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(const struct pci_dev *, u8, u8));
+void pci_bus_fixup_irqs(struct pci_bus *bus,
+		u8 (*swizzle)(struct pci_dev *, u8 *),
+		int (*map_irq)(const struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
1.7.0.4

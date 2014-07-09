From: matthew_minter@xyratex.com (Matthew Minter)
Date: Wed, 9 Jul 2014 18:08:07 +0100
Subject: [PATCH RFC] Armada XP (mvebu) Hot-plug issues continued
Message-ID: <CAFJTrDsu4k80kLjF9yZzctjznbYJ74y4m-VT3Vkf3XtGQXGAMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

This is something of a follow up to my previous thread:
Armada XP (mvebu) PCIe memory (BAR/window) re-allocation

Thanks to the helpful patches provided to the mvebu PCIe subsystem,
hot-plug PCIe devices worked much better on this board, however I have
discovered one remaining issue regarding them, due to the fact the
legacy style IRQ is assigned during the fake "PCI BIOS" phase, devices
which are plugged after boot will not be given an IRQ and thus if they
do not support MSI/MSI-X will fail to initialize.

This seems a fairly simple problem to squash and as such I have
written a small patch which helps solve this, however I am unsure if I
am doing this in a sensible way or if a different kind of rework is
needed here. Also, if this is the wrong mailing list to ask about this
please say so.

Any comments regarding this patch or a better way to achieve this
would be greatly appreciated. Patch follows (sorry if the format is
off, still getting used to git format-patch).

Many thanks,
Matthew


>From 54c95ae3939870e922659d0385cca9fca72d3524 Mon Sep 17 00:00:00 2001
From: matthew_minter <matthew_minter@xyratex.com>
Date: Wed, 9 Jul 2014 17:51:07 +0100
Subject: [PATCH RFC] Added code to ensure hot-added PCI devices are given an
 IRQ on rescan
To: linux-arm-kernel at lists.infradead.org

Signed-off-by: matthew_minter <matthew_minter@xyratex.com>
---
 drivers/pci/bus.c       | 11 +++++++++++
 drivers/pci/setup-irq.c |  2 +-
 include/linux/pci.h     |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 73aef51..eb4f93c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
@@ -245,6 +246,16 @@ void pci_bus_add_device(struct pci_dev *dev)
      * are not assigned yet for some devices.
      */
     pci_fixup_device(pci_fixup_final, dev);
+    /*
+     * Devices which are hot-added after boot have not
+     * been assigned an irq by the bios.
+     */
+    if (unlikely(!dev->irq)) {
+        dev_dbg(&dev->dev,
+            "PCI device missing IRQ, attempting to assign one\n");
+        pdev_fixup_irq(dev, pci_common_swizzle,
+            of_irq_parse_and_map_pci);
+    }
     pci_create_sysfs_dev_files(dev);
     pci_proc_attach_device(dev);

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 4e2d595..38c96c8 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -22,7 +22,7 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
     pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }

-static void pdev_fixup_irq(struct pci_dev *dev,
+void pdev_fixup_irq(struct pci_dev *dev,
                u8 (*swizzle)(struct pci_dev *, u8 *),
                int (*map_irq)(const struct pci_dev *, u8, u8))
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 466bcd1..4c1b1b3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1056,6 +1056,8 @@ void pci_assign_unassigned_bus_resources(struct
pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
+void pdev_fixup_irq(struct pci_dev *, u8 (*)(struct pci_dev *, u8 *),
+            int (*)(const struct pci_dev *, u8, u8));
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
             int (*)(const struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS    2
-- 
2.0.0

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------

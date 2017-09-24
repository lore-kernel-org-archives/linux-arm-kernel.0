From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 23 Sep 2017 20:16:54 -0400
Subject: [PATCH 1/5] PCI: protect restore with device lock to be consistent
Message-ID: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage
with device_lock()") added protection around pci_dev_restore() function so
that device specific remove callback does not cause a race condition
against hotplug.

pci_dev_lock() usage has been forgotten in two different places in the
code. Adding locks for pci_slot_restore() and moving pci_dev_restore()
inside the locks for pci_try_reset_function().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc..23681f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4344,9 +4344,9 @@ int pci_try_reset_function(struct pci_dev *dev)
 
 	pci_dev_save_and_disable(dev);
 	rc = __pci_reset_function_locked(dev);
+	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
-	pci_dev_restore(dev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_try_reset_function);
@@ -4546,7 +4546,9 @@ static void pci_slot_restore(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
+		pci_dev_lock(dev);
 		pci_dev_restore(dev);
+		pci_dev_unlock(dev);
 		if (dev->subordinate)
 			pci_bus_restore(dev->subordinate);
 	}
-- 
1.9.1

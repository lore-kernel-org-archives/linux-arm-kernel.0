From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 23 Oct 2017 17:36:48 -0400
Subject: [PATCH] PCI: rework error checking in the reset path
Message-ID: <1508794608-15310-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return codes from various reset types are not consistent. The code is
assuming that all reset types will return -ENOTTY when things go wrong.
Instead of relying on negative error status, let's bail out if the
operation is successful instead.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc..a753e07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4200,20 +4200,20 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	might_sleep();
 
 	rc = pci_dev_specific_reset(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	if (pcie_has_flr(dev)) {
 		pcie_flr(dev);
 		return 0;
 	}
 	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	return pci_parent_bus_reset(dev, 0);
 }
-- 
1.9.1

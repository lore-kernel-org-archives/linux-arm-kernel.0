From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 19 Apr 2018 15:56:24 -0400
Subject: [PATCH 2/2] PCI/AER: Try slot reset before secondary bus reset
In-Reply-To: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1524167784-5911-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The endpoint observing AER_FATAL error might be connected to a PCI hotplug
slot. Performing secondary bus reset on a hotplug slot causes PCI link
up/down interrupts.

Hotplug driver removes the device from system when a link down interrupt
is observed and performs re-enumeration when link up interrupt is observed.

This conflicts with what this code is trying to do. Try secondary bus
reset only if pci_reset_slot() fails/unsupported.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv.c      | 3 ++-
 drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 779b387..4eaa524 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -318,7 +318,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	pci_reset_bridge_secondary_bus(dev);
+	if (pci_reset_slot(dev->slot))
+		pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 0ea5acc..a915b0e6 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -407,7 +407,8 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  */
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
-	pci_reset_bridge_secondary_bus(dev);
+	if (pci_reset_slot(dev->slot))
+		pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
-- 
2.7.4

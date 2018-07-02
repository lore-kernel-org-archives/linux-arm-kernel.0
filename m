From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  2 Jul 2018 18:52:46 -0400
Subject: [PATCH V5 2/3] PCI: pciehp: reuse pciehp_mask/unmask_irq() in
 reset_slot()
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1530571967-19099-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have individual functions to mask/unmask hotplug interrupts
avoid code duplication and reuse the new API in multiple places.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d44e2c6..ebf9b3b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -726,34 +726,15 @@ static void pcie_disable_notification(struct controller *ctrl)
 int pciehp_reset_slot(struct slot *slot, int probe)
 {
 	struct controller *ctrl = slot->ctrl;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
 	if (probe)
 		return 0;
 
-	if (!ATTN_BUTTN(ctrl)) {
-		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
-		stat_mask |= PCI_EXP_SLTSTA_PDC;
-	}
-	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
-	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
-
-	pcie_write_cmd(ctrl, 0, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
-	if (pciehp_poll_mode)
-		del_timer_sync(&ctrl->poll_timer);
-
+	pciehp_mask_irq(slot);
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
+	pciehp_unmask_irq(slot);
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
-	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
-	if (pciehp_poll_mode)
-		int_poll_timeout(&ctrl->poll_timer);
 	return rc;
 }
 
-- 
2.7.4

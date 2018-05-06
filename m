From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun,  6 May 2018 06:30:53 -0400
Subject: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed erratum
Message-ID: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The QDF2400 controller does not set the Command Completed bit unless
writes to the Slot Command register change "Control" bits.  Command
Completed is never set for writes that only change software notification
"Enable" bits.  This results in timeouts like this:

pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038

Cc: stable at vger.kernel.org
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e70eba5..974a8f1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -914,3 +914,9 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x400,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x401,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-- 
2.7.4

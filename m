From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 24 Sep 2016 22:10:34 -0400
Subject: [PATCH] PCI: enable extended tags support for PCIe endpoints
Message-ID: <1474769434-5756-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each PCIe device can issue up to 32 transactions at a time by default.
Each transaction is tracked by a tag number on the bus. 32 outstanding
transactions is not enough for some performance critical applications
especially when a lot of small sized frames are transmitted.

Extended tags support increases this number to 256. Devices not
supporting extended tags tie-off this field to 0. According to ECN, it
is safe to enable this feature for all PCIe endpoints.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93f280d..2424f38 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1505,12 +1505,19 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
+static int pci_configure_extended_tags(struct pci_dev *dev)
+{
+	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
+					 PCI_EXP_DEVCTL_EXT_TAG);
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
 	int ret;
 
 	pci_configure_mps(dev);
+	pci_configure_extended_tags(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
-- 
1.9.1

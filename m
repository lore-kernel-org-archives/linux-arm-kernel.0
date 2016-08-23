From: okhaliq@caviumnetworks.com (Omer Khaliq)
Date: Tue, 23 Aug 2016 16:27:14 -0700
Subject: [PATCH v2 1/2] PCI: quirk fixup for cavium invalid sriov link value.
In-Reply-To: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
References: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
Message-ID: <1471994835-2423-2-git-send-email-okhaliq@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ananth Jasty <Ananth.Jasty@cavium.com>

Cavium cn88xx hardware presents an incorrect SR-IOV Function
Dependency Link, add a fixup quirk for the affected devices.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Ananth Jasty <Ananth.Jasty@cavium.com>
Signed-off-by: Omer Khaliq <okhaliq@caviumnetworks.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37ff015..5980aae 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -834,6 +834,17 @@ static void quirk_amd_ioapic(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
 #endif /* CONFIG_X86_IO_APIC */
 
+#ifdef CONFIG_ARM64
+
+static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
+{
+	/* Fix for improper SRIOV configuration on Cavium cn88xx  RNM device */
+	if (dev->subsystem_device == 0xa118)
+		dev->sriov->link = dev->devfn;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa018, quirk_cavium_sriov_rnm_link);
+#endif
+
 /*
  * Some settings of MMRBC can lead to data corruption so block changes.
  * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
-- 
1.9.1

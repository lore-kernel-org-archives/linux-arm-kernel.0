From: po.liu@nxp.com (Po Liu)
Date: Tue, 14 Jun 2016 16:24:05 +0800
Subject: [PATCH v3 2/2] pci/aer: interrupt fixup in the quirk
In-Reply-To: <1465892645-32381-1-git-send-email-po.liu@nxp.com>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-1-git-send-email-po.liu@nxp.com>
Message-ID: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
maybe there is interrupt line for aer pme etc. Search the interrupt
number in the fdt file. Then fixup the dev->irq with it.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for V3:
	- Move to quirk;
	- Only correct the irq in RC mode;

 drivers/pci/quirks.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ee72ebe..8b39cce 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/of_irq.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -4419,3 +4420,31 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
+
+/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
+ * but use standalone irq. Read the device tree for the aer
+ * interrupt number.
+ */
+static void quirk_aer_interrupt(struct pci_dev *dev)
+{
+	int ret;
+	u8 header_type;
+	struct device_node *np = NULL;
+
+	/* Only for the RC mode device */
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+	if ((header_type & 0x7F) != PCI_HEADER_TYPE_BRIDGE)
+		return;
+
+	if (dev->bus->dev.of_node)
+		np = dev->bus->dev.of_node;
+
+	if (IS_ENABLED(CONFIG_OF_IRQ) && np) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			dev->no_msi = 1;
+			dev->irq = ret;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_aer_interrupt);
-- 
2.1.0.27.g96db324

From: po.liu@nxp.com (Po Liu)
Date: Thu, 26 May 2016 14:00:06 +0800
Subject: [PATCH 2/2] aer: add support aer interrupt with none MSI/MSI-X/INTx
 mode
Message-ID: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
maybe there is interrupt line for aer pme etc. Search the interrupt
number in the fdt file.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
 drivers/pci/pcie/portdrv_core.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 32d4d0a..64833e5 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/pcieport_if.h>
 #include <linux/aer.h>
+#include <linux/of_irq.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -199,6 +200,28 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int i, irq = -1;
+	int ret;
+	struct device_node *np = NULL;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = 0;
+
+	if (dev->bus->dev.of_node)
+		np = dev->bus->dev.of_node;
+
+	/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
+	 * request irq for aer
+	 */
+	if (IS_ENABLED(CONFIG_OF_IRQ) && np &&
+			(mask & PCIE_PORT_SERVICE_PME)) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
+			if (dev->irq)
+				irq = dev->irq;
+			goto no_msi;
+		}
+	}
 
 	/*
 	 * If MSI cannot be used for PCIe PME or hotplug, we have to use
@@ -224,11 +247,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 		irq = dev->irq;
 
  no_msi:
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = irq;
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		if (!irqs[i])
+			irqs[i] = irq;
+	}
 	irqs[PCIE_PORT_SERVICE_VC_SHIFT] = -1;
 
-	if (irq < 0)
+	if (irq < 0 && irqs[PCIE_PORT_SERVICE_AER_SHIFT] < 0)
 		return -ENODEV;
 	return 0;
 }
-- 
2.1.0.27.g96db324

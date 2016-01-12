From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 12 Jan 2016 23:06:11 +0530
Subject: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to
 work on both Zynq and Microblaze
In-Reply-To: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1452620173-4905-4-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
Zynq and Microblaze Architectures.
With these modifications drivers/pci/host/pcie-xilinx.c, will
work on both Zynq and Microblaze Architectures.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
---
Changes:
Changed Total number of MSI IRQ count logic according to both architectures.
Updated MSI assigning functions accordingly to new count.
Modified irq_domain_add_linear with new MSI IRQ count.
Added #ifdef to pci_fixup_irqs which is ARM specific API.
---
 drivers/pci/host/pcie-xilinx.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 3e3757f..1981948 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -92,7 +92,12 @@
 #define ECAM_DEV_NUM_SHIFT		12
 
 /* Number of MSI IRQs */
-#define XILINX_NUM_MSI_IRQS		128
+#define XILINX_NUM_MSI_IRQS	128
+#ifdef CONFIG_ARM
+#define TOT_NR_IRQS		XILINX_NUM_MSI_IRQS
+#else
+#define TOT_NR_IRQS		(NR_IRQS + XILINX_NUM_MSI_IRQS)
+#endif
 
 
 /**
@@ -238,15 +243,20 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
  */
 static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *port)
 {
+	int irq;
 	int pos;
 
 	pos = find_first_zero_bit(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
-	if (pos < XILINX_NUM_MSI_IRQS)
+	irq = pos;
+#ifdef CONFIG_MICROBLAZE
+	irq = XILINX_NUM_MSI_IRQS + pos;
+#endif
+	if (irq < TOT_NR_IRQS)
 		set_bit(pos, msi_irq_in_use);
 	else
 		return -ENOSPC;
 
-	return pos;
+	return irq;
 }
 
 /**
@@ -520,7 +530,7 @@ static void xilinx_pcie_free_irq_domain(struct xilinx_pcie_port *port)
 
 		free_pages(port->msi_pages, 0);
 
-		num_irqs = XILINX_NUM_MSI_IRQS;
+		num_irqs = TOT_NR_IRQS;
 	} else {
 		/* INTx */
 		num_irqs = 4;
@@ -565,7 +575,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		port->irq_domain = irq_domain_add_linear(node,
-							 XILINX_NUM_MSI_IRQS,
+							 TOT_NR_IRQS,
 							 &msi_domain_ops,
 							 &xilinx_pcie_msi_chip);
 		if (!port->irq_domain) {
@@ -705,7 +715,9 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 #endif
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+#ifdef CONFIG_ARM
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+#endif
 	pci_bus_add_devices(bus);
 	platform_set_drvdata(pdev, port);
 
-- 
2.1.1

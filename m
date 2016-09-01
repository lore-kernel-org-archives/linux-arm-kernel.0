From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 1 Sep 2016 15:44:43 +0530
Subject: [PATCH 3/6] PCI: Xilinx: Clear correct msi set bit
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1472724886-28301-3-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel provides virtual irq number at teardown.
Get hwirq number from virtual irq and clear correct
MSI set bit.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index de1c758..ec2844a 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -221,13 +221,15 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
 {
 	struct msi_desc *msi;
 	struct xilinx_pcie_port *port;
+	struct irq_data *d = irq_get_irq_data(irq);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	if (!test_bit(irq, msi_irq_in_use)) {
+	if (!test_bit(hwirq, msi_irq_in_use)) {
 		msi = irq_get_msi_desc(irq);
 		port = msi_desc_to_pci_sysdata(msi);
 		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
 	} else {
-		clear_bit(irq, msi_irq_in_use);
+		clear_bit(hwirq, msi_irq_in_use);
 	}
 }
 
-- 
2.1.1

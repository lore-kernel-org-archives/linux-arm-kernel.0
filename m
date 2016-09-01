From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 1 Sep 2016 15:44:42 +0530
Subject: [PATCH 2/6] PCI: Xilinx : Clear interrupt register for invalid
 interrupt.
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1472724886-28301-2-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt decode register is not being cleared if
an invalid interrupt arises. This patch adds checks
and clears decode register in this case.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index bd64677..de1c758 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -434,7 +434,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
 			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
-			return IRQ_HANDLED;
+			goto error;
 		}
 
 		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
@@ -456,7 +456,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
 			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
-			return IRQ_HANDLED;
+			goto error;
 		}
 
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
@@ -501,6 +501,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
 		dev_warn(port->dev, "Master error poison\n");
 
+error:
 	/* Clear the Interrupt Decode register */
 	pcie_write(port, status, XILINX_PCIE_REG_IDR);
 
-- 
2.1.1

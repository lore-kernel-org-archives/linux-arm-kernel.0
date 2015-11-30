From: paul.burton@imgtec.com (Paul Burton)
Date: Mon, 30 Nov 2015 16:21:31 +0000
Subject: [PATCH 06/28] PCI: xilinx: unify INTx & MSI interrupt FIFO decode
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1448900513-20856-7-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When decoding either an INTx or MSI interrupt, the driver has no way to
know which it will pull out of the interrupt FIFO. If both were pending
then this would lead to either the interrupt being handled incorrectly
(MSI interrupt treated as INTx) or not at all (INTx interrupt dropped by
MSI path). Unify the reading of the interrupt FIFO & act according to
the type of interrupt actually read.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/pci/host/pcie-xilinx.c | 45 +++++++++++-------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index c412a37..c6fe273 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -397,7 +397,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
 	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
-	u32 val, mask, status, msi_data;
+	u32 val, mask, status;
 
 	/* Read interrupt decode and mask registers */
 	val = pcie_read(port, XILINX_PCIE_REG_IDR);
@@ -437,8 +437,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		xilinx_pcie_clear_err_interrupts(port);
 	}
 
-	if (status & XILINX_PCIE_INTR_INTX) {
-		/* INTx interrupt received */
+	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
+		/* Interrupt received */
 		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
@@ -447,41 +447,20 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			return IRQ_HANDLED;
 		}
 
-		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
-			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
-
-			/* Handle INTx Interrupt */
+		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
+			irq = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
+				XILINX_PCIE_RPIFR2_MSG_DATA;
+		} else {
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
-			generic_handle_irq(irq_find_mapping(port->irq_domain,
-							    val));
+			irq = irq_find_mapping(port->irq_domain, val);
 		}
-	}
 
-	if (status & XILINX_PCIE_INTR_MSI) {
-		/* MSI Interrupt */
-		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+		/* Clear interrupt FIFO register 1 */
+		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			   XILINX_PCIE_REG_RPIFR1);
 
-		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
-			return IRQ_HANDLED;
-		}
-
-		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
-			msi_data = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
-				   XILINX_PCIE_RPIFR2_MSG_DATA;
-
-			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
-				   XILINX_PCIE_REG_RPIFR1);
-
-			if (IS_ENABLED(CONFIG_PCI_MSI)) {
-				/* Handle MSI Interrupt */
-				generic_handle_irq(msi_data);
-			}
-		}
+		generic_handle_irq(irq);
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-- 
2.6.2

From: paul.burton@imgtec.com (Paul Burton)
Date: Mon, 30 Nov 2015 16:21:32 +0000
Subject: [PATCH 07/28] PCI: xilinx: always clear interrupt decode register
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1448900513-20856-8-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an MSI or INTx interrupt is incorrectly triggered with an empty FIFO
then xilinx_pcie_intr_handler will print a warning & skip further
processing. However it did not clear the interrupt in the decode
register, so the same INTX or MSI interrupt would trigger again
immediately even though the FIFO is still empty. Clear the interrupt in
the decode register to avoid that situation.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/pci/host/pcie-xilinx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index c6fe273..3058a57 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -444,7 +444,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
 			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
-			return IRQ_HANDLED;
+			goto out;
 		}
 
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
@@ -490,6 +490,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
 		dev_warn(port->dev, "Master error poison\n");
 
+out:
 	/* Clear the Interrupt Decode register */
 	pcie_write(port, status, XILINX_PCIE_REG_IDR);
 
-- 
2.6.2

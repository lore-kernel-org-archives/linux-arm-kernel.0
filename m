From: paul.burton@imgtec.com (Paul Burton)
Date: Thu, 4 Feb 2016 16:10:10 +0000
Subject: [PATCH v3 3/6] PCI: xilinx: Always clear interrupt decode register
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1454602213-967-4-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an MSI or INTx interrupt is incorrectly triggered with an empty FIFO
then xilinx_pcie_intr_handler will print a warning & skip further
processing. However it did not clear the interrupt in the decode
register, so the same INTX or MSI interrupt would trigger again
immediately even though the FIFO is still empty. Clear the interrupt in
the decode register to avoid that situation.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v3:
- Split out from Boston patchset.

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index afdfb09..1eb74a2 100644
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
@@ -492,6 +492,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
 		dev_warn(port->dev, "Master error poison\n");
 
+out:
 	/* Clear the Interrupt Decode register */
 	pcie_write(port, status, XILINX_PCIE_REG_IDR);
 
-- 
2.7.0

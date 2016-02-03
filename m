From: paul.burton@imgtec.com (Paul Burton)
Date: Wed, 3 Feb 2016 11:30:37 +0000
Subject: [PATCH v2 07/15] PCI: xilinx: Clear interrupt FIFO during probe
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1454499045-5020-8-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xilinx_pcie_init_port clears the pending interrupts in the interrupt
decode register, but does not clear the interrupt FIFO. This would lead
to spurious interrupts if any were present in the FIFO at probe time.
Clear the interrupt FIFO prior to the interrupt decode register in order
to start with a clean slate as expected.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 1eb74a2..6c5a503 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -568,6 +568,8 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 {
+	u32 val;
+
 	if (xilinx_pcie_link_is_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -577,6 +579,17 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
 		   XILINX_PCIE_REG_IMR);
 
+	/* Clear interrupt FIFO */
+	while (1) {
+		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+
+		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID))
+			break;
+
+		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			   XILINX_PCIE_REG_RPIFR1);
+	}
+
 	/* Clear pending interrupts */
 	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_IDR) &
 			 XILINX_PCIE_IMR_ALL_MASK,
-- 
2.7.0

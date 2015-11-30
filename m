From: paul.burton@imgtec.com (Paul Burton)
Date: Mon, 30 Nov 2015 16:21:45 +0000
Subject: [PATCH 20/28] net: pch_gbe: clear interrupt FIFO during probe
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xilinx_pcie_init_port clears the pending interrupts in the interrupt
decode register, but does not clear the interrupt FIFO. This would lead
to spurious interrupts if any were present in the FIFO at probe time.
Clear the interrupt FIFO prior to the interrupt decode register in order
to start with a clean slate as expected.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/pci/host/pcie-xilinx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index ac9da72..0edb612 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -566,6 +566,8 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 {
+	u32 val;
+
 	if (xilinx_pcie_link_is_up(port))
 		dev_info(port->dev, "PCIe Link is UP\n");
 	else
@@ -575,6 +577,17 @@ static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
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
2.6.2

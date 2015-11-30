From: paul.burton@imgtec.com (Paul Burton)
Date: Mon, 30 Nov 2015 16:21:33 +0000
Subject: [PATCH 08/28] PCI: xilinx: fix INTX irq dispatch
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1448900513-20856-9-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ domain for INTX interrupts has 4 entries, numbered 0 to 3. This
matches what the hardware reports from the interrupt FIFO exactly, but
xilinx_pcie_intr_handler was adding 1 to that value to convert to the
range 1 to 4. Stop adding 1, such that all of INTA through to INTD fall
within the range of the IRQ domain.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/pci/host/pcie-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 3058a57..ac9da72 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -451,8 +451,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			irq = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
 				XILINX_PCIE_RPIFR2_MSG_DATA;
 		} else {
-			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
-				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
+			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
+				XILINX_PCIE_RPIFR1_INTR_SHIFT;
 			irq = irq_find_mapping(port->irq_domain, val);
 		}
 
-- 
2.6.2

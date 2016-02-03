From: paul.burton@imgtec.com (Paul Burton)
Date: Wed, 3 Feb 2016 11:30:38 +0000
Subject: [PATCH v2 08/15] PCI: xilinx: Fix INTX irq dispatch
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
Message-ID: <1454499045-5020-9-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ domain for INTX interrupts has 4 entries, numbered 0 to 3. This
matches what the hardware reports from the interrupt FIFO exactly, but
xilinx_pcie_intr_handler was adding 1 to that value to convert to the
range 1 to 4. Stop adding 1, such that all of INTA through to INTD fall
within the range of the IRQ domain.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 6c5a503..8013e83 100644
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
2.7.0

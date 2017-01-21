From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Sat, 21 Jan 2017 16:41:09 +0530
Subject: [PATCH 1/4] PCI: Xilinx NWL: Fix,
 do not check for legacy status in while loop
Message-ID: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- The legacy status register value for particular INTx becomes low
only after DEASSERT_INTx is received.
- Few End Points take time for sending DEASSERT_INTx, checking
legacy status register in while loop causes invoking of EP
handler continuosly until DEASSERT_INTx is received.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 43eaa4a..c8b5a33 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -342,9 +342,10 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 	pcie = irq_desc_get_handler_data(desc);
+	status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
+				  MSGF_LEG_SR_MASKALL;
 
-	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
-				MSGF_LEG_SR_MASKALL) != 0) {
+	if (status != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
 			virq = irq_find_mapping(pcie->legacy_irq_domain,
 						bit + 1);
-- 
1.7.1

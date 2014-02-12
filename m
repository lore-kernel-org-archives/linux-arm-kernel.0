From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 16:55:39 +0100
Subject: [PATCH 05/14] net: axienet: Service completion interrupts ASAP
In-Reply-To: <cover.1392220536.git.michal.simek@xilinx.com>
References: <cover.1392220536.git.michal.simek@xilinx.com>
Message-ID: <cafb13f2ebe4bb996bafb91e405d8609454bb920.1392220536.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

The packet completion interrupts for TX and RX should be serviced before
the packets are consumed. This ensures against the degenerate case when a
new completion interrupt is raised after the handler has exited but before
the interrupts are cleared. In this case its possible for the ISR to clear
an unhandled interrupt (leading to potential deadlock).

Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Jason Wu <huanyu@xilinx.com>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2e21ab2..3c24f97 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -809,6 +809,7 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)

 	status = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
 	if (status & (XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK)) {
+		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);
 		axienet_start_xmit_done(lp->ndev);
 		goto out;
 	}
@@ -832,9 +833,9 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
 		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);

 		tasklet_schedule(&lp->dma_err_tasklet);
+		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);
 	}
 out:
-	axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);
 	return IRQ_HANDLED;
 }

@@ -857,6 +858,7 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)

 	status = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
 	if (status & (XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK)) {
+		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);
 		axienet_recv(lp->ndev);
 		goto out;
 	}
@@ -880,9 +882,9 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
 		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);

 		tasklet_schedule(&lp->dma_err_tasklet);
+		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);
 	}
 out:
-	axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);
 	return IRQ_HANDLED;
 }

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/e7924246/attachment.sig>

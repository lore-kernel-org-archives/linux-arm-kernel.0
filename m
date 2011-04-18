From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 18 Apr 2011 16:52:00 +0530
Subject: [PATCH] tty/serial/pl011: don't print error msg if dmaengine_pause is
	not supported
Message-ID: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few dma controller doesn't support dmaengine_pause() and return -ENXIO if
dmaengine_pause() is called for them. Error messages such as "unable to pause
DMA transfer" shouldn't be printed for them.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/tty/serial/amba-pl011.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6deee4e..c0e1a42 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -755,18 +755,21 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	size_t pending;
 	struct dma_tx_state state;
 	enum dma_status dmastat;
+	int ret;
 
 	/*
 	 * Pause the transfer so we can trust the current counter,
 	 * do this before we pause the PL011 block, else we may
 	 * overflow the FIFO.
 	 */
-	if (dmaengine_pause(rxchan))
-		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
+	ret = dmaengine_pause(rxchan);
+	if (ret && ret != -ENXIO)
+		dev_err(uap->port.dev, "unable to pause DMA transfer");
+
 	dmastat = rxchan->device->device_tx_status(rxchan,
-						   dmarx->cookie, &state);
-	if (dmastat != DMA_PAUSED)
-		dev_err(uap->port.dev, "unable to pause DMA transfer\n");
+			dmarx->cookie, &state);
+	if (ret != -ENXIO && dmastat != DMA_PAUSED)
+		dev_err(uap->port.dev, "unable to pause DMA transfer");
 
 	/* Disable RX DMA - incoming data will wait in the FIFO */
 	uap->dmacr &= ~UART011_RXDMAE;
-- 
1.7.2.2

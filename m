From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri,  5 Sep 2014 21:02:48 +0200
Subject: [PATCH 13/18] tty: serial: 8250_dma: keep own book keeping about RX
 transfers
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1409943773-7874-14-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After dmaengine_terminate_all() has been invoked then both DMA drivers
(edma and omap-dma) do not invoke dma_cookie_complete() to mark the
transfer as complete. This dma_cookie_complete() is performed by the
Synopsys DesignWare driver which is probably the only one that is used
by omap8250-dma and hence don't see following problem?
?which is that once a RX transfer has been terminated then following
query of channel status reports DMA_IN_PROGRESS (again: the actual
transfer has been canceled, there is nothing going on anymore).

This means that serial8250_rx_dma() never enqueues another DMA transfer
because it (wrongly) assumes that there is a transer already pending.

Vinod Koul refuses to accept a patch which adds this
dma_cookie_complete() to both drivers and so dmaengine_tx_status() would
report DMA_COMPLETE instead (and behave like the Synopsys DesignWare
driver already does). He argues that I am not allowed to use the cookie
to query the status and that the driver already cleaned everything up after
the invokation of dmaengine_terminate_all().

To end this I add a bookkeeping whether or not a RX-transfer has been
started to the 8250-dma code. It has already been done for the TX side.
*Now* we learn about the RX status based on our bookkeeping and don't
need dmaengine_tx_status() for this anymore.

Cc: vinod.koul at intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250.h     |  1 +
 drivers/tty/serial/8250/8250_dma.c | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 09489b391568..a7581b37f264 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -42,6 +42,7 @@ struct uart_8250_dma {
 
 	unsigned char		tx_running:1;
 	unsigned char		tx_err: 1;
+	unsigned char		rx_running:1;
 };
 
 struct old_serial_port {
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 48dc57aad0dd..6cd8a4db609a 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -60,6 +60,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p, bool error)
 	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
 				dma->rx_size, DMA_FROM_DEVICE);
 
+	dma->rx_running = 0;
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
 	dmaengine_terminate_all(dma->rxchan);
 
@@ -162,21 +163,21 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 {
 	struct uart_8250_dma		*dma = p->dma;
 	struct dma_async_tx_descriptor	*desc;
-	struct dma_tx_state		state;
-	int				dma_status;
-
-	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
 
 	switch (iir & 0x3f) {
 	case UART_IIR_RLSI:
 		/* 8250_core handles errors and break interrupts */
+		if (dma->rx_running) {
+			dmaengine_pause(dma->rxchan);
+			__dma_rx_do_complete(p, true);
+		}
 		return -EIO;
 	case UART_IIR_RX_TIMEOUT:
 		/*
 		 * If RCVR FIFO trigger level was not reached, complete the
 		 * transfer and let 8250_core copy the remaining data.
 		 */
-		if (dma_status == DMA_IN_PROGRESS) {
+		if (dma->rx_running) {
 			dmaengine_pause(dma->rxchan);
 			__dma_rx_do_complete(p, true);
 		}
@@ -185,7 +186,7 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 		break;
 	}
 
-	if (dma_status)
+	if (dma->rx_running)
 		return 0;
 
 	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
@@ -194,6 +195,7 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
 	if (!desc)
 		return -EBUSY;
 
+	dma->rx_running = 1;
 	desc->callback = __dma_rx_complete;
 	desc->callback_param = p;
 
-- 
2.1.0

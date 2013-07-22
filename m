From: elen.song@atmel.com (Elen Song)
Date: Mon, 22 Jul 2013 16:30:25 +0800
Subject: [PATCH 2/8 V3] serial: at91: use function pointer to choose pdc or pio
In-Reply-To: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
References: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
Message-ID: <1374481831-24573-3-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use function pointer can avoid define atmel_use_pdc_tx/rx everywhere.
(*prepare_rx/tx)() is in setup transfer stage.
(*schedule_rx/tx)() is in tasklet schedule stage.
(*release_rx/tx)() is used when shutdown the transfer.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |  203 ++++++++++++++++++++++++-------------
 1 file changed, 130 insertions(+), 73 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 81a8807..ae61f2b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -155,6 +155,12 @@ struct atmel_uart_port {
 
 	struct serial_rs485	rs485;		/* rs485 settings */
 	unsigned int		tx_done_mask;
+	int (*prepare_rx)(struct uart_port *port);
+	int (*prepare_tx)(struct uart_port *port);
+	void (*schedule_rx)(struct uart_port *port);
+	void (*schedule_tx)(struct uart_port *port);
+	void (*release_rx)(struct uart_port *port);
+	void (*release_tx)(struct uart_port *port);
 };
 
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
@@ -658,6 +664,17 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 	return pass_counter ? IRQ_HANDLED : IRQ_NONE;
 }
 
+static void atmel_release_tx_pdc(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
+
+	dma_unmap_single(port->dev,
+			 pdc->dma_addr,
+			 pdc->dma_size,
+			 DMA_TO_DEVICE);
+}
+
 /*
  * Called from tasklet with ENDTX and TXBUFE interrupts disabled.
  */
@@ -710,6 +727,23 @@ static void atmel_tx_pdc(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
+static int atmel_prepare_tx_pdc(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
+	struct circ_buf *xmit = &port->state->xmit;
+
+	pdc->buf = xmit->buf;
+	pdc->dma_addr = dma_map_single(port->dev,
+					pdc->buf,
+					UART_XMIT_SIZE,
+					DMA_TO_DEVICE);
+	pdc->dma_size = UART_XMIT_SIZE;
+	pdc->ofs = 0;
+
+	return 0;
+}
+
 static void atmel_rx_from_ring(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -778,6 +812,22 @@ static void atmel_rx_from_ring(struct uart_port *port)
 	spin_lock(&port->lock);
 }
 
+static void atmel_release_rx_pdc(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct atmel_dma_buffer *pdc = &atmel_port->pdc_rx[i];
+
+		dma_unmap_single(port->dev,
+				 pdc->dma_addr,
+				 pdc->dma_size,
+				 DMA_FROM_DEVICE);
+		kfree(pdc->buf);
+	}
+}
+
 static void atmel_rx_from_pdc(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -855,6 +905,45 @@ static void atmel_rx_from_pdc(struct uart_port *port)
 	UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
 }
 
+static int atmel_prepare_rx_pdc(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct atmel_dma_buffer *pdc = &atmel_port->pdc_rx[i];
+
+		pdc->buf = kmalloc(PDC_BUFFER_SIZE, GFP_KERNEL);
+		if (pdc->buf == NULL) {
+			if (i != 0) {
+				dma_unmap_single(port->dev,
+					atmel_port->pdc_rx[0].dma_addr,
+					PDC_BUFFER_SIZE,
+					DMA_FROM_DEVICE);
+				kfree(atmel_port->pdc_rx[0].buf);
+			}
+			atmel_port->use_pdc_rx = 0;
+			return -ENOMEM;
+		}
+		pdc->dma_addr = dma_map_single(port->dev,
+						pdc->buf,
+						PDC_BUFFER_SIZE,
+						DMA_FROM_DEVICE);
+		pdc->dma_size = PDC_BUFFER_SIZE;
+		pdc->ofs = 0;
+	}
+
+	atmel_port->pdc_rx_idx = 0;
+
+	UART_PUT_RPR(port, atmel_port->pdc_rx[0].dma_addr);
+	UART_PUT_RCR(port, PDC_BUFFER_SIZE);
+
+	UART_PUT_RNPR(port, atmel_port->pdc_rx[1].dma_addr);
+	UART_PUT_RNCR(port, PDC_BUFFER_SIZE);
+
+	return 0;
+}
+
 /*
  * tasklet handling tty stuff outside the interrupt handler.
  */
@@ -868,10 +957,7 @@ static void atmel_tasklet_func(unsigned long data)
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
 
-	if (atmel_use_pdc_tx(port))
-		atmel_tx_pdc(port);
-	else
-		atmel_tx_chars(port);
+	atmel_port->schedule_tx(port);
 
 	status = atmel_port->irq_status;
 	status_change = status ^ atmel_port->irq_status_prev;
@@ -893,14 +979,36 @@ static void atmel_tasklet_func(unsigned long data)
 		atmel_port->irq_status_prev = status;
 	}
 
-	if (atmel_use_pdc_rx(port))
-		atmel_rx_from_pdc(port);
-	else
-		atmel_rx_from_ring(port);
+	atmel_port->schedule_rx(port);
 
 	spin_unlock(&port->lock);
 }
 
+static void atmel_set_ops(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	if (atmel_use_pdc_rx(port)) {
+		atmel_port->prepare_rx = &atmel_prepare_rx_pdc;
+		atmel_port->schedule_rx = &atmel_rx_from_pdc;
+		atmel_port->release_rx = &atmel_release_rx_pdc;
+	} else {
+		atmel_port->prepare_rx = NULL;
+		atmel_port->schedule_rx = &atmel_rx_from_ring;
+		atmel_port->release_rx = NULL;
+	}
+
+	if (atmel_use_pdc_tx(port)) {
+		atmel_port->prepare_tx = &atmel_prepare_tx_pdc;
+		atmel_port->schedule_tx = &atmel_tx_pdc;
+		atmel_port->release_tx = &atmel_release_tx_pdc;
+	} else {
+		atmel_port->prepare_tx = NULL;
+		atmel_port->schedule_tx = &atmel_tx_chars;
+		atmel_port->release_tx = NULL;
+	}
+}
+
 /*
  * Perform initialization and enable port for reception
  */
@@ -930,53 +1038,17 @@ static int atmel_startup(struct uart_port *port)
 	/*
 	 * Initialize DMA (if necessary)
 	 */
-	if (atmel_use_pdc_rx(port)) {
-		int i;
-
-		for (i = 0; i < 2; i++) {
-			struct atmel_dma_buffer *pdc = &atmel_port->pdc_rx[i];
-
-			pdc->buf = kmalloc(PDC_BUFFER_SIZE, GFP_KERNEL);
-			if (pdc->buf == NULL) {
-				if (i != 0) {
-					dma_unmap_single(port->dev,
-						atmel_port->pdc_rx[0].dma_addr,
-						PDC_BUFFER_SIZE,
-						DMA_FROM_DEVICE);
-					kfree(atmel_port->pdc_rx[0].buf);
-				}
-				free_irq(port->irq, port);
-				return -ENOMEM;
-			}
-			pdc->dma_addr = dma_map_single(port->dev,
-						       pdc->buf,
-						       PDC_BUFFER_SIZE,
-						       DMA_FROM_DEVICE);
-			pdc->dma_size = PDC_BUFFER_SIZE;
-			pdc->ofs = 0;
-		}
-
-		atmel_port->pdc_rx_idx = 0;
-
-		UART_PUT_RPR(port, atmel_port->pdc_rx[0].dma_addr);
-		UART_PUT_RCR(port, PDC_BUFFER_SIZE);
-
-		UART_PUT_RNPR(port, atmel_port->pdc_rx[1].dma_addr);
-		UART_PUT_RNCR(port, PDC_BUFFER_SIZE);
+	if (atmel_port->prepare_rx) {
+		retval = atmel_port->prepare_rx(port);
+		if (retval < 0)
+			atmel_set_ops(port);
 	}
-	if (atmel_use_pdc_tx(port)) {
-		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
-		struct circ_buf *xmit = &port->state->xmit;
 
-		pdc->buf = xmit->buf;
-		pdc->dma_addr = dma_map_single(port->dev,
-					       pdc->buf,
-					       UART_XMIT_SIZE,
-					       DMA_TO_DEVICE);
-		pdc->dma_size = UART_XMIT_SIZE;
-		pdc->ofs = 0;
+	if (atmel_port->prepare_tx) {
+		retval = atmel_port->prepare_tx(port);
+		if (retval < 0)
+			atmel_set_ops(port);
 	}
-
 	/*
 	 * If there is a specific "open" function (to register
 	 * control line interrupts)
@@ -1031,27 +1103,10 @@ static void atmel_shutdown(struct uart_port *port)
 	/*
 	 * Shut-down the DMA.
 	 */
-	if (atmel_use_pdc_rx(port)) {
-		int i;
-
-		for (i = 0; i < 2; i++) {
-			struct atmel_dma_buffer *pdc = &atmel_port->pdc_rx[i];
-
-			dma_unmap_single(port->dev,
-					 pdc->dma_addr,
-					 pdc->dma_size,
-					 DMA_FROM_DEVICE);
-			kfree(pdc->buf);
-		}
-	}
-	if (atmel_use_pdc_tx(port)) {
-		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
-
-		dma_unmap_single(port->dev,
-				 pdc->dma_addr,
-				 pdc->dma_size,
-				 DMA_TO_DEVICE);
-	}
+	if (atmel_port->release_rx)
+		atmel_port->release_rx(port);
+	if (atmel_port->release_tx)
+		atmel_port->release_tx(port);
 
 	/*
 	 * Disable all interrupts, port and break condition.
@@ -1473,6 +1528,8 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
 		atmel_port->rs485	= pdata->rs485;
 	}
 
+	atmel_set_ops(port);
+
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF;
 	port->ops		= &atmel_pops;
-- 
1.7.9.5

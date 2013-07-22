From: elen.song@atmel.com (Elen Song)
Date: Mon, 22 Jul 2013 16:30:24 +0800
Subject: [PATCH 1/8 V3] serial: at91: correct definition from DMA to PDC
In-Reply-To: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
References: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
Message-ID: <1374481831-24573-2-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA is available since at91sam9x5 socs, before that, we use PDC.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   71 +++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3467462..81a8807 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -140,11 +140,11 @@ struct atmel_uart_port {
 	u32			backup_imr;	/* IMR saved during suspend */
 	int			break_active;	/* break being received */
 
-	short			use_dma_rx;	/* enable PDC receiver */
+	bool			use_pdc_rx;	/* enable PDC receiver */
 	short			pdc_rx_idx;	/* current PDC RX buffer */
 	struct atmel_dma_buffer	pdc_rx[2];	/* PDC receier */
 
-	short			use_dma_tx;	/* enable PDC transmitter */
+	bool			use_pdc_tx;	/* enable PDC transmitter */
 	struct atmel_dma_buffer	pdc_tx;		/* PDC transmitter */
 
 	struct tasklet_struct	tasklet;
@@ -181,26 +181,26 @@ to_atmel_uart_port(struct uart_port *uart)
 }
 
 #ifdef CONFIG_SERIAL_ATMEL_PDC
-static bool atmel_use_dma_rx(struct uart_port *port)
+static bool atmel_use_pdc_rx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	return atmel_port->use_dma_rx;
+	return atmel_port->use_pdc_rx;
 }
 
-static bool atmel_use_dma_tx(struct uart_port *port)
+static bool atmel_use_pdc_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	return atmel_port->use_dma_tx;
+	return atmel_port->use_pdc_tx;
 }
 #else
-static bool atmel_use_dma_rx(struct uart_port *port)
+static bool atmel_use_pdc_rx(struct uart_port *port)
 {
 	return false;
 }
 
-static bool atmel_use_dma_tx(struct uart_port *port)
+static bool atmel_use_pdc_tx(struct uart_port *port)
 {
 	return false;
 }
@@ -233,7 +233,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
-		if (atmel_use_dma_tx(port))
+		if (atmel_use_pdc_tx(port))
 			atmel_port->tx_done_mask = ATMEL_US_ENDTX |
 				ATMEL_US_TXBUFE;
 		else
@@ -345,7 +345,7 @@ static void atmel_stop_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	if (atmel_use_dma_tx(port)) {
+	if (atmel_use_pdc_tx(port)) {
 		/* disable PDC transmit */
 		UART_PUT_PTCR(port, ATMEL_PDC_TXTDIS);
 	}
@@ -364,7 +364,7 @@ static void atmel_start_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	if (atmel_use_dma_tx(port)) {
+	if (atmel_use_pdc_tx(port)) {
 		if (UART_GET_PTSR(port) & ATMEL_PDC_TXTEN)
 			/* The transmitter is already running.  Yes, we
 			   really need this.*/
@@ -390,7 +390,7 @@ static void atmel_start_rx(struct uart_port *port)
 
 	UART_PUT_CR(port, ATMEL_US_RXEN);
 
-	if (atmel_use_dma_rx(port)) {
+	if (atmel_use_pdc_rx(port)) {
 		/* enable PDC controller */
 		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
 			port->read_status_mask);
@@ -407,7 +407,7 @@ static void atmel_stop_rx(struct uart_port *port)
 {
 	UART_PUT_CR(port, ATMEL_US_RXDIS);
 
-	if (atmel_use_dma_rx(port)) {
+	if (atmel_use_pdc_rx(port)) {
 		/* disable PDC receive */
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTDIS);
 		UART_PUT_IDR(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
@@ -572,7 +572,7 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	if (atmel_use_dma_rx(port)) {
+	if (atmel_use_pdc_rx(port)) {
 		/*
 		 * PDC receive. Just schedule the tasklet and let it
 		 * figure out the details.
@@ -661,7 +661,7 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 /*
  * Called from tasklet with ENDTX and TXBUFE interrupts disabled.
  */
-static void atmel_tx_dma(struct uart_port *port)
+static void atmel_tx_pdc(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	struct circ_buf *xmit = &port->state->xmit;
@@ -778,7 +778,7 @@ static void atmel_rx_from_ring(struct uart_port *port)
 	spin_lock(&port->lock);
 }
 
-static void atmel_rx_from_dma(struct uart_port *port)
+static void atmel_rx_from_pdc(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	struct tty_port *tport = &port->state->port;
@@ -868,8 +868,8 @@ static void atmel_tasklet_func(unsigned long data)
 	/* The interrupt handler does not take the lock */
 	spin_lock(&port->lock);
 
-	if (atmel_use_dma_tx(port))
-		atmel_tx_dma(port);
+	if (atmel_use_pdc_tx(port))
+		atmel_tx_pdc(port);
 	else
 		atmel_tx_chars(port);
 
@@ -893,8 +893,8 @@ static void atmel_tasklet_func(unsigned long data)
 		atmel_port->irq_status_prev = status;
 	}
 
-	if (atmel_use_dma_rx(port))
-		atmel_rx_from_dma(port);
+	if (atmel_use_pdc_rx(port))
+		atmel_rx_from_pdc(port);
 	else
 		atmel_rx_from_ring(port);
 
@@ -930,7 +930,7 @@ static int atmel_startup(struct uart_port *port)
 	/*
 	 * Initialize DMA (if necessary)
 	 */
-	if (atmel_use_dma_rx(port)) {
+	if (atmel_use_pdc_rx(port)) {
 		int i;
 
 		for (i = 0; i < 2; i++) {
@@ -964,7 +964,7 @@ static int atmel_startup(struct uart_port *port)
 		UART_PUT_RNPR(port, atmel_port->pdc_rx[1].dma_addr);
 		UART_PUT_RNCR(port, PDC_BUFFER_SIZE);
 	}
-	if (atmel_use_dma_tx(port)) {
+	if (atmel_use_pdc_tx(port)) {
 		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
 		struct circ_buf *xmit = &port->state->xmit;
 
@@ -1000,7 +1000,7 @@ static int atmel_startup(struct uart_port *port)
 	/* enable xmit & rcvr */
 	UART_PUT_CR(port, ATMEL_US_TXEN | ATMEL_US_RXEN);
 
-	if (atmel_use_dma_rx(port)) {
+	if (atmel_use_pdc_rx(port)) {
 		/* set UART timeout */
 		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
 		UART_PUT_CR(port, ATMEL_US_STTTO);
@@ -1031,7 +1031,7 @@ static void atmel_shutdown(struct uart_port *port)
 	/*
 	 * Shut-down the DMA.
 	 */
-	if (atmel_use_dma_rx(port)) {
+	if (atmel_use_pdc_rx(port)) {
 		int i;
 
 		for (i = 0; i < 2; i++) {
@@ -1044,7 +1044,7 @@ static void atmel_shutdown(struct uart_port *port)
 			kfree(pdc->buf);
 		}
 	}
-	if (atmel_use_dma_tx(port)) {
+	if (atmel_use_pdc_tx(port)) {
 		struct atmel_dma_buffer *pdc = &atmel_port->pdc_tx;
 
 		dma_unmap_single(port->dev,
@@ -1080,7 +1080,7 @@ static void atmel_flush_buffer(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	if (atmel_use_dma_tx(port)) {
+	if (atmel_use_pdc_tx(port)) {
 		UART_PUT_TCR(port, 0);
 		atmel_port->pdc_tx.ofs = 0;
 	}
@@ -1193,7 +1193,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_iflag & (BRKINT | PARMRK))
 		port->read_status_mask |= ATMEL_US_RXBRK;
 
-	if (atmel_use_dma_rx(port))
+	if (atmel_use_pdc_rx(port))
 		/* need to enable error interrupts */
 		UART_PUT_IER(port, port->read_status_mask);
 
@@ -1430,13 +1430,14 @@ static void atmel_of_init_port(struct atmel_uart_port *atmel_port,
 
 	/* DMA/PDC usage specification */
 	if (of_get_property(np, "atmel,use-dma-rx", NULL))
-		atmel_port->use_dma_rx	= 1;
+		atmel_port->use_pdc_rx	= true;
 	else
-		atmel_port->use_dma_rx	= 0;
+		atmel_port->use_pdc_rx	= false;
+
 	if (of_get_property(np, "atmel,use-dma-tx", NULL))
-		atmel_port->use_dma_tx	= 1;
+		atmel_port->use_pdc_tx	= true;
 	else
-		atmel_port->use_dma_tx	= 0;
+		atmel_port->use_pdc_tx	= false;
 
 	/* rs485 properties */
 	if (of_property_read_u32_array(np, "rs485-rts-delay",
@@ -1467,8 +1468,8 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
 	if (pdev->dev.of_node) {
 		atmel_of_init_port(atmel_port, pdev->dev.of_node);
 	} else {
-		atmel_port->use_dma_rx	= pdata->use_dma_rx;
-		atmel_port->use_dma_tx	= pdata->use_dma_tx;
+		atmel_port->use_pdc_rx	= pdata->use_dma_rx;
+		atmel_port->use_pdc_tx	= pdata->use_dma_tx;
 		atmel_port->rs485	= pdata->rs485;
 	}
 
@@ -1505,7 +1506,7 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-	else if (atmel_use_dma_tx(port)) {
+	else if (atmel_use_pdc_tx(port)) {
 		port->fifosize = PDC_BUFFER_SIZE;
 		atmel_port->tx_done_mask = ATMEL_US_ENDTX | ATMEL_US_TXBUFE;
 	} else {
@@ -1794,7 +1795,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (!atmel_use_dma_rx(&port->uart)) {
+	if (!atmel_use_pdc_rx(&port->uart)) {
 		ret = -ENOMEM;
 		data = kmalloc(sizeof(struct atmel_uart_char)
 				* ATMEL_SERIAL_RINGSIZE, GFP_KERNEL);
-- 
1.7.9.5

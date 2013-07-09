From: elen.song@atmel.com (Elen Song)
Date: Tue, 9 Jul 2013 14:33:42 +0800
Subject: [PATCH 3/7] serial: at91: add rx dma support
In-Reply-To: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373351626-30143-4-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request a cyclic dma channel for rx dma use. Use cyclic transfer is to prevent
receive data overrun.

atmel_allocate_desc will allocate a cycle dma cookie after request channel,
after that, enable uart timeout interrupt in startup stage, when data successful
received, the timeout callback will check the residual bytes and insert
receiving datas into the framework during the transfer interval.

When current descriptor finished, the dma callback will also check the residual
bytes and filp the receiving data.

Signed-off-by: Elen Song <elen.song@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c   |  236 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/atmel.h |    1 +
 2 files changed, 237 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c20312d..a425ff2 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -140,6 +140,7 @@ struct atmel_uart_port {
 	u32			backup_imr;	/* IMR saved during suspend */
 	int			break_active;	/* break being received */
 
+	short			use_dma_rx;	/* enable DMA receiver */
 	short			use_pdc_rx;	/* enable PDC receiver */
 	short			pdc_rx_idx;	/* current PDC RX buffer */
 	struct atmel_dma_buffer	pdc_rx[2];	/* PDC receier */
@@ -149,10 +150,15 @@ struct atmel_uart_port {
 	struct atmel_dma_buffer	pdc_tx;		/* PDC transmitter */
 
 	spinlock_t			lock_tx;	/* port lock */
+	spinlock_t			lock_rx;	/* port lock */
 	struct dma_chan			*chan_tx;
+	struct dma_chan			*chan_rx;
 	struct dma_async_tx_descriptor	*desc_tx;
+	struct dma_async_tx_descriptor	*desc_rx;
 	dma_cookie_t			cookie_tx;
+	dma_cookie_t			cookie_rx;
 	struct scatterlist		sg_tx;
+	struct scatterlist		sg_rx;
 	struct tasklet_struct	tasklet;
 	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
@@ -219,6 +225,13 @@ static bool atmel_use_dma_tx(struct uart_port *port)
 	return atmel_port->use_dma_tx;
 }
 
+static bool atmel_use_dma_rx(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	return atmel_port->use_dma_rx;
+}
+
 /* Enable or disable the rs485 support */
 void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 {
@@ -757,6 +770,204 @@ chan_err:
 	return;
 }
 
+static void atmel_rx_dma_flip_buffer(struct uart_port *port,
+					char *buf, size_t count)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct tty_port *tport = &port->state->port;
+
+	dma_sync_sg_for_cpu(port->dev,
+				&atmel_port->sg_rx,
+				1,
+				DMA_DEV_TO_MEM);
+
+	tty_insert_flip_string(tport, buf, count);
+
+	dma_sync_sg_for_device(port->dev,
+				&atmel_port->sg_rx,
+				1,
+				DMA_DEV_TO_MEM);
+	/*
+	 * Drop the lock here since it might end up calling
+	 * uart_start(), which takes the lock.
+	 */
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(tport);
+	spin_lock(&port->lock);
+}
+
+static void atmel_dma_rx_complete(void *arg)
+{
+	struct uart_port *port = arg;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	tasklet_schedule(&atmel_port->tasklet);
+}
+
+static void atmel_rx_dma_release(struct atmel_uart_port *atmel_port)
+{
+	struct dma_chan *chan = atmel_port->chan_rx;
+	struct uart_port *port = &(atmel_port->uart);
+
+	if (chan) {
+		dmaengine_terminate_all(chan);
+		dma_release_channel(chan);
+		dma_unmap_sg(port->dev, &atmel_port->sg_rx, 1,
+				DMA_DEV_TO_MEM);
+	}
+
+	atmel_port->desc_rx = NULL;
+	atmel_port->chan_rx = NULL;
+	atmel_port->cookie_rx = -EINVAL;
+}
+
+static void atmel_rx_from_dma(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct circ_buf *ring = &atmel_port->rx_ring;
+	struct dma_chan *chan = atmel_port->chan_rx;
+	struct dma_tx_state state;
+	enum dma_status dmastat;
+	size_t pending, count;
+
+
+	/* Reset the UART timeout early so that we don't miss one */
+	UART_PUT_CR(port, ATMEL_US_STTTO);
+	dmastat = dmaengine_tx_status(chan,
+				atmel_port->cookie_rx,
+				&state);
+	/* Restart a new tasklet if DMA status is error */
+	if (dmastat == DMA_ERROR) {
+		dev_dbg(port->dev, "Get residue error, restart tasklet\n");
+		UART_PUT_IER(port, ATMEL_US_TIMEOUT);
+		tasklet_schedule(&atmel_port->tasklet);
+		return;
+	}
+	/* current transfer size should no larger than dma buffer */
+	pending = sg_dma_len(&atmel_port->sg_rx) - state.residue;
+	BUG_ON(pending > sg_dma_len(&atmel_port->sg_rx));
+
+	/*
+	 * This will take the chars we have so far,
+	 * ring->head will record the transfer size, only new bytes come
+	 * will insert into the framework.
+	 */
+	if (pending > ring->head) {
+		count = pending - ring->head;
+
+		atmel_rx_dma_flip_buffer(port, ring->buf + ring->head, count);
+
+		ring->head += count;
+		if (ring->head == sg_dma_len(&atmel_port->sg_rx))
+			ring->head = 0;
+
+		port->icount.rx += count;
+	}
+
+	UART_PUT_IER(port, ATMEL_US_TIMEOUT);
+}
+
+static void atmel_rx_request_dma(struct atmel_uart_port *atmel_port)
+{
+	struct uart_port	*port;
+	dma_cap_mask_t		mask;
+	struct dma_slave_config config;
+	struct circ_buf		*ring;
+	int ret, nent;
+
+	if (atmel_port == NULL)
+		return;
+
+	ring = &atmel_port->rx_ring;
+	port = &(atmel_port->uart);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_CYCLIC, mask);
+
+	atmel_port->chan_rx = dma_request_slave_channel(port->dev, "rx");
+	if (atmel_port->chan_rx == NULL)
+		goto chan_err;
+	dev_info(port->dev, "using %s for rx DMA transfers\n",
+		dma_chan_name(atmel_port->chan_rx));
+	atmel_port->use_dma_rx = 1;
+
+	spin_lock_init(&atmel_port->lock_rx);
+	sg_init_table(&atmel_port->sg_rx, 1);
+	/* UART circular rx buffer is an aligned page. */
+	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+	sg_set_page(&atmel_port->sg_rx,
+			virt_to_page(ring->buf),
+			ATMEL_SERIAL_RINGSIZE,
+			(int)ring->buf & ~PAGE_MASK);
+			nent = dma_map_sg(port->dev,
+					&atmel_port->sg_rx,
+					1,
+					DMA_DEV_TO_MEM);
+
+	if (!nent)
+		dev_dbg(port->dev, "need to release resource of dma\n");
+	else
+		dev_dbg(port->dev, "%s: mapped %d@%p to %x\n", __func__,
+			sg_dma_len(&atmel_port->sg_rx),
+			ring->buf,
+			sg_dma_address(&atmel_port->sg_rx));
+
+	/* Configure the slave DMA */
+	memset(&config, 0, sizeof(config));
+	config.direction = DMA_DEV_TO_MEM;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.src_addr = port->mapbase + ATMEL_US_RHR;
+
+	ret = dmaengine_device_control(atmel_port->chan_rx,
+					DMA_SLAVE_CONFIG,
+					(unsigned long)&config);
+	if (ret) {
+		dev_err(port->dev, "DMA rx slave configuration failed\n");
+		goto chan_err;
+	}
+
+	return;
+
+chan_err:
+	dev_err(port->dev, "RX channel not available, switch to pio\n");
+	atmel_port->use_dma_rx = 0;
+	if (atmel_port->chan_rx)
+		atmel_rx_dma_release(atmel_port);
+	return;
+}
+
+static int atmel_allocate_desc(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *chan = atmel_port->chan_rx;
+
+	if (!chan) {
+		dev_warn(port->dev, "No channel available\n");
+		goto err_dma;
+	}
+	/*
+	 * Prepare a cyclic dma transfer, assign 2 descriptors,
+	 * each one is half ring buffer size
+	 */
+	desc = dmaengine_prep_dma_cyclic(chan,
+				sg_dma_address(&atmel_port->sg_rx),
+				sg_dma_len(&atmel_port->sg_rx),
+				sg_dma_len(&atmel_port->sg_rx)/2,
+				DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT);
+	desc->callback = atmel_dma_rx_complete;
+	desc->callback_param = port;
+	atmel_port->desc_rx = desc;
+	atmel_port->cookie_rx = dmaengine_submit(desc);
+
+	return 0;
+
+err_dma:
+	atmel_rx_dma_release(atmel_port);
+	return -EINVAL;
+}
+
 /*
  * receive interrupt handler.
  */
@@ -784,6 +995,13 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 			atmel_pdc_rxerr(port, pending);
 	}
 
+	if (atmel_use_dma_rx(port)) {
+		if (pending & ATMEL_US_TIMEOUT) {
+			UART_PUT_IDR(port, ATMEL_US_TIMEOUT);
+			tasklet_schedule(&atmel_port->tasklet);
+		}
+	}
+
 	/* Interrupt receive */
 	if (pending & ATMEL_US_RXRDY)
 		atmel_rx_chars(port);
@@ -1090,6 +1308,8 @@ static void atmel_tasklet_func(unsigned long data)
 
 	if (atmel_use_pdc_rx(port))
 		atmel_rx_from_pdc(port);
+	else if (atmel_use_dma_rx(port))
+		atmel_rx_from_dma(port);
 	else
 		atmel_rx_from_ring(port);
 
@@ -1173,6 +1393,11 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	atmel_tx_request_dma(atmel_port);
+	atmel_rx_request_dma(atmel_port);
+	if (atmel_use_dma_rx(port)) {
+		if (atmel_allocate_desc(port))
+			return -EINVAL;
+	}
 
 	/*
 	 * If there is a specific "open" function (to register
@@ -1205,6 +1430,12 @@ static int atmel_startup(struct uart_port *port)
 		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
 		/* enable PDC controller */
 		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
+	} else if (atmel_use_dma_rx(port)) {
+		/* set UART timeout */
+		UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
+		UART_PUT_CR(port, ATMEL_US_STTTO);
+
+		UART_PUT_IER(port, ATMEL_US_TIMEOUT);
 	} else {
 		/* enable receive only */
 		UART_PUT_IER(port, ATMEL_US_RXRDY);
@@ -1252,6 +1483,10 @@ static void atmel_shutdown(struct uart_port *port)
 
 	if (atmel_use_dma_tx(port))
 		atmel_tx_dma_release(atmel_port);
+
+	if (atmel_use_dma_rx(port))
+		atmel_rx_dma_release(atmel_port);
+
 	/*
 	 * Disable all interrupts, port and break condition.
 	 */
@@ -1668,6 +1903,7 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
 	} else {
 		atmel_port->use_pdc_rx	= pdata->use_pdc_rx;
 		atmel_port->use_pdc_tx	= pdata->use_pdc_tx;
+		atmel_port->use_dma_rx	= 0;
 		atmel_port->use_dma_tx	= 0;
 		atmel_port->rs485	= pdata->rs485;
 	}
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 6f5a7c6..167a6fa 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -79,6 +79,7 @@ struct atmel_uart_data {
 	short			use_pdc_tx;	/* use transmit PDC? */
 	short			use_pdc_rx;	/* use receive PDC? */
 	short			use_dma_tx;	/* use transmit DMA? */
+	short			use_dma_rx;	/* use receive DMA? */
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
 };
-- 
1.7.9.5

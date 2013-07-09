From: elen.song@atmel.com (Elen Song)
Date: Tue, 9 Jul 2013 14:33:41 +0800
Subject: [PATCH 2/7] serial: at91: add tx dma support
In-Reply-To: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373351626-30143-3-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request a slave dma channel for tx dma use. Tx dma will setup a single transfer,
when transfer complete, it will call atmel_dma_tx_complete to do finish stuff.

Signed-off-by: Elen Song <elen.song@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c   |  200 +++++++++++++++++++++++++++++++++++
 include/linux/platform_data/atmel.h |    1 +
 2 files changed, 201 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ab9de8a..c20312d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -144,9 +144,15 @@ struct atmel_uart_port {
 	short			pdc_rx_idx;	/* current PDC RX buffer */
 	struct atmel_dma_buffer	pdc_rx[2];	/* PDC receier */
 
+	short                   use_dma_tx;     /* enable DMA transmitter */
 	short			use_pdc_tx;	/* enable PDC transmitter */
 	struct atmel_dma_buffer	pdc_tx;		/* PDC transmitter */
 
+	spinlock_t			lock_tx;	/* port lock */
+	struct dma_chan			*chan_tx;
+	struct dma_async_tx_descriptor	*desc_tx;
+	dma_cookie_t			cookie_tx;
+	struct scatterlist		sg_tx;
 	struct tasklet_struct	tasklet;
 	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
@@ -206,6 +212,13 @@ static bool atmel_use_pdc_tx(struct uart_port *port)
 }
 #endif
 
+static bool atmel_use_dma_tx(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	return atmel_port->use_dma_tx;
+}
+
 /* Enable or disable the rs485 support */
 void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 {
@@ -564,6 +577,186 @@ static void atmel_tx_chars(struct uart_port *port)
 		UART_PUT_IER(port, atmel_port->tx_done_mask);
 }
 
+static void atmel_dma_tx_complete(void *arg)
+{
+	struct atmel_uart_port *atmel_port = arg;
+	struct uart_port *port = &atmel_port->uart;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct dma_chan *chan = atmel_port->chan_tx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (chan)
+		dmaengine_terminate_all(chan);
+	xmit->tail += sg_dma_len(&atmel_port->sg_tx);
+	xmit->tail &= UART_XMIT_SIZE - 1;
+
+	port->icount.tx += sg_dma_len(&atmel_port->sg_tx);
+
+	spin_lock_irq(&atmel_port->lock_tx);
+	async_tx_ack(atmel_port->desc_tx);
+	atmel_port->cookie_tx = -EINVAL;
+	atmel_port->desc_tx = NULL;
+	spin_unlock_irq(&atmel_port->lock_tx);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	/* Do we really need this? */
+	if (!uart_circ_empty(xmit))
+		tasklet_schedule(&atmel_port->tasklet);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void atmel_tx_dma_release(struct atmel_uart_port *atmel_port)
+{
+	struct dma_chan *chan = atmel_port->chan_tx;
+	struct uart_port *port = &(atmel_port->uart);
+
+	if (chan) {
+		dmaengine_terminate_all(chan);
+		dma_release_channel(chan);
+		dma_unmap_sg(port->dev, &atmel_port->sg_tx, 1,
+				DMA_MEM_TO_DEV);
+	}
+
+	atmel_port->desc_tx = NULL;
+	atmel_port->chan_tx = NULL;
+	atmel_port->cookie_tx = -EINVAL;
+}
+
+/*
+ * Called from tasklet with TXRDY interrupt is disabled.
+ */
+static void atmel_tx_dma(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct circ_buf *xmit = &port->state->xmit;
+	struct dma_chan *chan = atmel_port->chan_tx;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sg = &atmel_port->sg_tx;
+
+	/* Make sure we have an idle channel */
+	if (atmel_port->desc_tx != NULL)
+		return;
+
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
+		/*
+		 * DMA is idle now.
+		 * Port xmit buffer is already mapped,
+		 * and it is one page... Just adjust
+		 * offsets and lengths. Since it is a circular buffer,
+		 * we have to transmit till the end, and then the rest.
+		 * Take the port lock to get a
+		 * consistent xmit buffer state.
+		 */
+		sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
+		sg_dma_address(sg) = (sg_dma_address(sg) &
+					~(UART_XMIT_SIZE - 1))
+					+ sg->offset;
+		sg_dma_len(sg) = CIRC_CNT_TO_END(xmit->head,
+						xmit->tail,
+						UART_XMIT_SIZE);
+		BUG_ON(!sg_dma_len(sg));
+
+		desc = dmaengine_prep_slave_sg(chan,
+						sg,
+						1,
+						DMA_MEM_TO_DEV,
+						DMA_PREP_INTERRUPT |
+						DMA_CTRL_ACK);
+		if (!desc) {
+			dev_err(port->dev, "Failed to send via dma!\n");
+			return;
+		}
+
+		dma_sync_sg_for_device(port->dev, sg, 1, DMA_MEM_TO_DEV);
+
+		atmel_port->desc_tx = desc;
+		desc->callback = atmel_dma_tx_complete;
+		desc->callback_param = atmel_port;
+		atmel_port->cookie_tx = dmaengine_submit(desc);
+
+	} else {
+		if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
+			/* DMA done, stop TX, start RX for RS485 */
+			atmel_start_rx(port);
+		}
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void atmel_tx_request_dma(struct atmel_uart_port *atmel_port)
+{
+	struct uart_port	*port;
+	dma_cap_mask_t		mask;
+	struct dma_slave_config config;
+	int ret, nent;
+
+	if (atmel_port == NULL)
+		return;
+
+	port = &(atmel_port->uart);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	atmel_port->chan_tx = dma_request_slave_channel(port->dev, "tx");
+	if (atmel_port->chan_tx == NULL)
+		goto chan_err;
+	dev_info(port->dev, "using %s for tx DMA transfers\n",
+		dma_chan_name(atmel_port->chan_tx));
+	atmel_port->use_dma_tx = 1;
+
+	spin_lock_init(&atmel_port->lock_tx);
+	sg_init_table(&atmel_port->sg_tx, 1);
+	/* UART circular tx buffer is an aligned page. */
+	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+	sg_set_page(&atmel_port->sg_tx,
+			virt_to_page(port->state->xmit.buf),
+			UART_XMIT_SIZE,
+			(int)port->state->xmit.buf & ~PAGE_MASK);
+			nent = dma_map_sg(port->dev,
+					&atmel_port->sg_tx,
+					1,
+					DMA_MEM_TO_DEV);
+
+	if (!nent)
+		dev_dbg(port->dev, "need to release resource of dma\n");
+	else
+		dev_dbg(port->dev, "%s: mapped %d@%p to %x\n", __func__,
+			sg_dma_len(&atmel_port->sg_tx),
+			port->state->xmit.buf,
+			sg_dma_address(&atmel_port->sg_tx));
+
+	/* Configure the slave DMA */
+	memset(&config, 0, sizeof(config));
+	config.direction = DMA_MEM_TO_DEV;
+	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.dst_addr = port->mapbase + ATMEL_US_THR;
+
+	ret = dmaengine_device_control(atmel_port->chan_tx,
+					DMA_SLAVE_CONFIG,
+					(unsigned long)&config);
+	if (ret) {
+		dev_err(port->dev, "DMA tx slave configuration failed\n");
+		goto chan_err;
+	}
+
+	return;
+
+chan_err:
+	dev_err(port->dev, "TX channel not available, switch to pio\n");
+	atmel_port->use_dma_tx = 0;
+	if (atmel_port->chan_tx)
+		atmel_tx_dma_release(atmel_port);
+	return;
+}
+
 /*
  * receive interrupt handler.
  */
@@ -870,6 +1063,8 @@ static void atmel_tasklet_func(unsigned long data)
 
 	if (atmel_use_pdc_tx(port))
 		atmel_tx_pdc(port);
+	else if (atmel_use_dma_tx(port))
+		atmel_tx_dma(port);
 	else
 		atmel_tx_chars(port);
 
@@ -977,6 +1172,8 @@ static int atmel_startup(struct uart_port *port)
 		pdc->ofs = 0;
 	}
 
+	atmel_tx_request_dma(atmel_port);
+
 	/*
 	 * If there is a specific "open" function (to register
 	 * control line interrupts)
@@ -1053,6 +1250,8 @@ static void atmel_shutdown(struct uart_port *port)
 				 DMA_TO_DEVICE);
 	}
 
+	if (atmel_use_dma_tx(port))
+		atmel_tx_dma_release(atmel_port);
 	/*
 	 * Disable all interrupts, port and break condition.
 	 */
@@ -1469,6 +1668,7 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
 	} else {
 		atmel_port->use_pdc_rx	= pdata->use_pdc_rx;
 		atmel_port->use_pdc_tx	= pdata->use_pdc_tx;
+		atmel_port->use_dma_tx	= 0;
 		atmel_port->rs485	= pdata->rs485;
 	}
 
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 8965fed..6f5a7c6 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -78,6 +78,7 @@ struct atmel_uart_data {
 	int			num;		/* port num */
 	short			use_pdc_tx;	/* use transmit PDC? */
 	short			use_pdc_rx;	/* use receive PDC? */
+	short			use_dma_tx;	/* use transmit DMA? */
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
 };
-- 
1.7.9.5

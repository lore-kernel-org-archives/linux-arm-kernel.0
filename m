From: elen.song@atmel.com (Elen Song)
Date: Mon, 29 Oct 2012 17:10:14 +0800
Subject: [PATCH 3/6] Serial: AT91: Request tx dma channel
Message-ID: <1351501814-8600-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request a slave dma channel for tx dma use

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |  110 +++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8a4b8f8..c02a919 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -151,6 +151,14 @@ struct atmel_uart_port {
 	short			use_pdc_tx;	/* enable PDC transmitter */
 	struct atmel_dma_buffer	pdc_tx;		/* PDC transmitter */
 
+	spinlock_t			lock_tx;	/* port lock */
+	struct dma_chan			*chan_tx;
+	struct dma_async_tx_descriptor	*desc_tx;
+	dma_cookie_t			cookie_tx;
+
+	struct scatterlist		sg_tx;
+	unsigned int			sg_len_tx;
+
 	struct tasklet_struct	tasklet;
 	unsigned int		irq_status;
 	unsigned int		irq_status_prev;
@@ -582,6 +590,102 @@ static void atmel_tx_chars(struct uart_port *port)
 		UART_PUT_IER(port, atmel_port->tx_done_mask);
 }
 
+static void atmel_tx_dma_release(struct atmel_uart_port *atmel_port)
+{
+	struct dma_chan *chan = atmel_port->chan_tx;
+
+	atmel_port->chan_tx = NULL;
+	atmel_port->cookie_tx = -EINVAL;
+	if (chan) {
+		dmaengine_terminate_all(chan);
+		dma_release_channel(chan);
+	}
+}
+
+static bool filter(struct dma_chan *chan, void *slave)
+{
+	struct	at_dma_slave		*sl = slave;
+
+	if (sl->dma_dev == chan->device->dev) {
+		chan->private = sl;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static void atmel_tx_request_dma(struct atmel_uart_port *atmel_port)
+{
+	struct uart_port	*port;
+	struct atmel_uart_data	*pdata;
+	dma_cap_mask_t		mask;
+	struct dma_chan		*chan = NULL;
+	struct dma_slave_config config;
+	int ret;
+
+	if (atmel_port == NULL)
+		return;
+
+	port = &(atmel_port->uart);
+	pdata = (struct atmel_uart_data *)port->private_data;
+
+	if (!pdata) {
+		dev_notice(port->dev, "DMA not available, using PIO\n");
+		return;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	if (atmel_use_dma_tx(port) && pdata->dma_tx_slave) {
+		pdata->dma_tx_slave->tx_reg = port->mapbase + ATMEL_US_THR;
+		chan = dma_request_channel(mask, filter, pdata->dma_tx_slave);
+		dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
+	}
+
+	if (chan) {
+		int nent;
+
+		spin_lock_init(&atmel_port->lock_tx);
+		atmel_port->chan_tx = chan;
+
+		sg_init_table(&atmel_port->sg_tx, 1);
+		/* UART circular tx buffer is an aligned page. */
+		BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+		sg_set_page(&atmel_port->sg_tx,
+				virt_to_page(port->state->xmit.buf),
+				UART_XMIT_SIZE,
+				(int)port->state->xmit.buf & ~PAGE_MASK);
+				nent = dma_map_sg(port->dev,
+						&atmel_port->sg_tx,
+						1,
+						DMA_MEM_TO_DEV);
+
+		if (!nent)
+			dev_dbg(port->dev, "need to release resource of dma\n");
+		else
+			dev_dbg(port->dev, "%s: mapped %d@%p to %x\n", __func__,
+				sg_dma_len(&atmel_port->sg_tx),
+				port->state->xmit.buf,
+				sg_dma_address(&atmel_port->sg_tx));
+
+		atmel_port->sg_len_tx = nent;
+	}
+
+	/* Configure the slave DMA */
+	memset(&config, 0, sizeof(config));
+	config.direction = DMA_MEM_TO_DEV;
+	config.dst_addr_width = pdata->dma_tx_slave->reg_width;
+	config.dst_addr = pdata->dma_tx_slave->tx_reg;
+
+	ret = dmaengine_device_control(chan, DMA_SLAVE_CONFIG,
+					(unsigned long)&config);
+	if (ret) {
+		dev_err(port->dev, "DMA tx slave configuration failed\n");
+		return;
+	}
+}
+
 /*
  * receive interrupt handler.
  */
@@ -994,6 +1098,9 @@ static int atmel_startup(struct uart_port *port)
 		pdc->ofs = 0;
 	}
 
+	if (atmel_use_dma_tx(port))
+		atmel_tx_request_dma(atmel_port);
+
 	/*
 	 * If there is a specific "open" function (to register
 	 * control line interrupts)
@@ -1070,6 +1177,9 @@ static void atmel_shutdown(struct uart_port *port)
 				 DMA_TO_DEVICE);
 	}
 
+	if (atmel_use_dma_tx(port))
+		atmel_tx_dma_release(atmel_port);
+
 	/*
 	 * Disable all interrupts, port and break condition.
 	 */
-- 
1.7.9.5

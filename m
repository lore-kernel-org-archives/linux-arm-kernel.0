From: elen.song@atmel.com (Elen Song)
Date: Mon, 29 Oct 2012 17:10:53 +0800
Subject: [PATCH 5/6] Serial: AT91: Request rx dma channel
Message-ID: <1351501853-15491-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request a cyclic dma channel for rx dma use.
Use cyclic transfer is to prevent receive data overrun

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |  103 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 352ef4a..8ee9023 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -130,7 +130,7 @@ struct atmel_uart_char {
 	u16		ch;
 };
 
-#define ATMEL_SERIAL_RINGSIZE 1024
+#define ATMEL_SERIAL_RINGSIZE 4096
 
 /*
  * We wrap our port structure around the generic uart_port.
@@ -152,11 +152,16 @@ struct atmel_uart_port {
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
 	unsigned int			sg_len_tx;
 
 	struct tasklet_struct	tasklet;
@@ -783,6 +788,98 @@ static void atmel_tx_request_dma(struct atmel_uart_port *atmel_port)
 	}
 }
 
+static void atmel_rx_dma_release(struct atmel_uart_port *atmel_port)
+{
+	struct dma_chan *chan = atmel_port->chan_rx;
+	struct uart_port *port = &(atmel_port->uart);
+
+	atmel_port->desc_rx = NULL;
+	atmel_port->chan_rx = NULL;
+	atmel_port->cookie_rx = -EINVAL;
+	dma_unmap_sg(port->dev, &atmel_port->sg_rx, 1,
+			DMA_DEV_TO_MEM);
+	if (chan) {
+		dmaengine_terminate_all(chan);
+		dma_release_channel(chan);
+	}
+}
+
+static void atmel_rx_request_dma(struct atmel_uart_port *atmel_port)
+{
+	struct uart_port	*port;
+	struct atmel_uart_data	*pdata;
+	dma_cap_mask_t		mask;
+	struct dma_chan		*chan = NULL;
+	struct circ_buf *ring = &atmel_port->rx_ring;
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
+	dma_cap_set(DMA_CYCLIC, mask);
+
+	if (atmel_use_dma_rx(port) && pdata->dma_rx_slave) {
+		pdata->dma_rx_slave->rx_reg = port->mapbase + ATMEL_US_RHR;
+		chan = dma_request_channel(mask, filter, pdata->dma_rx_slave);
+		dev_dbg(port->dev, "%s: RX: got channel %x\n",
+		__func__,
+		chan->chan_id);
+	}
+
+	if (chan) {
+		int nent;
+
+		spin_lock_init(&atmel_port->lock_rx);
+		atmel_port->chan_rx = chan;
+
+		sg_init_table(&atmel_port->sg_rx, 1);
+		/* UART circular tx buffer is an aligned page. */
+		BUG_ON((int)ring->buf & ~PAGE_MASK);
+		sg_set_page(&atmel_port->sg_rx,
+				virt_to_page(ring->buf),
+				ATMEL_SERIAL_RINGSIZE,
+				(int)ring->buf & ~PAGE_MASK);
+				nent = dma_map_sg(port->dev,
+				&atmel_port->sg_rx,
+				1,
+				DMA_DEV_TO_MEM);
+
+		if (!nent)
+			dev_dbg(port->dev, "need to release resource of dma\n");
+		else
+			dev_dbg(port->dev, "%s: mapped %d@%p to %x\n",
+				__func__,
+				sg_dma_len(&atmel_port->sg_rx),
+				ring->buf,
+				sg_dma_address(&atmel_port->sg_rx));
+
+		ring->head = 0;
+	}
+
+	/* Configure the slave DMA */
+	memset(&config, 0, sizeof(config));
+	config.direction = DMA_DEV_TO_MEM;
+	config.src_addr_width = pdata->dma_rx_slave->reg_width;
+	config.src_addr = pdata->dma_rx_slave->rx_reg;
+
+	ret = dmaengine_device_control(chan, DMA_SLAVE_CONFIG,
+					(unsigned long)&config);
+	if (ret) {
+		dev_err(port->dev, "DMA rx slave configuration failed\n");
+		return;
+	}
+}
+
 /*
  * receive interrupt handler.
  */
@@ -1200,6 +1297,8 @@ static int atmel_startup(struct uart_port *port)
 	if (atmel_use_dma_tx(port))
 		atmel_tx_request_dma(atmel_port);
 
+	if (atmel_use_dma_rx(port))
+		atmel_rx_request_dma(atmel_port);
 	/*
 	 * If there is a specific "open" function (to register
 	 * control line interrupts)
@@ -1276,6 +1375,8 @@ static void atmel_shutdown(struct uart_port *port)
 				 DMA_TO_DEVICE);
 	}
 
+	if (atmel_use_dma_rx(port))
+		atmel_rx_dma_release(atmel_port);
 	if (atmel_use_dma_tx(port))
 		atmel_tx_dma_release(atmel_port);
 
-- 
1.7.9.5

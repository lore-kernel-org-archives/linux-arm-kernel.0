From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:08:46 +0900
Subject: [PATCH 1/3] serial: sh-sci: Fix warnings due to improper casts and
 printk formats
In-Reply-To: <cover.1387761495.git.horms+renesas@verge.net.au>
References: <cover.1387761495.git.horms+renesas@verge.net.au>
Message-ID: <e2afca6988c335d2ec7b66f2fadcd63286570bf8.1387761495.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Use the %zu and %pad printk specifiers to print size_t and dma_addr_t
variables, and cast pointers to uintptr_t instead of unsigned int where
applicable. This fixes warnings on platforms where pointers and/or
dma_addr_t have a different size than int.

Cc: linux-serial at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7d8103c..6e5ce62 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -557,7 +557,7 @@ static inline int sci_rxd_in(struct uart_port *port)
 		return 1;
 
 	/* Cast for ARM damage */
-	return !!__raw_readb((void __iomem *)s->cfg->port_reg);
+	return !!__raw_readb((void __iomem *)(uintptr_t)s->cfg->port_reg);
 }
 
 /* ********************************************************************** *
@@ -1309,7 +1309,7 @@ static int sci_dma_rx_push(struct sci_port *s, size_t count)
 	}
 
 	if (room < count)
-		dev_warn(port->dev, "Rx overrun: dropping %u bytes\n",
+		dev_warn(port->dev, "Rx overrun: dropping %zu bytes\n",
 			 count - room);
 	if (!room)
 		return room;
@@ -1442,7 +1442,7 @@ static void work_fn_rx(struct work_struct *work)
 		int count;
 
 		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
-		dev_dbg(port->dev, "Read %u bytes with cookie %d\n",
+		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
 			sh_desc->partial, sh_desc->cookie);
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1691,16 +1691,17 @@ static void sci_request_dma(struct uart_port *port)
 		s->chan_tx = chan;
 		sg_init_table(&s->sg_tx, 1);
 		/* UART circular tx buffer is an aligned page. */
-		BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+		BUG_ON((uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
 		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
-			    UART_XMIT_SIZE, (int)port->state->xmit.buf & ~PAGE_MASK);
+			    UART_XMIT_SIZE,
+			    (uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
 		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
 		if (!nent)
 			sci_tx_dma_release(s, false);
 		else
-			dev_dbg(port->dev, "%s: mapped %d@%p to %x\n", __func__,
-				sg_dma_len(&s->sg_tx),
-				port->state->xmit.buf, sg_dma_address(&s->sg_tx));
+			dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
+				sg_dma_len(&s->sg_tx), port->state->xmit.buf,
+				&sg_dma_address(&s->sg_tx));
 
 		s->sg_len_tx = nent;
 
@@ -1740,7 +1741,7 @@ static void sci_request_dma(struct uart_port *port)
 
 			sg_init_table(sg, 1);
 			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
-				    (int)buf[i] & ~PAGE_MASK);
+				    (uintptr_t)buf[i] & ~PAGE_MASK);
 			sg_dma_address(sg) = dma[i];
 		}
 
-- 
1.8.4

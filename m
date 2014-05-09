From: dean_jenkins@mentor.com (dean_jenkins at mentor.com)
Date: Fri,  9 May 2014 16:19:47 +0100
Subject: [PATCH 4/5] serial: imx: move imx_transmit_buffer() into imx_txint()
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Message-ID: <1399648788-26061-5-git-send-email-dean_jenkins@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Move the code block of imx_transmit_buffer() into imx_txint() because
imx_transmit_buffer() is only called from a single place now. In other words,
having the inline function imx_transmit_buffer() for a single call is
unnecessary and code refactoring to eliminate the imx_transmit_buffer()
function call makes the code easier to read.

No functional change.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/tty/serial/imx.c |   31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cc79706..7b0ef85 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -456,24 +456,6 @@ static void imx_enable_ms(struct uart_port *port)
 	mod_timer(&sport->timer, jiffies);
 }
 
-static inline void imx_transmit_buffer(struct imx_port *sport)
-{
-	struct circ_buf *xmit = &sport->port.state->xmit;
-
-	while (!uart_circ_empty(xmit) &&
-			!(readl(sport->port.membase + uts_reg(sport))
-				& UTS_TXFULL)) {
-		/* send xmit->buf[xmit->tail]
-		 * out the port here */
-		writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-	}
-
-	if (uart_circ_empty(xmit))
-		imx_stop_tx(&sport->port);
-}
-
 static void dma_tx_callback(void *data)
 {
 	struct imx_port *sport = data;
@@ -634,7 +616,18 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 		goto out;
 	}
 
-	imx_transmit_buffer(sport);
+	while (!uart_circ_empty(xmit) &&
+			!(readl(sport->port.membase + uts_reg(sport))
+				& UTS_TXFULL)) {
+		/* send xmit->buf[xmit->tail]
+		 * out the port here */
+		writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		sport->port.icount.tx++;
+	}
+
+	if (uart_circ_empty(xmit))
+		imx_stop_tx(&sport->port);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
 		spin_unlock_irqrestore(&sport->port.lock, flags);
-- 
1.7.9.5

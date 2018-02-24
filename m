From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 23 Feb 2018 18:27:50 -0800
Subject: [PATCH v4 1/1] tty: serial: imx: allow breaks to be received when
 using dma
Message-ID: <20180224022750.20942-1-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows me to login after sending a break when service
serial-getty at ttymxc0.service is running

The "tty_insert_flip_char(port, 0, TTY_BREAK)" in clear_rx_errors
fixes this by allowing the higher layers to see a break.

Also, call uart_handle_break to handle possible
"secure attention key."

FYI: Martin said the ROM sdma firmware works with this patch,
but external sdma firmware still does not send breaks on a
i.mx6UL

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Tested-by: Martin Hicks <mort@bork.org>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

---
v2: rebase only
v3: change commit message as requested by Fabio,
    add tested-by
v4: add uart_handle_break as Uwe requested
    add Reviewed-by
    added to commit message
---
 drivers/tty/serial/imx.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1d7ca382bc12..ace96283bdb8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -927,7 +927,6 @@ static void dma_rx_callback(void *data)
 	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
 
 	if (status == DMA_ERROR) {
-		dev_err(sport->port.dev, "DMA transaction error.\n");
 		clear_rx_errors(sport);
 		return;
 	}
@@ -1028,6 +1027,7 @@ static int start_rx_dma(struct imx_port *sport)
 
 static void clear_rx_errors(struct imx_port *sport)
 {
+	struct tty_port *port = &sport->port.state->port;
 	unsigned int status_usr1, status_usr2;
 
 	status_usr1 = readl(sport->port.membase + USR1);
@@ -1036,12 +1036,19 @@ static void clear_rx_errors(struct imx_port *sport)
 	if (status_usr2 & USR2_BRCD) {
 		sport->port.icount.brk++;
 		writel(USR2_BRCD, sport->port.membase + USR2);
-	} else if (status_usr1 & USR1_FRAMERR) {
-		sport->port.icount.frame++;
-		writel(USR1_FRAMERR, sport->port.membase + USR1);
-	} else if (status_usr1 & USR1_PARITYERR) {
-		sport->port.icount.parity++;
-		writel(USR1_PARITYERR, sport->port.membase + USR1);
+		uart_handle_break(&sport->port);
+		if (tty_insert_flip_char(port, 0, TTY_BREAK) == 0)
+			sport->port.icount.buf_overrun++;
+		tty_flip_buffer_push(port);
+	} else {
+		dev_err(sport->port.dev, "DMA transaction error.\n");
+		if (status_usr1 & USR1_FRAMERR) {
+			sport->port.icount.frame++;
+			writel(USR1_FRAMERR, sport->port.membase + USR1);
+		} else if (status_usr1 & USR1_PARITYERR) {
+			sport->port.icount.parity++;
+			writel(USR1_PARITYERR, sport->port.membase + USR1);
+		}
 	}
 
 	if (status_usr2 & USR2_ORE) {
-- 
2.14.1

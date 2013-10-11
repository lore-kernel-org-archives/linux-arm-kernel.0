From: b32955@freescale.com (Huang Shijie)
Date: Fri, 11 Oct 2013 18:30:58 +0800
Subject: [PATCH 1/4] serial: imx: implement the flush_buffer hook
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Message-ID: <1381487461-12850-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current driver does not implement the flush_buffer hook for
uart_ops. When we enable the DMA for the driver, and test it with Bluetooth,
we may meet the following bug for TX:

    [1] User application may call the flush operation at any time.
        The uart_flush_buffer() calls the uart_circ_clear() to set
        the xmit->head and xmit->tail with 0.

    [2] The TX DMA callback can be called at any time too.
        The dma_tx_call() will update the xmit->tail.

    If [2] occurs just after the [1], we will get the wrong xmit->tail.

This patch implements the flush_buffer hook to fix this issue.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c07d9bb..708ba89 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1303,6 +1303,16 @@ static void imx_shutdown(struct uart_port *port)
 	clk_disable_unprepare(sport->clk_ipg);
 }
 
+static void imx_flush_buffer(struct uart_port *port)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+
+	if (sport->dma_is_enabled) {
+		sport->tx_bytes = 0;
+		dmaengine_terminate_all(sport->dma_chan_tx);
+	}
+}
+
 static void
 imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old)
@@ -1623,6 +1633,7 @@ static struct uart_ops imx_pops = {
 	.break_ctl	= imx_break_ctl,
 	.startup	= imx_startup,
 	.shutdown	= imx_shutdown,
+	.flush_buffer	= imx_flush_buffer,
 	.set_termios	= imx_set_termios,
 	.type		= imx_type,
 	.release_port	= imx_release_port,
-- 
1.7.2.rc3

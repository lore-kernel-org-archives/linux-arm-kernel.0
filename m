From: hector.palacios@digi.com (Hector Palacios)
Date: Wed, 2 Oct 2013 14:02:44 +0200
Subject: [PATCH v2 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
In-Reply-To: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Message-ID: <1380715364-8025-3-git-send-email-hector.palacios@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shutdown function was not waiting for the FIFO (which may be the
real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
before disabling the AUART.
This lead to many bytes not being transferred (specially at low
baudrates), as they were still in the DMA buffer when the AUART was
shutdown.
This patch also adds the check for the BUSY flag before disabling
the AUART.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/tty/serial/mxs-auart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 9f046177..589b595 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -757,9 +757,22 @@ static int mxs_auart_startup(struct uart_port *u)
 	return 0;
 }
 
+static unsigned int mxs_auart_tx_empty(struct uart_port *u);
+
 static void mxs_auart_shutdown(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
+	unsigned int to;
+
+	/* Wait for the FIFO to flush */
+	to = u->timeout;
+	while (!mxs_auart_tx_empty(u) && to--)
+		mdelay(1);
+
+	/* Wait for UART to become idle ... */
+	to = u->timeout;
+	while ((readl(u->membase + AUART_STAT) & AUART_STAT_BUSY) && to--)
+		mdelay(1);
 
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
-- 
1.8.4

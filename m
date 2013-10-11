From: b32955@freescale.com (Huang Shijie)
Date: Fri, 11 Oct 2013 18:30:59 +0800
Subject: [PATCH 2/4] serial: imx: check the DMA for imx_tx_empty
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Message-ID: <1381487461-12850-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assume the following situation:

  If the DMA is enabled, and the a TX DMA operation is working,
But we have not issued the TX DMA operation (or we have issued the
TX DMA operation with dma_async_issue_pending(), but the DMA has not
started to move the data from the memory to the TXFIFO).

At this time, we may get the wrong status of the transmitter when we
call the imx_tx_empty. In such situation, only check the USR2_TXDC
does not enough for us.

This patch checks the DMA's situation, and return 0 when the TX DMA is
working.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 708ba89..c6c3b16 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -795,8 +795,15 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 static unsigned int imx_tx_empty(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
+	unsigned int ret;
 
-	return (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
+	ret = (readl(sport->port.membase + USR2) & USR2_TXDC) ?  TIOCSER_TEMT : 0;
+
+	/* If the TX DMA is working, return 0. */
+	if (sport->dma_is_enabled && sport->dma_is_txing)
+		ret = 0;
+
+	return ret;
 }
 
 /*
-- 
1.7.2.rc3

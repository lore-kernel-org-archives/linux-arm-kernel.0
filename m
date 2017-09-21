From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Thu, 21 Sep 2017 17:18:13 +0100
Subject: [PATCH v3 2/6] serial: imx: only set dma_is_rxing when DMA starts
In-Reply-To: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <1506010697-22114-3-git-send-email-martyn.welch@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Romain Perier <romain.perier@collabora.com>

The variable dma_is_rxing is currently set to 1 in imx_disable_rx_int().
This is problematic as:

- whilst imx_disable_rx_int() is currently always called before
  start_rx_dma() this dependency isn't obvious.
- start_rx_dma() does error checking and might exit without
  enabling DMA. Currently this will result in dma_is_rxing suggesting
  that DMA is being used for recieving.

To avoid these issues, move the setting of dma_is_rxing to
start_rx_dma() when appropriate.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d90dae3..7835279 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -714,8 +714,6 @@ static void imx_disable_rx_int(struct imx_port *sport)
 {
 	unsigned long temp;
 
-	sport->dma_is_rxing = 1;
-
 	/* disable the receiver ready and aging timer interrupts */
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_RRDYEN);
@@ -1074,6 +1072,7 @@ static int start_rx_dma(struct imx_port *sport)
 	desc->callback_param = sport;
 
 	dev_dbg(dev, "RX: prepare for the DMA.\n");
+	sport->dma_is_rxing = 1;
 	sport->rx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
 	return 0;
-- 
1.8.3.1

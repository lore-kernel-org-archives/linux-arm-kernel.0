From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 30 Jun 2017 14:04:41 +0200
Subject: [PATCH 2/7] serial: imx: move log from error to debug type
In-Reply-To: <20170630120446.13994-1-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
Message-ID: <20170630120446.13994-3-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nandor Han <nandor.han@ge.com>

During DMA startup we have a data race condition since UART port can
receive data that can generate different type of errors.

This is not necessarily an error since DMA didn't yet started. The
situation is minimized but still present even if we try to clear up the
error before starting the DMA.

Therefore changing the log to debug type we avoid having "false" error
messages.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1d35293..188063d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -994,7 +994,7 @@ static void dma_rx_callback(void *data)
 	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
 
 	if (status == DMA_ERROR) {
-		dev_err(sport->port.dev, "DMA transaction error.\n");
+		dev_dbg(sport->port.dev, "DMA transaction error.\n");
 		clear_rx_errors(sport);
 		return;
 	}
-- 
1.8.3.1

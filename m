From: b32955@freescale.com (Huang Shijie)
Date: Fri, 11 Oct 2013 18:31:01 +0800
Subject: [PATCH 4/4] serial: imx: use the dmaengine_tx_status
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Message-ID: <1381487461-12850-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the dmaengine_tx_status to simplify the code, do not change any logic.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cadf7e5..13c2c2d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -521,7 +521,7 @@ static void dma_tx_work(struct work_struct *w)
 	unsigned long flags;
 	int ret;
 
-	status = chan->device->device_tx_status(chan, (dma_cookie_t)0, NULL);
+	status = dmaengine_tx_status(chan, (dma_cookie_t)0, NULL);
 	if (DMA_IN_PROGRESS == status)
 		return;
 
@@ -926,7 +926,7 @@ static void dma_rx_callback(void *data)
 	/* unmap it first */
 	dma_unmap_sg(sport->port.dev, sgl, 1, DMA_FROM_DEVICE);
 
-	status = chan->device->device_tx_status(chan, (dma_cookie_t)0, &state);
+	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
 	count = RX_BUF_SIZE - state.residue;
 	dev_dbg(sport->port.dev, "We get %d bytes.\n", count);
 
-- 
1.7.2.rc3

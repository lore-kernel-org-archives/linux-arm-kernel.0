From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 17 Jul 2012 12:53:57 +0200 (CEST)
Subject: [PATCH/RFC 4/4] mmc: sh_mmcif: switch to using
 dma_request_slave_channel()
In-Reply-To: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
References: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
Message-ID: <Pine.LNX.4.64.1207171243210.17060@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dma_request_slave_channel() to obtain DMA channels, which eliminates
the need for a filter function.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This shall only be applied after all MMCIF users, using DMA, have been 
converted

 drivers/mmc/host/sh_mmcif.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0f07d28..cb71410 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -386,8 +386,7 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->chan_tx = dma_request_channel(mask, shdma_chan_filter,
-					    (void *)pdata->slave_id_tx);
+	host->chan_tx = dma_request_slave_channel(&host->pd->dev, DMA_MEM_TO_DEV, NULL);
 	dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
 		host->chan_tx);
 
@@ -402,8 +401,7 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	if (ret < 0)
 		goto ecfgtx;
 
-	host->chan_rx = dma_request_channel(mask, shdma_chan_filter,
-					    (void *)pdata->slave_id_rx);
+	host->chan_rx = dma_request_slave_channel(&host->pd->dev, DMA_DEV_TO_MEM, NULL);
 	dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
 		host->chan_rx);
 
-- 
1.7.2.5

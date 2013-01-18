From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 18 Jan 2013 08:46:22 +0100
Subject: [PATCH 3/3] dma: mv_xor: get rid of a DMA-API sanity check warning
In-Reply-To: <1358495154.28503.5.camel@unicorn>
References: <1358495154.28503.5.camel@unicorn>
Message-ID: <1358495182-30964-3-git-send-email-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv_xor mv_xor.0: DMA-API: device driver frees DMA memory with different direction [device address=0x000000001dea4000] [size=4096 bytes] [mapped with DMA_FROM_DEVICE] [unmapped with DMA_BIDIRECTIONAL]

Change xor self test destination buffer allocation direction to bidirectional,
as it's what mv_xor_run_tx_complete_actions() frees for multiple sources.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mv_xor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d00a834..1e90f5d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1042,7 +1042,7 @@ mv_xor_xor_self_test(struct mv_xor_chan *mv_chan)
 
 	/* test xor */
 	dest_dma = dma_map_page(dma_chan->device->dev, dest, 0, PAGE_SIZE,
-				DMA_FROM_DEVICE);
+				DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dma_chan->device->dev, dest_dma)) {
 		dev_err(dma_chan->device->dev,
 			"Could not map destination page, disabling\n");
-- 
1.7.1

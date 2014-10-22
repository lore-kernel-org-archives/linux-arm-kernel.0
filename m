From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 17:43:15 +0200
Subject: [PATCH v3 01/59] crypto: ux500: Use dmaengine_terminate_all API
In-Reply-To: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413992653-21963-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are removing the dmaengine_device_control API, that shouldn't even have been
exposed in the first place. Change the callers to use the proper API.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 4 ++--
 drivers/crypto/ux500/hash/hash_core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 92105f3dc8e0..75bd0f1e9a94 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -606,12 +606,12 @@ static void cryp_dma_done(struct cryp_ctx *ctx)
 	dev_dbg(ctx->device->dev, "[%s]: ", __func__);
 
 	chan = ctx->device->dma.chan_mem2cryp;
-	dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(chan);
 	dma_unmap_sg(chan->device->dev, ctx->device->dma.sg_src,
 		     ctx->device->dma.sg_src_len, DMA_TO_DEVICE);
 
 	chan = ctx->device->dma.chan_cryp2mem;
-	dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(chan);
 	dma_unmap_sg(chan->device->dev, ctx->device->dma.sg_dst,
 		     ctx->device->dma.sg_dst_len, DMA_FROM_DEVICE);
 }
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 1c73f4fbc252..48bdc5df7b3b 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -202,7 +202,7 @@ static void hash_dma_done(struct hash_ctx *ctx)
 	struct dma_chan *chan;
 
 	chan = ctx->device->dma.chan_mem2hash;
-	dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(chan);
 	dma_unmap_sg(chan->device->dev, ctx->device->dma.sg,
 		     ctx->device->dma.sg_len, DMA_TO_DEVICE);
 }
-- 
2.1.1

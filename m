From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Dec 2016 22:03:36 +0800
Subject: [PATCH 2/3] dma: zx: set DMA_CYCLIC cap_mask bit
In-Reply-To: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
References: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1481810617-7650-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The zx_dma driver supports cyclic transfer mode.  Let's set DMA_CYCLIC
cap_mask bit to make that clear, and avoid unnecessary failure when
clients request channel via dma_request_chan_by_mask() with DMA_CYCLIC
bit set in mask.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/zx_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 380276d078b2..33155c6816cc 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -812,6 +812,7 @@ static int zx_dma_probe(struct platform_device *op)
 	INIT_LIST_HEAD(&d->slave.channels);
 	dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, d->slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, d->slave.cap_mask);
 	dma_cap_set(DMA_PRIVATE, d->slave.cap_mask);
 	d->slave.dev = &op->dev;
 	d->slave.device_free_chan_resources = zx_dma_free_chan_resources;
-- 
1.9.1

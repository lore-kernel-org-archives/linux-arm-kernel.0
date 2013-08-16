From: zonque@gmail.com (Daniel Mack)
Date: Fri, 16 Aug 2013 19:05:07 +0200
Subject: [PATCH v4 4/4] dma: mmp_pdma: set DMA_PRIVATE
In-Reply-To: <1376672707-24527-1-git-send-email-zonque@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
Message-ID: <1376672707-24527-5-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver now has its own xlate function and makes use of the
dma_get_slave_channel(), we need to manually set the DMA_PRIVATE flags.

Drivers which rely on of_dma_simple_xlate() do implicitly the same by
going through __dma_request_channel().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index b29b581..dfccfe1 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1086,6 +1086,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, pdev->device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, pdev->device.cap_mask);
+	dma_cap_set(DMA_PRIVATE, pdev->device.cap_mask);
 	pdev->device.dev = &op->dev;
 	pdev->device.device_alloc_chan_resources = mmp_pdma_alloc_chan_resources;
 	pdev->device.device_free_chan_resources = mmp_pdma_free_chan_resources;
-- 
1.8.3.1

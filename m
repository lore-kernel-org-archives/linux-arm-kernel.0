From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Nov 2014 14:42:53 +0100
Subject: [PATCH v5 59/61] dmaengine: Add a warning for drivers not using the
 generic slave caps retrieval
In-Reply-To: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1416231775-31252-60-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the slave caps retrieval to be really useful, most drivers need to
implement it.

Hence, we need to be slightly more aggressive, and trigger a warning at
registration time for drivers that don't fill their caps infos in order to
encourage them to implement it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/dmaengine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 98e9431f85ec..300c8cd2786c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -827,6 +827,9 @@ int dma_async_device_register(struct dma_device *device)
 	BUG_ON(!device->device_issue_pending);
 	BUG_ON(!device->dev);
 
+	WARN(dma_has_cap(DMA_SLAVE, device->cap_mask) && !device->directions,
+	     "this driver doesn't support generic slave capabilities reporting\n");
+
 	/* note: this only matters in the
 	 * CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=n case
 	 */
-- 
2.1.1

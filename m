From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 22:26:12 +0100
Subject: [PATCH v4 57/58] dmaengine: Add a warning for drivers not using the
 generic slave caps retrieval
In-Reply-To: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1414531573-18807-58-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the slave caps retrieval to be really useful, most drivers need to
implement it.

Hence, we need to be slightly more aggressive, and trigger a warning at
registration time for drivers that don't fill their caps infos in order to
encourage them to implement it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
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

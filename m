From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 10 Jul 2018 18:17:18 +0100
Subject: [RFC PATCH 3/4] of/device: Set bus DMA mask as appropriate
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Message-ID: <346c004b599fb77a2006a4eeb992b30feb06fce5.1531239284.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an explicit DMA limit is described by firmware, we need to remember
it regardless of how drivers might subsequently update their devices'
masks. The new bus_dma_mask field does that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 33d85511d790..0d39633e8545 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,6 +149,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
+	dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 
-- 
2.17.1.dirty

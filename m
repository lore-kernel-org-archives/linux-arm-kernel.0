From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  7 Mar 2017 18:12:51 +0000
Subject: [PATCH] of: Fix DMA mask assignment
Message-ID: <94ede94e98502a7948085fba5a16994d3805010c.1488910224.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we start moving towards mandating that device DMA addressing
capabilities are correctly described in DT for platforms like arm64, it
turns out that actually assigning DMA masks wider than 32 bits from
"dma-ranges" is made largely impossible by the current code. New PCI
devices are passed in with 32-bit masks, while new platform devices are
passed in with their masks unset, so we install default 32-bit masks for
them. As a result, subsequently taking the minimum between any existing
mask and the size given by "dma-ranges" means that we can never exceed
32 bits for the vast majority of devices.

Since the DT can be assumed to describe the hardware appropriately, and
the device's driver is expected by the DMA API to explicitly set a mask
later when it probes, we can safely let "dma-ranges" unconditionally
override any initial mask from device creation (and as a small bonus
deduplicate the calculation in the process).

CC: Arnd Bergmann <arnd@arndb.de>
CC: Murali Karicheri <m-karicheri2@ti.com>
Fixes: 9a6d7298b083 ("of: Calculate device DMA masks based on DT dma-range size")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index b1e6bebda3f3..9bb8518b28f2 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -129,15 +129,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	}
 
 	dev->dma_pfn_offset = offset;
-
-	/*
-	 * Limit coherent and dma mask based on size and default mask
-	 * set by the driver.
-	 */
-	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
-				     DMA_BIT_MASK(ilog2(dma_addr + size)));
-	*dev->dma_mask = min((*dev->dma_mask),
-			     DMA_BIT_MASK(ilog2(dma_addr + size)));
+	dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
+	*dev->dma_mask = dev->coherent_dma_mask;
 
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
-- 
2.11.0.dirty

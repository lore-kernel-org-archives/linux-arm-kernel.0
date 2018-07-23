From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 23 Jul 2018 23:16:08 +0100
Subject: [PATCH v2 3/7] ACPI/IORT: Set bus DMA mask as appropriate
In-Reply-To: <cover.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
Message-ID: <07cbf8f77fac552dca9b4c85a9d3bd8ed5a4cd29.1532382222.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an explicit DMA limit is described by firmware, we need to remember
it regardless of how drivers might subsequently update their devices'
masks. The new bus_dma_mask field does that.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Hanjun Guo <hanjun.guo@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4a66896e2aa3..bc51cff5505e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1014,6 +1014,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 		 * Limit coherent and dma mask based on size
 		 * retrieved from firmware.
 		 */
+		dev->bus_dma_mask = mask;
 		dev->coherent_dma_mask = mask;
 		*dev->dma_mask = mask;
 	}
-- 
2.17.1.dirty

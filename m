From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 19 Sep 2013 22:49:01 +0100
Subject: [PATCH 24/51] DMA-API: dma: pl330: add dma_set_mask_and_coherent()
 call
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Message-ID: <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA API requires drivers to call the appropriate dma_set_mask()
functions before doing any DMA mapping.  Add this required call to
the AMBA PL08x driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/pl330.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index a562d24..df8b10f 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2903,6 +2903,10 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pdat = dev_get_platdata(&adev->dev);
 
+	ret = dma_set_mask_and_coherent(&adev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	/* Allocate a new DMAC and its Channels */
 	pdmac = devm_kzalloc(&adev->dev, sizeof(*pdmac), GFP_KERNEL);
 	if (!pdmac) {
-- 
1.7.4.4

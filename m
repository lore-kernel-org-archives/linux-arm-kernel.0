From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 26 Apr 2013 13:31:06 -0700
Subject: [PATCH V3] of: Set the DMA mask to 64 bits when dma_addr_t is 64-bits
Message-ID: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, of_platform_device_create_pdata always sets the
coherent DMA mask to 32 bits. On ARM systems without CONFIG_ZONE_DMA,
arm_dma_limit gets set to ~0 or 0xFFFFFFFFFFFFFFFF on LPAE based
systems. Since arm_dma_limit represents the smallest dma_mask
on the system, the default of 32 bits prevents any dma_coherent
allocation from succeeding unless clients manually set the
dma mask first. Rather than make every client on an LPAE system set
the mask manually, account for the size of dma_addr_t when setting
the coherent mask.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 drivers/of/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 0970505..5f0ba94 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -214,7 +214,7 @@ struct platform_device *of_platform_device_create_pdata(
 #if defined(CONFIG_MICROBLAZE)
 	dev->archdata.dma_mask = 0xffffffffUL;
 #endif
-	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(sizeof(dma_addr_t) * 8);
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

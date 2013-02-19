From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 19 Feb 2013 11:02:09 +0900
Subject: [PATCH 2/2] ARM: EXYNOS: support burst mode for for dev-to-mem and
 dev-to-mem transmit
Message-ID: <00eb01ce0e45$20223c90$6066b5b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to support burst mode for for dev-to-mem and dev-to-mem transmit

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/plat-samsung/dma-ops.c              |   10 ++++++++--
 arch/arm/plat-samsung/include/plat/dma-ops.h |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index d088afa..c25e842 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -54,14 +54,20 @@ static int samsung_dmadev_config(unsigned ch,
 		slave_config.direction = param->direction;
 		slave_config.src_addr = param->fifo;
 		slave_config.src_addr_width = param->width;
-		slave_config.src_maxburst = 1;
+		if (param->maxburst)
+			slave_config.src_maxburst = param->maxburst;
+		else
+			slave_config.src_maxburst = 1;
 		dmaengine_slave_config(chan, &slave_config);
 	} else if (param->direction == DMA_MEM_TO_DEV) {
 		memset(&slave_config, 0, sizeof(struct dma_slave_config));
 		slave_config.direction = param->direction;
 		slave_config.dst_addr = param->fifo;
 		slave_config.dst_addr_width = param->width;
-		slave_config.dst_maxburst = 1;
+		if (param->maxburst)
+			slave_config.dst_maxburst = param->maxburst;
+		else
+			slave_config.dst_maxburst = 1;
 		dmaengine_slave_config(chan, &slave_config);
 	} else {
 		pr_warn("unsupported direction\n");
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
index f5144cd..95893c7 100644
--- a/arch/arm/plat-samsung/include/plat/dma-ops.h
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -35,6 +35,7 @@ struct samsung_dma_prep {
 struct samsung_dma_config {
 	enum dma_transfer_direction direction;
 	enum dma_slave_buswidth width;
+	u32 maxburst;
 	dma_addr_t fifo;
 };

--
1.7.5.4

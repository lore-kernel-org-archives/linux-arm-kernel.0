From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 14 Sep 2012 15:05:54 +0300
Subject: [PATCH v3 11/15] ASoC: omap-mcpdm: Use platform_get_resource_* to get
 resources
In-Reply-To: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1347624358-25582-12-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the needed resources in a correct way and avoid using defines for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index baf92da..f90d5de 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -71,15 +71,11 @@ struct omap_mcpdm {
 static struct omap_pcm_dma_data omap_mcpdm_dai_dma_params[] = {
 	{
 		.name = "Audio playback",
-		.dma_req = OMAP44XX_DMA_MCPDM_DL,
 		.data_type = OMAP_DMA_DATA_TYPE_S32,
-		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_REG_DN_DATA,
 	},
 	{
 		.name = "Audio capture",
-		.dma_req = OMAP44XX_DMA_MCPDM_UP,
 		.data_type = OMAP_DMA_DATA_TYPE_S32,
-		.port_addr = OMAP44XX_MCPDM_L3_BASE + MCPDM_REG_UP_DATA,
 	},
 };
 
@@ -452,10 +448,33 @@ static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
 
 	mutex_init(&mcpdm->mutex);
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
+	if (res == NULL)
+		return -ENOMEM;
+
+	omap_mcpdm_dai_dma_params[0].port_addr = res->start + MCPDM_REG_DN_DATA;
+	omap_mcpdm_dai_dma_params[1].port_addr = res->start + MCPDM_REG_UP_DATA;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL)
 		return -ENOMEM;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link");
+	if (!res)
+		return -ENODEV;
+
+	omap_mcpdm_dai_dma_params[0].dma_req = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "up_link");
+	if (!res)
+		return -ENODEV;
+
+	omap_mcpdm_dai_dma_params[1].dma_req = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
+	if (res == NULL)
+		return -ENOMEM;
+
 	if (!devm_request_mem_region(&pdev->dev, res->start,
 				     resource_size(res), "McPDM"))
 		return -EBUSY;
-- 
1.7.12

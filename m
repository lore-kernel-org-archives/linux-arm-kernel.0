From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 27 Oct 2015 14:24:25 +0800
Subject: [PATCH v3 05/10] mmc: mediatek: fix got GPD checksum error interrupt
 when data transfer
In-Reply-To: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
References: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1445927070-5102-6-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if we only use one gpd, we need alloc 2 gpd and make
the gpd->next pointer to the second gpd, or may get gpd checksum
error, this was checked by hardware

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c877ded..3858163 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1145,11 +1145,14 @@ static void msdc_init_gpd_bd(struct msdc_host *host, struct msdc_dma *dma)
 	struct mt_bdma_desc *bd = dma->bd;
 	int i;
 
-	memset(gpd, 0, sizeof(struct mt_gpdma_desc));
+	memset(gpd, 0, sizeof(struct mt_gpdma_desc) * 2);
 
 	gpd->gpd_info = GPDMA_DESC_BDP; /* hwo, cs, bd pointer */
 	gpd->ptr = (u32)dma->bd_addr; /* physical address */
-
+	/* gpd->next is must set for desc DMA
+	 * That's why must alloc 2 gpd structure.
+	 */
+	gpd->next = (u32)dma->gpd_addr + sizeof(struct mt_gpdma_desc);
 	memset(bd, 0, sizeof(struct mt_bdma_desc) * MAX_BD_NUM);
 	for (i = 0; i < (MAX_BD_NUM - 1); i++)
 		bd[i].next = (u32)dma->bd_addr + sizeof(*bd) * (i + 1);
@@ -1306,7 +1309,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->timeout_clks = 3 * 1048576;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
-				sizeof(struct mt_gpdma_desc),
+				2 * sizeof(struct mt_gpdma_desc),
 				&host->dma.gpd_addr, GFP_KERNEL);
 	host->dma.bd = dma_alloc_coherent(&pdev->dev,
 				MAX_BD_NUM * sizeof(struct mt_bdma_desc),
@@ -1347,7 +1350,7 @@ release:
 release_mem:
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
-			sizeof(struct mt_gpdma_desc),
+			2 * sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
 	if (host->dma.bd)
 		dma_free_coherent(&pdev->dev,
-- 
1.8.1.1.dirty

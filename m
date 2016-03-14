From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Mar 2016 15:07:11 +0100
Subject: [PATCH 2/3] net: mediatek: remove incorrect dma_mask assignment
In-Reply-To: <1457964435-2945038-1-git-send-email-arnd@arndb.de>
References: <1457964435-2945038-1-git-send-email-arnd@arndb.de>
Message-ID: <1457964435-2945038-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device drivers should not mess with the DMA mask directly,
but instead call dma_set_mask() etc if needed.

In case of the mtk_eth_soc driver, the mask already gets set
correctly when the device is created, and setting it again
is against the documented API.

This removes the incorrect setting.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3e42204adfe5..87f417712da0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1676,9 +1676,6 @@ static int mtk_probe(struct platform_device *pdev)
 	struct mtk_eth *eth;
 	int err;
 
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-
 	device_reset(&pdev->dev);
 
 	match = of_match_device(of_mtk_match, &pdev->dev);
-- 
2.7.0

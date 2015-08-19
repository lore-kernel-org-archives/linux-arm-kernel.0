From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 19 Aug 2015 11:37:57 +0800
Subject: [PATCH 2/3] spi: mediatek: remove redundant clock in
 prepare_hardware/unprepare_hardware
In-Reply-To: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
References: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1439955478-2733-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock in prepare_hardware/unprepare_hardware is redundant
with pm_runtime, so remove them.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 814bca4..1c2b215 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -181,13 +181,6 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 	struct spi_transfer *trans;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	struct spi_message *msg = master->cur_msg;
-	int ret;
-
-	ret = clk_prepare_enable(mdata->spi_clk);
-	if (ret < 0) {
-		dev_err(&master->dev, "failed to enable clock (%d)\n", ret);
-		return ret;
-	}
 
 	trans = list_first_entry(&msg->transfers, struct spi_transfer,
 				 transfer_list);
@@ -196,15 +189,6 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 		mtk_spi_reset(mdata);
 	}
 
-	return ret;
-}
-
-static int mtk_spi_unprepare_hardware(struct spi_master *master)
-{
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(mdata->spi_clk);
-
 	return 0;
 }
 
@@ -537,7 +521,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	master->set_cs = mtk_spi_set_cs;
 	master->prepare_transfer_hardware = mtk_spi_prepare_hardware;
-	master->unprepare_transfer_hardware = mtk_spi_unprepare_hardware;
 	master->prepare_message = mtk_spi_prepare_message;
 	master->transfer_one = mtk_spi_transfer_one;
 	master->can_dma = mtk_spi_can_dma;
-- 
1.8.1.1.dirty

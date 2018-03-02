From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:24 +0100
Subject: [PATCH 16/52] mtd: rawnand: fsmc: fix probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-17-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() should trigger a nand_release().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 28c48dcc514e..1bf73d4d4c0d 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1123,14 +1123,16 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	mtd->name = "nand";
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
-		goto err_probe;
+		goto err_release_nand;
 
 	platform_set_drvdata(pdev, host);
 	dev_info(&pdev->dev, "FSMC NAND driver registration successful\n");
+
 	return 0;
 
+err_release_nand:
+	nand_release(mtd);
 err_probe:
-err_scan_ident:
 	if (host->mode == USE_DMA_ACCESS)
 		dma_release_channel(host->write_dma_chan);
 err_req_write_chnl:
-- 
2.14.1

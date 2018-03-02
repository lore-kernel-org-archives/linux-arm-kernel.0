From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:39 +0100
Subject: [PATCH 31/52] mtd: rawnand: omap2: fix the probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-32-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() call should trigger a nand_release()
call. This is rightly handled in the remove function, but not in the
probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/omap2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 8cdf7d3d8fa7..88c43334d777 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2263,12 +2263,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	err = mtd_device_register(mtd, NULL, 0);
 	if (err)
-		goto return_error;
+		goto release_nand;
 
 	platform_set_drvdata(pdev, mtd);
 
 	return 0;
 
+release_nand:
+	nand_release(mtd);
 return_error:
 	if (!IS_ERR_OR_NULL(info->dma))
 		dma_release_channel(info->dma);
-- 
2.14.1

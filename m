From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:32 +0100
Subject: [PATCH 24/52] mtd: rawnand: lpc32xx_slc: enhance the probe function
 error
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-25-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the migration of the lpc32xx_slc driver to use nand_scan() by
cleaning the error path in the probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/lpc32xx_slc.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 5f7cc6da0a7f..342f666ad435 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -831,11 +831,11 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk)) {
 		dev_err(&pdev->dev, "Clock failure\n");
 		res = -ENOENT;
-		goto err_exit1;
+		goto release_gpio;
 	}
 	res = clk_prepare_enable(host->clk);
 	if (res)
-		goto err_exit1;
+		goto release_gpio;
 
 	/* Set NAND IO addresses and command/ready functions */
 	chip->IO_ADDR_R = SLC_DATA(host->io_base);
@@ -874,19 +874,19 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 				      GFP_KERNEL);
 	if (host->data_buf == NULL) {
 		res = -ENOMEM;
-		goto err_exit2;
+		goto release_clk;
 	}
 
 	res = lpc32xx_nand_dma_setup(host);
 	if (res) {
 		res = -EIO;
-		goto err_exit2;
+		goto release_clk;
 	}
 
 	/* Find NAND device */
 	res = nand_scan_ident(mtd, 1, NULL);
 	if (res)
-		goto err_exit3;
+		goto release_dma;
 
 	/* OOB and ECC CPU and DMA work areas */
 	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
@@ -920,21 +920,23 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	 */
 	res = nand_scan_tail(mtd);
 	if (res)
-		goto err_exit3;
+		goto release_dma;
 
 	mtd->name = "nxp_lpc3220_slc";
 	res = mtd_device_register(mtd, host->ncfg->parts,
 				  host->ncfg->num_parts);
-	if (!res)
-		return res;
+	if (res)
+		goto release_nand;
 
+	return 0;
+
+release_nand:
 	nand_release(mtd);
-
-err_exit3:
+release_dma:
 	dma_release_channel(host->dma_chan);
-err_exit2:
+release_clk:
 	clk_disable_unprepare(host->clk);
-err_exit1:
+release_gpio:
 	lpc32xx_wp_enable(host);
 
 	return res;
-- 
2.14.1
